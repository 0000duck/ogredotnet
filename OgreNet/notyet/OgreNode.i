%{
#include "OgreNode.h"
#include "NodeExt.h"
%}

%rename Ogre::Node::getParent             GetParent;
%rename Ogre::Node::getOrientation        GetOrientation;
%rename Ogre::Node::setOrientation        SetOrientation;
%rename Ogre::Node::resetOrientation      ResetOrientation;
%rename Ogre::Node::setPosition           SetPosition;
%rename Ogre::Node::getPosition           GetPosition;
%rename Ogre::Node::setScale              SetScale;
%rename Ogre::Node::getScale              GetScale;
%rename Ogre::Node::setInheritScale       SetInheritScale;
%rename Ogre::Node::getInheritScale       GetInheritScale;
%rename Ogre::Node::scale                 Scale;
%rename Ogre::Node::translate             Translate;
%rename Ogre::Node::roll                  Roll;
%rename Ogre::Node::pitch                 Pitch;
%rename Ogre::Node::yaw                   Yaw;
%rename Ogre::Node::rotate                Rotate;
%rename Ogre::Node::getLocalAxes          GetLocalAxes;
%rename Ogre::Node::createChild           CreateChild;
%rename Ogre::Node::addChild              AddChild;
%rename Ogre::Node::numChildren           NumChildren;
%rename Ogre::Node::getChild              GetChild;
%rename Ogre::Node::getName               GetName;
%rename Ogre::Node::removeChild           RemoveChild;
%rename Ogre::Node::removeAllChildren     RemoveAllChildren;
%rename Ogre::Node::getMaterial           GetMaterial;
%rename Ogre::Node::getWorldTransforms    GetWorldTransforms;
%rename Ogre::Node::getWorldOrientation   GetWorldOrientation;
%rename Ogre::Node::getWorldPosition      GetWorldPosition;
%rename Ogre::Node::setInitialState       SetInitialState;
%rename Ogre::Node::resetToInitialState   ResetToInitialState;
%rename Ogre::Node::getInitialPosition    GetInitialPosition;
%rename Ogre::Node::getInitialOrientation GetInitialOrientation;
%rename Ogre::Node::getInitialScale       GetInitialScale;
%rename Ogre::Node::getSquaredViewDepth   GetSquaredViewDepth;
%rename Ogre::Node::needUpdate            NeedUpdate;
%rename Ogre::Node::requestUpdate         RequestUpdate;
%rename Ogre::Node::cancelUpdate          CancelUpdate;
%rename Ogre::Node::getLights             GetLights;

//ignore because of RenderOperation is private
%ignore Ogre::Node::getRenderOperation;

//Custom wrap DONE, use NodeListenerDirector 
// you must keep a ref to the NodeListenerDirector untill the node is distroyed since theres no remove
%ignore Ogre::Node::setListener;
%ignore Ogre::Node::getListener;

//Custom wrap DONE,  swig does not have hash_map for csharp, use ChildNodeIteratorWrap
%ignore Ogre::Node::ChildNodeMap;
%ignore Ogre::Node::ConstChildNodeIterator;
%ignore Ogre::Node::ChildNodeIterator;
%ignore Ogre::Node::getChildIterator;



%newobject Ogre::Node::GetChildIterator;
%nodefault Ogre::ChildNodeIteratorWrap;



%typemap(cscode) Ogre::Node
%{
    public object GameNode // njkogre- added to allow for two-way pointers between OgreNodes and RF Nodes.
    {
        get { return _gameNode; }
        set { _gameNode = value; }
    }
    private object _gameNode;

    #region njkogre - added Yaw, Pitch, Roll with argument as Degrees
    //rastaman backwards, it should be PI/180 
    static private float _DegreesToRadiansFactor = (float)(Math.PI / 180.0); // njkogre-added

    public void Yaw(float degrees) // njkogre-added to bridge gap interface Axiom supported
    {
        float radians = degrees * _DegreesToRadiansFactor;
        Yaw(new Radian(radians));
    }

    public void Pitch(float degrees) // njkogre-added to bridge gap interface Axiom supported
    {
        float radians = degrees * _DegreesToRadiansFactor;
        Pitch(new Radian(radians));
    }

    public void Roll(float degrees) // njkogre-added to bridge gap interface Axiom supported
    {
        float radians = degrees * _DegreesToRadiansFactor;
        Roll(new Radian(radians));
    }

    #endregion njkogre - added Yaw, Pitch, Roll with argument as Degrees

    public string Name {
        get { return GetName(); }
    }

    public virtual Node Parent {
        get { return GetParent(); }
    }

    public virtual Math3D.Quaternion Orientation {
        get { return GetOrientation(); }
        set { SetOrientation(value); }
    }

    public virtual Math3D.Vector3 Position {
        get { return GetPosition(); }
        set { SetPosition(value); }
    }

    public virtual bool InheritScale {
        get { return GetInheritScale(); }
        set { SetInheritScale((bool)value); }
    }

    public virtual Math3D.Matrix3 LocalAxes {
        get { return GetLocalAxes(); }
    }

    public MaterialPtr Material {
        get { return GetMaterial(); }
    }

    public Math3D.Quaternion WorldOrientation {
        get { return GetWorldOrientation(); }
    }

    public Math3D.Vector3 WorldPosition {
        get { return GetWorldPosition(); }
    }

    public virtual Math3D.Vector3 InitialPosition {
        get { return GetInitialPosition(); }
    }

    public virtual Math3D.Quaternion InitialOrientation {
        get { return GetInitialOrientation(); }
    }

    public virtual Math3D.Vector3 InitialScale {
        get { return GetInitialScale(); }
    }

    public LightList Lights {
        get { return GetLights(); }
    }
%}


