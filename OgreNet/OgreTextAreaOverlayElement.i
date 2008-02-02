%{
#include "OgreTextAreaOverlayElement.h"
%}


//ignore because of RenderOperation is private
%ignore Ogre::TextAreaOverlayElement::getRenderOperation;

%include OgreTextAreaOverlayElement.h
