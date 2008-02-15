%{
#include "OgreControllerManager.h"
%}

#define base baseName
#define params gpuParams

%rename Ogre::ControllerManager::createController             CreateController;
%rename Ogre::ControllerManager::clearControllers             ClearControllers;
%rename Ogre::ControllerManager::updateAllControllers         UpdateAllControllers;
%rename Ogre::ControllerManager::getFrameTimeSource           GetFrameTimeSource;
%rename Ogre::ControllerManager::createTextureAnimator        CreateTextureAnimator;
%rename Ogre::ControllerManager::createTextureScroller        CreateTextureScroller;
%rename Ogre::ControllerManager::createTextureRotater         CreateTextureRotater;
%rename Ogre::ControllerManager::createTextureWaveTransformer CreateTextureWaveTransformer;
%rename Ogre::ControllerManager::createGpuProgramTimerParam   CreateGpuProgramTimerParam;
%rename Ogre::ControllerManager::destroyController            DestroyController;
%rename Ogre::ControllerManager::getTimeFactor                GetTimeFactor;
%rename Ogre::ControllerManager::setTimeFactor                SetTimeFactor;
%rename Ogre::ControllerManager::getSingleton                 GetSingleton;
%rename Ogre::ControllerManager::getSingletonPtr              GetSingletonPtr;


//    typedef SharedPtr< ControllerValue<Real> > ControllerValueRealPtr;
%template(ControllerValueFloatPtr) Ogre::SharedPtr< ControllerValue<float> >;

//    typedef SharedPtr< ControllerFunction<Real> > ControllerFunctionRealPtr;
%template(ControllerFunctionFloatPtr) Ogre::SharedPtr< ControllerFunction<float> >;




%typemap(cscode) Ogre::ControllerManager
%{
    public static ControllerManager Instance
    {
        get
        {
            return new ControllerManager(OgreBindingsPINVOKE.ControllerManager_GetSingleton(), false);
        }
    }
%}


%include "OgreControllerManager.h"

