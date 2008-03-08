%{
#include "OgreSkeletonInstance.h"
%}

//custom warp because of pointer to pointer
%ignore Ogre::SkeletonInstance::getAnimation;

%typemap(cscode) Ogre::SkeletonInstance
%{
    public override int NumAnimations {
        get
        {
            return getNumAnimations();
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
