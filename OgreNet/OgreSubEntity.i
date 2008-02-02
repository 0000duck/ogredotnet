%{
#include "OgreSubEntity.h"
%}

//ignore because of RenderOperation is private
%ignore Ogre::SubEntity::getRenderOperation;

//TODO wrapp AutoConstantEntry
%ignore Ogre::SubEntity::_updateCustomGpuParameter;


%include OgreSubEntity.h

%extend Ogre::SubEntity {
	Renderable * GetAsRenderable()	{
		return (Renderable*)self;
	}
};
