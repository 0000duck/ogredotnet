using System;
using System.IO;
using System.Drawing;
using OgreDotNet;
using Math3D;

namespace DemoSimple
{
    public class App
    {
        protected Root mRoot = null;
        public Root Root
        {
            get { return mRoot; }
        }

        protected RenderWindow mRenderWindow = null;
        public RenderWindow RenderWindow
        {
            get { return mRenderWindow; }
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

        public App()
        {
            mRoot = new Root(String.Format("plugins-{0}.cfg", GetOS()));
            Initialiser.SetupResources("resources.cfg");
            mRoot.ShowConfigDialog();
            mRenderWindow = mRoot.Initialise(true);

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
            // TODO: enabling this causes a crash:
//            mSceneManager.RootSceneNode.CreateChildSceneNode(new Math3D.Vector3(0.0f, 6.5f, -67.0f)).AttachObject(mParticleSystem);
        }

        [STAThread]
        static void Main() 
        {
            App app = new App();

            while (true)
            {
                app.Root.RenderOneFrame();
                app.RenderWindow.Update();
            }

            app.Root.Dispose();
        }
    }
}
