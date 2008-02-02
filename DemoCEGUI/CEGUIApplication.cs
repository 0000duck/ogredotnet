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
		protected Window mEditorWindow = null;
		protected PushButton mQuitButton = null;
		protected Editbox mEditbox = null;
		protected Combobox mCombobox = null;
		protected Log mLog = null;
		protected ListboxTextItem mCboItem1=null, mCboItem2=null, mCboItem3=null, mCboItem4=null;

		protected override void CreateScene()
		{
			mLog = LogManager.Singleton.createLog("DemoCEGUI.log", false, true );
			mLog.LogMessage("My new Log. Hells yeah!");

			base.mSceneManager.AmbientLight = Color.FromArgb(125,125,125,125);
			base.mSceneManager.SetSkyDome(true, "Examples/CloudySky", 5, 8);

			mGuiRenderer = new OgreCEGUIRenderer( base.mRenderWindow,
				(byte)RenderQueueGroupID.RENDER_QUEUE_OVERLAY, false, 3000, mSceneManager );
			mGuiRenderer.Initialise();
			mGuiSystem = new GuiSystem(mGuiRenderer);
			//mGuiSystem = GuiSystem.CreateGuiSystemSpecial(mGuiRenderer);

			Logger.Instance.setLoggingLevel(LoggingLevel.Informative );

			SchemeManager.Instance.LoadScheme("TaharezLookSkin.scheme");
			mGuiSystem.SetDefaultMouseCursor("TaharezLook", "MouseArrow");
			mGuiSystem.DefaultFontName = "BlueHighway-12";

			mBackgroundWindow = WindowManager.Instance.CreateWindow("DefaultWindow", "BackgroundWindow");
			mGuiSystem.GUISheet = mBackgroundWindow;

			mEditorWindow = WindowManager.Instance.CreateWindow("TaharezLook/FrameWindow", "TestWindow");
			mBackgroundWindow.AddChildWindow( mEditorWindow );
			mEditorWindow.SetSize(0.9f, 0.9f);
			mEditorWindow.SetPosition(0.05f, 0.05f);
			mEditorWindow.Text = "CeguiDotNet Demo";
			mEditorWindow.SubscribeEvents();

			mQuitButton = WindowManager.Instance.CreatePushButton("TaharezLook/Button", "QuitButton");
			mQuitButton.Text = "Quit";
			mQuitButton.SetPosition(0.1f,0.15f);
			mQuitButton.SetSize(0.8f,0.15f);
			mQuitButton.SubscribeEvents();
			mQuitButton.Clicked += new WindowEventDelegate(QuitClicked);
			mEditorWindow.AddChildWindow(mQuitButton);

			mEditbox = WindowManager.Instance.CreateEditbox("TaharezLook/Editbox", "Editbox");
			mEditbox.Text = "Editbox";
			mEditbox.SetPosition(0.1f, 0.32f);
			mEditbox.SetSize(0.8f, 0.15f);
			mEditbox.setReadOnly(false);
			mEditbox.SubscribeEvents();
			mEditbox.KeyDown += new CeguiDotNet.KeyEventDelegate(this.UsernameCharacterKey);
			mEditorWindow.AddChildWindow(mEditbox);

			mCombobox = WindowManager.Instance.CreateCombobox("TaharezLook/Combobox", "Combobox");
			mCombobox.SetPosition(0.1f, 0.49f);
			mCombobox.SetSize(0.8f, 0.25f);
			mCombobox.setReadOnly(false);
			mCombobox.SubscribeEvents();
			mCombobox.ListSelectionChanged += new WindowEventDelegate(this.combobox_SelectionChanged);
			mCombobox.TextAccepted += new WindowEventDelegate(this.combobox_TextAccepted);
			mEditorWindow.AddChildWindow(mCombobox);
			
			mCboItem1 = new ListboxTextItem("Item 1", 0,  IntPtr.Zero, false, true);
			mCboItem1.setAutoDeleted(false);
			mCombobox.addItem( mCboItem1 );
			mCboItem2 = new ListboxTextItem("Item 2", 1,  IntPtr.Zero, false, true);
			mCboItem2.setAutoDeleted(false);
			mCombobox.addItem( mCboItem2 );
			mCboItem3 = new ListboxTextItem("Item 3", 2,  IntPtr.Zero, false, true);
			mCboItem3.setAutoDeleted(false);
			mCombobox.addItem( mCboItem3 );
			mCboItem4 = new ListboxTextItem("Item 4", 3,  IntPtr.Zero, false, true);
			mCboItem4.setAutoDeleted(false);
			mCombobox.addItem( mCboItem4 );
			
			mEditorWindow.Show();
		}

		//handler function definition
		protected bool UsernameCharacterKey(CeguiDotNet.KeyEventArgs e)
		{
			Console.WriteLine("-UsernameCharacterKey- key={0}" , e.scancode );
			return true;
		}


		protected bool QuitClicked( WindowEventArgs e )
		{
			Console.WriteLine("Quit Clicked");
			return true;
		}
		
		protected bool combobox_TextAccepted( WindowEventArgs e )
		{
			ListboxItem li = mCombobox.getSelectedItem();
			if (li == null)
				mLog.LogMessage( string.Format("ComboBox TextAccepted unable to getSelectedItem ") );
			else 
				mLog.LogMessage( string.Format("ComboBox TextAccepted  item {0}, {1}", li.getID(),  li.getText() ) );
			return true;
		}

		protected bool combobox_SelectionChanged( WindowEventArgs e )
		{
			ListboxItem li = mCombobox.getSelectedItem();
			if (li == null)
				mLog.LogMessage( string.Format("ComboBox Selection Changed  unable to getSelectedItem ") );
			else 
				mLog.LogMessage( string.Format("ComboBox Selection Changed  item {0}, {1}", li.getID(),  li.getText() ) );
			return true;
		}

		protected bool TestWindowSized( WindowEventArgs e )
		{
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

		protected override void KeyPressed(KeyEvent e)
		{
			//mLog.LogMessage("KeyPressed KeyCode = " + (uint)e.KeyCode + " isReadonly=" + mEditbox.isReadOnly() );
			GuiSystem.Instance.injectKeyDown( (UInt32)e.KeyCode );
			GuiSystem.Instance.injectChar( (UInt32)e.KeyChar );
			
			base.KeyPressed (e);
		}

		protected override void KeyReleased( KeyEvent e )
		{
			//mLog.LogMessage("KeyReleased KeyCode = " + (uint)e.KeyCode );
			GuiSystem.Instance.injectKeyUp( (uint)e.KeyCode );
			
			base.KeyReleased(e);
		}


		protected override void MousePressed(MouseEvent e)
		{
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
			GuiSystem.Instance.InjectMouseMove(e.DeltaX*mRenderWindow.Width, 
				e.DeltaY*mRenderWindow.Height);
		}

		protected override void MouseDragged(MouseMotionEvent e)
		{
			this.MouseMotion( e );
		}

		public override void Dispose()
		{
			mBackgroundWindow.Dispose();
			mBackgroundWindow=null;
			mEditorWindow.Dispose();
			mEditorWindow = null;
			mQuitButton.Dispose();
			mQuitButton = null;
			mEditbox.Dispose();
			mEditbox = null;
			mCombobox.Dispose();
			mCombobox = null;
			mCboItem1=null; mCboItem2=null; mCboItem3=null; mCboItem4=null;

			WindowManager.Instance.destroyAllWindows();
			mGuiSystem.Dispose();
			mGuiSystem=null;
			mGuiRenderer.Dispose();
			mGuiRenderer=null;

			mLog=null;
			base.Dispose();
		}

		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main(string[] args)
		{
			CEGUIApplication app = new CEGUIApplication();
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
					Console.WriteLine( "###  Exception {0}\n{1}\n{2}", ex.Message ,ex.Source , ex.StackTrace );
				}
			}
		}
	}
}
