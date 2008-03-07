%{
#include "OgreMesh.h"
%}

//bool suggestTangentVectorBuildParams(unsigned short& outSourceCoordSet, unsigned short& outDestCoordSet);
%apply unsigned short     &INOUT { unsigned short& outSourceCoordSet, unsigned short& outDestCoordSet };

//TODO is multimap working?  below is the template
//swig is having some problem with "struct" Ogre::VertexBoneAssignment being in a multimap and MapIterator
//have to custom wrap this function because swig cant see it right.
%ignore Ogre::Mesh::getBoneAssignmentIterator;

//TODO swig does not have hash map we need to custome wrap this
%ignore Ogre::Mesh::getSubMeshNameMap;

//TODO how do we deal with an cpp array of unsigned short
//@param pIndexMap Pointer to an array of indices to translate blend indices in the sourceVertexData to the index of pMatrices
%ignore Ogre::Mesh::softwareVertexBlend;

%typemap(cscode) Ogre::Mesh
%{
    public int NumSubMeshes {
        get
        {
            return getNumSubMeshes();
        }
    }

    public AxisAlignedBox Bounds {
        get
        {
            return getBounds();
        }
    }

    public float BoundingSphereRadius {
        get
        {
            return getBoundingSphereRadius();
        }
    }

    public SkeletonPtr Skeleton {
        get
        {
            return getSkeleton();
        }
    }

    public string SkeletonName {
        set
        {
            setSkeletonName(value);
        }
        get
        {
            return getSkeletonName();
        }
    }

    public int NumLodLevels {
        get
        {
            return getNumLodLevels();
        }
    }

//  public void VertexBufferPolicy {
//    set
//    {
//        setVertexBufferPolicy((HardwareBuffer.Usage)value);
//    }
//  }

//  public void IndexBufferPolicy {
//    set
//    {
//        setIndexBufferPolicy((HardwareBuffer.Usage)value);
//    }
//  }

    public HardwareBuffer.Usage VertexBufferUsage {
        get
        {
            return getVertexBufferUsage();
        }
    }

    public HardwareBuffer.Usage IndexBufferUsage {
        get
        {
            return getIndexBufferUsage();
        }
    }

    public SWIGTYPE_p_Ogre__EdgeData EdgeList {
        get
        {
            return getEdgeList();
        }
    }

    public bool AutoBuildEdgeLists {
        set
        {
            setAutoBuildEdgeLists(value);
        }
        get
        {
            return getAutoBuildEdgeLists();
        }
    }
%}

%include OgreMesh.h

//class _OgreExport MeshPtr : public SharedPtr<Mesh>
//lot of trouble with templating the SharedPtr + we dont need 2 of them.
// so just the autocreated one some functions
%extend Ogre::MeshPtr
{
    Ogre::Mesh* Get()
    {
        return (Ogre::Mesh*)self->get();
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


%extend Ogre::Mesh
{
    Ogre::Mesh::BoneAssignmentIterator *GetBoneAssignmentIterator()
    {
        Ogre::Mesh::BoneAssignmentIterator * jresult;
        
        //typedef std::multimap<size_t, VertexBoneAssignment> VertexBoneAssignmentList;
        //typedef MapIterator<VertexBoneAssignmentList> BoneAssignmentIterator;
        SwigValueWrapper<Ogre::MapIterator<std::multimap<size_t, Ogre::VertexBoneAssignment> > > result;

        result = self->getBoneAssignmentIterator();
        jresult = new Ogre::Mesh::BoneAssignmentIterator((Ogre::Mesh::BoneAssignmentIterator &)result); 
        
        return jresult;
    }
};

//        typedef std::vector<SubMesh*> SubMeshList;
SWIG_STD_VECTOR_SPECIALIZE_MINIMUM(SubMesh, Ogre::SubMesh*)
%template(SubMeshList) std::vector<Ogre::SubMesh*>;

//        typedef VectorIterator<SubMeshList> SubMeshIterator;
VectorIteratorWRAP(SubMeshIteratorWrap, std::vector, Ogre::SubMesh*);

//typedef VectorIterator<PoseList> PoseIterator;
VectorIteratorWRAP(PoseIteratorWrap, std::vector, Ogre::Pose*);

//typedef ConstVectorIterator<PoseList> ConstPoseIterator;
ConstVectorIteratorWRAP(ConstPoseIteratorWrap, std::vector, Ogre::Pose*);
