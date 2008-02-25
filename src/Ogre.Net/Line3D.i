%{
#include "Line3D.h"
%}

//ignore because of RenderOperation is private is private
%ignore Ogre::Line3D::setRenderOperation;
%ignore Ogre::Line3D::getRenderOperation;

DLLEnumType(OgreDotNet.OperationType, Ogre::RenderOperation::OperationType)

%include "Line3D.h"

