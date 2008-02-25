%{
#include "OgreSimpleRenderable.h"
#include "SimpleRenderableDirector.h"
%}

//ignore because of RenderOperation is private
%ignore Ogre::SimpleRenderable::setRenderOperation;
%ignore Ogre::SimpleRenderable::getRenderOperation;
%ignore Ogre::SimpleRenderableDirector::setRenderOperation;
%ignore Ogre::SimpleRenderableDirector::getRenderOperation;


%typemap(cscode) Ogre::SimpleRenderable
%{
    //because theres no static_cast if you get an object that was originaly created as a SimpleRenderable
    // or somthing derived from SimpleRenderable.  Use these to convert it
    static public SimpleRenderable GetSimpleRenderableFrom(MovableObject c)
    {
        SimpleRenderable ret = new SimpleRenderable(MovableObject.getCPtr(c).Handle , false);
        return ret;
    }
    static public SimpleRenderable GetSimpleRenderableFrom(Renderable c)
    {
        SimpleRenderable ret = new SimpleRenderable(Renderable.getCPtr(c).Handle , false);
        return ret;
    }
%}



%include "OgreSimpleRenderable.h"


%extend Ogre::SimpleRenderable {
    Ogre::Renderable * GetAsRenderable()    {
        return (Ogre::Renderable*)self;
    }
};



