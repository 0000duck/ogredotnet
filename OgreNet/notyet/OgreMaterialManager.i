%{
#include "OgreMaterialManager.h"
%}

%rename Ogre::MaterialManager::getDefaultTextureFiltering GetDefaultTextureFiltering;
%rename Ogre::MaterialManager::setDefaultTextureFiltering SetDefaultTextureFiltering;
%rename Ogre::MaterialManager::getDefaultAnisotropy       GetDefaultAnisotropy;
%rename Ogre::MaterialManager::setDefaultAnisotropy       SetDefaultAnisotropy;
%rename Ogre::MaterialManager::getDefaultSettings         GetDefaultSettings;
%rename Ogre::MaterialManager::getSingleton               GetSingleton;
%rename Ogre::MaterialManager::getSingletonPtr            GetSingletonPtr;
%rename Ogre::MaterialManager::initialise Initialise;
%rename Ogre::MaterialManager::parseScript ParseScript;


%typemap(cscode) Ogre::MaterialManager
%{
    public static MaterialManager Instance {
        get { return new MaterialManager(OgreBindingsPINVOKE.MaterialManager_GetSingleton(), false); }
    }

    public virtual TextureFilterOptions DefaultTextureFiltering {
        set { SetDefaultTextureFiltering(value); }
    }

    public UInt32 DefaultAnisotropy {
        get { return GetDefaultAnisotropy(); }
        set { SetDefaultAnisotropy(value); }
    }

    public virtual MaterialPtr DefaultSettings {
        get { return GetDefaultSettings(); }
    }

    public static MaterialManager Singleton {
        get { return GetSingleton(); }
    }

    public static MaterialManager SingletonPtr {
        get { return GetSingletonPtr(); }
    }
%}


%include "OgreMaterialManager.h"

