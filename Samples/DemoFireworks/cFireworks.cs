using System;
using System.Drawing;
using System.Collections;
using System.Runtime.InteropServices;

using Math3D;
using OgreDotNet;

namespace DemoFireworks
{
	/// <summary>
	/// cFireworks main application class
	/// </summary>
	public class cFireworks : OgreDotNet.ExampleApplication
	{
		protected static cFireworks m_Singleton=null;
		protected float timeDelay = 0.0f;
		protected float mtimeNext = 0.0f;
		protected ArrayList mALFireworks = null;
		protected int mccNamer=0;
		
		public  OgreDotNet.Log	mLog =null;
		
		public cFireworks()
		{
			if (m_Singleton ==null)
				m_Singleton = this;
			mALFireworks = new ArrayList();
		}
		
		public static cFireworks Instance		{
			get { return m_Singleton; }
		}

		protected virtual string GetFWName()
		{
			this.mccNamer++;
			return string.Format("firworks{0}", this.mccNamer);
		}
		
		
		protected override void CreateScene()
		{
			mMoveScale = 400.0f;
			
			mLog = LogManager.Singleton.createLog("DemoFireworks.log", false, true );
			mLog.LogMessage(string.Format("DemoFireworks log {0}" , System.DateTime.Now ) );
			
			mLog.LogMessage("CreateScene point setup envirenment");
			mSceneManager.SetAmbientLight( Converter.GetColor(0.15f, 0.15f, 0.15f) );
			mSceneManager.SetSkyBox( true, "skybox/Starfield", 1000.0f);
			
			mLog.LogMessage("CreateScene point setup mainlight");
			/*******/
			Light l = mSceneManager.CreateLight("MainLight");
			l.SetPosition( 0.0f, 50.0f, 0.0f );
			l.SetSpecularColour( 0.25f, 0.25f, 0.25f );
			l.SetDiffuseColour( 0.25f, 0.25f, 0.25f );
			l.SetCastShadows(false);
			/*******/
			
			mLog.LogMessage("CreateScene point setup groundplane");
			Plane plane = new Plane( new Vector3(0,1,0), 0  );
			MeshManager.GetSingleton().CreatePlane( "GroundPlane", "General", plane,
				150000,150000,10,10,true,1,100,100,Vector3.UnitZ );
			Entity pPlaneEnt = mSceneManager.CreateEntity( "Ground", "GroundPlane" );
			pPlaneEnt.SetMaterialName("Examples/GrassFloor");
			pPlaneEnt.SetCastShadows(false);
			mSceneManager.GetRootSceneNode().CreateChildSceneNode().AttachObject(pPlaneEnt);
			
			
			/*******/
			mLog.LogMessage("CreateScene point setup sky clouds");
			plane = new Plane( new Vector3(0,-1,0), -4000  );
			MeshManager.GetSingleton().CreatePlane( "CloudsPlaneBottom", "General", plane,
				150000,150000,10,10,true,1,1,1,Vector3.UnitZ );
			pPlaneEnt = mSceneManager.CreateEntity( "CloudsBottom", "CloudsPlaneBottom" );
			pPlaneEnt.SetMaterialName("firworks/clouds01/512");
			pPlaneEnt.SetCastShadows(false);
			mSceneManager.GetRootSceneNode().CreateChildSceneNode().AttachObject(pPlaneEnt);
			
			plane = new Plane( new Vector3(0,1,0), 4000  );
			MeshManager.GetSingleton().CreatePlane( "CloudsPlaneTop", "General", plane,
				150000,150000,10,10,true,1,1,1,Vector3.UnitZ );
			pPlaneEnt = mSceneManager.CreateEntity( "CloudsTop", "CloudsPlaneTop" );
			pPlaneEnt.SetMaterialName("firworks/clouds01/512");
			pPlaneEnt.SetCastShadows(false);
			SceneNode pNode = mSceneManager.GetRootSceneNode().CreateChildSceneNode();
			pNode.AttachObject(pPlaneEnt);
			pNode.Yaw( 180.0f );
			/*******/
			
			// -1014 x -1363
			/*******/
			mLog.LogMessage("CreateScene point setup default fountains");
			string strName = this.GetFWName();
			cfirework fw = new cfirework(strName, cfirework.FWType.Fountain01, mSceneManager);
			fw.mNode.SetPosition ( -50.0f, 1.0f, 0.0f );
			fw.mTimeToLive = 0;
			fw.mMoveable = false;
			mALFireworks.Add(fw);
			
			strName = this.GetFWName();
			fw = new cfirework(strName, cfirework.FWType.Fountain01, mSceneManager);
			fw.mNode.SetPosition ( 50.0f, 1.0f, 0.0f );
			fw.mTimeToLive = 0;
			fw.mMoveable = false;
			mALFireworks.Add(fw);
			/******/
			mtimeNext = OgreDotNet.OgreMath.RangeRandom( 0.0f, 2.0f);
			
			mLog.LogMessage("CreateScene point setup camera");
			mCamera.SetPosition( 0.0f, 400.0f, 3000.0f );
			mCamera._lookAt( 0.0f, 5.0f, 0.0f );
			
			mLog.LogMessage("CreateScene point call create4LineDebugOverLay");
			create4LineDebugOverLay();
			Show4LineDebugOverLay();
			
		}


		protected override bool FrameStarted( FrameEvent e )
		{
			if (!base.FrameStarted( e ))
				return false;
			timeDelay -= e.TimeSinceLastFrame;
			
			mtimeNext -= e.TimeSinceLastFrame;
			if (mtimeNext <= 0)
			{
				//mLog.LogMessage("FrameStarted timeNext");
				string strName = this.GetFWName();
				cfirework fw = new cfirework(strName, cfirework.FWType.Rocket01, mSceneManager);
				fw.mNode.SetPosition ( 0.0f, 1.0f, 0.0f );
				fw.mTimeToLive = OgreDotNet.OgreMath.RangeRandom( 1.0f, 3.0f);
				mALFireworks.Add(fw);
				mtimeNext = OgreDotNet.OgreMath.RangeRandom( 0.0f, 1.5f);
			}
			foreach (cfirework fw in mALFireworks)
			{
				fw.Update(e.TimeSinceLastFrame);
			}
			bool bBroke=false;
			do {
				bBroke= false;
				foreach (cfirework fw in mALFireworks)	{
					if (fw.isDead)	{
						mALFireworks.Remove( fw );
						if (fw.mPS != null)	{
							mSceneManager.DestroyParticleSystem(  fw.mPS.GetName() );
							fw.mPS = null;
						}
						if (fw.mPS2 != null)	{
							mSceneManager.DestroyParticleSystem( fw.mPS2.GetName() );
							fw.mPS2 = null;
						}
						if (fw.mNode != null)	{
							mSceneManager.DestroySceneNode( fw.mNode.GetName() );
							fw.mNode = null;
						}
						bBroke=true;
						break;
					}
				}
			} while (bBroke);


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





		/// <summary>
		/// Disposes 
		/// </summary>
		public override void Dispose()
		{
			m_Singleton= null;
			mALFireworks.Clear();
			base.Dispose();
		}


		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main(string[] args)
		{
			cFireworks app = new cFireworks();
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
				catch 
				{
				}
			}
		}
	}
}