%typemap(cscode) Ogre::SimpleRenderableDirector %{
    public delegate  MaterialPtr        SRD_Delegate_getMaterial            ();
    public delegate  void                 SRD_Delegate_getWorldTransforms        (Math3D.Matrix4 xform);
    public delegate  Math3D.Quaternion     SRD_Delegate_getWorldOrientation    ();
    public delegate  Math3D.Vector3     SRD_Delegate_getWorldPosition        ();
    public delegate  void                 SRD_Delegate_notifyCurrentCamera    (Camera cam);
    public delegate  AxisAlignedBox        SRD_Delegate_getBoundingBox            ();
    public delegate  void                 SRD_Delegate_updateRenderQueue        (RenderQueue queue);
    public delegate  string             SRD_Delegate_getName                ();
    public delegate  string             SRD_Delegate_getMovableType            ();
    public delegate  LightList             SRD_Delegate_getLights                ();
    public delegate  float                SRD_Delegate_getSquaredViewDepth    (Camera cam);
    public delegate  float                SRD_Delegate_getBoundingRadius        ();
    
    protected delegate  IntPtr        _SRD_Delegate_getMaterial            ();
    protected delegate  void         _SRD_Delegate_getWorldTransforms    (IntPtr xform);
    protected delegate  IntPtr        _SRD_Delegate_getWorldOrientation    ();
    protected delegate  IntPtr        _SRD_Delegate_getWorldPosition        ();
    protected delegate  void         _SRD_Delegate_notifyCurrentCamera    (IntPtr cam);
    protected delegate  IntPtr        _SRD_Delegate_getBoundingBox        ();
    protected delegate  void         _SRD_Delegate_updateRenderQueue        (IntPtr queue);
    protected delegate  string         _SRD_Delegate_getName                ();
    protected delegate  string         _SRD_Delegate_getMovableType        ();
    protected delegate  IntPtr        _SRD_Delegate_getLights                ();
    protected delegate  float        _SRD_Delegate_getSquaredViewDepth    (IntPtr cam);
    protected delegate  float        _SRD_Delegate_getBoundingRadius        ();
    
    
    
    public Renderable RO_Renderable {
        get { return this.GetRO_Renderable(); }
    }
        
    public IndexData RO_IndexData {
        get { return this.GetRO_IndexData(); }
        set { this.SetRO_IndexData(value); }
    }
    
    public bool RO_UseIndexes {
        get { return this.GetRO_UseIndexes(); }
        set { this.SetRO_UseIndexes(value); }
    }
    
    public OperationType RO_OperationType {
        get { return (OperationType)this.GetRO_OperationType(); }
        set { this.SetRO_OperationType((int)value); }
    }
    
    public VertexData RO_VertexData {
        get { return this.GetRO_VertexData(); }
        set { this.SetRO_VertexData(value); }
    }
    
    
    
    public void Init_Event_GetMaterial()    {
        m_Delegate_GetMaterial =            new _SRD_Delegate_getMaterial            (Handle_GetMaterial);
        set_SRD_FP_getMaterial            (swigCPtr, m_Delegate_GetMaterial);
    }
    public void Init_Event_GetWorldTransforms()            {
        m_Delegate_GetWorldTransforms =        new    _SRD_Delegate_getWorldTransforms    (Handle_GetWorldTransforms);
        set_SRD_FP_getWorldTransforms    (swigCPtr, m_Delegate_GetWorldTransforms);
    }
    public void Init_Event_GetWorldOrientation()        {
        m_Delegate_GetWorldOrientation =    new    _SRD_Delegate_getWorldOrientation    (Handle_GetWorldOrientation);
        set_SRD_FP_getWorldOrientation    (swigCPtr, m_Delegate_GetWorldOrientation);
    }
    public void Init_Event_GetWorldPosition()            {
        m_Delegate_GetWorldPosition =        new    _SRD_Delegate_getWorldPosition        (Handle_GetWorldPosition);
        set_SRD_FP_getWorldPosition        (swigCPtr, m_Delegate_GetWorldPosition);
    }
    public void Init_Event_NotifyCurrentCamera()        {
        m_Delegate_NotifyCurrentCamera =    new    _SRD_Delegate_notifyCurrentCamera    (Handle_NotifyCurrentCamera);
        set_SRD_FP_notifyCurrentCamera    (swigCPtr, m_Delegate_NotifyCurrentCamera);
    }
    public void Init_Event_GetBoundingBox()        {
        m_Delegate_GetBoundingBox =            new    _SRD_Delegate_getBoundingBox        (Handle_GetBoundingBox);
        set_SRD_FP_getBoundingBox        (swigCPtr, m_Delegate_GetBoundingBox);
    }
    public void Init_Event_UpdateRenderQueue()        {
        m_Delegate_UpdateRenderQueue =        new    _SRD_Delegate_updateRenderQueue        (Handle_UpdateRenderQueue);
        set_SRD_FP_updateRenderQueue    (swigCPtr, m_Delegate_UpdateRenderQueue);
    }
    public void Init_Event_GetName()        {
        m_Delegate_GetName =                new    _SRD_Delegate_getName                (Handle_GetName);
        set_SRD_FP_getName                (swigCPtr, m_Delegate_GetName);
    }
    public void Init_Event_GetMovableType()        {
        m_Delegate_GetMovableType =            new    _SRD_Delegate_getMovableType        (Handle_GetMovableType);
        set_SRD_FP_getMovableType        (swigCPtr, m_Delegate_GetMovableType);
    }
    public void Init_Event_GetLights()        {
        m_Delegate_GetLights =                new    _SRD_Delegate_getLights                (Handle_GetLights);
        set_SRD_FP_getLights            (swigCPtr, m_Delegate_GetLights);
    }
    public void Init_Event_GetSquaredViewDepth()        {
        m_Delegate_GetSquaredViewDepth =    new    _SRD_Delegate_getSquaredViewDepth    (Handle_GetSquaredViewDepth);
        set_SRD_FP_getSquaredViewDepth    (swigCPtr, m_Delegate_GetSquaredViewDepth);
    }
    public void Init_Event_GetBoundingRadius()        {
        m_Delegate_GetBoundingRadius =        new    _SRD_Delegate_getBoundingRadius        (Handle_GetBoundingRadius);
        set_SRD_FP_getBoundingRadius    (swigCPtr, m_Delegate_GetBoundingRadius);
    }
    
    public event    SRD_Delegate_getMaterial            evtGetMaterial = null;
    public event    SRD_Delegate_getWorldTransforms        evtGetWorldTransforms = null;
    public event    SRD_Delegate_getWorldOrientation    evtGetWorldOrientation = null;
    public event    SRD_Delegate_getWorldPosition        evtGetWorldPosition = null;
    public event    SRD_Delegate_notifyCurrentCamera    evtNotifyCurrentCamera = null;
    public event    SRD_Delegate_getBoundingBox            evtGetBoundingBox = null;
    public event    SRD_Delegate_updateRenderQueue        evtUpdateRenderQueue = null;
    public event    SRD_Delegate_getName                evtGetName = null;
    public event    SRD_Delegate_getMovableType            evtGetMovableType = null;
    public event    SRD_Delegate_getLights                evtGetLights = null;
    public event    SRD_Delegate_getSquaredViewDepth    evtGetSquaredViewDepth = null;
    public event    SRD_Delegate_getBoundingRadius        evtGetBoundingRadius = null;
    
    protected    _SRD_Delegate_getMaterial            m_Delegate_GetMaterial = null;
    protected    _SRD_Delegate_getWorldTransforms    m_Delegate_GetWorldTransforms = null;
    protected    _SRD_Delegate_getWorldOrientation    m_Delegate_GetWorldOrientation = null;
    protected    _SRD_Delegate_getWorldPosition        m_Delegate_GetWorldPosition = null;
    protected    _SRD_Delegate_notifyCurrentCamera    m_Delegate_NotifyCurrentCamera = null;
    protected    _SRD_Delegate_getBoundingBox        m_Delegate_GetBoundingBox = null;
    protected    _SRD_Delegate_updateRenderQueue        m_Delegate_UpdateRenderQueue = null;
    protected    _SRD_Delegate_getName                m_Delegate_GetName = null;
    protected    _SRD_Delegate_getMovableType        m_Delegate_GetMovableType = null;
    protected    _SRD_Delegate_getLights                m_Delegate_GetLights = null;
    protected    _SRD_Delegate_getSquaredViewDepth    m_Delegate_GetSquaredViewDepth = null;
    protected    _SRD_Delegate_getBoundingRadius        m_Delegate_GetBoundingRadius = null;
    
    
    [DllImport("OgreBindings", EntryPoint="set_SRD_FP_getMaterial")]
    protected static extern void set_SRD_FP_getMaterial(HandleRef SRenderableDirector, _SRD_Delegate_getMaterial fn);
    
    [DllImport("OgreBindings", EntryPoint="set_SRD_FP_getWorldTransforms")]
    protected static extern void set_SRD_FP_getWorldTransforms(HandleRef SRenderableDirector, _SRD_Delegate_getWorldTransforms fn);
    
    [DllImport("OgreBindings", EntryPoint="set_SRD_FP_getWorldOrientation")]
    protected static extern void set_SRD_FP_getWorldOrientation(HandleRef SRenderableDirector, _SRD_Delegate_getWorldOrientation fn);
    
    [DllImport("OgreBindings", EntryPoint="set_SRD_FP_getWorldPosition")]
    protected static extern void set_SRD_FP_getWorldPosition(HandleRef SRenderableDirector, _SRD_Delegate_getWorldPosition fn);
    
    [DllImport("OgreBindings", EntryPoint="set_SRD_FP_notifyCurrentCamera")]
    protected static extern void set_SRD_FP_notifyCurrentCamera(HandleRef SRenderableDirector, _SRD_Delegate_notifyCurrentCamera fn);
    
    [DllImport("OgreBindings", EntryPoint="set_SRD_FP_getBoundingBox")]
    protected static extern void set_SRD_FP_getBoundingBox(HandleRef SRenderableDirector, _SRD_Delegate_getBoundingBox fn);
    
    [DllImport("OgreBindings", EntryPoint="set_SRD_FP_updateRenderQueue")]
    protected static extern void set_SRD_FP_updateRenderQueue(HandleRef SRenderableDirector, _SRD_Delegate_updateRenderQueue fn);
    
    [DllImport("OgreBindings", EntryPoint="set_SRD_FP_getName")]
    protected static extern void set_SRD_FP_getName(HandleRef SRenderableDirector, _SRD_Delegate_getName fn);
    
    [DllImport("OgreBindings", EntryPoint="set_SRD_FP_getMovableType")]
    protected static extern void set_SRD_FP_getMovableType(HandleRef SRenderableDirector, _SRD_Delegate_getMovableType fn);
    
    [DllImport("OgreBindings", EntryPoint="set_SRD_FP_getLights")]
    protected static extern void set_SRD_FP_getLights(HandleRef SRenderableDirector, _SRD_Delegate_getLights fn);
    
    [DllImport("OgreBindings", EntryPoint="set_SRD_FP_getSquaredViewDepth")]
    protected static extern void set_SRD_FP_getSquaredViewDepth(HandleRef SRenderableDirector, _SRD_Delegate_getSquaredViewDepth fn);
    
    [DllImport("OgreBindings", EntryPoint="set_SRD_FP_getBoundingRadius")]
    protected static extern void set_SRD_FP_getBoundingRadius(HandleRef SRenderableDirector, _SRD_Delegate_getBoundingRadius fn);
    
    
    protected IntPtr Handle_GetMaterial()
    {
        IntPtr ret;
        MaterialPtr m;
        if(evtGetMaterial != null)
            m = evtGetMaterial();
        else
            m = this.CallBase_getMaterial();
        ret = MaterialPtr.getCPtr(m).Handle;
        return ret;
    }

    protected void Handle_GetWorldTransforms (IntPtr xform)
    {
        Math3D.Matrix4 m = OgreMatrix4.ToMatrix4(new OgreMatrix4(xform,false));
        if(evtGetWorldTransforms != null)
            evtGetWorldTransforms(m);
        else
            this.CallBase_getWorldTransforms(m);
    }
    

    protected IntPtr Handle_GetWorldOrientation ()
    {
        IntPtr ret;
        OgreQuaternion q;
        if(evtGetWorldOrientation != null)    
            q = OgreQuaternion.FromQuaternion(evtGetWorldOrientation());
        else 
            q = OgreQuaternion.FromQuaternion(this.CallBase_getWorldOrientation());
        ret = OgreQuaternion.getCPtr(q).Handle;
        return ret;
    }
    

    protected IntPtr Handle_GetWorldPosition ()
    {
        IntPtr ret;
        OgreVector3 v;
        if(evtGetWorldPosition != null)
            v = OgreVector3.FromVector3(evtGetWorldPosition());
        else
            v = OgreVector3.FromVector3(this.CallBase_getWorldPosition());
        ret = OgreVector3.getCPtr(v).Handle;
        return ret;
    }
    

    protected void Handle_NotifyCurrentCamera (IntPtr cam)
    {
        Camera c = new Camera(cam, false);
        if(evtNotifyCurrentCamera != null)
            evtNotifyCurrentCamera(c);
        else
            this.CallBase_notifyCurrentCamera(c);
    }
    

    protected IntPtr Handle_GetBoundingBox ()
    {
        IntPtr ret;
        AxisAlignedBox a;
        if(evtGetBoundingBox != null)
            a = evtGetBoundingBox();
        else
            a = this.CallBase_getBoundingBox();
        ret = AxisAlignedBox.getCPtr(a).Handle;
        return ret;
    }
    

    protected void Handle_UpdateRenderQueue (IntPtr queue)
    {
        RenderQueue r = new RenderQueue(queue, false);
        if(evtUpdateRenderQueue != null)
            evtUpdateRenderQueue(r);
        else
            this.CallBase_updateRenderQueue(r);
    }
    

    protected string Handle_GetName ()
    {
        if(evtGetName != null)
            return evtGetName();
        else
            return this.CallBase_getName();
    }
    

    protected string Handle_GetMovableType ()
    {
        if(evtGetMovableType != null)
            return evtGetMovableType();
        else
            return this.CallBase_getMovableType();
    }
    

    protected IntPtr Handle_GetLights ()
    {
        IntPtr ret;
        LightList l;
        if(evtGetLights != null)
            l = evtGetLights();
        else
            l = this.CallBase_getLights();
        ret = LightList.getCPtr(l).Handle;
        return ret;
    }
    

    protected float Handle_GetSquaredViewDepth (IntPtr cam)
    {
        Camera c = new Camera(cam, false);
        if(evtGetSquaredViewDepth != null)
            return evtGetSquaredViewDepth(c);
        else
            return 0.0f; //it is abstract and not on SimpleRenderer (multi-Inheritence problem)
    }
    

    protected float Handle_GetBoundingRadius ()
    {
        if(evtGetBoundingRadius != null)
            return evtGetBoundingRadius();
        else
            return 0.0f;    //it is abstract and not on SimpleRenderer (multi-Inheritence problem)
    }
    
%}


