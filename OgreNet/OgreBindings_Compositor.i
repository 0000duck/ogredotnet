%module (directors="1") OgreBindings_Compositor

%{
#include "Ogre.h"
#include "OgrePrerequisites.h"
#include "OgreIteratorWrappers.h"
#include "OgreString.h"

using namespace Ogre;
%}

#define _OgreExport
#define OGRE_AUTO_SHARED_MUTE

%rename params parameters;

%include std_string.i
//%include std_pair.i
//%include new_std_map.i
%include std_vector.i
//%include new_std_list.i

%apply const std::string & {std::string &};
%apply std::string & {std::string *};
%apply const std::string & {const Ogre::string &};
%apply std::string & {Ogre::string &};
%apply std::string & {Ogre::string *};


%include CLSCompliancy.i

//already defined in ogrebindings_wrap.obj
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


//---- typemaps for classes in the dll that we do not swig here

%typemap(cstype) const Ogre::ColourValue &,  Ogre::ColourValue   "System.Drawing.Color"
%typemap(csin)   const Ogre::ColourValue &,  Ogre::ColourValue   "ColourValue.getCPtr(Converter.ToColourValue($csinput))"
%typemap(csout, excode=SWIGEXCODE) const Ogre::ColourValue &,  Ogre::ColourValue
{
	return Converter.ToColor(new ColourValue($imcall, false));
}


DLLEnumType(OgreDotNet.CompareFunction, CompareFunction)
DLLEnumType(OgreDotNet.StencilOperation, StencilOperation)
DLLEnumType(OgreDotNet.PixelFormat, PixelFormat)

PTR_REF_TYPEMAPS(OgreDotNet.DataStreamPtr, DataStreamPtr)
PTR_REF_TYPEMAPS(OgreDotNet.NameValuePairList, NameValuePairList)
PTR_REF_TYPEMAPS(OgreDotNet.RenderTargetEvent, RenderTargetEvent)
PTR_REF_TYPEMAPS(OgreDotNet.RenderTargetViewportEvent, RenderTargetViewportEvent)
PTR_REF_TYPEMAPS(OgreDotNet.ResourcePtr, ResourcePtr)

PTR_REF_TYPEMAPS(OgreDotNet.Font, Ogre::Font)
PTR_REF_TYPEMAPS(OgreDotNet.ManualResourceLoader, Ogre::ManualResourceLoader)
PTR_REF_TYPEMAPS(OgreDotNet.MaterialPtr, Ogre::MaterialPtr)
PTR_REF_TYPEMAPS(OgreDotNet.Renderable, Ogre::Renderable)
PTR_REF_TYPEMAPS(OgreDotNet.Resource, Ogre::Resource)
PTR_REF_TYPEMAPS(OgreDotNet.ResourceManager, Ogre::ResourceManager)
PTR_REF_TYPEMAPS(OgreDotNet.Viewport, Ogre::Viewport)
PTR_REF_TYPEMAPS(OgreDotNet.StringVector, StringVector)


DLLNonePtrType(OgreDotNet.MaterialPtr, Ogre::MaterialPtr);
DLLNonePtrType(OgreDotNet.ResourcePtr, ResourcePtr);


//---- 





%include OgreIteratorWrappers.i


%include OgreCompositionPass.i
%include OgreCompositionTargetPass.i
%include OgreCompositionTechnique.i
%include OgreCompositor.i
%include OgreCompositorInstance.i
%include OgreCompositorChain.i
%include OgreCompositorManager.i

