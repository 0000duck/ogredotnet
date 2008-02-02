%{
	#include "GaPtr.h"
%}

//there where lots of problems with the smart pointer Ga:GaPtr.
// So while searching for a solution i found a topic on SwigUser mailing list.
// Someone used typemap to in a way hide the smart pointer and let the c++ side
// handle it. This is an adaptation of that typemap for GaPtr.
%define GaPtr_TYPEMAPS(CTYPE, NCTYPE, CSTYPE)
#if defined(SWIGCSHARP)
%typemap(ctype)    CTYPE, CTYPE &  "void *"
%typemap(imtype)   CTYPE, CTYPE &  "IntPtr"
%typemap(cstype)   CTYPE, CTYPE &  "CSTYPE"
%typemap(csin)     CTYPE, CTYPE &  "CSTYPE.getCPtr($csinput).Handle"
%typemap(csout)    CTYPE, CTYPE &  {
    IntPtr cPtr = $imcall;
    CSTYPE ret = (cPtr == IntPtr.Zero) ? null : new CSTYPE(cPtr, false);
    return ret;
}
%typemap(out)      CTYPE    %{
  $result = ((CTYPE&)$1).get();
%}
%typemap(out)      CTYPE &  %{
  $result = ((CTYPE&)*$1).get();
%}
%typemap(in)       CTYPE    %{
  $1 = CTYPE( (NCTYPE*)$input );
%}
%typemap(in)       CTYPE &  %{
  CTYPE tmpPtr = CTYPE( (NCTYPE*)$input );
  $1 = &tmpPtr;
%}
#endif
%enddef

GaPtr_TYPEMAPS( Ga::GaPtr<Ga::World>,                    Ga::World,                   GangstaDotNet.World)
GaPtr_TYPEMAPS( Ga::GaPtr<Ga::Shape>,                    Ga::Shape,                   GangstaDotNet.Shape)
GaPtr_TYPEMAPS( Ga::GaPtr<Ga::Body>,                     Ga::Body,                    GangstaDotNet.Body)
GaPtr_TYPEMAPS( Ga::GaPtr<Ga::CallbackInterface>,        Ga::CallbackInterface,       GangstaDotNet.CallbackInterface)
GaPtr_TYPEMAPS( Ga::GaPtr<Ga::Collision>,                Ga::Collision,               GangstaDotNet.Collision)
GaPtr_TYPEMAPS( Ga::GaPtr<Ga::DebugVisual>,              Ga::DebugVisual,             GangstaDotNet.DebugVisual)
GaPtr_TYPEMAPS( Ga::GaPtr<Ga::DynamicObject>,            Ga::DynamicObject,           GangstaDotNet.DynamicObject)
GaPtr_TYPEMAPS( Ga::GaPtr<Ga::DynamicModule>,            Ga::DynamicModule,           GangstaDotNet.DynamicModule)
GaPtr_TYPEMAPS( Ga::GaPtr<Ga::CallbackInterface_Ogre>,   Ga::CallbackInterface_Ogre,  GangstaDotNet.CallbackInterface_Ogre)
GaPtr_TYPEMAPS( Ga::GaPtr<Ga::DebugVisual_Ogre>,         Ga::DebugVisual_Ogre,        GangstaDotNet.DebugVisual_Ogre)
GaPtr_TYPEMAPS( Ga::GaPtr<Ga::Joint>,                    Ga::Joint,                   GangstaDotNet.Joint)
GaPtr_TYPEMAPS( Ga::GaPtr<Ga::Manager>,                  Ga::Manager,                 GangstaDotNet.Manager)
GaPtr_TYPEMAPS( Ga::GaPtr<Ga::PhysicsDriver>,            Ga::PhysicsDriver,           GangstaDotNet.PhysicsDriver)
GaPtr_TYPEMAPS( Ga::GaPtr<Ga::Ray>,                      Ga::Ray,                     GangstaDotNet.Ray)
GaPtr_TYPEMAPS( Ga::GaPtr<Ga::Material>,                 Ga::Material,                GangstaDotNet.Material)


// When used from World.createRay Ray needs a way to release from a Ga::GaPtr<>.
// this is because it is a Ray_ODE or what ever PE you use. an just deletting the pointer
// does not seem to call the top level class distructor(~Ray_ODE). So in each .i file
// for the classes typemaped above will have a %exted function for GaPtr::release.
// We can not put them here they haveto be after the %include.


// old way 
//%rename Ga::GaPtr::get			Get;
//%rename Ga::GaPtr::isNull		IsNull;
//%rename Ga::GaPtr::release		Release;
//%ignore Ga::GaPtr::operator->;
//%ignore Ga::GaPtr::operator==;
//%include "GaPtr.h"
//
//%template(GaPtrWorld) Ga::GaPtr<Ga::World>;
//%template(GaPtrShape) Ga::GaPtr<Ga::Shape>;
//%template(GaPtrBody) Ga::GaPtr<Ga::Body>;
//%template(GaPtrCallbackInterface) Ga::GaPtr<Ga::CallbackInterface>;
//%template(GaPtrCollision) Ga::GaPtr<Ga::Collision>;
//%template(GaPtrDebugVisual) Ga::GaPtr<Ga::DebugVisual>;
//%template(GaPtrDynamicObject) Ga::GaPtr<Ga::DynamicObject>;
//%template(GaPtrDynamicModule) Ga::GaPtr<Ga::DynamicModule>;
//%template(GaPtrCallbackInterface_Ogre) Ga::GaPtr<Ga::CallbackInterface_Ogre>;
//%template(GaPtrDebugVisual_Ogre) Ga::GaPtr<Ga::DebugVisual_Ogre>;
//%template(GaPtrJoint) Ga::GaPtr<Ga::Joint>;
//%template(GaPtrManager) Ga::GaPtr<Ga::Manager>;
//%template(GaPtrPhysicsDriver) Ga::GaPtr<Ga::PhysicsDriver>;
//%template(GaPtrRay) Ga::GaPtr<Ga::Ray>;
//%template(GaPtrMaterial) Ga::GaPtr<Ga::Material>;



