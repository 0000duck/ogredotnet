using System;
using System.Drawing;

using OgreDotNet;
using Math3D;

namespace DemoSkeletalAnimation
{
	/// <summary>
	/// Skeletal Animation sample from Ogre, using C# and OgreDotNet
	/// </summary>
	public class SkeletalAnimationApplication : ExampleApplication
	{
        int NUM_ROBOTS = 10;
        int ROW_COUNT = 10;
        protected Entity ent = null;
        AnimationState [] AnimState;
        float [] AnimationSpeed;

        public SkeletalAnimationApplication()
		{
            AnimState = new AnimationState[NUM_ROBOTS];
            AnimationSpeed = new float[NUM_ROBOTS];
		}



		// Just override the mandatory create scene method
		protected override void CreateScene()
		{
            Animation.SetDefaultInterpolationMode((int)InterpolationMode.Linear);
            Animation.SetDefaultRotationInterpolationMode(0/*RotationInterpolationMode.Linear*/);

            mSceneManager.AmbientLight = Color.FromArgb(255, 125, 125, 125);


            
            int row = 0;
            int column = 0;

            for(int i = 0; i < NUM_ROBOTS; ++i, ++column)
            {
                if(column > ROW_COUNT)
                {
                    ++row;
                    column = 0;
                }

                ent = mSceneManager.CreateEntity("robot" + i.ToString(), "robot.mesh");
                //Add entity to the scene node
                mSceneManager.GetRootSceneNode().CreateChildSceneNode(new Math3D.Vector3(-(row *100), 0, (column*50))).AttachObject(ent);
                AnimState[i] = ent.GetAnimationState("Walk");
                AnimState[i].SetEnabled(true);
                AnimationSpeed[i] = (1.5f);
            }

            Light l = new Light();
            l = mSceneManager.CreateLight("BlueLight");
            l.SetPosition(-200, -80, -100);
            l.SetDiffuseColour(0.5f, 0.5f, 1.0f);

            l = mSceneManager.CreateLight("GreenLight");
            l.SetPosition(0, 0, -100);
            l.SetDiffuseColour(0.5f, 1.0f, 0.5f);

            mCamera.SetPosition(100, 50, 100);
            mCamera.LookAt = new Vector3(-50, 50, 0);

            Technique t =  ent.GetSubEntity(0).getMaterial().GetBestTechnique();
            Pass p = t.getPass(0);

            if (p.hasVertexProgram() &&
                p.getVertexProgram().isSkeletalAnimationIncluded())
            {
                this.mRenderWindow.SetDebugText("Hardware skinning is enabled");
            }
            else
            {
                this.mRenderWindow.SetDebugText("Software skinning is enabled");
            }


            this.mEventHandler.FrameStarted += new FrameEventDelegate(FrameStarted);
		}

        public new bool FrameStarted(FrameEvent evt)
		{

            if (!base.FrameStarted(evt))
            {
                return false;
            }

            for (int i = 0; i < NUM_ROBOTS; i++)
            {
                AnimState[i].AddTime(evt.TimeSinceLastFrame * AnimationSpeed[i]);
            }
            return true;
		}

        
        [STAThread]
        static void Main(string[] args)
		{
			using( SkeletalAnimationApplication app = new SkeletalAnimationApplication() )
			{
				app.Start();
			}
		}
	}
}
