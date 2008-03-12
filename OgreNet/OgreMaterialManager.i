%{
#include "OgreMaterialManager.h"
%}

%typemap(cscode) Ogre::MaterialManager
%{
    public static MaterialManager Instance {
        get { return new MaterialManager(OgreBindingsPINVOKE.MaterialManager_getSingleton(), false); }
    }

    public virtual TextureFilterOptions DefaultTextureFiltering {
        set { setDefaultTextureFiltering(value); }
    }

    public UInt32 DefaultAnisotropy {
        get { return getDefaultAnisotropy(); }
        set { setDefaultAnisotropy(value); }
    }

    public virtual MaterialPtr DefaultSettings {
        get { return getDefaultSettings(); }
    }

    public static MaterialManager Singleton {
        get { return getSingleton(); }
    }

    public static MaterialManager SingletonPtr {
        get { return getSingletonPtr(); }
    }
%}

%include "OgreMaterialManager.h"
