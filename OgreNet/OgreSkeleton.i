%{
#include "OgreSkeleton.h"
//LinkedSkeletonAnimationSource
namespace Ogre
{
	struct SkeletonAnimLSAS
	{
		const LinkedSkeletonAnimationSource* mLSAS;
		Animation* mAnimation;
		SkeletonAnimLSAS() : mLSAS(0), mAnimation(0) {}
	};
}
%}

%rename Ogre::Skeleton::createBone                               CreateBone;
%rename Ogre::Skeleton::getNumBones                              GetNumBones;
%rename Ogre::Skeleton::getRootBone                              GetRootBone;
%rename Ogre::Skeleton::getRootBoneIterator                      GetRootBoneIterator;
%rename Ogre::Skeleton::getBoneIterator                          GetBoneIterator;
%rename Ogre::Skeleton::getBone                                  GetBone;
%rename Ogre::Skeleton::setBindingPose                           SetBindingPose;
%rename Ogre::Skeleton::reset                                    Reset;
%rename Ogre::Skeleton::createAnimation                          CreateAnimation;
%rename Ogre::Skeleton::removeAnimation                          RemoveAnimation;
%rename Ogre::Skeleton::setAnimationState                        SetAnimationState;
%rename Ogre::Skeleton::getNumAnimations                         GetNumAnimations;
%rename Ogre::Skeleton::getBlendMode                             GetBlendMode;
%rename Ogre::Skeleton::setBlendMode                             SetBlendMode;
%rename Ogre::Skeleton::optimiseAllAnimations                    OptimiseAllAnimations;
%rename Ogre::Skeleton::addLinkedSkeletonAnimationSource         AddLinkedSkeletonAnimationSource;
%rename Ogre::Skeleton::removeAllLinkedSkeletonAnimationSources  RemoveAllLinkedSkeletonAnimationSources;
%rename Ogre::Skeleton::getLinkedSkeletonAnimationSourceIterator GetLinkedSkeletonAnimationSourceIterator;

//custom warp because of pointer to pointer
%ignore Ogre::Skeleton::getAnimation(const String& name, const LinkedSkeletonAnimationSource** linker = 0) const;
%ignore Ogre::Skeleton::_getAnimationImpl;
%newobject Ogre::Skeleton::GetAnimation;


%typemap(cscode) Ogre::Skeleton
%{
  public virtual int NumBones {
    get { return GetNumBones(); }
  }
  
  public virtual Bone RootBone {
    get { return GetRootBone(); }
  }

  public virtual int NumAnimations {
    get { return GetNumAnimations(); }
  }

  public virtual SkeletonAnimationBlendMode BlendMode {
    get { return GetBlendMode(); }
    set { SetBlendMode((SkeletonAnimationBlendMode)value); }    
  }

%}


%include OgreSkeleton.h

namespace Ogre
{
	struct SkeletonAnimLSAS
	{
		const LinkedSkeletonAnimationSource* mLSAS;
		Animation* mAnimation;
		SkeletonAnimLSAS();
	};
}


%extend Ogre::Skeleton
{
	Ogre::SkeletonAnimLSAS* GetAnimation(const String& name) const
	{
		Ogre::SkeletonAnimLSAS* ret= new Ogre::SkeletonAnimLSAS();
		ret->mAnimation = self->getAnimation(name, &ret->mLSAS );
		return ret;
	}
};


//class _OgreExport SkeletonPtr : public SharedPtr<Skeleton>
//lot of trouble with templating the SharedPtr + we dont need 2 of them.
// so just the autocreated one some functions
%extend Ogre::SkeletonPtr
{
	Ogre::Skeleton* Get()
	{
		return (Ogre::Skeleton*)self->get();
	}
	bool IsUnique()
	{
		return self->unique();
	}
	unsigned int UseCount()
	{
		return self->useCount();
	}
	bool IsNull()
	{
		return self->isNull();
	}
	void SetNull()
	{
		return self->setNull();
	}
};






//## BoneIterator
//typedef std::vector<Bone*> BoneList;
//swig.29     PTR_REF_TYPEMAPS(Bone, Ogre::Bone*)
SWIG_STD_VECTOR_SPECIALIZE_MINIMUM(Bone, Ogre::Bone*)
%template(BoneList) std::vector<Ogre::Bone*>;

//typedef VectorIterator<BoneList> BoneIterator;
VectorIteratorWRAP(BoneIteratorWrap, std::vector, Ogre::Bone*);
//##

//## LinkedSkeletonAnimSourceIterator
//typedef std::vector<LinkedSkeletonAnimationSource> 	LinkedSkeletonAnimSourceList;
SWIG_STD_VECTOR_SPECIALIZE_MINIMUM(LinkedSkeletonAnimationSource, Ogre::LinkedSkeletonAnimationSource)
%template(LinkedSkeletonAnimSourceList) std::vector<Ogre::LinkedSkeletonAnimationSource>;

//typedef ConstVectorIterator<LinkedSkeletonAnimSourceList> 	LinkedSkeletonAnimSourceIterator;
ConstVectorIteratorWRAP(LinkedSkeletonAnimSourceIteratorWrap, std::vector, Ogre::LinkedSkeletonAnimationSource);
//##

