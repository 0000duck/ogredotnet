%{
#include "OgreConfigOptionMap.h"
%}


%include OgreConfigOptionMap.h

//    typedef std::map< String, ConfigOption > ConfigOptionMap;
%template(ConfigOptionMap) std::map<std::string, Ogre::_ConfigOption>;

