using System;
using System.Drawing;

using OgreDotNet;
using OgreDotNet.Cegui;

using CeguiDotNet;

namespace DemoCEGUI
{
	/// <summary>
	/// Summary description for Class1.
	/// </summary>
	class CEGUIApplication : ExampleApplication
	{
		protected OgreCEGUIRenderer mGuiRenderer = null;
		protected GuiSystem mGuiSystem = null;
		protected Window mBackgroundWindow = null;
		protected Window mTestWindow = null;
		protected PushButton mQuitButton = null;
		protected Editbox mEditbox = null;

		protected override void CreateScene()
		{
			base.mSceneManager.AmbientLight = Color.FromArgb(125,125,125,125);
			base.mSceneManager.SetSkyDome(true, "Examples/CloudySky", 5, 8);

			mGuiRenderer = new OgreCEGUIRenderer( base.mRenderWindow,
				(byte)RenderQueueGroupID.RENDER_QUEUE_OVERLAY, false, 3000, mSceneManager );
			mGuiRenderer.Initialise();
			mGuiSystem = new GuiSystem( mGuiRenderer );


			Logger.Instance.setLoggingLevel(LoggingLevel.Informative );

			SchemeManager.Instance.LoadScheme("TaharezLookSkin.scheme");
			mGuiSystem.SetDefaultMouseCursor("TaharezLook", "MouseArrow");
			mGuiSystem.DefaultFontName = "BlueHighway-12";

			mBackgroundWindow = WindowManager.Instance.CreateWindow("DefaultWindow", "BackgroundWindow");
			mGuiSystem.GUISheet = mBackgroundWindow;

			mTestWindow = WindowManager.Instance.CreateWindow("TaharezLook/FrameWindow", "TestWindow");
			mBackgroundWindow.AddChildWindow( mTestWindow );
			mTestWindow.SetSize(0.3f, 0.6f);
			mTestWindow.SetPosition(0.7f, 0.2f);
			mTestWindow.Text = "Test Window";
			mTestWindow.SubscribeEvents();

			mQuitButton = WindowManager.Instance.CreatePushButton("TaharezLook/Button", "QuitButton");
			mQuitButton.Text = "Quit";
			mQuitButton.SetPosition(0.1f,0.1f);
			mQuitButton.SetSize(0.8f,0.2f);
			mQuitButton.SubscribeEvents();
			mQuitButton.Clicked += new WindowEventDelegate(QuitClicked);
			mTestWindow.AddChildWindow(mQuitButton);

			mEditbox = WindowManager.Instance.CreateEditbox("TaharezLook/Editbox", "Editbox");
			mEditbox.Text = "Editbox";
			mEditbox.SetPosition(0.1f, 0.4f);
			mEditbox.SetSize(0.8f, 0.2f);
			mTestWindow.AddChildWindow(mEditbox);

			Menubar menuBar = WindowManager.Instance.CreateMenubar("TaharezLook/Menubar", "Main menubar");
			menuBar.SetPosition(0.0f, 0.0f);
			menuBar.SetSize(1.0f, 0.04f);
			mBackgroundWindow.AddChildWindow(menuBar);

			MenuItem mnuFile = WindowManager.Instance.CreateMenuItem("TaharezLook/MenubarItem", "mnuFile");
			mnuFile.setText("File");
			menuBar.addItem(mnuFile);

			PopupMenu mnuFilePopup = WindowManager.Instance.CreatePopupMenu("TaharezLook/PopupMenu", "mnuFilePopup");
			mnuFile.AddChildWindow(mnuFilePopup);

			MenuItem mnuFileNew = WindowManager.Instance.CreateMenuItem("TaharezLook/MenuItem", "mnuFileNew");
			mnuFileNew.setText("New");
			mnuFilePopup.AddChildWindow(mnuFileNew);

			MenuItem mnuFileOpen = WindowManager.Instance.CreateMenuItem("TaharezLook/MenuItem", "mnuFileOpen");
			mnuFileOpen.setText("Open");
			mnuFilePopup.AddChildWindow(mnuFileOpen);

			MenuItem mnuFileClose = WindowManager.Instance.CreateMenuItem("TaharezLook/MenuItem", "mnuFileClose");
			mnuFileClose.setText("Close");
			mnuFileClose.setEnabled(false);
			mnuFilePopup.AddChildWindow(mnuFileClose);

			MenuItem mnuFileSave = WindowManager.Instance.CreateMenuItem("TaharezLook/MenuItem", "mnuFileSave");
			mnuFileSave.setText("Save");
			mnuFileSave.setEnabled(false);
			mnuFilePopup.AddChildWindow(mnuFileSave);

			MenuItem mnuFileSaveAs = WindowManager.Instance.CreateMenuItem("TaharezLook/MenuItem", "mnuFileSaveAs");
			mnuFileSaveAs.setText("Save As");
			mnuFileSaveAs.setEnabled(false);
			mnuFilePopup.AddChildWindow(mnuFileSaveAs);

			MenuItem mnuFileExit = WindowManager.Instance.CreateMenuItem("TaharezLook/MenuItem", "mnuFileExit");
			mnuFileExit.setText("Exit");
			mnuFileExit.SubscribeEvents();
			mnuFileExit.Clicked += new WindowEventDelegate(QuitClicked);
			mnuFilePopup.AddChildWindow(mnuFileExit);

			mTestWindow.Show();
		}

		protected bool QuitClicked(WindowEventArgs e)
		{
			Console.WriteLine("Quit Clicked");
			return true;
		}

		protected override void KeyClicked( KeyEvent e )
		{
			base.KeyClicked( e );
			switch (e.KeyCode)
			{
				case KeyCode.P:
					mRenderWindow.WriteContentsToFile("CeguiNet.png");
					break;
			}
		}

		protected override void MousePressed(MouseEvent e)
		{
			//base.MousePressed (e);
			switch( e.ButtonID )
			{
				case 16:
					GuiSystem.Instance.InjectMouseButtonDown( MouseButton.Left );
					break;
				case 32:
					GuiSystem.Instance.InjectMouseButtonDown( MouseButton.Right );
					break;
			}
		}

		protected override void MouseReleased(MouseEvent e)
		{
			//base.MouseReleased (e);
			switch( e.ButtonID )
			{
				case 16:
					GuiSystem.Instance.InjectMouseButtonUp( MouseButton.Left );
					break;
				case 32:
					GuiSystem.Instance.InjectMouseButtonUp( MouseButton.Right );
					break;
			}
		}


		protected override void MouseMotion(MouseMotionEvent e)
		{
			//base.MouseMotion (e);
			GuiSystem.Instance.InjectMouseMove(e.DeltaX*mRenderWindow.Width, 
				e.DeltaY*mRenderWindow.Height);
		}

		protected override void MouseDragged(MouseMotionEvent e)
		{
			//base.MouseDragged (e);
			this.MouseMotion( e );
		}


		public override void Dispose()
		{
			mBackgroundWindow.Dispose();
			mBackgroundWindow = null;
			mTestWindow.Dispose();
			mTestWindow = null;
			mQuitButton.Dispose();
			mQuitButton = null;
			mEditbox.Dispose();
			mEditbox = null;

			WindowManager.Instance.destroyAllWindows();
			mGuiSystem.Dispose();
			mGuiSystem = null;
			mGuiRenderer.Dispose();
			mGuiRenderer = null;

			base.Dispose();
		}

		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main(string[] args)
		{
			using( CEGUIApplication app = new CEGUIApplication() )
			{
				app.Start();
			}
		}
	}
}
