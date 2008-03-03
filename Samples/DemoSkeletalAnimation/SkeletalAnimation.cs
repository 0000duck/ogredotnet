using System;
using System.Drawing;

using OgreDotNet;
using Math3D;

namespace SkeletalApplication {
	
	class SkeletalApplication : ExampleApplication {
		
		protected const int IM_LINEAR = 0;
		protected const int RIM_LINEAR = 0;
		protected const int NUM_ROBOTS = 10;
		protected const int ROW_COUNT = 10;

		protected AnimationState[] mAnimState = new AnimationState[NUM_ROBOTS];
		protected float[] mAnimationSpeed = new float[NUM_ROBOTS];
		
		// Just override the mandatory create scene method
		protected override void CreateScene() {
			
			// Setup animation default
			Animation.SetDefaultInterpolationMode(Animation.InterpolationMode.Linear);
			Animation.SetDefaultRotationInterpolationMode( Animation.RotationInterpolationMode.RLinear );

			// Set ambient light
			mSceneManager.SetAmbientLight(Color.FromArgb(128,128,128));
			
			// Set Background Color
			mViewport.BackgroundColor = Color.Black;
			
			Entity ent;
			int row = 0;
			int column = 0;
			for (int i = 0; i < NUM_ROBOTS; ++i, ++column) {
				if (column > ROW_COUNT) {
					++row;
					column = 0;
				}

				ent = mSceneManager.CreateEntity(string.Format("robot{0}",i), "robot.mesh");
				// Add entity to the scene node
				mSceneManager.GetRootSceneNode().CreateChildSceneNode(
					new Vector3(-(row*100), 0,(column*50))).AttachObject(ent);

				mAnimState[i] = ent.GetAnimationState("Walk");
				mAnimState[i].SetEnabled(true);
				mAnimationSpeed[i] = OgreMath.RangeRandom(0.5f, 1.5f);
				if (i==0)
				{
					Technique t = ent.GetSubEntity(0).getMaterial().Get().GetBestTechnique();
					Pass p = t.getPass(0);
					if (p.hasVertexProgram() && 
						p.getVertexProgram().Get().isSkeletalAnimationIncluded()) {
						mRenderWindow.SetDebugText("Hardware skinning is enabled");
					}
					else {
						mRenderWindow.SetDebugText("Software skinning is enabled");
					}
				}
			}
			// Give it a little ambience with lights
			Light l;
			l = mSceneManager.CreateLight("BlueLight");
			l.SetPosition(-200,-80,-100);
			l.SetDiffuseColour(0.5f, 0.5f, 1.0f);

			l = mSceneManager.CreateLight("GreenLight");
			l.SetPosition(0,0,-100);
			l.SetDiffuseColour(0.5f, 1.0f, 0.5f);

			// Position the camera
			mCamera.SetPosition(100,50,100);
			mCamera.LookAt = new Vector3(-50,50,0);
			
		}
		protected override bool FrameStarted( FrameEvent e )
		{
			if(!base.FrameStarted(e)) {
				return false;
			}
			for (int i = 0; i < NUM_ROBOTS; ++i)
			{
				mAnimState[i].AddTime(e.TimeSinceLastFrame * mAnimationSpeed[i]);
			}
			return true;
		}

		[STAThread]
		static void Main(string[] args) {
			using (SkeletalApplication app = new SkeletalApplication()) {
				app.Start();
			}
		}
	}
}
