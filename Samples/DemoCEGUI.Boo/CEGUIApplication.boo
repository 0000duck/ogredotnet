
namespace DemoCEGUI.Boo

import System
import System.Drawing

import Math3D
import OgreDotNet
import CeguiDotNet
import OgreDotNet.Cegui


class CEGUIApplication(OgreDotNet.ExampleApplication):
    //in boo: All members whose names start with an underscore, i.e. how fields should be named,
    // will automatically be protected. Otherwise, it will be public by default.
    
    [Getter(Log)]
    _mlog as OgreDotNet.Log = null
    
    _mGuiRenderer as OgreCEGUIRenderer = null
    _mGuiSystem as GuiSystem = null
    _mBackgroundWindow as Window = null
    _mEditorWindow as Window = null
    _mQuitButton as PushButton = null
    _mEditbox as Editbox = null
    _mCombobox as Combobox = null
    _mCboItem1 as ListboxTextItem = null
    _mCboItem2 as ListboxTextItem = null
    _mCboItem3 as ListboxTextItem = null
    _mCboItem4 as ListboxTextItem = null
    
    
    override protected def CreateScene():
        _mlog = LogManager.Singleton.createLog("DemoCEGUI.Boo.log", false, true)
        _mlog.LogMessage("My new Log. Hells yeah!")
        
        mSceneManager.AmbientLight = Color.FromArgb(125, 125, 125, 125)
        mSceneManager.SetSkyDome(true, "Examples/CloudySky", Convert.ToSingle(5.0), Convert.ToSingle(8.0))
        
        _mGuiRenderer = OgreCEGUIRenderer(mRenderWindow, cast(byte, RenderQueueGroupID.RENDER_QUEUE_OVERLAY), false, 3000, mSceneManager)
        _mGuiRenderer.Initialise()
        _mGuiSystem = GuiSystem(_mGuiRenderer)
        
        Logger.Instance.setLoggingLevel(LoggingLevel.Insane)
        
        SchemeManager.Instance.LoadScheme("TaharezLook.scheme")
        _mGuiSystem.SetDefaultMouseCursor("TaharezLook", "MouseArrow")
        _mGuiSystem.DefaultFontName = "Tahoma-12"
        
        _mBackgroundWindow = WindowManager.Instance.CreateWindow("DefaultWindow", "BackgroundWindow")
        _mGuiSystem.GUISheet = _mBackgroundWindow
        
        _mEditorWindow = WindowManager.Instance.CreateWindow("TaharezLook/FrameWindow", "TestWindow")
        _mBackgroundWindow.AddChildWindow(_mEditorWindow)
        _mEditorWindow.SetSize(0.9, 0.9)
        _mEditorWindow.SetPosition(0.05, 0.05)
        _mEditorWindow.Text = "CeguiDotNet Demo"
        _mEditorWindow.SubscribeEvents()
        
        _mQuitButton = WindowManager.Instance.CreatePushButton("TaharezLook/Button", "QuitButton")
        _mQuitButton.Text = "Quit"
        _mQuitButton.SetPosition(0.1, 0.15)
        _mQuitButton.SetSize(0.8, 0.15)
        _mQuitButton.SubscribeEvents()
        _mQuitButton.Clicked += self.QuitClicked
        _mEditorWindow.AddChildWindow(_mQuitButton)
        
        _mEditbox = WindowManager.Instance.CreateEditbox("TaharezLook/Editbox", "Editbox")
        _mEditbox.Text = "Editbox"
        _mEditbox.SetPosition(0.1, 0.32)
        _mEditbox.SetSize(0.8, 0.15)
        _mEditbox.setReadOnly(false)
        _mEditbox.SubscribeEvents()
        _mEditorWindow.AddChildWindow(_mEditbox)
        
        _mCombobox = WindowManager.Instance.CreateCombobox("TaharezLook/Combobox", "Combobox")
        _mCombobox.SetPosition(0.1, 0.49)
        _mCombobox.SetSize(0.8, 0.15)
        _mCombobox.setReadOnly(false)
        _mCombobox.SubscribeEvents()
        _mCombobox.ListSelectionChanged += self.combobox_SelectionChanged
        _mCombobox.TextAccepted += self.combobox_TextAccepted
        _mEditorWindow.AddChildWindow(_mCombobox)
        
        _mCboItem1 = ListboxTextItem("Item 1", Convert.ToUInt32(0), IntPtr.Zero, false, true)
        _mCombobox.addItem(_mCboItem1)
        _mCboItem2 = ListboxTextItem("Item 2", Convert.ToUInt32(1), IntPtr.Zero, false, true)
        _mCombobox.addItem(_mCboItem2)
        _mCboItem3 = ListboxTextItem("Item 3", Convert.ToUInt32(2), IntPtr.Zero, false, true)
        _mCombobox.addItem(_mCboItem3)
        _mCboItem4 = ListboxTextItem("Item 4", Convert.ToUInt32(3), IntPtr.Zero, false, true)
        _mCombobox.addItem(_mCboItem4)
        
        _mEditorWindow.Show()
    
    protected def QuitClicked( e as WindowEventArgs) as bool:
        Console.WriteLine("Quit Clicked")
        return true
    
    protected def combobox_TextAccepted( e as WindowEventArgs) as bool:
        li as ListboxItem = _mCombobox.getSelectedItem()
        if li is null:
            _mlog.LogMessage(System.String.Format("ComboBox TextAccepted unable to getSelectedItem "))
        else:
            _mlog.LogMessage(System.String.Format("ComboBox TextAccepted  item {0}, {1}", li.getID(), li.getText()))
        return true
    
    protected def combobox_SelectionChanged( e as WindowEventArgs) as bool:
        li as ListboxItem = _mCombobox.getSelectedItem()
        if li is null:
            _mlog.LogMessage(System.String.Format("ComboBox Selection Changed  unable to getSelectedItem "))
        else:
            _mlog.LogMessage(System.String.Format("ComboBox Selection Changed  item {0}, {1}", li.getID(), li.getText()))
        return true
    
    
    override protected def KeyClicked(e as KeyEvent):
        super(e)
        if e.KeyCode == KeyCode.P:
            mRenderWindow.WriteContentsToFile("CeguiNet.png")
        
    
    override protected def KeyPressed(e as KeyEvent):
        //_mlog.LogMessage("KeyPressed KeyCode = " + (uint)e.KeyCode + " isReadonly=" + mEditbox.isReadOnly() );
        GuiSystem.Instance.injectKeyDown(Convert.ToUInt32(e.KeyCode))
        GuiSystem.Instance.injectChar(Convert.ToUInt32(e.KeyChar))
        super(e)
    
    override protected def  KeyReleased(e as KeyEvent):
        //_mlog.LogMessage("KeyReleased KeyCode = " + (uint)e.KeyCode )
        GuiSystem.Instance.injectKeyUp(Convert.ToUInt32(e.KeyCode))
        super(e)
    
    
    override protected def MousePressed(e as MouseEvent):
        if e.ButtonID == 16:
            GuiSystem.Instance.InjectMouseButtonDown(MouseButton.Left)
        elif e.ButtonID == 32:
            GuiSystem.Instance.InjectMouseButtonDown(MouseButton.Right)
    
    override protected def MouseReleased(e as MouseEvent):
        if e.ButtonID == 16:
            GuiSystem.Instance.InjectMouseButtonUp(MouseButton.Left)
        elif e.ButtonID == 32:
            GuiSystem.Instance.InjectMouseButtonUp(MouseButton.Right)
    
    
    override protected def MouseMotion(e as MouseMotionEvent):
        GuiSystem.Instance.InjectMouseMove(e.DeltaX * Convert.ToSingle(mRenderWindow.Width), e.DeltaY * Convert.ToSingle(mRenderWindow.Height))
    
    override protected def MouseDragged(e as MouseMotionEvent):
        MouseMotion(e)
    
    
    
    override def Dispose():
        WindowManager.Instance.destroyAllWindows()
        _mGuiSystem.Dispose()
        _mGuiRenderer.Dispose()
        super()
    



def Main(argv as (string)):
    app as CEGUIApplication
    try:
        app = CEGUIApplication()
        app.Start()
    except e as Exception:
        Console.WriteLine( "init Exception {0}\n{1}\n{2}", e.Message ,e.Source , e.StackTrace )
    except:
        Console.WriteLine( "init Exception Unknown")
    ensure:
        try:
            app.Dispose()
        except e as Exception:
            Console.WriteLine( "Dispose Exception {0}\n{1}\n{2}", e.Message ,e.Source , e.StackTrace )
        except:
            Console.WriteLine( "Dispose Exception unknown")
    