namespace Ogre
{
    class SimpleRenderableDirector : public SimpleRenderable
    {
    public:
        SimpleRenderableDirector();
        
        const Renderable * GetRO_Renderable();
        
        IndexData * GetRO_IndexData();
        void SetRO_IndexData(IndexData * v);
        
        bool GetRO_UseIndexes();
        void SetRO_UseIndexes(bool v);
        
        int GetRO_OperationType();
        void SetRO_OperationType(int v);
        
        VertexData * GetRO_VertexData();
        void SetRO_VertexData(VertexData * v);
        
        
        const MaterialPtr& CallBase_getMaterial(void) const;
        void CallBase_getWorldTransforms(Matrix4* xform) const;
        const Quaternion& CallBase_getWorldOrientation(void) const;
        const Vector3& CallBase_getWorldPosition(void) const;
        void CallBase_notifyCurrentCamera(Camera* cam);
        const AxisAlignedBox& CallBase_getBoundingBox(void) const;
        void CallBase_updateRenderQueue(RenderQueue* queue);
        const String& CallBase_getName(void) const;
        const String& CallBase_getMovableType(void) const;
        const LightList& CallBase_getLights(void) const;

        virtual Real getSquaredViewDepth(const Camera* cam) const;
        virtual Real getBoundingRadius(void) const;
    };
}

