using System;
using System.Drawing;

using Math3D;
using OgreDotNet;

namespace DemoRSQ
{

	class cDemoRSQ : OgreDotNet.ExampleApplication
	{
		protected OgreDotNet.Log	mLog;
		protected Ray mRay;
		protected RaySceneQuery mRaySceneQuery;
/*** test ***/
		protected Line3D myLine;
/*** test ***/
		
		protected override void CreateScene()
		{
			mSceneManager.SetSkyBox(true,  "Examples/CloudyNoonSkyBox" );
			
			mLog = LogManager.Singleton.createLog("RSQTest.log", false, true );
			mLog.LogMessage(string.Format("RSQTest log {0}" , System.DateTime.Now ) );
			
			create4LineDebugOverLay();
			Show4LineDebugOverLay();
			
			Entity e;
			SceneNode n;
			Plane plane = new Plane();
			plane.Normal.x=0.0f;
			plane.Normal.y=1.0f;
			plane.Normal.z=0.0f;
			plane.D = 0.0f;
			MeshManager.GetSingleton().CreatePlane( "Myplane01", "General" , plane,
				250.0f,500.0f, 10,10,true,1, 5.0f,5.0f, Vector3.UnitZ );
			e = mSceneManager.CreateEntity( "plane01", "Myplane01" );
			e.SetMaterialName("Examples/GrassFloor");
			e.SetCastShadows(false);
			n = mSceneManager.GetRootSceneNode().CreateChildSceneNode();
			n.SetPosition( -125.0f, 10.0f, 0.0f );
			n.Pitch( new Radian( new Degree( 5.0f ) ) );
			n.AttachObject(e);
			
			plane.Normal.x=0.0f;
			plane.Normal.y=1.0f;
			plane.Normal.z=0.0f;
			plane.D = 0.0f;
			MeshManager.GetSingleton().CreatePlane( "Myplane02", "General" , plane,
				250.0f,500.0f, 10,10,true,1, 5.0f,5.0f, Vector3.UnitZ );
			e = mSceneManager.CreateEntity( "plane02", "Myplane02" );
			e.SetMaterialName("Examples/GrassFloor");
			e.SetCastShadows(false);
			n = mSceneManager.GetRootSceneNode().CreateChildSceneNode();
			n.SetPosition( 125.0f, 10.0f, 0.0f );
			n.AttachObject(e);
			
			for (int x=0; x<4; x++)	{
				string sname = string.Format("head{0}", x);
				e = mSceneManager.CreateEntity( sname, "ogrehead.mesh");
				n = mSceneManager.GetRootSceneNode().CreateChildSceneNode(sname);
				n.AttachObject(e);
				float px= (x%2==0? -100.0f: 100.0f);
				float pz= ((x<=1)? -100.0f: 100.0f);
				float py= (x%2==0? 50.0f : 30.0f);
				n.SetPosition( px, py, pz );
			}
			
			mRay = new OgreDotNet.Ray(Vector3.Zero, Vector3.NegativeUnitY );
    		mRaySceneQuery = mSceneManager.CreateRayQuery( mRay );
			
			mCamera.Move( new Vector3(0, 300, 600) );
			mCamera.LookAt = new Vector3( 0, 0, 0 );
			
/*** test ***/
			myLine = new Line3D();
			myLine.addPoint( new Vector3( 0.0f,   9.6f, 0.0f) );
			myLine.addPoint( new Vector3( 160.0f, 9.6f, 0.0f) );
			myLine.addPoint( new Vector3( 160.0f, 9.6f, 160.0f) );
			myLine.addPoint( new Vector3( 0.0f,   9.6f, 160.0f) );
			myLine.addPoint( new Vector3( 0.0f,   9.6f, 0.0f) );
			myLine.drawLines();
			
			SceneNode myNode = mSceneManager.GetRootSceneNode().CreateChildSceneNode("Line1");
			myNode.AttachObject(myLine);
			myNode.SetPosition( 0.0f, 200.0f, 0.0f );
/*** test ***/
		}
	
	
		protected override bool FrameStarted( FrameEvent e )
		{
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


			Vector3 p = mCamera.GetPosition();
			p.y = 3000.0f;
			mRay.setOrigin( p );
			SetDebugCaption( 2, string.Format("  ray at : ({0}, {1}, {2}) ", mRay.getOrigin().x, mRay.getOrigin().y, mRay.getOrigin().z ) );
			SetDebugCaption( 3, "");
			mRaySceneQuery.setRay( mRay );
			RaySceneQueryResult  qryResult = mRaySceneQuery.execute();
			if (qryResult.Count > 0)
			{
				float newY =-999.0f;
				foreach (RaySceneQueryResultEntry qryEntry in qryResult) {
					if (newY < qryEntry.distance )
						newY = qryEntry.distance;
				}
				if (newY != -999.0f)	{
					newY = 3000.0f - newY;
					p = mCamera.GetPosition();
					p.y = newY+5.0f;
					mCamera.SetPosition( p.x,  p.y,  p.z );
					SetDebugCaption( 3, string.Format("  intersect at : ({0}, {1}, {2}) ", p.x, p.y, p.z ) );
				}
			}
			return true;
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
						myLine.deletePoint( (UInt32)5 ); //the sixth point
					myLine.drawLines();
					break;
				default:
					base.KeyClicked(e);
					break;
			}
		}


		public override void Dispose()
		{
			mRay.Dispose();
			mRay=null;

			mRaySceneQuery.Dispose();
			mRaySceneQuery=null;

			/*if (myLine != null)
			{
				SceneNode n = mSceneManager.GetSceneNode("Line1");
				if (n!= null)
					n.DetachObject(myLine);
				myLine.Dispose();
			}*/
			myLine.Dispose();
			myLine=null;

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
			cDemoRSQ app = new cDemoRSQ();
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
