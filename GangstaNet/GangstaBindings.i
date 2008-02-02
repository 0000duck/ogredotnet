%module (directors="1") GangstaBindings

%{
#include "Ogre.h"

#include "Gangsta.h"
#include "GaCallbackInterface_Ogre.h"
#include "Ogre_EntityInformer.h"
#include "GaDebugVisual_Ogre.h"
//#include "GaVehicle.h"

using namespace Ga;
%}

%include std_string.i
%include std_vector.i

%apply const std::string & {std::string &};
%apply std::string & {std::string *};
%apply const std::string & {const Ogre::String &};
%apply std::string & {Ogre::String &};
%apply std::string & {Ogre::String *};

%apply const std::string & {const Ga::GaString &};
%apply std::string & {Ga::GaString &};
%apply std::string & {Ga::GaString *};

%include CLSCompliancy.i

SIMPLE_TYPEMAP(GaUint,         unsigned int,    UInt32)
SIMPLE_TYPEMAP(GaFloat,        float,           Single)
SIMPLE_TYPEMAP(GaByte,         unsigned char,   Byte)

SIMPLE_TYPEMAP(Ogre::Real,     float,           Single)


%include GaPreReqs.h 

#define GaCallbackInterfaceExport

//	typedef std::vector<GaString>	GaStringList;
%template(GaStringList) std::vector<std::string>;


%define DLLNonePtrType(CSTYPE, CTYPE)
#if defined(SWIGCSHARP)
%typemap(ctype)    CTYPE   "void *";
%typemap(imtype)   CTYPE   "IntPtr";
%typemap(cstype)   CTYPE   "CSTYPE";
%typemap(csbase)   CTYPE   "CSTYPE";
%typemap(csin)     CTYPE   "CSTYPE.getCPtr($csinput).Handle"
%typemap(csout, excode=SWIGEXCODE)    CTYPE   {
    IntPtr cPtr = $imcall;
    return (cPtr == IntPtr.Zero) ? null : new CSTYPE(cPtr, $owner);
}
%typemap(out)      CTYPE   %{ $result = (void *)new CTYPE($1); %}
#endif
%enddef

DLLNonePtrType(OgreDotNet.SimpleRenderable, Ogre::SimpleRenderable)
//DLLNonePtrType(OgreDotNet.OgreVector3, Ogre::Vector3)



PTR_REF_TYPEMAPS(OgreDotNet.OgreMatrix4, Ogre::Matrix4)
PTR_REF_TYPEMAPS(OgreDotNet.SceneManager, Ogre::SceneManager)
PTR_REF_TYPEMAPS(OgreDotNet.MovableObject, Ogre::MovableObject)

PTR_REF_TYPEMAPS(OgreDotNet.Camera, Ogre::Camera)
PTR_REF_TYPEMAPS(OgreDotNet.Entity, Ogre::Entity)
PTR_REF_TYPEMAPS(OgreDotNet.SceneNode, Ogre::SceneNode)
PTR_REF_TYPEMAPS(OgreDotNet.OgreVector3, Ogre::Vector3)
PTR_REF_TYPEMAPS(OgreDotNet.MemoryDataStream, Ogre::MemoryDataStream)




%include GangstaPtr.i
%include GangstaTypes.i
%include GangstaParameter.i
%include GangstaException.i

%include GangstaManager.i
%include GangstaDynamicModule.i
%include GangstaDebugVisual.i

%include GangstaCapability.i
%include GangstaPhysicsDriver.i
%include GangstaWorld.i
%include GangstaBody.i
%include GangstaShape.i
%include GangstaJoint.i
%include GangstaMaterial.i
%include GangstaRay.i
%include GangstaCollision.i

%include GangstaCallbackInterface.i

%include GangstaGOCallbackInterface_Ogre.i
%include GangstaGODebugVisual_Ogre.i
%include GangstaGOOgre_EntityInformer.i
//%include GangstaGOVehicle.i
