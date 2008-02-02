using System;
using System.Drawing;

using Math3D;
using OgreDotNet;

namespace DemoCelShading
{
	/// <summary>
	/// Summary description for Class1.
	/// </summary>
	class cCelShading : OgreDotNet.ExampleApplication
	{

		// Custom parameter bindings
		protected const uint CUSTOM_SHININESS = 1;
		protected const uint CUSTOM_DIFFUSE =2;
		protected const uint CUSTOM_SPECULAR =3;

		protected OgreDotNet.Log	mLog=null;
		protected SceneNode			rotNode=null;

		protected override void CreateScene()
		{
			RenderSystemCapabilities caps = mRoot.RenderSystem.GetCapabilities();
			if ( (!caps.hasCapability(Capabilities.VertexProgram)) ||
				(!caps.hasCapability(Capabilities.FragmentProgram)) )
			{
				throw new Exception( "Your card does not support vertex and fragment programs (or you selected D3D7), so cannot run this demo. Sorry!\n cCelShading.CreateScene" );
			}

			mLog = LogManager.Singleton.createLog("DemoCelShading.log", false, true );
			mLog.LogMessage(string.Format("DemoCelShading log {0}" , System.DateTime.Now ) );
			
			create4LineDebugOverLay();
			Show4LineDebugOverLay();

			// Create a point light
			Light l = mSceneManager.CreateLight("MainLight");
			// Accept default settings: point light, white diffuse, just set position
			// Add light to the scene node
			rotNode = mSceneManager.GetRootSceneNode().CreateChildSceneNode();
			rotNode.CreateChildSceneNode( new Vector3(20.0f, 40.0f, 50.0f)).AttachObject(l);

			Entity ent = mSceneManager.CreateEntity("head", "ogrehead.mesh");

			mCamera.SetPosition( 20.0f, 0.0f, 100.0f);
			mCamera.LookAt = new Vector3(0.0f, 0.0f, 0.0f );


			// Set common material, but define custom parameters to change colours
			// See Example-Advanced.material for how these are finally bound to GPU parameters
			SubEntity sub;
			// eyes
			sub = ent.GetSubEntity(0);
			sub.setMaterialName("Examples/CelShading");
			sub.GetAsRenderable().setCustomParameter( CUSTOM_SHININESS, new Vector4(35.0f, 0.0f, 0.0f, 0.0f));
			sub.GetAsRenderable().setCustomParameter(CUSTOM_DIFFUSE, new Vector4(1.0f, 0.3f, 0.3f, 1.0f));
			sub.GetAsRenderable().setCustomParameter(CUSTOM_SPECULAR, new Vector4(1.0f, 0.6f, 0.6f, 1.0f));
			// skin
			sub = ent.GetSubEntity(1);
			sub.setMaterialName("Examples/CelShading");
			sub.GetAsRenderable().setCustomParameter(CUSTOM_SHININESS, new Vector4(10.0f, 0.0f, 0.0f, 0.0f));
			sub.GetAsRenderable().setCustomParameter(CUSTOM_DIFFUSE, new Vector4(0.0f, 0.5f, 0.0f, 1.0f));
			sub.GetAsRenderable().setCustomParameter(CUSTOM_SPECULAR, new Vector4(0.3f, 0.5f, 0.3f, 1.0f));
			// earring
			sub = ent.GetSubEntity(2);
			sub.setMaterialName("Examples/CelShading");
			sub.GetAsRenderable().setCustomParameter(CUSTOM_SHININESS, new Vector4(25.0f, 0.0f, 0.0f, 0.0f));
			sub.GetAsRenderable().setCustomParameter(CUSTOM_DIFFUSE, new Vector4(1.0f, 1.0f, 0.0f, 1.0f));
			sub.GetAsRenderable().setCustomParameter(CUSTOM_SPECULAR, new Vector4(1.0f, 1.0f, 0.7f, 1.0f));
			// teeth
			sub = ent.GetSubEntity(3);
			sub.setMaterialName("Examples/CelShading");
			sub.GetAsRenderable().setCustomParameter(CUSTOM_SHININESS, new Vector4(20.0f, 0.0f, 0.0f, 0.0f));
			sub.GetAsRenderable().setCustomParameter(CUSTOM_DIFFUSE, new Vector4(1.0f, 1.0f, 0.7f, 1.0f));
			sub.GetAsRenderable().setCustomParameter(CUSTOM_SPECULAR, new Vector4(1.0f, 1.0f, 1.0f, 1.0f));

			// Add entity to the root scene node
			mSceneManager.GetRootSceneNode().CreateChildSceneNode().AttachObject(ent);

			mRenderWindow.GetViewport(0).SetBackgroundColour( Color.White );
		}


		protected override bool FrameStarted( FrameEvent e )
		{
			if (!base.FrameStarted( e ))
				return false;

			rotNode.Yaw( e.TimeSinceLastFrame * 30.0f  );

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


		protected override void KeyClicked( KeyEvent e )
		{
			switch( e.KeyCode )
			{
				case KeyCode.Y:
					break;
				default:
					base.KeyClicked(e);
					break;
			}
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
			cCelShading app = new cCelShading();
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
