using System;
using System.Drawing;
using System.Runtime.InteropServices;
using System.IO;

using Math3D;
using OgreDotNet;

namespace OgreDotNet
{
	/// <summary>
	/// Base class for simple demos.
	/// </summary>
	public abstract class ExampleApplication : IDisposable
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

		protected int   mRoll=0;
		protected int   mPitch=0;
		protected int   mYaw=0;
        protected int mMoveCam = 0;	//bits: 1=forward, 2=backward, 4=left, 8=right, 16=up, 32=down
		protected float mMoveScale=150.0f;
		protected float mRotateScale=3.0f;
		protected int   mScreenShotCount=0;

		protected OverlayContainer			mPanel=null;
		protected Overlay					mOverlay=null;
		protected TextAreaOverlayElement	mODebugText1=null, mODebugText2=null, mODebugText3=null, mODebugText4=null;

		/// <summary>
		/// Initialises Ogre and starts rendering.
		/// </summary>
		public virtual void Start()
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
		protected virtual bool Setup()
		{
			mRoot = new Root();
			
			SetupResources( "resources.cfg" );
			
			if( !mRoot.ShowConfigDialog() )
				return false;
			
			mRenderWindow = mRoot.Initialise(true, "Ogre Render Window");
			
			CreateSceneManager();
			CreateCamera();
			CreateViewPort();
			
			TextureManager.Instance.SetDefaultNumMipmaps(5);
			
			LoadResources();
			
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
			
			CreateEventHandler();
			
			return true;
		}

		/// <summary>
		/// Called in Setup when Resources should be added to ResourceGroupManager
		/// Method which will define the source of resources (other than current folder)
		/// </summary>
		protected virtual void SetupResources(string sFileName)
		{
			//Initialiser.SetupResources(sFileName);
			using (StreamReader sr = new StreamReader(sFileName)) 
			{
				string secName="", sLocType, sarchName;
				string line;
				while ((line = sr.ReadLine()) != null) 
				{
					int x=line.IndexOf("#");
					if (x>-1)
						line = line.Substring(0, x);
					line = line.Trim();
					if (line.Length > 0)
					{
						if (line[0] == '[')
						{
							secName = line.Substring(1, line.Length-2);
						}
						else if (secName.Length >0)
						{
							x=line.IndexOf("=");
							if (x <= 0)
								throw new Exception("Invalid line in resource file " + sFileName );
							sLocType = line.Substring( 0, x);
							sarchName = line.Substring( x+1 );
							ResourceGroupManager.getSingleton().addResourceLocation( sarchName, sLocType, secName );
						}
					}
				}
			}
		}

		/// <summary>
		/// Called when the SceneManager needs to be created.
		/// </summary>
		protected virtual void CreateSceneManager()
		{
			mSceneManager = this.mRoot.CreateSceneManager( (UInt16)SceneType.Generic, "ExampleSMInstance" );
		}

		/// <summary>
		/// Called when the default camera needs to be created.
		/// </summary>
		protected virtual void CreateCamera()
		{
			mCamera = this.mSceneManager.CreateCamera("MainCamera");
			mCamera.SetPosition( 0, 0, -200 );
			mCamera.LookAt = new Vector3(0,0,0);
			mCamera.NearClipDistance = 5;
		}

		/// <summary>
		/// Called when the default ViewPort needs to be created.
		/// </summary>
		protected virtual void CreateViewPort()
		{
			mViewport = mRenderWindow.AddViewport( mCamera );
			mViewport.BackgroundColor = Color.Blue;
			mCamera.AspectRatio = (float)mViewport.ActualWidth/(float)mViewport.ActualHeight;
		}
		
		///  <summary>
		/// Optional override method where you can perform resource group loading
		/// Must at least do ResourceGroupManager.getSingleton().initialiseAllResourceGroups();
		/// </summary>
		protected virtual void LoadResources()
		{
			ResourceGroupManager.getSingleton().initialiseAllResourceGroups();
		}

