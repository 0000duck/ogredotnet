%{
#include "OgreStringVector.h"
%}

%include "OgreStringVector.h"

// Instantiate the two templates typedefed in OgreStringVector.h
//    typedef std::vector<String> StringVector;
%template(StringVector) std::vector<std::string>;

//    typedef SharedPtr<StringVector> StringVectorPtr;
//DLLNonePtrType(StringVector, std::vector<std::string>)
//%template(StringVectorPtr) Ogre::SharedPtr<std::vector<std::string> >;

