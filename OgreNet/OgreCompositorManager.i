%{
#include "OgreCompositorManager.h"
%}



%typemap(cscode) Ogre::CompositorManager
%{
	public static CompositorManager Instance {
		get {
			CompositorManager ret = new CompositorManager(OgreBindings_CompositorPINVOKE.CompositorManager_GetSingleton(), false);
			return ret;
		}
	}
%}

%include "OgreCompositorManager.h"

//both base classes for CompositorManager are in another swig call.
// So we to make it easy, use the extended function GetAsResourceManager to access those functions
%extend Ogre::CompositorManager
{
	Ogre::ResourceManager* GetAsResourceManager(void)
	{
		return (Ogre::ResourceManager*)self;
	}
	
	static Ogre::CompositorManager& GetSingleton( void )
	{
		return (CompositorManager&)Ogre::CompositorManager::getSingleton();
	}
	static Ogre::CompositorManager* GetSingletonPtr( void )
	{
		return (CompositorManager*)Ogre::CompositorManager::getSingletonPtr();
	}
};
