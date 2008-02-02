using System;
using System.Drawing;

using OgreDotNet;

using Math3D;

namespace SkyBox
{
	class SkyBoxApplication : ExampleApplication
	{
		protected Light mLight = null;
		protected Entity mEntity = null;
		protected ParticleSystem mParticleSystem = null;
		protected ParticleEmitter mParticleEmitter1 = null;
		protected ParticleEmitter mParticleEmitter2 = null;

		protected SceneNode mCameraPosition = null;
		protected SceneNode mCameraTarget = null;
		protected bool mRollLeft = false;
		protected bool mRollRight = false;

		protected override void CreateScene()
		{
			mSceneManager.AmbientLightColor = Color.FromArgb(125, 125, 125, 125);
			mSceneManager.SetSkyBox(true, "Examples/SpaceSkyBox", 50);

			mCameraTarget = mSceneManager.RootSceneNode.CreateChildSceneNode();
			mCameraPosition = mCameraTarget.CreateChildSceneNode( new Vector3( 0, 0, -200 ));
			mCameraPosition.AttachObject( mCamera );
			mCamera.SetPosition( 0, 0 , 0 );
			mCamera.LookAt = new Vector3(0,0,0);
			mCamera.NearClipDistance = 5;

			mLight = mSceneManager.CreateLight("MainLight");
			mLight.Position = new Math3D.Vector3(20, 80, 50);

			mEntity = mSceneManager.CreateEntity("razor", "razor.mesh");
			mSceneManager.RootSceneNode.AttachObject(mEntity);

			mParticleSystem = mSceneManager.CreateParticleSystem( "ParticleSys1", 200);
			mParticleSystem.MaterialName = "Examples/Flare";
			mParticleSystem.SetDefaultDimensions(25, 25);

			mParticleEmitter1 = mParticleSystem.AddEmitter("Point");
            mParticleEmitter1.TimeToLive = 0.2f;
            mParticleEmitter1.EmissionRate = 70.0f;
            mParticleEmitter1.ParticleVelocity = 100.0f;
            mParticleEmitter1.Direction = new Math3D.Vector3(0.0f, 0.0f, -1.0f);
            mParticleEmitter1.SetColors(Color.White, Color.Red);
            mParticleEmitter1.Position = new Math3D.Vector3(5.7f, 0.0f, 0.0f);

			mParticleEmitter2 = mParticleSystem.AddEmitter("Point");
            mParticleEmitter2.TimeToLive = 0.2f;
            mParticleEmitter2.EmissionRate = 70.0f;
            mParticleEmitter2.ParticleVelocity = 100.0f;
            mParticleEmitter2.Direction = new Math3D.Vector3(0.0f, 0.0f, -1.0f);
            mParticleEmitter2.SetColors(Color.White, Color.Red);
            mParticleEmitter2.Position = new Math3D.Vector3(-18.0f, 0.0f, 0.0f);
			mSceneManager.RootSceneNode.
				CreateChildSceneNode(new Math3D.Vector3(0.0f, 6.5f, -67.0f)).AttachObject(mParticleSystem);

		}

		protected override bool FrameStarted( FrameEvent e )
		{
			if( mRenderWindow.Closed || mDone ) return false;

			mDeltaTime = e.TimeSinceLastFrame;

			UpdateDebugOverlay();

			if( mRollLeft ) mCameraTarget.Roll( new Radian( -3.0f * mDeltaTime ));
			if( mRollRight) mCameraTarget.Roll( new Radian( 3.0f * mDeltaTime ));

			return true;
		}

		protected override bool FrameEnded( FrameEvent e )
		{
			return base.FrameEnded(e);
		}

		protected override void MouseMotion( MouseMotionEvent e )
		{
			mCameraTarget.Pitch( new Radian(-e.DeltaY * mDeltaTime * 500.0f));
			mCameraTarget.Yaw( new Radian(-e.DeltaX * mDeltaTime * 500.0f));

			if( e.DeltaZ > 0 )
			{
				Vector3 initial = mCameraPosition.Position;
				Vector3 final = new Vector3(initial.x*1.1f, initial.y*1.1f, initial.z*1.1f);
				Vector3 delta = Vector3.Subtract(initial, final);
				mCameraPosition.Translate(delta, Node.TransformSpace.TS_LOCAL);
			}
			if( e.DeltaZ < 0 )
			{
				Vector3 initial = mCameraPosition.Position;
				Vector3 final = new Vector3(initial.x*0.9f, initial.y*0.9f, initial.z*0.9f);
				Vector3 delta = Vector3.Subtract(initial, final);
				mCameraPosition.Translate(delta, Node.TransformSpace.TS_LOCAL);
			}
		}
		protected override void MouseDragged( MouseMotionEvent e )
		{
			MouseMotion( e );
		}

		protected override void MousePressed( MouseEvent e )
		{
			switch( e.ButtonID )
			{
				case 16:
					mRollLeft = true;
					break;
				case 32:
					mRollRight = true;
					break;
			}
		}

		protected override void MouseReleased( MouseEvent e )
		{
			switch( e.ButtonID )
			{
				case 16:
					mRollLeft = false;
					break;
				case 32:
					mRollRight = false;
					break;
			}
		}

		protected override void KeyClicked( KeyEvent e )
		{
			switch( e.KeyCode )
			{
				case KeyCode.Home:
					break;
				default:
					base.KeyClicked(e);
					break;
			}
		}

		protected override void KeyPressed( KeyEvent e )
		{
		}

		protected override void KeyReleased( KeyEvent e )
		{
		}

		[STAThread]
		static void Main(string[] args)
		{
			SkyBoxApplication app = new SkyBoxApplication();
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
