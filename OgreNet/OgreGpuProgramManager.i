%{
#include "OgreGpuProgramManager.h"
%}

//typedef std::set<String> SyntaxCodes; 
%template(SyntaxCodes) std::set<std::string>;


%newobject Ogre::GpuProgramManager::GetSupportedSyntax;


%include OgreGpuProgramManager.h

