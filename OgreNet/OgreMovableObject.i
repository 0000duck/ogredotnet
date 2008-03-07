%{
#include "OgreMovableObject.h"
#include "MovableObjectExt.h"
%}

//params is a keyword in C#.  there is a %extend for this function
%ignore Ogre::MovableObjectFactory::createInstance(const String& name, SceneManager* manager, const NameValuePairList* params = 0);

%typemap(cscode) Ogre::MovableObject
%{
    public object UserData // njkogre - dont use the Ogre "UserObject" - we got our own.
    {
        get{return _userData;}
        set{_userData = value;}
    }
    private object _userData;

    public virtual string Name {
        get { return getName(); }
    }

    public virtual string MovableType {
        get { return getMovableType(); }
    }

    public virtual Node ParentNode {
        get { return getParentNode(); }
    }

    public virtual SceneNode ParentSceneNode {
        get { return getParentSceneNode(); }
    }

    public virtual AxisAlignedBox BoundingBox {
        get { return getBoundingBox(); }
    }

    public virtual float BoundingRadius {
        get { return getBoundingRadius(); }
    }

//    public virtual void Visible {
//        get { return IsVisible(); }
//        set { setVisible((bool)value); }
//    }

    public virtual RenderQueueGroupID RenderQueueGroup {
        get { return (RenderQueueGroupID)(int)getRenderQueueGroup(); }
        set { setRenderQueueGroup((byte)value); }
    }

    public virtual UInt32 QueryFlags {
        get { return getQueryFlags(); }
        set { setQueryFlags(value); }
    }

    public AxisAlignedBox LightCapBounds {
        get { return getLightCapBounds(); }
    }

    public bool CastShadows {
        get { return getCastShadows(); }
        set { setCastShadows((bool)value); }
    }

    static public MovableObject GetMovableObjectFrom(BillboardSet c)    {
        return new MovableObject(BillboardSet.getCPtr(c).Handle , false);
    }

    static public MovableObject GetMovableObjectFrom(Entity c)    {
        return new MovableObject(Entity.getCPtr(c).Handle , false);
    }

    static public MovableObject GetMovableObjectFrom(Frustum c)    {
        return new MovableObject(Frustum.getCPtr(c).Handle , false);
    }

    static public MovableObject GetMovableObjectFrom(Light c)    {
        return new MovableObject(Light.getCPtr(c).Handle , false);
    }

    static public MovableObject GetMovableObjectFrom(MovablePlane c)    {
        return new MovableObject(MovablePlane.getCPtr(c).Handle , false);
    }

    static public MovableObject GetMovableObjectFrom(ParticleSystem c)    {
        return new MovableObject(ParticleSystem.getCPtr(c).Handle , false);
    }

    static public MovableObject GetMovableObjectFrom(SimpleRenderable c)    {
        return new MovableObject(SimpleRenderable.getCPtr(c).Handle , false);
    }

/*    static public MovableObject GetMovableObjectFrom(Region c)    {
        return new MovableObject(Region.getCPtr(c).Handle , false);
    }
*/
%}

%include "OgreMovableObject.h"

%extend Ogre::MovableObject {
    AnimableObject * GetAsAnimableObject()    {
        return (AnimableObject*)self;
    }
};

%extend Ogre::MovableObjectFactory {
    MovableObject* CreateInstance(const String& name, SceneManager* manager, const NameValuePairList* vparams = 0)
    {
        return self->createInstance(name, manager, vparams);
    }
};

