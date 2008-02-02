using System;
using System.Drawing;

using Math3D;
using OgreDotNet;
using GangstaDotNet;

namespace DemoGAPyramid
{

	class cGAPyramid : GangstaDotNet.GangstaExample
	{
		protected OgreDotNet.Log	mLog;
		
		protected override void CreateEventHandler()
		{
			mEventHandler = new OgreDotNet.EventHandler( mRoot, mRenderWindow, true );
			mEventHandler.SubscribeEvents();
			mEventHandler.FrameStarted += new FrameEventDelegate( FrameStarted );
			mEventHandler.FrameEnded += new FrameEventDelegate( FrameEnded );
			mEventHandler.KeyClicked += new KeyEventDelegate( KeyClicked );
			mEventHandler.KeyPressed += new KeyEventDelegate( KeyPressed );
			mEventHandler.KeyReleased += new KeyEventDelegate( KeyReleased );
			mEventHandler.MouseMoved += new MouseMotionEventDelegate( MouseMotion );
			mEventHandler.MouseClicked += new MouseEventDelegate( MouseClick );
			mEventHandler.MousePressed += new MouseEventDelegate( MousePressed );
			mEventHandler.MouseReleased += new MouseEventDelegate( MouseReleased );
			mEventHandler.MouseDragged += new MouseMotionEventDelegate( MouseDragged );

			//InputReader inputreader = mEventHandler.GetInputReader();
		}

		protected override bool LoadPhysicsDrivers()
		{
			mDriver = mManager.loadPhysicsDriver( "ODE" );
			//mDriver = mManager.loadPhysicsDriver( "Newton" );
			//mDriver = mManager.loadPhysicsDriver( "TrueAxis" );
			return true;
		}


		protected override void CreateScene()
		{
			mLog = LogManager.Singleton.createLog("DemoGAPyramid.log", false, true );
			mLog.LogMessage(string.Format("DemoGAPyramid log {0}" , System.DateTime.Now ) );
			
			base.CreateScene();
			
			create4LineDebugOverLay();
			Show4LineDebugOverLay();
			
			Entity pyra_ent = mSceneManager.CreateEntity("Pyramid_entity","pyramid.mesh");
			pyra_ent.SetCastShadows(true);
			
			SceneNode pyra_node = mSceneManager.GetRootSceneNode().CreateChildSceneNode("Pyramid_node");
			pyra_node.AttachObject(pyra_ent);
			
		}

