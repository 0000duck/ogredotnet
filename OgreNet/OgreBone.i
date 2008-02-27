%{
#include "OgreBone.h"
%}

%rename Ogre::Bone::getHandle             GetHandle;
%rename Ogre::Bone::setBindingPose        SetBindingPose;
%rename Ogre::Bone::reset                 Reset;
%rename Ogre::Bone::setManuallyControlled SetManuallyControlled;
%rename Ogre::Bone::isManuallyControlled  IsManuallyControlled;
%rename Ogre::Bone::needUpdate            NeedUpdate;

%include OgreBone.h
