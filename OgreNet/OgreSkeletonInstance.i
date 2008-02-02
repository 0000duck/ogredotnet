%{
#include "OgreSkeletonInstance.h"
%}

%rename Ogre::SkeletonInstance::getNumAnimations                         GetNumAnimations;
%rename Ogre::SkeletonInstance::createAnimation                          CreateAnimation;
%rename Ogre::SkeletonInstance::removeAnimation                          RemoveAnimation;
%rename Ogre::SkeletonInstance::createTagPointOnBone                     CreateTagPointOnBone;
%rename Ogre::SkeletonInstance::freeTagPoint                             FreeTagPoint;
%rename Ogre::SkeletonInstance::addLinkedSkeletonAnimationSource         AddLinkedSkeletonAnimationSource;
%rename Ogre::SkeletonInstance::removeAllLinkedSkeletonAnimationSources  RemoveAllLinkedSkeletonAnimationSources;
%rename Ogre::SkeletonInstance::getLinkedSkeletonAnimationSourceIterator GetLinkedSkeletonAnimationSourceIterator;

//custom warp because of pointer to pointer
%ignore Ogre::SkeletonInstance::getAnimation;

%typemap(cscode) Ogre::SkeletonInstance
%{
  public override int NumAnimations {
    get
    {
        return GetNumAnimations();
    }
  }

%}


%include OgreSkeletonInstance.h


%extend Ogre::SkeletonInstance
{
	Ogre::Animation* GetAnimation(const String& name, 
		const LinkedSkeletonAnimationSource* linker = 0) const
	{
		const LinkedSkeletonAnimationSource** pplinker= &linker;
		return self->getAnimation(name, pplinker);
	}
};
