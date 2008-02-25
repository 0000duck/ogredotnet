%{
#include "OgrePlatformManager.h"
%}

%ignore Ogre::PlatformManager::createErrorDialog;
%ignore Ogre::PlatformManager::destroyErrorDialog;

%include OgrePlatformManager.h
