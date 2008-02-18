%{
#include "OgrePredefinedControllers.h"
%}

%rename Ogre::FrameTimeControllerValue::getValue GetValue;
%rename Ogre::FrameTimeControllerValue::setValue SetValue;
%rename Ogre::FrameTimeControllerValue::getTimeFactor GetTimeFactor;
%rename Ogre::FrameTimeControllerValue::setTimeFactor SetTimeFactor;
%rename Ogre::TextureFrameControllerValue::getValue GetValue;
%rename Ogre::TextureFrameControllerValue::setValue SetValue;
%rename Ogre::FloatGpuParameterControllerValue::getValue GetValue;
%rename Ogre::FloatGpuParameterControllerValue::setValue SetValue;
%rename Ogre::TexCoordModifierControllerValue::getValue GetValue;
%rename Ogre::TexCoordModifierControllerValue::setValue SetValue;
%rename Ogre::AnimationControllerFunction::calculate Calculate;
%rename Ogre::ScaleControllerFunction::calculate Calculate;
%rename Ogre::WaveformControllerFunction::calculate Calculate;

%rename Ogre::PassthroughControllerFunction::calculate Calculate;

%ignore Ogre::FrameTimeControllerValue::frameEnded;
%ignore Ogre::FrameTimeControllerValue::frameStarted;

%typemap(cscode) Ogre::FrameTimeControllerValue
%{
  public float TimeFactor {
    get
    {
       return GetTimeFactor();
    }
    set
    {
       SetTimeFactor((float)value);
    }
  }

%}

%include "OgrePredefinedControllers.h"
