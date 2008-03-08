%{
#include "OgreTextureManager.h"
%}

%typemap(cscode) Ogre::TextureManager
%{
    public static TextureManager Instance
    {
        get
        {
            return new TextureManager(OgreBindingsPINVOKE.TextureManager_getSingleton(), false);
        }
    }
%}

%ignore Ogre::TextureManager::TextureManager;
%include "OgreTextureManager.h"
