using System;
using System.Drawing;
using System.Runtime.InteropServices;

using Math3D;
using OgreDotNet;

namespace DemoFireworks
{
	/// <summary>
	/// Base class for simple demos.
	/// </summary>
	public abstract class cApplication : IDisposable
	{
		protected Root mRoot = null;
		protected RenderWindow mRenderWindow = null;
		protected SceneManager mSceneManager = null;
		protected Camera mCamera = null;
		protected Viewport mViewport = null;
		protected OgreDotNet.EventHandler mEventHandler = null;

		protected Overlay mDebugOverlay = null;
		protected OverlayElement mAverageFPS = null;
		protected OverlayElement mBestFPS = null;
		protected OverlayElement mWorstFPS = null;
		protected OverlayElement mCurrentFPS = null;
		protected OverlayElement mTriangleCount = null;

		protected float mDeltaTime = 0.0f;

		protected bool mDone = false;

		protected bool mDebugOverlayVisible = true;
		protected bool mWireFrame = false;
		protected TextureFilterOptions mFilter = TextureFilterOptions.TfoBilinear;
		protected UInt32 mAnisotropy = 1;

		protected bool mRollLeft = false;
		protected bool mRollRight = false;
		protected int	mMouseMoveCam=0;
		protected int  mScreenShotCount=0;

		/// <summary>
		/// Initialises Ogre and starts rendering.
		/// </summary>
		public void Start()
		{
			if( !Setup() ) return;

			mRoot.StartRendering();
		}

		/// <summary>
		/// Initialises Ogre objects and event handling, loads resources, and calls ExampleApplication.CreateScene().
		/// </summary>
		/// <returns>Returns true if successfull, false if unsuccessfull</returns>
		/// <remarks>This method should only be called by the user if ExampleApplication.Start() is not called.</remarks>
		/// <seealso>ExampleApplication.Start</seealso>
		protected bool Setup()
		{
			mRoot = new Root();
			Initialiser.SetupResources("resources.cfg");
			if( !mRoot.ShowConfigDialog() ) return false;
			mRenderWindow = mRoot.Initialise(true, "Ogre Render Window");
			mSceneManager = this.mRoot.GetSceneManager( SceneType.Generic );

			mCamera = this.mSceneManager.CreateCamera("MainCamera");
			mCamera.SetPosition( 0, 0, -200 );
			mCamera.LookAt = new Vector3(0,0,0);
			mCamera.NearClipDistance = 5;
			mViewport = mRenderWindow.AddViewport( mCamera );
			mViewport.BackgroundColor = Color.Blue;
			mCamera.AspectRatio = (float)mViewport.ActualWidth/(float)mViewport.ActualHeight;

			TextureManager.Instance.SetDefaultNumMipmaps(5);

			ResourceGroupManager.getSingleton().initialiseAllResourceGroups();

			mEventHandler = new OgreDotNet.EventHandler( mRoot, mRenderWindow );
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

			InputReader inputreader = mEventHandler.GetInputReader();

			mDebugOverlay = OverlayManager.getSingleton().getByName("Core/DebugOverlay");
			mAverageFPS = OverlayManager.getSingleton().getOverlayElement("Core/AverageFps");
			mCurrentFPS = OverlayManager.getSingleton().getOverlayElement("Core/CurrFps");
			mBestFPS = OverlayManager.getSingleton().getOverlayElement("Core/BestFps");
			mWorstFPS = OverlayManager.getSingleton().getOverlayElement("Core/WorstFps");
			mTriangleCount = OverlayManager.getSingleton().getOverlayElement("Core/NumTris");
			DebugOverlayVisible = true;

			MaterialManager.Instance.SetDefaultTextureFiltering(mFilter);
			MaterialManager.Instance.SetDefaultAnisotropy(mAnisotropy);

			CreateScene();

			return true;
		}

		/// <summary>
		/// Called when user defined objects need to be instanced.
		/// </summary>
		protected abstract void CreateScene();


		/// <summary>
		/// Called at the start of a rendering frame.
		/// </summary>
		/// <param name="timesincelastframe"></param>
		/// <param name="timesincelastevent"></param>
		/// <returns></returns>
		protected virtual bool FrameStarted( FrameEvent e )
		{
			if( mRenderWindow.Closed || mDone ) return false;

			mDeltaTime = e.TimeSinceLastFrame;

			UpdateDebugOverlay();

			if( mRollLeft ) mCamera.Roll( new Radian( -3.0f * mDeltaTime ));
			if( mRollRight) mCamera.Roll( new Radian( 3.0f * mDeltaTime ));

			if (mMouseMoveCam > 0)	{
				float dt = mDeltaTime;
				if (mMouseMoveCam==1)
					dt *= -1.0f;
				Vector3 vmove= new Vector3( 0.0f, 0.0f, 400.0f * dt  );
				mCamera.MoveRelative( vmove );
			}
			
			return true;
		}


		/// <summary>
		/// Called at the end of a rendering frame.
		/// </summary>
		/// <param name="timesincelastframe"></param>
		/// <param name="timesincelastevent"></param>
		/// <returns></returns>
		protected virtual bool FrameEnded( FrameEvent e )
		{
			return true;
		}