		///  <summary>
		///called by Setup. create EventHandler and set the Delegates
		/// </summary>
		protected virtual void CreateEventHandler()
		{
			if (mEventHandler==null)
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

			//InputReader inputreader = mEventHandler.GetInputReader();
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


			if ((mRoll & 1) > 0)
				mCamera.Roll( new Radian( mRotateScale * 1.0f * e.TimeSinceLastFrame ));
            if ((mRoll & 2) > 0)
                mCamera.Roll(new Radian(mRotateScale * -1.0f * e.TimeSinceLastFrame));
            if ((mPitch & 1) > 0)
                mCamera.Pitch(new Radian(mRotateScale * 1.0f * e.TimeSinceLastFrame));
            if ((mPitch & 2) > 0)
                mCamera.Pitch(new Radian(mRotateScale * -1.0f * e.TimeSinceLastFrame));
            if ((mYaw & 1) > 0)
                mCamera.Yaw(new Radian(mRotateScale * 1.0f * e.TimeSinceLastFrame));
            if ((mYaw & 2) > 0)
                mCamera.Yaw(new Radian(mRotateScale * -1.0f * e.TimeSinceLastFrame));

			if (mMoveCam > 0)
			{//mMoveCam bits: 1=forward, 2=backward, 4=left, 8=right, 16=up, 32=down
                Vector3 vCamMove = Vector3.Zero;
				float mvscale = mMoveScale * e.TimeSinceLastFrame;

                if ((mMoveCam & 1) > 0)
                    vCamMove += Vector3.NegativeUnitZ;
                if ((mMoveCam & 2) > 0)
                    vCamMove += Vector3.UnitZ;
                if ((mMoveCam & 4) > 0)
                    vCamMove += Vector3.NegativeUnitX;
                if ((mMoveCam & 8) > 0)
                    vCamMove += Vector3.UnitX;
                if ((mMoveCam & 16) > 0)
                    vCamMove += Vector3.UnitY;
                if ((mMoveCam & 32) > 0)
                    vCamMove += Vector3.NegativeUnitY;
                
				vCamMove *= mvscale;
				mCamera.MoveRelative( vCamMove );
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
					mMoveCam |= 1;
					break;
				case 32:
					mMoveCam |= 2;
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
                    mMoveCam &= ~1;
					break;
				case 32:
                    mMoveCam &= ~2;
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
				case KeyCode.Home:
					mCamera.SetOrientation( Quaternion.Identity );
					break;
				case KeyCode.F:
					DebugOverlayVisible = !DebugOverlayVisible;
					break;
				case KeyCode.Escape:
					mDone = true;
					break;
				case KeyCode.R:
					mWireFrame = !mWireFrame;
					if( mWireFrame )
						mCamera.DetailLevel = PolygonMode.PMWireframe;
					else
						mCamera.DetailLevel =  PolygonMode.PMSolid;
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
			switch( e.KeyCode )
			{
				case KeyCode.W:
					mMoveCam |= 1;
					break;
				case KeyCode.S:
					mMoveCam |= 2;
					break;
				case KeyCode.A:
					mMoveCam |= 4;
					break;
				case KeyCode.D:
					mMoveCam |= 8;
					break;
				case KeyCode.PageUp:
				case KeyCode.Q:
					mMoveCam |= 16;
					break;
				case KeyCode.PageDown:
				case KeyCode.Z:
					mMoveCam |= 32;
					break;

				case KeyCode.Insert:
					mRoll |= 1;
					break;
				case KeyCode.Delete:
					mRoll |= 2;
					break;
				case KeyCode.Up:
					mPitch |= 1;
					break;
				case KeyCode.Down:
					mPitch |= 2;
					break;
				case KeyCode.Left:
					mYaw |= 1;
					break;
				case KeyCode.Right:
					mYaw |= 2;
					break;
			}
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
			switch( e.KeyCode )
			{
				case KeyCode.W:
					mMoveCam &= ~1;
					break;
				case KeyCode.S:
                    mMoveCam &= ~2;
					break;
				case KeyCode.A:
                    mMoveCam &= ~4;
					break;
				case KeyCode.D:
                    mMoveCam &= ~8;
					break;
				case KeyCode.PageUp:
				case KeyCode.Q:
                    mMoveCam &= ~16;
					break;
				case KeyCode.PageDown:
				case KeyCode.Z:
                    mMoveCam &= ~32;
					break;

				case KeyCode.Insert:
                    mRoll &= ~1;
					break;
				case KeyCode.Delete:
                    mRoll &= ~2;
					break;
				case KeyCode.Up:
                    mPitch &= ~1;
					break;
				case KeyCode.Down:
                    mPitch &= ~2;
					break;
				case KeyCode.Left:
                    mYaw &= ~1;
					break;
				case KeyCode.Right:
                    mYaw &= ~2;
					break;

			}
		}

		/// <summary>
		/// Sets or gets the visibility of the debug overlay.
		/// </summary>
		protected virtual bool DebugOverlayVisible
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
		protected virtual void UpdateDebugOverlay()
		{
			mCurrentFPS.setCaption("Current FPS: " + mRenderWindow.LastFPS );
			mAverageFPS.setCaption("Average FPS: " + mRenderWindow.AverageFPS );
			mBestFPS.setCaption("Best FPS: " + mRenderWindow.BestFPS );
			mWorstFPS.setCaption("Worst FPS: " + mRenderWindow.WorstFPS );
			mTriangleCount.setCaption("Triangle Count: " + mRenderWindow.TriangleCount );
		}


		/// <summary>
		/// call create4LineDebugOverLay to create an Overlay with 4 text lines at the top left corrner
		/// </summary>
		protected virtual void create4LineDebugOverLay()
		{
			if (mPanel !=null)
				return;
			// Create a panel
			// WTF I keep getting segmentfault when i use PanelOverlayElement, at the panel.addChild line.
			//   prob in mono somewhere not reconizeing it derives from container? but HTF?
			//mPanel = OverlayManager.Instance.CreatePanelElement( "Status/Panel");
			OverlayElement el = OverlayManager.Instance.CreateOverlayElement("Panel", "DebugStatus/Panel" );
			mPanel = new OverlayContainer( OverlayElement.getCPtr(el).Handle , false );
			
			mPanel.setMetricsMode(GuiMetricsMode.GMM_PIXELS);
			mPanel.setPosition(10, 10);
			mPanel.setDimensions(500, 100);
			//mPanel->setMaterialName("MaterialName"); // Optional background material

			// Create a text area
			mODebugText1 = OverlayManager.Instance.CreateTextAreaElement( "DebugStatus/DebugText1" );
			mPanel.addChild( mODebugText1 );
			mODebugText1.setMetricsMode(GuiMetricsMode.GMM_PIXELS);
			mODebugText1.setPosition(0, 0);
			mODebugText1.setDimensions(100, 100);
			mODebugText1.setCaption("");
			mODebugText1.setCharHeight(16);
			mODebugText1.setFontName("BlueHighway");
			mODebugText1.setColourBottom( Converter.GetColor(0.3f, 0.5f, 0.3f) );
			mODebugText1.setColourTop( Converter.GetColor(0.5f, 0.7f, 0.5f));


			// Create a text area
			mODebugText2 = OverlayManager.Instance.CreateTextAreaElement( "DebugStatus/DebugText2" );
			mODebugText2.setMetricsMode(GuiMetricsMode.GMM_PIXELS);
			mODebugText2.setPosition(0, 20);
			mODebugText2.setDimensions(100, 100);
			mODebugText2.setCaption("");
			mODebugText2.setCharHeight(16);
			mODebugText2.setFontName("BlueHighway");
			mODebugText2.setColourBottom( Converter.GetColor(0.3f, 0.5f, 0.3f) );
			mODebugText2.setColourTop( Converter.GetColor(0.5f, 0.7f, 0.5f));
			mPanel.addChild(mODebugText2);


			// Create a text area
			mODebugText3 = OverlayManager.Instance.CreateTextAreaElement( "DebugStatus/DebugText3" );
			mODebugText3.setMetricsMode(GuiMetricsMode.GMM_PIXELS);
			mODebugText3.setPosition(0, 40);
			mODebugText3.setDimensions(100, 100);
			mODebugText3.setCaption("");
			mODebugText3.setCharHeight(16);
			mODebugText3.setFontName("BlueHighway");
			mODebugText3.setColourBottom( Converter.GetColor(0.3f, 0.5f, 0.3f) );
			mODebugText3.setColourTop( Converter.GetColor(0.5f, 0.7f, 0.5f));
			mPanel.addChild(mODebugText3);


			// Create a text area
			mODebugText4 = OverlayManager.Instance.CreateTextAreaElement( "DebugStatus/DebugText4" );
			mODebugText4.setMetricsMode(GuiMetricsMode.GMM_PIXELS);
			mODebugText4.setPosition(0, 60);
			mODebugText4.setDimensions(100, 100);
			mODebugText4.setCaption("");
			mODebugText4.setCharHeight(16);
			mODebugText4.setFontName("BlueHighway");
			mODebugText4.setColourBottom( Converter.GetColor(0.3f, 0.5f, 0.3f) );
			mODebugText4.setColourTop( Converter.GetColor(0.5f, 0.7f, 0.5f));
			mPanel.addChild(mODebugText4);

			// Create an overlay, and add the panel
			mOverlay = OverlayManager.Instance.create("Status/Overlay");
			mOverlay.add2D(mPanel);
		}

		public virtual void Show4LineDebugOverLay()
		{
			if (mOverlay != null)
				mOverlay.show();
		}

		public virtual void Hide4LineDebugOverLay()
		{
			if (mOverlay != null)
				mOverlay.hide();
		}
		public virtual void SetDebugCaption(int line, string msg)
		{
			switch (line)	{
			case 0:
				if (mODebugText1 != null)
					mODebugText1.setCaption(msg);
				break;
			case 1:
				if (mODebugText2 != null)
					mODebugText2.setCaption(msg);
				break;
			case 2:
				if (mODebugText3 != null)
					mODebugText3.setCaption(msg);
				break;
			case 3:
				if (mODebugText4 != null)
					mODebugText4.setCaption(msg);
				break;
			}
		}

		/// <summary>
		/// Disposes of the ExampleApplication instance.
		/// </summary>
		public virtual void Dispose()
		{
			mSceneManager.ClearScene();
			
			mPanel=null;
			mOverlay=null;
			mODebugText1=null;
			mODebugText2=null;
			mODebugText3=null;
			mODebugText4=null;
			
			mRenderWindow=null;
			mCamera=null;
			mViewport=null;
			mEventHandler=null;
			mDebugOverlay=null;
			mAverageFPS=null;
			mBestFPS=null;
			mWorstFPS=null;
			mCurrentFPS=null;
			mTriangleCount=null;
			
			mSceneManager=null;

			mRoot.Dispose();
		}
	}
}
