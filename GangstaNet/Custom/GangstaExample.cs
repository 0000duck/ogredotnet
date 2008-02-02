using System;
using System.Drawing;
using OgreDotNet;
using Math3D;

namespace GangstaDotNet
{
	/// <summary>
	/// Summary description for GangstaExample.
	/// </summary>
	public abstract class GangstaExample : OgreDotNet.ExampleApplication
	{
		protected GangstaDotNet.Manager						mManager=null;
		protected GangstaDotNet.PhysicsDriver				mDriver=null;
		protected GangstaDotNet.World						mWorld=null;
		protected GangstaDotNet.CallbackInterface_Ogre		mCallBackOgre=null;
		protected bool mPaused=false;
		protected float mSingleStepScale=0.1f;

		//protected RayHitExample		mRayHit;

		public GangstaExample()
		{
		}

		protected override bool Setup()
		{
			mRoot = new Root();
			
			SetupResources( "resources.cfg" );

			if( !mRoot.ShowConfigDialog() )
				return false;
			
			mRenderWindow = mRoot.Initialise(true, "Ogre Render Window");

			CreateSceneManager();
			CreateCamera();
			CreateViewPort();

			TextureManager.Instance.SetDefaultNumMipmaps(5);

			LoadResources();

			mDebugOverlay = OverlayManager.getSingleton().getByName("Core/DebugOverlay");
			mAverageFPS = OverlayManager.getSingleton().getOverlayElement("Core/AverageFps");
			mCurrentFPS = OverlayManager.getSingleton().getOverlayElement("Core/CurrFps");
			mBestFPS = OverlayManager.getSingleton().getOverlayElement("Core/BestFps");
			mWorstFPS = OverlayManager.getSingleton().getOverlayElement("Core/WorstFps");
			mTriangleCount = OverlayManager.getSingleton().getOverlayElement("Core/NumTris");
			DebugOverlayVisible = true;

			MaterialManager.Instance.SetDefaultTextureFiltering(mFilter);
			MaterialManager.Instance.SetDefaultAnisotropy(mAnisotropy);

			//init PhysicsSystem
			mManager = new Manager();
			if (!LoadPhysicsDrivers())	//mDriver = mManager.loadDynamicModule( "ODE" );
				return false;
			mCallBackOgre = new CallbackInterface_Ogre( mSceneManager );
			mCallBackOgre.setupCallbackInterface( mDriver );
			if (!CreatePhysicsWorld())
				return false;

			LoadGangstaLogo();

			//mRayHit = new RayHitExample( mSceneManager );

			CreateScene();
			CreatePhysicsScene();

			CreateEventHandler();

			return true;
		}

		/// <summary>
		/// Called when the default camera needs to be created.
		/// </summary>
		protected override void CreateCamera()
		{
			mCamera = this.mSceneManager.CreateCamera("MainCamera");
			mCamera.SetPosition( 0, 20, 40 );
			mCamera.LookAt = new Vector3(0,0,0);
			mCamera.NearClipDistance = 5;
		}

		/// <summary>
		/// Called in Setup, the overrider must load the PhysicsSystem(s) they wish to use.
		/// mDriver = mManager.loadPhysicsDriver( "ODE" );
		/// </summary>
		protected abstract bool LoadPhysicsDrivers();

		protected virtual bool CreatePhysicsWorld()
		{
			mWorld = mDriver.createWorld( "sample_world" );

			ParameterList pl = new ParameterList();

			mWorld.getSupportedParameters( pl);

			pl.Item("gravity").setVec3( new Vector3( 0.0f, -9.80665f, 0.0f ) );
			pl.Item("extents").setVec3( new Vector3( 1000.0f, 500.0f, 1000.0f ) );
			pl.Item("step").setFloat( (1.0f / 60.0f)  );

			mWorld.initialise( pl );

			mWorld.getDefaultMaterial().setParameter( "staticFriction", new Parameter( 60.0f)  );
			mWorld.getDefaultMaterial().setParameter( "softCFM",  new Parameter( 0.01f ) );

			return true;
		}

		protected virtual void LoadGangstaLogo()
		{
			OverlayElement  logo = OverlayManager.Instance.getOverlayElement( "Core/LogoPanel" );
			if(logo != null)
			{
				logo.setMaterialName("Gangsta/Logo");
				logo.setLeft(-169);
				logo.setTop(-130);
				logo.setWidth(164);
				logo.setHeight(125);
			}
		}

		protected override void CreateScene()
		{
			((Overlay)OverlayManager.Instance.getByName("Gangsta/Demo/Target")).show();    

			Light l = mSceneManager.CreateLight("Light");
			l.Position = new Math3D.Vector3(400,500,300);
			l.SetSpecularColour( 1.0f, 1.0f, 1.0f);
			l.SetCastShadows(true);

			mSceneManager.SetShadowTechnique( ShadowTechnique.ShadowTypeStencilModulative );
			mSceneManager.SetShadowColour( Converter.GetColor( 0.5f,0.5f,0.5f) );
			mSceneManager.SetAmbientLight( Converter.GetColor(0.5f, 0.5f, 0.5f) ) ;
			mSceneManager.SetSkyBox( true, "Gangsta/Skybox/Io" );

			Plane plane = new Plane();
			plane.Normal.x=0.0f;
			plane.Normal.y=1.0f;
			plane.Normal.z=0.0f;
			plane.D = 0.0f;
			MeshPtr m = MeshManager.GetSingleton().CreatePlane( "Plane_mesh", ResourceGroupManager.DEFAULT_RESOURCE_GROUP_NAME,
					plane, 400.0f, 400.0f, 10, 10, true,
					1, 16.0f, 16.0f, Vector3.NegativeUnitZ  );
			Entity e = mSceneManager.CreateEntity( "Plane_entity", "Plane_mesh");
			e.SetCastShadows(false);
			e.SetMaterialName("Gangsta/Ground/Dust");
			m.SetNull();
			m=null;

			SceneNode n = mSceneManager.GetRootSceneNode().CreateChildSceneNode("Plane_node");
			n.AttachObject( e );
		}

