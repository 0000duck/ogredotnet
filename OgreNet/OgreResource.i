%{
#include "OgreResource.h"
#include "ResourceExt.h"
%}

%rename Ogre::Resource::load             Load;
%rename Ogre::Resource::reload           Reload;
%rename Ogre::Resource::isManuallyLoaded IsManuallyLoaded;
%rename Ogre::Resource::unload           Unload;
%rename Ogre::Resource::getSize          GetSize;
%rename Ogre::Resource::touch            Touch;
%rename Ogre::Resource::getName          GetName;
%rename Ogre::Resource::getHandle        GetHandle;
%rename Ogre::Resource::isLoaded         IsLoaded;
%rename Ogre::Resource::getGroup         GetGroup;
%rename Ogre::Resource::getCreator       GetCreator;
%rename Ogre::Resource::getOrigin        GetOrigin;

//typedef SharedPtr<Resource> ResourcePtr;
%template(ResourcePtr) Ogre::SharedPtr<Ogre::Resource>;



%typemap(cscode) Ogre::ManualResourceLoaderDirector %{
	public    delegate  void  MRLD_Delegate_loadResource  ( Resource resource );
	protected delegate  void  _MRLD_Delegate_loadResource ( IntPtr resource );

	public void SubscribeEvents()
	{
		m_Delegate_loadResource =    new _MRLD_Delegate_loadResource  ( Handle_LoadResource );
		set_MRLD_FP_loadResource     (swigCPtr, m_Delegate_loadResource);
	}
	
	public event	MRLD_Delegate_loadResource		evtLoadResource = null;
	protected	_MRLD_Delegate_loadResource			m_Delegate_loadResource = null;


	[DllImport("OgreBindings", EntryPoint="set_MRLD_FP_loadResource")]
	protected static extern void set_MRLD_FP_loadResource( HandleRef manualresourceloaderdirector, _MRLD_Delegate_loadResource fn );


	protected void Handle_LoadResource ( IntPtr resource )
	{
		if( evtLoadResource != null )
			evtLoadResource( new Resource( resource, false ) );
	}
	
%}



%include "OgreResource.h"

namespace Ogre
{
	class ManualResourceLoaderDirector : public Ogre::ManualResourceLoader
	{
	public:
		ManualResourceLoaderDirector();
		virtual ~ManualResourceLoaderDirector();
		virtual void loadResource(Resource* resource);
	};
}
