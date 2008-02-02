%{
#include "OgreController.h"
%}

%rename Ogre::ControllerFunction<float>::calculate Calculate;
%rename Ogre::ControllerValueFunction<float>::get       Get;
%rename Ogre::ControllerValueFunction<float>::bind      Bind;
%rename Ogre::ControllerValueFunction<float>::unique    Unique;
%rename Ogre::ControllerValueFunction<float>::useCount  UseCount;
%rename Ogre::ControllerValueFunction<float>::useCountPointer UseCountPointer;
%rename Ogre::ControllerValueFunction<float>::getPointer GetPointer;
%rename Ogre::ControllerValueFunction<float>::isNull    IsNull;
%rename Ogre::ControllerValueFunction<float>::setNull   SetNull;
%rename Ogre::ControllerValueFunction<float>::getValue  GetValue;
%rename Ogre::ControllerValueFunction<float>::setValue  SetValue;
%rename Ogre::ControllerValue<float>::getValue  GetValue;
%rename Ogre::ControllerValue<float>::setValue  SetValue;
%rename Ogre::ControllerValue<float>::get       Get;
%rename Ogre::ControllerValue<float>::bind      Bind;
%rename Ogre::ControllerValue<float>::unique    Unique;
%rename Ogre::ControllerValue<float>::useCount  UseCount;
%rename Ogre::ControllerValue<float>::useCountPointer UseCountPointer;
%rename Ogre::ControllerValue<float>::getPointer GetPointer;
%rename Ogre::ControllerValue<float>::isNull    IsNull;
%rename Ogre::ControllerValue<float>::setNull   SetNull;
%rename Ogre::Controller<float>::setSource      SetSource;
%rename Ogre::Controller<float>::getSource      GetSource;
%rename Ogre::Controller<float>::setDestination SetDestination;
%rename Ogre::Controller<float>::getDestination GetDestination;
%rename Ogre::Controller<float>::getEnabled     GetEnabled;
%rename Ogre::Controller<float>::setEnabled     SetEnabled;
%rename Ogre::Controller<float>::setFunction    SetFunction;
%rename Ogre::Controller<float>::getFunction    GetFunction;
%rename Ogre::Controller<float>::update         Update;

%include "OgreController.h"

%template(ControllerValueFloat) Ogre::ControllerValue<float>;
%template(ControllerFunctionFloat) Ogre::ControllerFunction<float>;
%template(ControllerFloat) Ogre::Controller<float>;


%typemap(cscode) Ogre::ControllerFloat
%{
  public ControllerValueFloatPtr Source {
    get
    {
        return GetSource();
    }
    set
    {
        SetSource((ControllerValueFloatPtr)value);
    }
  }

  public ControllerValueFloatPtr Destination {
    get
    {
        return GetDestination();
    }
    set
    {
        SetDestination((ControllerValueFloatPtr)value);
    }
  }

  public bool Enabled {
    get
    {
        return GetEnabled();
    }
    set
    {
        SetEnabled((bool)value);
    }
  }

  public ControllerFunctionFloatPtr Function {
    get
    {
        return GetFunction();
    }
    set
    {
        SetFunction((ControllerFunctionFloatPtr)value);
    }
  }

%}
