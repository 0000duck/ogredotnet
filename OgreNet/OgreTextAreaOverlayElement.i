%{
#include "OgreTextAreaOverlayElement.h"
%}

//ignore because RenderOperation is private
%ignore Ogre::TextAreaOverlayElement::getRenderOperation;

%include OgreTextAreaOverlayElement.h
