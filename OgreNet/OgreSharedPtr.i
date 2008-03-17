%{
#include "OgreSharedPtr.h"
%}

%rename Ogre::SharedPtr::get            Get;        // We could also ignore this one and use the __deref__() method
%rename Ogre::SharedPtr::unique         IsUnique;
%rename Ogre::SharedPtr::useCount       UseCount;
%rename Ogre::SharedPtr::isNull         IsNull;
%rename Ogre::SharedPtr::setNull        SetNull;

%ignore Ogre::SharedPtr::bind;
%ignore Ogre::SharedPtr::useCountPointer;
%ignore Ogre::SharedPtr::getPointer;

%include "OgreSharedPtr.h"
