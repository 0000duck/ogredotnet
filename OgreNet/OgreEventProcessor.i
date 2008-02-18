%{
#include "OgreInputEvent.h"
#include "OgreEventQueue.h"
#include "OgreEventTarget.h"
#include "OgreEventProcessor.h"
%}

%include OgreInputEvent.h
%include OgreEventTarget.h
%include OgreEventQueue.h

%ignore Ogre::EventProcessor::frameStarted;
%ignore Ogre::EventProcessor::frameEnded;

// #FIX#  only on EventProcessor and it only returns null
// exposes PositionTarget(not wrapped) is it needed? will need custom Director class
%ignore Ogre::EventProcessor::getPositionTargetParent;

%include OgreEventProcessor.h
