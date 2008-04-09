using System;
using System.Drawing;
using System.IO;
using System.Windows.Forms;
using OgreDotNet;
using Math3D;

namespace DemoWinForms
{
    public class App
    {
        protected Root mRoot = null;
        public Root Root
        {
            get
            {
                return mRoot;
            }
        }

        protected RenderWindow mRenderWindow = null;
        public RenderWindow RenderWindow
        {
            get
            {
                return mRenderWindow;
            }
        }

        protected SceneManager mSceneManager = null;
        protected Camera mCamera = null;
        protected Viewport mViewport = null;

        protected Light mLight = null;
        protected Entity mEntity = null;
        protected ParticleSystem mParticleSystem = null;
        protected ParticleEmitter mParticleEmitter1 = null;
        protected ParticleEmitter mParticleEmitter2 = null;

        public static string GetOS()
        {
            if (Environment.OSVersion.Platform == PlatformID.Unix)
            {
                if (File.Exists("/System/Library/Frameworks/Cocoa.framework/Cocoa"))
                {
                    return "osx";
                }
                else
                {
                    return "unix";
                }
            }
            else
            {
                return "win";
            }
        }

        public App(Control control)
        {
            mRoot = new Root(String.Format("plugins-{0}.cfg", GetOS()));
            Initialiser.SetupResources("resources.cfg");
            mRoot.ShowConfigDialog();
            mRenderWindow = mRoot.Initialise(control);

            mSceneManager = mRoot.CreateSceneManager((UInt16)SceneType.Generic, "ExampleSMInstance");

            mCamera = mSceneManager.CreateCamera("MainCamera");
            mCamera.Position = new Math3D.Vector3(150, 150, 150);
            mCamera.LookAt(new Math3D.Vector3(0, 0, 0));
            mCamera.NearClipDistance = 5;

            mViewport = mRenderWindow.AddViewport(mCamera);
            mViewport.BackgroundColor = Color.Blue;
            mCamera.AspectRatio = (float)mViewport.ActualWidth/(float)mViewport.ActualHeight;

            TextureManager.Instance.SetDefaultNumMipmaps(5);

            ResourceGroupManager.getSingleton().initialiseAllResourceGroups();

            mSceneManager.AmbientLightColor = Color.FromArgb(125, 125, 125, 125);
            mSceneManager.SetSkyBox(true, "Examples/SpaceSkyBox", 50);

            mLight = mSceneManager.CreateLight("MainLight");
            mLight.Position = new Math3D.Vector3(20, 80, 50);

            mEntity = mSceneManager.CreateEntity("razor", "razor.mesh");
            mSceneManager.RootSceneNode.AttachObject(mEntity);

            mParticleSystem = mSceneManager.CreateParticleSystem("ParticleSys1", 200);
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
    }
}
