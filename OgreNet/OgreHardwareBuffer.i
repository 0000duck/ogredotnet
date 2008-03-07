%{
#include "OgreHardwareBuffer.h"
%}

%rename Ogre::HardwareBuffer::lock Lock;
%rename Ogre::HardwareBuffer::unlock Unlock;

%include OgreHardwareBuffer.h
