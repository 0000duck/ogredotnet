%{
#include "OgreCamera.h"
%}

%warnfilter(503) Ogre::Camera;

%ignore Ogre::Camera::_renderScene;
%ignore Ogre::Camera::_notifyRenderedFaces;
%ignore Ogre::Camera::_notifyRenderedBatches;
%ignore Ogre::Camera::_getNumRenderedFaces;
%ignore Ogre::Camera::_getNumRenderedBatches;
%ignore Ogre::Camera::_getLodBiasInverse;
%ignore Ogre::Camera::_autoTrack;
%ignore Ogre::Camera::_notifyViewport;

%nodefault;
%include "OgreCamera.h"
%makedefault;
