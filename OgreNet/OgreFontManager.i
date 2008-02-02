%{
#include "OgreFontManager.h"
%}

%rename Ogre::ScriptLoader::parseScript ParseScript;

%typemap(cscode) Ogre::FontManager
%{
	public static FontManager Instance
	{
		get
		{
			return new FontManager(OgreBindingsPINVOKE.FontManager_getSingleton(), false);
		}
	}
%}

%include OgreFontManager.h


