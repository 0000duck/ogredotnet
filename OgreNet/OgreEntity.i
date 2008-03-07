%{
#include "OgreEntity.h"
%}

%typemap(cscode) Ogre::Entity
%{
    public MeshPtr Mesh {
        get { return getMesh(); }
    }

    public UInt32 NumSubEntities    {
        get { return getNumSubEntities(); }
    }

    public string MaterialName {
        set { setMaterialName(value); }
    }

    public override RenderQueueGroupID RenderQueueGroup {
        set { setRenderQueueGroup((byte)value); }
    }

    public override AxisAlignedBox BoundingBox {
        get { return getBoundingBox(); }
    }

    public AxisAlignedBox ChildObjectsBoundingBox {
        get { return getChildObjectsBoundingBox(); }
    }

    public override string Name {
        get { return getName(); }
    }

    public override string MovableType {
        get { return getMovableType(); }
    }

    public AnimationStateSet AllAnimationStates {
        get { return getAllAnimationStates(); }
    }

    public bool DisplaySkeleton {
        get { return getDisplaySkeleton(); }
        set { setDisplaySkeleton((bool)value); }    
    }

    public float MeshLodBias {
        set { setMeshLodBias(value); }
    }

    public float MaterialLodBias {
        set { setMaterialLodBias(value); }
    }

    public override float BoundingRadius {
        get { return getBoundingRadius(); }
    }

    public AxisAlignedBox WorldBoundingBox {
        get { return getWorldBoundingBox(); }
    }

    public Sphere WorldBoundingSphere {
        get { return getWorldBoundingSphere(); }
    }

    public bool NormaliseNormals {
        get { return getNormaliseNormals(); }
        set { setNormaliseNormals((bool)value); }    
    }

    public Math3D.Matrix4 BoneMatrices {
        get { return _getBoneMatrices(); }
    }

    public int NumBoneMatrices {
        get { return _getNumBoneMatrices(); }
    }

    public SkeletonInstance Skeleton {
        get { return getSkeleton(); }
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
