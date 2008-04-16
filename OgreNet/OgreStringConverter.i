%{
#include "OgreStringConverter.h"
%}

// We ignore these because they can be implicitly cast to other functions
%ignore Ogre::StringConverter::toString(size_t);
%ignore Ogre::StringConverter::toString(size_t, unsigned short);
%ignore Ogre::StringConverter::toString(size_t, unsigned short, char);
%ignore Ogre::StringConverter::toString(size_t, unsigned short, char, std::ios::fmtflags);
%ignore Ogre::StringConverter::toString(long);
%ignore Ogre::StringConverter::toString(long, unsigned short);
%ignore Ogre::StringConverter::toString(long, unsigned short, char);
%ignore Ogre::StringConverter::toString(long, unsigned short, char, std::ios::fmtflags);

%include "OgreStringConverter.h"
