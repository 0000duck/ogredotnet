%{
#include "OgreCompositorInstance.h"
#include "CompositorInstanceExt.h"
%}

%ignore Ogre::CompositorInstance::addListener;
%ignore Ogre::CompositorInstance::removeListener;
%ignore Ogre::CompositorInstance::_compileTargetOperations;
%ignore Ogre::CompositorInstance::_compileOutputOperation;


%typemap(cscode) Ogre::CompositorInstanceListenerDirector %{
	public    delegate  void  CILD_Delegate  (UInt32 pass_id, MaterialPtr mat);
	protected delegate  void  _CILD_Delegate (UInt32 pass_id, IntPtr mat);

	public void SubscribeEvents()
	{
		m_Delegate_notifyMaterialSetup =    new _CILD_Delegate  ( Handle_NotifyMaterialSetup );
		set_CILD_FP_notifyMaterialSetup     (swigCPtr, m_Delegate_notifyMaterialSetup);
		
		m_Delegate_notifyMaterialRender =    new _CILD_Delegate  ( Handle_NotifyMaterialRender );
		set_CILD_FP_notifyMaterialRender     (swigCPtr, m_Delegate_notifyMaterialRender);
	}
	
	public event	CILD_Delegate		evtNotifyMaterialSetup = null;
	public event	CILD_Delegate		evtNotifyMaterialRender = null;
	
	protected	_CILD_Delegate			m_Delegate_notifyMaterialSetup = null;
	protected	_CILD_Delegate			m_Delegate_notifyMaterialRender = null;
	
	[DllImport("OgreBindings", EntryPoint="set_CILD_FP_notifyMaterialSetup")]
	protected static extern void set_CILD_FP_notifyMaterialSetup( HandleRef cilistenerd, _CILD_Delegate fn );
	
	[DllImport("OgreBindings", EntryPoint="set_CILD_FP_notifyMaterialRender")]
	protected static extern void set_CILD_FP_notifyMaterialRender( HandleRef cilistenerd, _CILD_Delegate fn );
	
	
	protected void Handle_NotifyMaterialSetup (UInt32 pass_id, IntPtr mat)
	{
		if( evtNotifyMaterialSetup != null )
			evtNotifyMaterialSetup( pass_id, new MaterialPtr( mat, false ) );
	}
	
	protected void Handle_NotifyMaterialRender (UInt32 pass_id, IntPtr mat)
	{
		if( evtNotifyMaterialRender != null )
			evtNotifyMaterialRender( pass_id, new MaterialPtr( mat, false ) );
	}
	
	
%}



%include "OgreCompositorInstance.h"

namespace Ogre
{
	class CompositorInstanceListenerDirector
	{
	public:
		CompositorInstanceListenerDirector();
		virtual ~CompositorInstanceListenerDirector();
		virtual void notifyMaterialSetup(uint32 pass_id, MaterialPtr &mat);
		virtual void notifyMaterialRender(uint32 pass_id, MaterialPtr &mat);
	};
}


%extend Ogre::CompositorInstance
{
	void AddListener(Ogre::CompositorInstanceListenerDirector *l)
	{
		self->addListener( (Ogre::CompositorInstance::Listener *)l );
	}
	void RemoveListener(Ogre::CompositorInstanceListenerDirector *l)
	{
		self->removeListener( (Ogre::CompositorInstance::Listener *)l );
	}
};


//typedef std::vector<CompositorInstance*> Instances;
SWIG_STD_VECTOR_SPECIALIZE_MINIMUM(CompositorInstance, Ogre::CompositorInstance*)
%template(CompositorInstances) std::vector<Ogre::CompositorInstance*>;

	
//typedef VectorIterator<Instances> InstanceIterator;
VectorIteratorWRAP(CompositorInstancesIteratorWrap, std::vector, Ogre::CompositorInstance*);
