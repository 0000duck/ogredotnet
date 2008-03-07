%{
#include "OgreSharedPtr.h"
%}

%ignore Ogre::SharedPtr::bind;
%ignore Ogre::SharedPtr::useCountPointer;
%ignore Ogre::SharedPtr::getPointer;

%include "OgreSharedPtr.h"
