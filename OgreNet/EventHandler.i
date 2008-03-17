%{
#include "EventHandler.h"
%}

%typemap(cscode) Ogre::EventHandler %{
    
    protected delegate bool _FrameDelegate(float TimeSinceLastFrame, float TimeSinceLastEvent);

/*
    protected delegate void _KeyDelegate(OgreDotNet.KeyCode keycode, char keychar, bool shift, bool alt, bool ctrl);
    protected delegate void _MouseMotionDelegate(float deltax, float deltay, float deltaz);
    protected delegate void _MouseDelegate(float x, float y, float z, int button);
*/
    
    public void SubscribeEvents()
    {
        mFrameStartedDelegate = new _FrameDelegate(FrameStartedHandler);
        SetFrameStartedFunction(swigCPtr, mFrameStartedDelegate);
        
        mFrameEndedDelegate = new _FrameDelegate(FrameEndedHandler);
        SetFrameEndedFunction(swigCPtr, mFrameEndedDelegate);
        
/*
        mKeyClickedDelegate = new _KeyDelegate(KeyClickedHandler);
        SetKeyClickedFunction(swigCPtr, mKeyClickedDelegate);
        
        mKeyPressedDelegate = new _KeyDelegate(KeyPressedHandler);
        SetKeyPressedFunction(swigCPtr, mKeyPressedDelegate);
        
        mKeyReleasedDelegate = new _KeyDelegate(KeyReleasedHandler);
        SetKeyReleasedFunction(swigCPtr, mKeyReleasedDelegate);
        
        mMouseMotionDelegate = new _MouseMotionDelegate(MouseMotionHandler);
        SetMouseMotionFunction(swigCPtr, mMouseMotionDelegate);
        
        mMouseDraggedDelegate = new _MouseMotionDelegate(MouseDraggedHandler);
        SetMouseDraggedFunction(swigCPtr, mMouseDraggedDelegate);
        
        mMouseClickedDelegate = new _MouseDelegate(MouseClickedHandler);
        SetMouseClickedFunction(swigCPtr, mMouseClickedDelegate);
        
        mMousePressedDelegate = new _MouseDelegate(MousePressedHandler);
        SetMousePressedFunction(swigCPtr, mMousePressedDelegate);
        
        mMouseReleasedDelegate = new _MouseDelegate(MouseReleasedHandler);
        SetMouseReleasedFunction(swigCPtr, mMouseReleasedDelegate);
*/
    }
        
    //
    // FrameStarted handling
    //
    public event FrameEventDelegate FrameStarted = null;
    
    [DllImport("OgreBindings", EntryPoint="EventHandlerSetFrameFunctionStarted")]
    protected static extern void SetFrameStartedFunction(HandleRef eventhandler, _FrameDelegate fn);
    
    protected _FrameDelegate mFrameStartedDelegate = null;
    
    protected bool FrameStartedHandler(float timesincelastframe, float timesincelastevent)
    {
        if(FrameStarted != null)
            return FrameStarted(new FrameEvent(timesincelastframe, timesincelastevent));
        
        return true;
    }
    
    //
    // FrameEnded handling
    //
    public event FrameEventDelegate FrameEnded = null;
    
    [DllImport("OgreBindings", EntryPoint="EventHandlerSetFrameEndFunction")]
    protected static extern void SetFrameEndedFunction(HandleRef eventhandler, _FrameDelegate fn);
    
    protected _FrameDelegate mFrameEndedDelegate = null;
    
    protected bool FrameEndedHandler(float timesincelastframe, float timesincelastevent)
    {
        if(FrameEnded != null)
            return FrameEnded(new FrameEvent(timesincelastframe, timesincelastevent));
        
        return true;
    }
    
/*
    //
    // KeyClicked handling
    //
    public event KeyEventDelegate KeyClicked = null;
    
    [DllImport("OgreBindings", EntryPoint="EventHandlerSetKeyClickedFunction")]
    protected static extern void SetKeyClickedFunction(HandleRef eventhandler, _KeyDelegate fn);
    
    protected _KeyDelegate mKeyClickedDelegate = null;
    
    protected void KeyClickedHandler(KeyCode keycode, char keychar, bool shift, bool alt, bool ctrl)
    {
        if(KeyClicked != null)
            KeyClicked(new KeyEvent(keycode, keychar, shift, alt, ctrl, false));
    }
    
    //
    // KeyPressed
    //
    public event KeyEventDelegate KeyPressed = null;
    
    [DllImport("OgreBindings", EntryPoint="EventHandlerSetKeyPressedFunction")]
    protected static extern void SetKeyPressedFunction(HandleRef eventhandler, _KeyDelegate fn);
    
    protected _KeyDelegate mKeyPressedDelegate = null;
    
    protected void KeyPressedHandler(KeyCode keycode, char keychar, bool shift, bool alt, bool ctrl)
    {
        if(KeyPressed != null)
            KeyPressed(new KeyEvent(keycode, keychar, shift, alt, ctrl, false));
    }
    
    //
    // KeyReleased
    //
    public event KeyEventDelegate KeyReleased = null;
    
    [DllImport("OgreBindings", EntryPoint="EventHandlerSetKeyReleasedFunction")]
    protected static extern void SetKeyReleasedFunction(HandleRef eventhandler, _KeyDelegate fn);
    
    protected _KeyDelegate mKeyReleasedDelegate = null;
    
    protected void KeyReleasedHandler(KeyCode keycode, char keychar, bool shift, bool alt, bool ctrl)
    {
        if(KeyReleased != null)
            KeyReleased(new KeyEvent(keycode, keychar, shift, alt, ctrl, false));
    }

    //
    // MouseMoved
    //
    public event MouseMotionEventDelegate MouseMoved = null;
    
    [DllImport("OgreBindings", EntryPoint="EventHandlerSetMouseMotionFunction")]
    protected static extern void SetMouseMotionFunction(HandleRef eventhandler, _MouseMotionDelegate fn);
    
    protected _MouseMotionDelegate mMouseMotionDelegate = null;
    
    protected void MouseMotionHandler(float deltax, float deltay, float deltaz)
    {
        if(MouseMoved != null)
            MouseMoved(new MouseMotionEvent(deltax, deltay, deltaz));
    }
    
    //
    // MouseDragged
    //
    public event MouseMotionEventDelegate MouseDragged = null;
    
    [DllImport("OgreBindings", EntryPoint="EventHandlerSetMouseDraggedFunction")]
    protected static extern void SetMouseDraggedFunction(HandleRef eventhandler, _MouseMotionDelegate fn);
    
    protected _MouseMotionDelegate mMouseDraggedDelegate = null;
    
    protected void MouseDraggedHandler(float deltax, float deltay, float deltaz)
    {
        if(MouseDragged != null)
            MouseDragged(new MouseMotionEvent(deltax, deltay, deltaz));
    }
    
    //
    // MouseClicked
    //
    public event MouseEventDelegate MouseClicked = null;
    
    [DllImport("OgreBindings", EntryPoint="EventHandlerSetMouseClickFunction")]
    protected static extern void SetMouseClickedFunction(HandleRef eventhandler, _MouseDelegate fn);
    
    protected _MouseDelegate mMouseClickedDelegate = null;
    
    protected void MouseClickedHandler(float x, float y, float z, int buttonid)
    {
        if(MouseClicked != null)
            MouseClicked(new MouseEvent(x, y, z, buttonid));
    }
    
    //
    // MousePressed
    //
    public event MouseEventDelegate MousePressed = null;
    
    [DllImport("OgreBindings", EntryPoint="EventHandlerSetMousePressedFunction")]
    protected static extern void SetMousePressedFunction(HandleRef eventhandler, _MouseDelegate fn);
    
    protected _MouseDelegate mMousePressedDelegate = null;
    
    protected void MousePressedHandler(float x, float y, float z, int buttonid)
    {
        if(MousePressed != null)
            MousePressed(new MouseEvent(x, y, z, buttonid));
    }
    
    //
    // MouseReleased
    //
    public event MouseEventDelegate MouseReleased = null;
    
    [DllImport("OgreBindings", EntryPoint="EventHandlerSetMouseReleasedFunction")]
    protected static extern void SetMouseReleasedFunction(HandleRef eventhandler, _MouseDelegate fn);
    
    protected _MouseDelegate mMouseReleasedDelegate = null;
    
    protected void MouseReleasedHandler(float x, float y, float z, int buttonid)
    {
        if(MouseReleased != null)
            MouseReleased(new MouseEvent(x, y, z, buttonid));
    }
*/
%}

namespace Ogre
{
    class EventHandler : public FrameListener // , public KeyListener, public MouseMotionListener, public MouseListener
    {
    public:
        EventHandler(Root* root, RenderWindow* renderwindow); // , bool bHandleInput = true);

//        InputReader* GetInputReader();
    };
}
