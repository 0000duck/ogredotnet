using System;
using System.Collections;
using System.Xml;
using System.Drawing;

using Math3D;
using OgreDotNet;

namespace DemoCustomObjects
{

	class cDemoCustomObjects : ExampleApplication
	{
		protected OgreDotNet.Log	mLog;

		protected myLine3D myLine;
		protected DemoCustomObjects.myBillBoardChain   mBBC;

		protected override void CreateEventHandler()
		{
			/**  change last paramater to false to disable input **/
			mEventHandler = new OgreDotNet.EventHandler( mRoot, mRenderWindow , true );
			base.CreateEventHandler();
		}

		protected override void CreateScene()
		{
			mSceneManager.SetSkyBox(true,  "Examples/CloudyNoonSkyBox" );
			
			mLog = LogManager.Singleton.createLog("DemoCustomObjects.log", false, true );
			mLog.LogMessage(string.Format("DemoCustomObjects log {0}" , System.DateTime.Now ) );
			
			create4LineDebugOverLay();
			Show4LineDebugOverLay();

			Entity e;
			SceneNode n;

			
			Plane plane = new Plane();
			plane.Normal.x=0;
			plane.Normal.y=1;
			plane.Normal.z=0;
			plane.D = 0;
			MeshManager.GetSingleton().CreatePlane( "Myplane", "General" , plane,
				14500,14500,10,10,true,1,50,50,Vector3.UnitZ );
			e = mSceneManager.CreateEntity( "plane", "Myplane" );
			e.SetMaterialName("Examples/GrassFloor");
			e.SetCastShadows(false);
			n = mSceneManager.GetRootSceneNode().CreateChildSceneNode("Myplane");
			n.AttachObject(e);
			
			
			//##MyLine3D test
			mLog.LogMessage("test line 0");
			myLine = new myLine3D();
			mLog.LogMessage("test line 1");
			myLine.addPoint( new Vector3( 0.0f,   9.6f, 0.0f) );
			myLine.addPoint( new Vector3( 160.0f, 9.6f, 0.0f) );
			myLine.addPoint( new Vector3( 160.0f, 9.6f, 160.0f) );
			myLine.addPoint( new Vector3( 0.0f,   9.6f, 160.0f) );
			myLine.addPoint( new Vector3( 0.0f,   9.6f, 0.0f) );
			mLog.LogMessage("test line 2");
			myLine.drawLines();
			
			mLog.LogMessage("test line 3");
			n = mSceneManager.GetRootSceneNode().CreateChildSceneNode("Line1");
			mLog.LogMessage("test line 4");
			n.AttachObject(myLine);
			mLog.LogMessage("test line 5");
			n.SetPosition( 0.0f, 200.0f, 0.0f );
			//##

			/***/
			//## bill board chain
			mLog.LogMessage("test BBC 1");
			mBBC = new DemoCustomObjects.myBillBoardChain( mCamera, 1000 );
			mBBC.setMaterial("DemoCustomObjects/smoketrail");
			for (int i = 0; i < 500; i++)
			{
				myBillBoardChainElement ce = new myBillBoardChainElement(
					new Vector3( (float)Math.Sin( (double)i / 100.0 * 2.0 * Math.PI ),
								 (float)Math.Cos( (double)i / 100.0 * 2.0 * Math.PI ),
								 (float)i / 100.0f),
                    0.1f,
					(float)i / 10.0f,
					Converter.GetColor(1.0f, 1.0f, 1.0f) );
				mBBC.addChainElement( ce );
			}
			mBBC.updateBoundingBox();
			// Add it to the scene
			n = mSceneManager.GetRootSceneNode().CreateChildSceneNode("BBC");
			n.AttachObject(mBBC);
			n.SetPosition( 0.0f, 100.0f, 0.0f );
			n.SetScale( 50.0f, 50.0f, 50.0f );
			mLog.LogMessage("test BBC 2");
			//##
			/***/


			mCamera.Move( new Vector3(0, 300, 600) );
			mCamera.LookAt = new Vector3( 0, 0, -600 );

			SetDebugCaption( 2, "keys: Y updates and adds a new point" );
			SetDebugCaption( 3, "     U updates and deletes the new point" );

		}
		

		protected override void KeyClicked( KeyEvent e )
		{
			switch( e.KeyCode )
			{
				case KeyCode.Y:
					myLine.updatePoint(2, new Vector3( 160.0f, -50.0f, 160.0f) );
					if ( myLine.getNumPoints() == (UInt32)5 )
						myLine.addPoint( new Vector3( 0.0f, 50.0f, 0.0f) );

					myLine.drawLines();
					break;
				case KeyCode.U:
					myLine.updatePoint(2, new Vector3( 160.0f, 9.6f, 160.0f) );
					if ( myLine.getNumPoints() > (UInt32)5 )
						myLine.deletePoint( 5 ); //the sixth point
					myLine.drawLines();
					break;
				default:
					base.KeyClicked(e);
					break;
			}
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
			if (myLine !=null)
				myLine.Dispose();
			myLine=null;
			
			if (mBBC !=null)
				mBBC.Dispose();
			mBBC = null;
			
			if (mLog !=null)
				mLog.Dispose();
			mLog=null;
			
			//force collect befor root gets Dispose
			GC.Collect();
			
			base.Dispose();
		}

		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main(string[] args)
		{
			cDemoCustomObjects app = new cDemoCustomObjects();
			try 
			{
				app.Start();
			}
			catch ( Exception ex) 
			{
				Console.WriteLine( "###  Exception {0}\n{1}\n{2}", ex.Message ,ex.Source , ex.StackTrace );
			}
			finally 
			{
				try 
				{
					app.Dispose();
				}
				catch ( Exception ex) 
				{
					Console.WriteLine( "###  Exception in Dispose {0}\n{1}\n{2}", ex.Message ,ex.Source , ex.StackTrace );
				}
			}
		}
	}
}