%typemap(cscode) Ogre::MovableObjectFactoryDirector %{
    public delegate  MovableObject    MOFD_Delegate_createInstanceImpl    (string name, NameValuePairList vParams);
    public delegate  string            MOFD_Delegate_getType                ();
    public delegate  MovableObject    MOFD_Delegate_createInstance        (string name, SceneManager scnMngr, NameValuePairList vParams);
    public delegate  void            MOFD_Delegate_destroyInstance        (MovableObject obj);
    public delegate  bool            MOFD_Delegate_requestTypeFlags        ();
    public delegate  void            MOFD_Delegate_notifyTypeFlags        (UInt32 flag);
    public delegate  UInt32            MOFD_Delegate_getTypeFlags            ();
    
    protected delegate  IntPtr        _MOFD_Delegate_createInstanceImpl    (string name, IntPtr vParams);
    protected delegate  string        _MOFD_Delegate_getType                ();
    protected delegate  IntPtr        _MOFD_Delegate_createInstance        (string name, IntPtr scnMngr, IntPtr vParams);
    protected delegate  void        _MOFD_Delegate_destroyInstance        (IntPtr obj);
    protected delegate  bool        _MOFD_Delegate_requestTypeFlags        ();
    protected delegate  void        _MOFD_Delegate_notifyTypeFlags        (UInt32 flag);
    protected delegate  UInt32        _MOFD_Delegate_getTypeFlags            ();
    
    public void Init_Event_CreateInstanceImpl()    {
        m_Delegate_CreateInstanceImpl = new _MOFD_Delegate_createInstanceImpl(Handle_CreateInstanceImpl);
        set_MOFD_FP_createInstanceImpl(swigCPtr, m_Delegate_CreateInstanceImpl);
    }
    public void Init_Event_GetType()    {
        m_Delegate_GetType = new _MOFD_Delegate_getType(Handle_GetType);
        set_MOFD_FP_getType(swigCPtr, m_Delegate_GetType);
    }
    public void Init_Event_CreateInstance()    {
        m_Delegate_CreateInstance = new _MOFD_Delegate_createInstance(Handle_CreateInstance);
        set_MOFD_FP_createInstance(swigCPtr, m_Delegate_CreateInstance);
    }
    public void Init_Event_DestroyInstance()    {
        m_Delegate_DestroyInstance = new _MOFD_Delegate_destroyInstance(Handle_DestroyInstance);
        set_MOFD_FP_destroyInstance(swigCPtr, m_Delegate_DestroyInstance);
    }
    public void Init_Event_RequestTypeFlags()    {
        m_Delegate_RequestTypeFlags = new _MOFD_Delegate_requestTypeFlags(Handle_RequestTypeFlags);
        set_MOFD_FP_requestTypeFlags(swigCPtr, m_Delegate_RequestTypeFlags);
    }
    public void Init_Event_NotifyTypeFlags()    {
        m_Delegate_NotifyTypeFlags = new _MOFD_Delegate_notifyTypeFlags(Handle_NotifyTypeFlags);
        set_MOFD_FP_notifyTypeFlags(swigCPtr, m_Delegate_NotifyTypeFlags);
    }
    public void Init_Event_GetTypeFlags()    {
        m_Delegate_GetTypeFlags = new _MOFD_Delegate_getTypeFlags(Handle_GetTypeFlags);
        set_MOFD_FP_getTypeFlags(swigCPtr, m_Delegate_GetTypeFlags);
    }
    
    public event    MOFD_Delegate_createInstanceImpl        evtCreateInstanceImpl = null;
    public event    MOFD_Delegate_getType                    evtGetType = null;
    public event    MOFD_Delegate_createInstance            evtCreateInstance = null;
    public event    MOFD_Delegate_destroyInstance            evtDestroyInstance = null;
    public event    MOFD_Delegate_requestTypeFlags            evtRequestTypeFlags = null;
    public event    MOFD_Delegate_notifyTypeFlags            evtNotifyTypeFlags = null;
    public event    MOFD_Delegate_getTypeFlags                evtGetTypeFlags = null;
    
    protected    _MOFD_Delegate_createInstanceImpl        m_Delegate_CreateInstanceImpl = null;
    protected    _MOFD_Delegate_getType                    m_Delegate_GetType = null;
    protected    _MOFD_Delegate_createInstance            m_Delegate_CreateInstance = null;
    protected    _MOFD_Delegate_destroyInstance            m_Delegate_DestroyInstance = null;
    protected    _MOFD_Delegate_requestTypeFlags            m_Delegate_RequestTypeFlags = null;
    protected    _MOFD_Delegate_notifyTypeFlags            m_Delegate_NotifyTypeFlags = null;
    protected    _MOFD_Delegate_getTypeFlags                m_Delegate_GetTypeFlags = null;
    
    [DllImport("OgreBindings", EntryPoint="set_MOFD_FP_createInstanceImpl")]
    protected static extern void set_MOFD_FP_createInstanceImpl(HandleRef MOFactoryDirector, _MOFD_Delegate_createInstanceImpl fn);
    
    [DllImport("OgreBindings", EntryPoint="set_MOFD_FP_getType")]
    protected static extern void set_MOFD_FP_getType(HandleRef MOFactoryDirector, _MOFD_Delegate_getType fn);
    
    [DllImport("OgreBindings", EntryPoint="set_MOFD_FP_createInstance")]
    protected static extern void set_MOFD_FP_createInstance(HandleRef MOFactoryDirector, _MOFD_Delegate_createInstance fn);
    
    [DllImport("OgreBindings", EntryPoint="set_MOFD_FP_destroyInstance")]
    protected static extern void set_MOFD_FP_destroyInstance(HandleRef MOFactoryDirector, _MOFD_Delegate_destroyInstance fn);
    
    [DllImport("OgreBindings", EntryPoint="set_MOFD_FP_requestTypeFlags")]
    protected static extern void set_MOFD_FP_requestTypeFlags(HandleRef MOFactoryDirector, _MOFD_Delegate_requestTypeFlags fn);
    
    [DllImport("OgreBindings", EntryPoint="set_MOFD_FP_notifyTypeFlags")]
    protected static extern void set_MOFD_FP_notifyTypeFlags(HandleRef MOFactoryDirector, _MOFD_Delegate_notifyTypeFlags fn);
    
    [DllImport("OgreBindings", EntryPoint="set_MOFD_FP_getTypeFlags")]
    protected static extern void set_MOFD_FP_getTypeFlags(HandleRef MOFactoryDirector, _MOFD_Delegate_getTypeFlags fn);

    protected IntPtr Handle_CreateInstanceImpl(string name, IntPtr vParams)
    {
        IntPtr ret;
        MovableObject r=null;
        if (evtCreateInstanceImpl != null)
            r = evtCreateInstanceImpl(name,  new NameValuePairList(vParams, false));
        ret = MovableObject.getCPtr(r).Handle;
        return ret;
    }
    
    protected string Handle_GetType()
    {
        if (evtGetType != null)
            return evtGetType();
        else
            return "";
    }
    
    protected IntPtr Handle_CreateInstance(string name, IntPtr scnMngr, IntPtr vParams)
    {
        IntPtr ret;
        MovableObject r=null;
        if (evtCreateInstance != null)
            r = evtCreateInstance(name, new SceneManager(scnMngr, false), new NameValuePairList(vParams, false));
        ret = MovableObject.getCPtr(r).Handle;
        return ret;
    }
    
    protected void Handle_DestroyInstance(IntPtr obj)
    {
        if (evtDestroyInstance != null)
            evtDestroyInstance(new MovableObject(obj, false));
    }
    
    protected bool Handle_RequestTypeFlags()
    {
        if (evtRequestTypeFlags != null)
            return evtRequestTypeFlags();
        else
            return false;
    }
    
    protected void Handle_NotifyTypeFlags(UInt32 flag)
    {
        if (evtNotifyTypeFlags != null)
            evtNotifyTypeFlags(flag);
    }
    
    protected UInt32 Handle_GetTypeFlags()
    {
        if (evtGetTypeFlags != null)
            return evtGetTypeFlags();
        else
            return 0;
    }
%}

namespace Ogre
{
    class MovableObjectFactoryDirector : public Ogre::MovableObjectFactory 
    {
    public:
        MovableObjectFactoryDirector();
        virtual ~MovableObjectFactoryDirector();

        /// Type flag, allocated if requested
        unsigned long get_TypeFlag();
        void set_TypeFlag(unsigned long value);

        /// Internal implementation of create method - must be overridden
        virtual MovableObject* CreateInstanceImpl(const String& name, const NameValuePairList* vParams = 0);
    };
}
