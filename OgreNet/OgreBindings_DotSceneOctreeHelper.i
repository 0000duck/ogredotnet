//OgreBindings_DotSceneOctreeHelper.i
%module (directors="1") OgreBindings_DotSceneOctreeHelper

%{
#include "Ogre.h"
#include "DotSceneOctreeHelper.h"

using namespace Ogre;
%}

%include std_string.i

%apply const std::string & {std::string &};
%apply std::string & {std::string *};
%apply const std::string & {const Ogre::String &};
%apply std::string & {Ogre::String &};
%apply std::string & {Ogre::String *};

%include CLSCompliancy.i


//already defined in OgreDotNet, we do not need to expose them here
%ignore Ogre::KeyCode;
%ignore Ogre::OGRE_PLATFORM_WIN32;
%ignore Ogre::OGRE_PLATFORM_LINUX;
%ignore Ogre::OGRE_PLATFORM_APPLE;
%ignore Ogre::OGRE_COMPILER_MSVC;
%ignore Ogre::OGRE_COMPILER_GNUC;
%ignore Ogre::OGRE_COMPILER_BORL;
%ignore Ogre::OGRE_ENDIAN_LITTLE;
%ignore Ogre::OGRE_ENDIAN_BIG;
%ignore Ogre::OGRE_ARCHITECTURE_32;
%ignore Ogre::OGRE_ARCHITECTURE_64;
%ignore Ogre::OGRE_PLATFORM;
%ignore Ogre::OGRE_ARCH_TYPE;
%ignore Ogre::OGRE_DEBUG_MODE;
%ignore Ogre::OGRE_PLATFORM_LIB;
%ignore Ogre::OGRE_ENDIAN;
%ignore Ogre::OGRE_VERSION_MAJOR;
%ignore Ogre::OGRE_VERSION_MINOR;
%ignore Ogre::OGRE_VERSION_PATCH;
%ignore Ogre::OGRE_VERSION_NAME;
%ignore Ogre::OGRE_VERSION;
%include OgrePlatform.h
%include OgrePrerequisites.h 



PTR_REF_TYPEMAPS(OgreDotNet.AxisAlignedBox, Ogre::AxisAlignedBox)
PTR_REF_TYPEMAPS(OgreDotNet.SceneManager, Ogre::SceneManager)
PTR_REF_TYPEMAPS(OgreDotNet.MemoryDataStream, Ogre::MemoryDataStream)
PTR_REF_TYPEMAPS(OgreDotNet.MemoryDataStreamSharedPtr, Ogre::MemoryDataStreamSharedPtr)

%newobject Ogre::DotSceneOctreeHelper::getVerticesPtr;
%newobject Ogre::DotSceneOctreeHelper::getIndexPtr;

%include DotSceneOctreeHelper.h