%typemap(cscode) Ogre::NodeListenerDirector %{
    public    delegate  void  NLD_Delegate  (Node node);
    protected delegate  void  _NLD_Delegate (IntPtr node);

    public void SubscribeEvents()
    {
        m_Delegate_nodeUpdated =    new _NLD_Delegate  (Handle_NodeUpdated);
        set_NLD_FP_nodeUpdated     (swigCPtr, m_Delegate_nodeUpdated);
        
        m_Delegate_nodeDestroyed =    new _NLD_Delegate  (Handle_NodeDestroyed);
        set_NLD_FP_nodeDestroyed     (swigCPtr, m_Delegate_nodeDestroyed);
        
        m_Delegate_nodeAttached =    new _NLD_Delegate  (Handle_NodeAttached);
        set_NLD_FP_nodeAttached     (swigCPtr, m_Delegate_nodeAttached);
        
        m_Delegate_nodeDetached =    new _NLD_Delegate  (Handle_NodeDetached);
        set_NLD_FP_nodeDetached     (swigCPtr, m_Delegate_nodeDetached);
        
    }
    public event    NLD_Delegate        evtNodeUpdated = null;
    public event    NLD_Delegate        evtNodeDestroyed = null;
    public event    NLD_Delegate        evtNodeAttached = null;
    public event    NLD_Delegate        evtNodeDetached = null;
    
    protected    _NLD_Delegate            m_Delegate_nodeUpdated = null;
    protected    _NLD_Delegate            m_Delegate_nodeDestroyed = null;
    protected    _NLD_Delegate            m_Delegate_nodeAttached = null;
    protected    _NLD_Delegate            m_Delegate_nodeDetached = null;



    [DllImport("OgreBindings", EntryPoint="set_NLD_FP_nodeUpdated")]
    protected static extern void set_NLD_FP_nodeUpdated(HandleRef nodelistenerdirector, _NLD_Delegate fn);

    [DllImport("OgreBindings", EntryPoint="set_NLD_FP_nodeDestroyed")]
    protected static extern void set_NLD_FP_nodeDestroyed(HandleRef nodelistenerdirector, _NLD_Delegate fn);

    [DllImport("OgreBindings", EntryPoint="set_NLD_FP_nodeAttached")]
    protected static extern void set_NLD_FP_nodeAttached(HandleRef nodelistenerdirector, _NLD_Delegate fn);

    [DllImport("OgreBindings", EntryPoint="set_NLD_FP_nodeDetached")]
    protected static extern void set_NLD_FP_nodeDetached(HandleRef nodelistenerdirector, _NLD_Delegate fn);
    
    
    
    protected void Handle_NodeUpdated (IntPtr node)
    {
        if(evtNodeUpdated != null)
            evtNodeUpdated(new Node(node, false));
    }
    
    protected void Handle_NodeDestroyed (IntPtr node)
    {
        if(evtNodeDestroyed != null)
            evtNodeDestroyed(new Node(node, false));
    }
    
    protected void Handle_NodeAttached (IntPtr node)
    {
        if(evtNodeAttached != null)
            evtNodeAttached(new Node(node, false));
    }
    
    protected void Handle_NodeDetached (IntPtr node)
    {
        if(evtNodeDetached != null)
            evtNodeDetached(new Node(node, false));
    }
    
%}


%include "OgreNode.h"

namespace Ogre
{
    class ChildNodeIteratorWrap 
    {
    public:
        std::string peekNextKey(void);
        Ogre::Node * peekNextValue(void);
        Ogre::Node * getNext(void);
        bool hasMoreElements(void) const;
        void moveNext(void) const;
        Ogre::Node * next();
    };
    
    
    class NodeListenerDirector
    {
    public:
        NodeListenerDirector();
        virtual ~NodeListenerDirector();
        virtual void nodeUpdated(const Node* node);
        virtual void nodeDestroyed(const Node* node);
        virtual void nodeAttached(const Node* node);
        virtual void nodeDetached(const Node* node);
    };
    
}


%extend Ogre::Node
{
    Ogre::ChildNodeIteratorWrap* GetChildIterator()
    {
        Ogre::Node::ChildNodeIterator *i = &self->getChildIterator();
        return new Ogre::ChildNodeIteratorWrap(i);
    }
    Ogre::Renderable * GetAsRenderable()    {
        return (Renderable*)self;
    }
    
    void SetListener(Ogre::NodeListenerDirector* listener)
    {
        self->setListener (listener);
    }
    Ogre::NodeListenerDirector* GetListener(void) const
    {
        //this should be ok, the only thing that sets a listener should be your app
        // and it needs to uses NodeListenerDirector.
        //but how can we make sure what type is returned?
        //if we dont static cast will an exception be thown if its not a director???
        return (Ogre::NodeListenerDirector*)self->getListener(); 
    }

};