		/// <summary>
		/// Called at the end of a rendering frame.
		/// </summary>
		/// <param name="deltax"></param>
		/// <param name="deltay"></param>
		/// <param name="deltaz"></param>
		protected virtual void MouseMotion( MouseMotionEvent e )
		{
			mCamera.Pitch( new Radian(-e.DeltaY * mDeltaTime * 500.0f));
			mCamera.Yaw( new Radian(-e.DeltaX * mDeltaTime * 500.0f));
		}

		/// <summary>
		/// Called when the mouse moves while a mouse button is down.
		/// </summary>
		/// <param name="deltax"></param>
		/// <param name="deltay"></param>
		/// <param name="deltaz"></param>
		protected virtual void MouseDragged( MouseMotionEvent e )
		{
			this.MouseMotion( e );
		}

		/// <summary>
		/// Called when a mouse button is clicked.
		/// </summary>
		/// <param name="x"></param>
		/// <param name="y"></param>
		/// <param name="z"></param>
		/// <param name="buttonid"></param>
		protected virtual void MouseClick( MouseEvent e )
		{
			
		}

		/// <summary>
		/// Called when a mouse button is pressed down.
		/// </summary>
		/// <param name="x"></param>
		/// <param name="y"></param>
		/// <param name="z"></param>
		/// <param name="buttonid"></param>
		protected virtual void MousePressed( MouseEvent e )
		{
			switch( e.ButtonID )
			{
				case 16:
					if (mMouseMoveCam==0)	mMouseMoveCam =1;
					break;
				case 32:
					if (mMouseMoveCam==0)	mMouseMoveCam =2;
					break;
			}
		}

		/// <summary>
		/// Called when a mouse button is released.
		/// </summary>
		/// <param name="x"></param>
		/// <param name="y"></param>
		/// <param name="z"></param>
		/// <param name="buttonid"></param>
		protected virtual void MouseReleased( MouseEvent e )
		{
			switch( e.ButtonID )
			{
				case 16:
					if (mMouseMoveCam==1)	mMouseMoveCam=0;
					break;
				case 32:
					if (mMouseMoveCam==2)	mMouseMoveCam=0;
					break;
			}
		}

		/// <summary>
		/// Called when a key is clicked.
		/// </summary>
		/// <param name="keycode"></param>
		/// <param name="shift"></param>
		/// <param name="alt"></param>
		/// <param name="ctrl"></param>
		protected virtual void KeyClicked( KeyEvent e )
		{
			switch( e.KeyCode )
			{
				case KeyCode.F:
					DebugOverlayVisible = !DebugOverlayVisible;
					break;
				case KeyCode.Escape:
					mDone = true;
					break;
				case KeyCode.R:
					mWireFrame = !mWireFrame;
					if( mWireFrame )
						mCamera.DetailLevel = SceneDetailLevel.SdlWireframe;
					else
						mCamera.DetailLevel =  SceneDetailLevel.SdlSolid;
					break;
				case KeyCode.T:
					switch(mFilter)
					{
						case TextureFilterOptions.TfoBilinear:
							mFilter = TextureFilterOptions.TfoTrilinear;
							mAnisotropy = 1;
							break;
						case TextureFilterOptions.TfoTrilinear:
							mFilter = TextureFilterOptions.TfoAnisotropic;
							mAnisotropy = 8;
							break;
						case TextureFilterOptions.TfoAnisotropic:
							mFilter = TextureFilterOptions.TfoBilinear;
							mAnisotropy = 1;
							break;
					}
					MaterialManager.Instance.SetDefaultTextureFiltering( mFilter );
					MaterialManager.Instance.DefaultAnisotropy = mAnisotropy;
					break;
				case KeyCode.SYSRQ:
					mRenderWindow.WriteContentsToFile( string.Format("ScreenShot{0}.png", mScreenShotCount++) );
					break;
			}
		}

		/// <summary>
		/// Called when a key is pressed down.
		/// </summary>
		/// <param name="keycode"></param>
		/// <param name="shift"></param>
		/// <param name="alt"></param>
		/// <param name="ctrl"></param>
		protected virtual void KeyPressed( KeyEvent e )
		{

		}

		/// <summary>
		/// Called when a key is released.
		/// </summary>
		/// <param name="keycode"></param>
		/// <param name="shift"></param>
		/// <param name="alt"></param>
		/// <param name="ctrl"></param>
		protected virtual void KeyReleased( KeyEvent e )
		{

		}

		/// <summary>
		/// Sets or gets the visibility of the debug overlay.
		/// </summary>
		protected bool DebugOverlayVisible
		{
			set
			{
				mDebugOverlayVisible = value;
				if( value )
					mDebugOverlay.show();
				else
					mDebugOverlay.hide();
			}
			get
			{
				return mDebugOverlayVisible;
			}
		}

		/// <summary>
		/// Updates the debug overlay with the current frame rate statistics and triangle count.
		/// </summary>
		protected void UpdateDebugOverlay()
		{
			mCurrentFPS.setCaption("Current FPS: " + mRenderWindow.LastFPS );
			mAverageFPS.setCaption("Average FPS: " + mRenderWindow.AverageFPS );
			mBestFPS.setCaption("Best FPS: " + mRenderWindow.BestFPS );
			mWorstFPS.setCaption("Worst FPS: " + mRenderWindow.WorstFPS );
			mTriangleCount.setCaption("Triangle Count: " + mRenderWindow.TriangleCount );
		}

		/// <summary>
		/// Disposes of the ExampleApplication instance.
		/// </summary>
		public virtual void Dispose()
		{
			mRoot.Dispose();
		}
	}
}
