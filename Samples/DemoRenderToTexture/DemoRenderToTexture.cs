using System;
using System.Drawing;

using Math3D;
using OgreDotNet;

namespace DemoRenderToTexture
{

	class cDemoRenderToTexture : OgreDotNet.ExampleApplication
	{
		protected OgreDotNet.Log	mLog =null;
		protected RenderTargetListenerDirector		mRTListener =null;

		protected MovablePlane		mPlane =null;
		protected Entity			mPlaneEnt =null;
		protected Camera			mReflectCam =null;
		protected SceneNode			mPlaneNode =null;
		
		protected override void CreateScene()
		{
			mLog = LogManager.Singleton.createLog("RSQTest.log", false, true );
			mLog.LogMessage(string.Format("RSQTest log {0}" , System.DateTime.Now ) );
			
			create4LineDebugOverLay();
			Show4LineDebugOverLay();
			
			//setup RenderTargetListenerDirector
			mRTListener = new RenderTargetListenerDirector();
			mRTListener.SubscribeEvents();
			mRTListener.evtPreRenderTargetUpdate += new RenderTargetListenerDirector.RTLD_Delegate_RenderTargetUpdate( event_PreRenderTargetUpdate );
			mRTListener.evtPostRenderTargetUpdate += new RenderTargetListenerDirector.RTLD_Delegate_RenderTargetUpdate( event_PostRenderTargetUpdate );
			
			mSceneManager.SetAmbientLight( Converter.GetColor(0.2f, 0.2f, 0.2f) );
			
			mSceneManager.SetSkyBox(true,  "Examples/MorningSkyBox" );
			
			// Create a light
			Light l = mSceneManager.CreateLight("MainLight");
			l.SetLightType( OgreDotNet.Light.LightTypes.Directional);
			Math3D.Vector3 dir = new Vector3(0.5f, -1.0f, 0.0f);
			dir.Normalize();
			l.SetDirection(dir);
			l.SetDiffuseColour(1.0f, 1.0f, 0.8f);
			l.SetSpecularColour(1.0f, 1.0f, 1.0f);
			
			// Create a prefab plane
			mPlane = new MovablePlane("ReflectPlane");
			mPlane.D = 0;
			mPlane.Normal = OgreVector3.FromVector3( Math3D.Vector3.UnitY );
			MeshManager.GetSingleton().CreatePlane( "ReflectionPlane", ResourceGroupManager.DEFAULT_RESOURCE_GROUP_NAME,
				mPlane, 2000,2000, 1,1, true, 1, 1,1, Vector3.UnitZ );
			mPlaneEnt = mSceneManager.CreateEntity( "Plane", "ReflectionPlane" );
			
			// Create an entity from a model (will be loaded automatically)
			Entity knotEnt = mSceneManager.CreateEntity("Knot", "knot.mesh");
			
			// Create an entity from a model (will be loaded automatically)
			Entity ogreHead = mSceneManager.CreateEntity("Head", "ogrehead.mesh");
			
			knotEnt.SetMaterialName("Examples/TextureEffect2");
			
			// Attach the rtt entity to the root of the scene
			SceneNode rootNode = mSceneManager.GetRootSceneNode();
			mPlaneNode = rootNode.CreateChildSceneNode();
			
			// Attach both the plane entity, and the plane definition
			mPlaneNode.AttachObject(mPlaneEnt);
			
			//multi Inheritence problem, use the static Get*From function to convert
			MovableObject mo = MovableObject.GetMovableObjectFrom(mPlane);
			mPlaneNode.AttachObject(mo);
			
			mPlaneNode.Translate(0.0f, -10.0f, 0.0f);
			
			// Tilt it a little to make it interesting
			//mPlaneNode.Roll( new Radian( new Degree( 5.0f)) );
			mPlaneNode.Roll( 5.0f );
			
			rootNode.CreateChildSceneNode( "Head" ).AttachObject( ogreHead );
			
			
			RenderTexture rttTex = mRoot.GetRenderSystem().CreateRenderTexture( "RttTex", 512, 512,
				TextureType.TEX_TYPE_2D, PixelFormat.PF_R8G8B8 );
			
			{//new scope for some reason
				mReflectCam = mSceneManager.CreateCamera("ReflectCam");
				mReflectCam.SetNearClipDistance( mCamera.GetNearClipDistance());
				mReflectCam.SetFarClipDistance( mCamera.GetFarClipDistance());
				mReflectCam.SetAspectRatio(
					(float)mRenderWindow.GetViewport(0).ActualWidth /
					(float)mRenderWindow.GetViewport(0).ActualHeight );
			
				Viewport v = rttTex.AddViewport( mReflectCam );
				v.ClearEveryFrame = true;
				v.BackgroundColor = System.Drawing.Color.Black; //Converter.ToColor( ColourValue.Black );
				
				ResourcePtr resPtr = MaterialManager.Instance.Create("RttMat",
					ResourceGroupManager.DEFAULT_RESOURCE_GROUP_NAME );
				
				MaterialPtr mat = new MaterialPtr( ResourcePtr.getCPtr(resPtr).Handle, false);
				
				TextureUnitState t = mat.Get().GetTechnique(0).getPass(0).createTextureUnitState("RustedMetal.jpg");
				t = mat.Get().GetTechnique(0).getPass(0).createTextureUnitState("RttTex");
				// Blend with base texture
				t.setColourOperationEx(LayerBlendOperationEx.LBX_BLEND_MANUAL, LayerBlendSource.LBS_TEXTURE,
					LayerBlendSource.LBS_CURRENT, Color.White,
					Color.White, 0.25f);
				t.SetTextureAddressingMode( TextureUnitState.TextureAddressingMode.TAM_CLAMP);
				t.setProjectiveTexturing(true, mReflectCam);
				rttTex.AddListener(mRTListener);
			
				// set up linked reflection
				mReflectCam.EnableReflection(mPlane);
				// Also clip
				mReflectCam.EnableCustomNearClipPlane(mPlane);
			}
			
			// Give the plane a texture
			mPlaneEnt.SetMaterialName("RttMat");
			
			
			// Add a whole bunch of extra transparent entities
			Entity cloneEnt;
			for (int n = 0; n < 10; ++n)
			{
				// Create a new node under the root
				SceneNode node = mSceneManager.CreateSceneNode();
				// Random translate
				Vector3 nodePos;
				nodePos.x = OgreMath.SymmetricRandom() * 750.0f;
				nodePos.y = OgreMath.SymmetricRandom() * 100.0f + 25.0f;
				nodePos.z = OgreMath.SymmetricRandom() * 750.0f;
				node.SetPosition(nodePos);
				rootNode.AddChild(node);
				// Clone knot
				string cloneName = string.Format( "Knot{0}", n);
				cloneEnt = knotEnt.Clone(cloneName);
				// Attach to new node
				node.AttachObject( cloneEnt );
			}
			
			
			mCamera.SetPosition( new Vector3(-50.0f, 100.0f, 500.0f) );
			mCamera.LookAt = new Vector3( 0, 0, 0 );
			
		}
	
