%{
#include "OgreLogManager.h"
%}


%rename Ogre::LogManager::getSingleton               GetSingleton;
%rename Ogre::LogManager::getSingletonPtr            GetSingletonPtr;


%typemap(cscode) Ogre::LogManager
%{
	public static LogManager Instance	{
		get	{
			return new LogManager(OgreBindingsPINVOKE.LogManager_GetSingleton(), false);
		}
	}
	
	public static LogManager Singleton	{
		get	{
			return GetSingleton();
		}
	}
	
	public static LogManager SingletonPtr	{
		get	{
			return GetSingletonPtr();
		}
	}
%}

%include OgreLogManager.h