		/// <summary>
		/// Called when user defined Physics world objects need to be instanced/re-instanced.
		/// </summary>
		protected virtual void CreatePhysicsScene()
		{
			// Create the ground plane
			ParameterList pl = new ParameterList();
			GangstaDotNet.Shape shape = mWorld.createShape( "plane" );
			shape.getSupportedParameters( pl , "plane" );

			pl.Item("normal").setVec3( new Vector3(0.0f, 1.0f, 0.0f) );
			pl.Item("distance").setFloat( 0.0f );

			shape.initialise( pl );
			shape.setGroup( 31 );
		}


		protected  bool bWasLastHitting=false;
		protected override bool FrameStarted( FrameEvent e )
		{
			if (!base.FrameStarted( e ))
				return false;

			InputReader inputreader = mEventHandler.GetInputReader();
			
			/*
			if (mRayHit != null)
				if (!mRayHit.FrameEnded(e, inputreader , mCamera , mWorld ) )
					return false;
			*/
			
			if ( (inputreader != null) &&  (inputreader.getMouseButton((byte)InputEvent.BUTTON1_MASK)) )
			{
				if(!mCallBackOgre.isDragging())
				{
					Vector3 o_pos = mCamera.GetDerivedPosition();
					Quaternion o_rot = mCamera.GetDerivedOrientation();
					OgreDotNet.Ray o_ray = mCamera.GetCameraToViewportRay( 0.5f, 0.5f );
					
					Vector3 o_org = o_ray.getOrigin();
					Vector3 o_dir = o_ray.getDirection();
					o_dir.Normalize();
					
					GangstaDotNet.Ray g_ray = mWorld.createRay( o_org, o_dir, 500.0f);
					mCallBackOgre.beginDrag( o_pos, o_rot, g_ray);
					g_ray.Release();
				}
				else
				{
					Vector3 o_pos = mCamera.GetDerivedPosition();
					Quaternion o_rot = mCamera.GetDerivedOrientation();
					mCallBackOgre.updateDrag( o_pos, o_rot, 10.0f );
				}
				bWasLastHitting=true;
			}
			else
			{
				if (bWasLastHitting)	
				{
					mCallBackOgre.endDrag();
				}
				bWasLastHitting=false;
			}

			return true;
		}

		protected override bool FrameEnded( FrameEvent e )
		{
			if (!base.FrameEnded( e ))
				return false;

			float t = e.TimeSinceLastFrame;
			if ( (!mPaused) && (mWorld != null) )
			{
				mWorld.advanceTime( t );
			}

			return true;
		}

		
		/// <summary>
		/// override ExampleApplication to prevent mousebutton movement 
		/// </summary>
		protected override void MousePressed( MouseEvent e )
		{
		}

		/// <summary>
		/// override ExampleApplication to prevent mousebutton movement 
		/// </summary>
		protected override void MouseReleased( MouseEvent e )
		{
		}


		protected override void KeyClicked( KeyEvent e )
		{
			switch( e.KeyCode )
			{
				case KeyCode.F1:
					Console.WriteLine("setDebugVisualMode GDV_SHAPES");
					mWorld.setDebugVisualMode( (uint)DebugVisual.Mode.GDV_SHAPES );
					break;

				case KeyCode.F2:
					Console.WriteLine("setDebugVisualMode GDV_NONE");
					mWorld.setDebugVisualMode( (uint)DebugVisual.Mode.GDV_NONE );
					break;

				case KeyCode.F5:
					DebugVisual.Mode old_mode = (DebugVisual.Mode)mWorld.getDebugVisualMode();

					mWorld.setDebugVisualMode( (uint)DebugVisual.Mode.GDV_NONE );
					mCallBackOgre.endDrag();
					mDriver.destroyWorld( mWorld);
					//mWorld.Dispose();
					//mWorld=null;

					CreatePhysicsWorld();
					CreatePhysicsScene();

					mWorld.setDebugVisualMode( (uint)old_mode);
					break;

				case KeyCode.F6:
					mPaused = !mPaused;
					break;

				case KeyCode.F7:
					if ( mPaused ) 
					{
						if (mWorld != null)
							mWorld.advanceTime( mSingleStepScale );
					}
					break;

				default:
					base.KeyClicked(e);
					break;
			}
		}


		/// <summary>
		/// Disposes of the GangstaExample instance.
		/// </summary>
		public override void Dispose()
		{
			if (mDriver != null) 
			{
				if (mWorld != null)
				{
					mWorld.setDebugVisualMode( (uint)DebugVisual.Mode.GDV_NONE );
					if (mCallBackOgre != null)
						mCallBackOgre.endDrag();
					mDriver.destroyWorld( mWorld);
				}
				mWorld=null;
				mManager.unloadPhysicsDriver( mDriver );
			}
			mDriver=null;

			if (mCallBackOgre != null)
				mCallBackOgre.Dispose();
			mCallBackOgre = null;
			
			if (mManager != null)
				mManager.Dispose();
			mManager=null;
			
			//mRayHit = null;

			base.Dispose();
		}

	}
}