		protected override void CreatePhysicsScene()
		{
			Console.WriteLine("##GAPyramid::CreatePhysicsScene  1");
			base.CreatePhysicsScene();

			Console.WriteLine("##GAPyramid::CreatePhysicsScene  2");
			ParameterList pl = new ParameterList();
			GangstaDotNet.Body body = null;
			GangstaDotNet.Shape shape = null;
			Entity e = null;

			Console.WriteLine("##GAPyramid::CreatePhysicsScene  3");
			// Create a stack of objects
			//for (float y = 12.0f; y < 52.0f; y += 8.0f)
			for (float y = 20.0f; y < 60.0f; y += 8.0f)
			{
				// Create a box body
				body = mWorld.createBody("box" + y.ToString(),"Gangsta_Crate.mesh");
				e = body.getEntity();
				e.SetMaterialName( "Gangsta/Ogre/Demo/" + mDriver.getName() );
				body.getSupportedParameters(pl);
				pl.Item("inertia_tensor").setVec3( 1.0f, 1.0f, 1.0f );
				pl.Item("mass").setFloat( 1.0f );
				body.initialise(pl);
				body.setPosition( new Vector3( 0.0f, y ,0.0f) );
				pl.clear();
				
				// Create a box shape
				shape = mWorld.createShape("box" + y.ToString(), body);
				shape.getSupportedParameters(pl,"box");
				pl.Item("size").setVec3( 1.0f, 1.0f, 1.0f );
				shape.initialise(pl);
				pl.clear();


				Console.WriteLine("##GAPyramid::CreatePhysicsScene  3.1");
				// Create a sphere body
				body = mWorld.createBody("sphere" + y.ToString(),"Gangsta_Sphere.mesh");
				e = body.getEntity();
				e.SetMaterialName( "Gangsta/Ogre/Demo/" + mDriver.getName() );
				body.getSupportedParameters(pl);
				pl.Item("inertia_tensor").setVec3( 1.0f, 1.0f, 1.0f );
				pl.Item("mass").setFloat( 1.0f );
				body.initialise(pl);
				body.setPosition( new Vector3(0.0f, y + 2.0f, 0.0f));
				pl.clear();
				
				// Create a sphere shape
				shape = mWorld.createShape("sphere" + y.ToString(),body);
				shape.getSupportedParameters(pl,"sphere");
				pl.Item("radius").setFloat( 0.5f );
				shape.initialise(pl);
				pl.clear();


				Console.WriteLine("##GAPyramid::CreatePhysicsScene  3.2");
				// Create a capsule body
				body = mWorld.createBody("capsule" + y.ToString(),"Gangsta_Capsule.mesh");
				e = body.getEntity();
				e.SetMaterialName( "Gangsta/Ogre/Demo/" + mDriver.getName() );
				body.getSupportedParameters(pl);
				pl.Item("inertia_tensor").setVec3( 1.0f, 1.0f, 1.0f );
				pl.Item("mass").setFloat( 1.0f );
				body.initialise(pl);
				body.setPosition( new Vector3( 0.0f, y + 4.0f, 0.0f));
				pl.clear();
				
				// Create a capsule shape
				shape = mWorld.createShape("capsule" + y.ToString(),body);
				shape.getSupportedParameters(pl,"capsule");
				pl.Item("radius").setFloat( 0.5f );
				pl.Item("length").setFloat( 1.0f );
				shape.initialise(pl);
				pl.clear();


				Console.WriteLine("##GAPyramid::CreatePhysicsScene  3.3");
				// Create a body for the composite object
				body = mWorld.createBody("composite" + y.ToString(),"simple_composite.mesh");
				e = body.getEntity();
				e.SetMaterialName( "Gangsta/Ogre/Demo/" + mDriver.getName() );
				body.getSupportedParameters(pl);
				pl.Item("inertia_tensor").setVec3( 1.0f, 1.0f, 1.0f );
				pl.Item("mass").setFloat( 1.0f );
				body.initialise(pl);
				body.setPosition( new Vector3( 0.0f, y + 6.0f, 0.0f));
				pl.clear();

				Console.WriteLine("##GAPyramid::CreatePhysicsScene  3.31");
				// Create an offset sphere shape
				shape = mWorld.createShape("offset sphere" + y.ToString(),body);
				shape.getSupportedParameters(pl,"sphere");
				pl.Item("radius").setFloat( 0.5f );
				pl.Item("position").setVec3( -0.7f, 0.5f, 0.2f );
				shape.initialise(pl);
				pl.clear();

				Console.WriteLine("##GAPyramid::CreatePhysicsScene  3.32");
				// Create an offset box shape
				shape = mWorld.createShape("offset box" + y.ToString(),body);
				shape.getSupportedParameters(pl,"box");
				pl.Item("size").setVec3( 1.1f, 0.5f, 0.4f );
				pl.Item("position").setVec3( 0.8f, 0.6f, -0.7f );
				if (pl.Item("orientation") != null)
					pl.Item("orientation").setQuat( GaQuat.ToQuaternion( new GaQuat( new GaRadian(30.0f), new Math3D.Vector3(0.0f, 0.0f, 1.0f))) );
				shape.initialise(pl);
				pl.clear();

				Console.WriteLine("##GAPyramid::CreatePhysicsScene  3.33");
				// Create an offset capsule shape
				shape = mWorld.createShape("offset capsule" + y.ToString(),body);
				shape.getSupportedParameters(pl,"capsule");
				pl.Item("length").setFloat( 1.0f );
				pl.Item("radius").setFloat( 0.5f );
				pl.Item("position").setVec3( 0.2f, -0.2f, -0.2f );
				if (pl.Item("orientation") != null)
					pl.Item("orientation").setQuat( GaQuat.ToQuaternion( new GaQuat( new GaRadian(45.0f), new Math3D.Vector3(0.0f, 1.0f, 0.0f))) );
				shape.initialise(pl);
				pl.clear();

			}

			Console.WriteLine("##GAPyramid::CreatePhysicsScene  4");
			// Create the Mayan pyramid mesh
			mCallBackOgre.shapeFromEntity(mWorld,"Pyramid_entity","mesh", GangstaDotNet.Body.getNullBodyPtr() );
			
			Console.WriteLine("##GAPyramid::CreatePhysicsScene  end");
		}




		/** for testing to close after a time, good when disabling input **/
		private static int zzz=0;
		protected override bool FrameStarted( FrameEvent e )
		{
			/** for testing to close after a time, good when disabling input **
			if (zzz++ > 500)
				return false;
			/****/

			if (!base.FrameStarted( e ))
				return false;
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
			cGAPyramid app = new cGAPyramid();
			try 
			{
				app.Start();
			}
			catch ( Exception ex) 
			{
				string strErrMsg = string.Format("### Exception {0}\n{1}\n{2}", ex.Message ,ex.Source , ex.StackTrace  );
				Console.WriteLine( strErrMsg );
				if (LogManager.Singleton != null)
					LogManager.Singleton.logMessage( strErrMsg );
			}
			finally 
			{
				try 
				{
					app.Dispose();
				}
				catch ( Exception ex) 
				{
					string strErrMsg = string.Format("### Exception {0}\n{1}\n{2}", ex.Message ,ex.Source , ex.StackTrace  );
					Console.WriteLine( strErrMsg );
				}
			}
		}

	}
}
