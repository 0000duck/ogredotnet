%{
#include "OgreSubEntity.h"
%}

// ignore because RenderOperation is private
%ignore Ogre::SubEntity::getRenderOperation;

//TODO: wrap AutoConstantEntry
%ignore Ogre::SubEntity::_updateCustomGpuParameter;

%include OgreSubEntity.h

%extend Ogre::SubEntity
{
    Renderable* GetAsRenderable()
    {
        return (Renderable*)self;
    }
};
