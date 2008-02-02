%{
	#include "OgreTextureManager.h"
%}

%rename Ogre::TextureManager::load                 Load;
%rename Ogre::TextureManager::loadImage            LoadImage;
%rename Ogre::TextureManager::loadRawData          LoadRawData;
%rename Ogre::TextureManager::createManual         CreateManual;
%rename Ogre::TextureManager::enable32BitTextures  Enable32BitTextures;
%rename Ogre::TextureManager::setDefaultNumMipmaps SetDefaultNumMipmaps;
%rename Ogre::TextureManager::getDefaultNumMipmaps GetDefaultNumMipmaps;
%rename Ogre::TextureManager::getSingleton         GetSingleton;
%rename Ogre::TextureManager::getSingletonPtr      GetSingletonPtr;

%typemap(cscode) Ogre::TextureManager
%{
	public static TextureManager Instance
	{
		get
		{
			return new TextureManager(OgreBindingsPINVOKE.TextureManager_GetSingleton(), false);
		}
	}
%}

%ignore Ogre::TextureManager::TextureManager;
%include "OgreTextureManager.h"
