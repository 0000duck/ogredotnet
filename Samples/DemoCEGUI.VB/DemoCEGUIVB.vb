Imports System
Imports System.Drawing

Imports Math3D
Imports OgreDotNet
Imports CeguiDotNet
Imports OgreDotNet.Cegui

Namespace DemoCEGUIVB
    Module Module1

        Sub Main()
            Dim app As cDemoCEGUIApp
            Try
                app = New cDemoCEGUIApp
                app.Start()
            Catch ex As System.Exception
                Console.WriteLine("Dispose Exception {0}\n{1}\n{2}", ex.Message, ex.Source, ex.StackTrace)
            Finally
                Try
                    app.Dispose()
                Catch
                    Console.WriteLine("Dispose Exception unknown")
                End Try
            End Try
        End Sub

    End Module

    Public Class cDemoCEGUIApp
        Inherits OgreDotNet.ExampleApplication

        Protected mGuiRenderer As OgreCEGUIRenderer = Nothing
        Protected mGuiSystem As GuiSystem = Nothing
        Protected mBackgroundWindow As Window = Nothing
        Protected mEditorWindow As Window = Nothing
        Protected mQuitButton As PushButton = Nothing
        Protected mEditbox As Editbox = Nothing
        Protected mCombobox As Combobox = Nothing
        Protected mLog As Log = Nothing
        Protected mCboItem1 As ListboxTextItem = Nothing
        Protected mCboItem2 As ListboxTextItem = Nothing
        Protected mCboItem3 As ListboxTextItem = Nothing
        Protected mCboItem4 As ListboxTextItem = Nothing

        Protected Overrides Sub CreateScene()
            mLog = LogManager.Singleton.createLog("DemoCEGUI.log", False, True)
            mLog.LogMessage("My new Log. Hells yeah!")

            mSceneManager.AmbientLight = Color.FromArgb(125, 125, 125, 125)
            mSceneManager.SetSkyDome(True, "Examples/CloudySky", 5.0!, 8.0!)

            mGuiRenderer = New OgreCEGUIRenderer(Me.mRenderWindow)
            mGuiRenderer.Initialise()
            'mGuiSystem = New GuiSystem(mGuiRenderer)
            mGuiSystem = GuiSystem.CreateGuiSystemSpecial(mGuiRenderer)

            Logger.Instance.setLoggingLevel(LoggingLevel.Insane)

            SchemeManager.Instance.LoadScheme("TaharezLook.scheme")
            mGuiSystem.SetDefaultMouseCursor("TaharezLook", "MouseArrow")
            mGuiSystem.DefaultFontName = "Tahoma-12"

            mBackgroundWindow = WindowManager.Instance.CreateWindow("DefaultWindow", "BackgroundWindow")
            mGuiSystem.GUISheet = mBackgroundWindow

            mEditorWindow = WindowManager.Instance.CreateWindow("TaharezLook/FrameWindow", "TestWindow")
            mBackgroundWindow.AddChildWindow(mEditorWindow)
            mEditorWindow.SetSize(0.9!, 0.9!)
            mEditorWindow.SetPosition(0.05!, 0.05!)
            mEditorWindow.Text = "CeguiDotNet Demo"
            mEditorWindow.SubscribeEvents()

            mQuitButton = WindowManager.Instance.CreatePushButton("TaharezLook/Button", "QuitButton")
            mQuitButton.Text = "Quit"
            mQuitButton.SetPosition(0.1!, 0.15!)
            mQuitButton.SetSize(0.8!, 0.15!)
            mQuitButton.SubscribeEvents()
            AddHandler mQuitButton.Clicked, AddressOf Me.QuitClicked
            mEditorWindow.AddChildWindow(mQuitButton)

            mEditbox = WindowManager.Instance.CreateEditbox("TaharezLook/Editbox", "Editbox")
            mEditbox.Text = "Editbox"
            mEditbox.SetPosition(0.1!, 0.32!)
            mEditbox.SetSize(0.8!, 0.15!)
            mEditbox.setReadOnly(False)
            mEditbox.SubscribeEvents()
            mEditorWindow.AddChildWindow(mEditbox)

            mCombobox = WindowManager.Instance.CreateCombobox("TaharezLook/Combobox", "Combobox")
            mCombobox.SetPosition(0.1!, 0.49!)
            mCombobox.SetSize(0.8!, 0.15!)
            mCombobox.setReadOnly(False)
            mCombobox.SubscribeEvents()
            AddHandler mCombobox.ListSelectionChanged, AddressOf Me.combobox_SelectionChanged
            AddHandler mCombobox.TextAccepted, AddressOf Me.combobox_TextAccepted
            mEditorWindow.AddChildWindow(mCombobox)

            mCboItem1 = New ListboxTextItem("Item 1", Convert.ToUInt32(0), IntPtr.Zero, False, True)
            mCombobox.addItem(mCboItem1)
            mCboItem2 = New ListboxTextItem("Item 2", Convert.ToUInt32(1), IntPtr.Zero, False, True)
            mCombobox.addItem(mCboItem2)
            mCboItem3 = New ListboxTextItem("Item 3", Convert.ToUInt32(2), IntPtr.Zero, False, True)
            mCombobox.addItem(mCboItem3)
            mCboItem4 = New ListboxTextItem("Item 4", Convert.ToUInt32(3), IntPtr.Zero, False, True)
            mCombobox.addItem(mCboItem4)

            mEditorWindow.Show()
        End Sub

        Protected Function QuitClicked(ByVal e As WindowEventArgs) As Boolean
            Console.WriteLine("Quit Clicked")
            Return True
        End Function

        Protected Function combobox_TextAccepted(ByVal e As WindowEventArgs) As Boolean
            Dim li As ListboxItem = mCombobox.getSelectedItem()
            If li Is Nothing Then
                mLog.LogMessage(String.Format("ComboBox TextAccepted unable to getSelectedItem "))
            Else
                mLog.LogMessage(String.Format("ComboBox TextAccepted  item {0}, {1}", li.getID(), li.getText()))
            End If
            Return True
        End Function

        Protected Function combobox_SelectionChanged(ByVal e As WindowEventArgs) As Boolean
            Dim li As ListboxItem = mCombobox.getSelectedItem()
            If li Is Nothing Then
                mLog.LogMessage(String.Format("ComboBox Selection Changed  unable to getSelectedItem "))
            Else
                mLog.LogMessage(String.Format("ComboBox Selection Changed  item {0}, {1}", li.getID(), li.getText()))
            End If
            Return True
        End Function

        Protected Overrides Sub KeyClicked(ByVal e As KeyEvent)
            MyBase.KeyClicked(e)
            Select Case (e.KeyCode)
                Case KeyCode.P
                    mRenderWindow.WriteContentsToFile("CeguiNet.png")
            End Select
        End Sub

        Protected Overrides Sub KeyPressed(ByVal e As KeyEvent)
            'mLog.LogMessage("KeyPressed KeyCode = " + (uint)e.KeyCode + " isReadonly=" + mEditbox.isReadOnly() );
            GuiSystem.Instance.injectKeyDown(Convert.ToUInt32(e.KeyCode))
            GuiSystem.Instance.injectChar(Convert.ToUInt32(e.KeyChar))

            MyBase.KeyPressed(e)
        End Sub

        Protected Overrides Sub KeyReleased(ByVal e As KeyEvent)
            'mLog.LogMessage("KeyReleased KeyCode = " + (uint)e.KeyCode )
            GuiSystem.Instance.injectKeyUp(Convert.ToUInt32(e.KeyCode))

            MyBase.KeyReleased(e)
        End Sub


        Protected Overrides Sub MousePressed(ByVal e As MouseEvent)
            Select Case e.ButtonID
                Case 16
                    GuiSystem.Instance.InjectMouseButtonDown(MouseButton.Left)
                Case 32
                    GuiSystem.Instance.InjectMouseButtonDown(MouseButton.Right)
            End Select
        End Sub

        Protected Overrides Sub MouseReleased(ByVal e As MouseEvent)
            Select Case e.ButtonID
                Case 16
                    GuiSystem.Instance.InjectMouseButtonUp(MouseButton.Left)
                Case 32
                    GuiSystem.Instance.InjectMouseButtonUp(MouseButton.Right)
            End Select
        End Sub


        Protected Overrides Sub MouseMotion(ByVal e As MouseMotionEvent)
            GuiSystem.Instance.InjectMouseMove(e.DeltaX * Convert.ToSingle(mRenderWindow.Width), _
                e.DeltaY * Convert.ToSingle(mRenderWindow.Height))
        End Sub

        Protected Overrides Sub MouseDragged(ByVal e As MouseMotionEvent)
            MyBase.MouseMotion(e)
        End Sub


        Public Overrides Sub Dispose()
            WindowManager.Instance.destroyAllWindows()
            mGuiSystem.Dispose()
            mGuiRenderer.Dispose()
            MyBase.Dispose()
        End Sub
    End Class



End Namespace

