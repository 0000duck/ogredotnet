%{
#include "OgreStringInterface.h"
%}

// The director needs SWIGTYPE_p_void but no function return it so it is not
// wrapped in a SwigType: by inlining this function we make sure the type
// exists and the problem is fixed.
%inline %{
    void* _p_void_super_fixer(void) { return (void*)0; } 
%}

%feature("director") Ogre::ParamCommand;
%include "OgreStringInterface.h"

//%template(_ParamCommandMapPair) std::pair<Ogre::String, Ogre::ParamCommand*>;
//%template(ParamCommandMap) std::map<Ogre::String, Ogre::ParamCommand*>;
//%template(_ParamDictionaryPair) std::pair<Ogre::String, Ogre::ParamDictionary>;
//%template(ParamDictionaryMap) std::map<Ogre::String, Ogre::ParamDictionary>;

/* Now we have quite a problem because Ogre::ParameterList is the return value
   of some functions but we can't just wrap it in the default std::map wrapper
   because the ParameterDef class does not have a default constructor. */