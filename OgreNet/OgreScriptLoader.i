%{
#include "OgreScriptLoader.h"
%}

%rename Ogre::ScriptLoader::getScriptPatterns GetScriptPatterns;
%rename Ogre::ScriptLoader::parseScript ParseScript;
%rename Ogre::ScriptLoader::getLoadingOrder GetLoadingOrder;

%include "OgreScriptLoader.h"