		public void event_PreRenderTargetUpdate ( RenderTargetEvent evt )
		{
			mPlaneEnt.SetVisible(false);
		}
		public void event_PostRenderTargetUpdate ( RenderTargetEvent evt )
		{
			mPlaneEnt.SetVisible(true);
		}

		protected override bool FrameStarted( FrameEvent e )
		{
			if (!base.FrameStarted( e ))
				return false;
			
			// Make sure reflection camera is updated too
			mReflectCam.SetOrientation( mCamera.GetOrientation() );
			mReflectCam.SetPosition( mCamera.GetPosition() );
			
			// Rotate plane
			mPlaneNode.Yaw( new Radian( new Degree(30.0f * e.TimeSinceLastFrame)) , Node.TransformSpace.TS_PARENT);
			
			return true;
		}

		protected override bool FrameEnded( FrameEvent e )
		{
			if (!base.FrameEnded( e ))
				return false;
			
			SetDebugCaption( 0, string.Format("Camera Location: ({0}, {1}, {2}) ",
					mCamera.GetPosition().x, mCamera.GetPosition().y, mCamera.GetPosition().z  ));
			
			SetDebugCaption( 1, string.Format("Camera Orientation: ({0}, {1}, {2}, {3}) ",
					mCamera.GetOrientation().x, mCamera.GetOrientation().y, mCamera.GetOrientation().z, mCamera.GetOrientation().w  ));
			
			return true;
		}

		public override void Dispose()
		{
			
			mLog.Dispose();
			mLog=null;
			
			base.Dispose();
		}

		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main(string[] args)
		{
			cDemoRenderToTexture app = new cDemoRenderToTexture();
			try 
			{
				app.Start();
			}
			catch ( Exception e) 
			{
				Console.WriteLine( "###  Exception {0}\n{1}\n{2}", 
					e.Message ,e.Source , e.StackTrace );
			}
			finally 
			{
				try 
				{
					app.Dispose();
				}
				catch ( Exception e) 
				{
					Console.WriteLine( "###  Exception {0}\n{1}\n{2}", 
						e.Message ,e.Source , e.StackTrace );
				}
			}
		}
	}
}
