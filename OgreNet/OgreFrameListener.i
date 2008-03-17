//Deprecated
%{
#include "OgreFrameListener.h"
%}

// TODO: defined in Custom/FrameEvent.cs.  Delete that one and extend this one instead?
%ignore FrameEvent;

%feature("director") Ogre::FrameListener;
%include "OgreFrameListener.h"
