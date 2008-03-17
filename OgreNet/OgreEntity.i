%{
#include "OgreEntity.h"
%}

%rename Ogre::Entity::getMesh                        GetMesh;
%rename Ogre::Entity::getSubEntity                   GetSubEntity;
%rename Ogre::Entity::getNumSubEntities              GetNumSubEntities;
%rename Ogre::Entity::clone                          Clone;
%rename Ogre::Entity::setMaterialName                SetMaterialName;
%rename Ogre::Entity::setRenderQueueGroup            SetRenderQueueGroup;
%rename Ogre::Entity::getBoundingBox                 GetBoundingBox;
%rename Ogre::Entity::getChildObjectsBoundingBox     GetChildObjectsBoundingBox;
%rename Ogre::Entity::GetName                        GetName;
%rename Ogre::Entity::GetMovableType                 GetMovableType;
%rename Ogre::Entity::getAnimationState              GetAnimationState;
%rename Ogre::Entity::getAllAnimationStates          GetAllAnimationStates;
%rename Ogre::Entity::setDisplaySkeleton             SetDisplaySkeleton;
%rename Ogre::Entity::getDisplaySkeleton             GetDisplaySkeleton;
//%rename Ogre::Entity::setBoundingBox                 SetBoundingBox;
%rename Ogre::Entity::setMeshLodBias                 SetMeshLodBias;
%rename Ogre::Entity::setMaterialLodBias             SetMaterialLodBias;
%rename Ogre::Entity::attachObjectToBone             AttachObjectToBone;
%rename Ogre::Entity::detachObjectFromBone           DetachObjectFromBone;
%rename Ogre::Entity::detachAllObjectsFromBone       DetachAllObjectsFromBone;
%rename Ogre::Entity::getAttachedObjectIterator      GetAttachedObjectIterator;
%rename Ogre::Entity::GetBoundingRadius              GetBoundingRadius;
%rename Ogre::Entity::getWorldBoundingBox            GetWorldBoundingBox;
%rename Ogre::Entity::getWorldBoundingSphere         GetWorldBoundingSphere;
%rename Ogre::Entity::setNormaliseNormals            SetNormaliseNormals;
%rename Ogre::Entity::getNormaliseNormals            GetNormaliseNormals;
%rename Ogre::Entity::getEdgeList                    GetEdgeList;
%rename Ogre::Entity::hasSkeleton                    HasSkeleton;
%rename Ogre::Entity::getSkeleton                    GetSkeleton;
%rename Ogre::Entity::isHardwareSkinningEnabled      IsHardwareSkinningEnabled;
%rename Ogre::Entity::shareSkeletonInstanceWith      ShareSkeletonInstanceWith;
%rename Ogre::Entity::sharesSkeletonInstance         SharesSkeletonInstance;
%rename Ogre::Entity::getSkeletonInstanceSharingSet  GetSkeletonInstanceSharingSet;
%rename Ogre::Entity::refreshAvailableAnimationState RefreshAvailableAnimationState;

%typemap(cscode) Ogre::Entity
%{
    public MeshPtr Mesh {
        get { return GetMesh(); }
    }

    public UInt32 NumSubEntities    {
        get { return GetNumSubEntities(); }
    }

    public string MaterialName {
        set { SetMaterialName(value); }
    }

    public override RenderQueueGroupID RenderQueueGroup {
        set { SetRenderQueueGroup((byte)value); }
    }

    public override AxisAlignedBox BoundingBox {
        get { return GetBoundingBox(); }
    }

    public AxisAlignedBox ChildObjectsBoundingBox {
        get { return GetChildObjectsBoundingBox(); }
    }

    public override string Name {
        get { return GetName(); }
    }

    public override string MovableType {
        get { return GetMovableType(); }
    }

    public AnimationStateSet AllAnimationStates {
        get { return GetAllAnimationStates(); }
    }

    public bool DisplaySkeleton {
        get { return GetDisplaySkeleton(); }
        set { SetDisplaySkeleton((bool)value); }    
    }

    public float MeshLodBias {
        set { SetMeshLodBias(value); }
    }

    public float MaterialLodBias {
        set { SetMaterialLodBias(value); }
    }

    public override float BoundingRadius {
        get { return GetBoundingRadius(); }
    }

    public AxisAlignedBox WorldBoundingBox {
        get { return GetWorldBoundingBox(); }
    }

    public Sphere WorldBoundingSphere {
        get { return GetWorldBoundingSphere(); }
    }

    public bool NormaliseNormals {
        get { return GetNormaliseNormals(); }
        set { SetNormaliseNormals((bool)value); }    
    }

    public Math3D.Matrix4 BoneMatrices {
        get { return _getBoneMatrices(); }
    }

    public int NumBoneMatrices {
        get { return _getNumBoneMatrices(); }
    }

    public SkeletonInstance Skeleton {
        get { return GetSkeleton(); }
    }
%}

//TODO EdgeData has alot of inline things. 
%ignore Ogre::Entity::getEdgeList;

%include "OgreEntity.h"

//the names from SceneManager are better
//        typedef std::map<String, MovableObject*> ChildObjectList;
//        typedef MapIterator<ChildObjectList> ChildObjectListIterator;
//
//        typedef std::map<String, MovableObject*> MovableObjectMap;
//        typedef MapIterator<MovableObjectMap> MovableObjectIterator;
PTR_REF_TYPEMAPS(MovableObject, Ogre::MovableObject*)
%template(MovableObjectMap) std::map<std::string, Ogre::MovableObject*>;

MapIteratorWRAP(MovableObjectIteratorWrap, std::map, std::string, Ogre::MovableObject*);

//typedef std::set<Entity*> EntitySet;
SWIG_STD_SET_SPECIALIZE_MINIMUM(Entity, Ogre::Entity*)
%template(EntitySet) std::set<Ogre::Entity*>;
