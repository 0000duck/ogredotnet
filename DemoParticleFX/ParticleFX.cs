using System;
using System.Drawing;

using OgreDotNet;
using Math3D;

namespace DemoParticleFX
{
	/// <summary>
	/// Zusammenfassung fr ParticleFX.
	/// </summary>
	public class ParticleFXApplication : ExampleApplication
	{
		protected SceneNode mFountainNode;

		public ParticleFXApplication()
		{
		}


		// Just override the mandatory create scene method
		protected override void CreateScene()
		{
			this.mViewport.BackgroundColor = Color.Black;

			// Set ambient light
			mSceneManager.AmbientLight = Color.FromArgb(255, 125, 125, 125);
       
			Entity ent = mSceneManager.CreateEntity("head", "ogrehead.mesh");

			// Add entity to the root scene node
			mSceneManager.GetRootSceneNode().CreateChildSceneNode().AttachObject(ent);

			// Green nimbus around Ogre
			ParticleSystem pSys1 = mSceneManager.CreateParticleSystem("Nimbus", "Examples/GreenyNimbus");
			mSceneManager.GetRootSceneNode().CreateChildSceneNode().AttachObject(pSys1);

			// Create shared node for 2 fountains
			mFountainNode = mSceneManager.GetRootSceneNode().CreateChildSceneNode();

			// fountain 1
			ParticleSystem pSys2 = mSceneManager.CreateParticleSystem("fountain1", 
															   "Examples/PurpleFountain");
			// Point the fountain at an angle
			SceneNode fNode = mFountainNode.CreateChildSceneNode();
			fNode.Translate(200,-100,0);
			fNode.Rotate(Vector3.UnitZ, new Radian(new Degree(20)));
			fNode.AttachObject(pSys2);

			// fountain 2
			ParticleSystem pSys3 = mSceneManager.CreateParticleSystem("fountain2", 
															   "Examples/PurpleFountain");
			// Point the fountain at an angle
			fNode = mFountainNode.CreateChildSceneNode();
			fNode.Translate(-200,-100,0);
			fNode.Rotate(Vector3.UnitZ, new Radian(new Degree(-20)));
			fNode.AttachObject(pSys3);

			// Create a rainstorm 
			ParticleSystem pSys4 = mSceneManager.CreateParticleSystem("rain", 
															   "Examples/Rain");
			SceneNode rNode = mSceneManager.GetRootSceneNode().CreateChildSceneNode();
			rNode.Translate(0,1000,0);
			rNode.AttachObject(pSys4);
			// Fast-forward the rain so it looks more natural
			pSys4.FastForward(5);

			mCamera.SetPosition( 0, 0, 200 );
			mCamera.LookAt = new Vector3(0,0,0);
		}
		
		protected override bool FrameStarted( FrameEvent e )
		{
			if(!base.FrameStarted(e))
			{
				return false;
			}
			// Rotate fountains
			mFountainNode.Yaw(new Radian((new Degree(e.TimeSinceLastFrame * 30))));

			return true;
		}

		[STAThread]
		static void Main(string[] args)
		{
			ParticleFXApplication app = new ParticleFXApplication();
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
