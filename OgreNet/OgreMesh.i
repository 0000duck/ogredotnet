%{
#include "OgreMesh.h"
%}

%rename Ogre::Mesh::createSubMesh                   CreateSubMesh;
%rename Ogre::Mesh::nameSubMesh                     NameSubMesh;
%rename Ogre::Mesh::getNumSubMeshes                 GetNumSubMeshes;
%rename Ogre::Mesh::getSubMesh                      GetSubMesh;
%rename Ogre::Mesh::getSubMeshIterator              GetSubMeshIterator;
%rename Ogre::Mesh::sharedVertexData                SharedVertexData;
%rename Ogre::Mesh::clone                           Clone;
%rename Ogre::Mesh::getBounds                       GetBounds;
%rename Ogre::Mesh::getBoundingSphereRadius         GetBoundingSphereRadius;
%rename Ogre::Mesh::setSkeletonName                 SetSkeletonName;
%rename Ogre::Mesh::hasSkeleton                     HasSkeleton;
%rename Ogre::Mesh::getSkeleton                     GetSkeleton;
%rename Ogre::Mesh::getSkeletonName                 GetSkeletonName;
%rename Ogre::Mesh::addBoneAssignment               AddBoneAssignment;
%rename Ogre::Mesh::clearBoneAssignments            ClearBoneAssignments;
%rename Ogre::Mesh::getNumLodLevels                 GetNumLodLevels;
%rename Ogre::Mesh::getLodLevel                     GetLodLevel;
%rename Ogre::Mesh::createManualLodLevel            CreateManualLodLevel;
%rename Ogre::Mesh::updateManualLodLevel            UpdateManualLodLevel;
%rename Ogre::Mesh::getLodIndex                     GetLodIndex;
%rename Ogre::Mesh::getLodIndexSquaredDepth         GetLodIndexSquaredDepth;
%rename Ogre::Mesh::isLodManual                     IsLodManual;
%rename Ogre::Mesh::removeLodLevels                 RemoveLodLevels;
%rename Ogre::Mesh::setVertexBufferPolicy           SetVertexBufferPolicy;
%rename Ogre::Mesh::setIndexBufferPolicy            SetIndexBufferPolicy;
%rename Ogre::Mesh::getVertexBufferUsage            GetVertexBufferUsage;
%rename Ogre::Mesh::isVertexBufferShadowed          IsVertexBufferShadowed;
%rename Ogre::Mesh::isIndexBufferShadowed           IsIndexBufferShadowed;
%rename Ogre::Mesh::buildTangentVectors             BuildTangentVectors;
%rename Ogre::Mesh::suggestTangentVectorBuildParams SuggestTangentVectorBuildParams;
%rename Ogre::Mesh::buildEdgeList                   BuildEdgeList;
%rename Ogre::Mesh::freeEdgeList                    FreeEdgeList;
%rename Ogre::Mesh::prepareForShadowVolume          PrepareForShadowVolume;
%rename Ogre::Mesh::getEdgeList                     GetEdgeList;
%rename Ogre::Mesh::isPreparedForShadowVolumes      IsPreparedForShadowVolumes;
%rename Ogre::Mesh::isEdgeListBuilt                 IsEdgeListBuilt;
%rename Ogre::Mesh::softwareVertexBlend             SoftwareVertexBlend;
%rename Ogre::Mesh::setAutoBuildEdgeLists           SetAutoBuildEdgeLists;
%rename Ogre::Mesh::getAutoBuildEdgeLists           GetAutoBuildEdgeLists;
%rename Ogre::Mesh::getIndexBufferUsage             GetIndexBufferUsage;

%rename Ogre::Mesh::generateLodLevels               GenerateLodLevels;

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
        return GetNumSubMeshes();
    }
  }

  public AxisAlignedBox Bounds {
    get
    {
        return GetBounds();
    }
  }

  public float BoundingSphereRadius {
    get
    {
        return GetBoundingSphereRadius();
    }
  }

  public SkeletonPtr Skeleton {
    get
    {
        return GetSkeleton();
    }
  }

  public string SkeletonName {
    set
    {
        SetSkeletonName(value);
    }
    get
    {
        return GetSkeletonName();
    }
  }

  public int NumLodLevels {
    get
    {
        return GetNumLodLevels();
    }
  }


//  public void VertexBufferPolicy {
//    set
//    {
//        SetVertexBufferPolicy((HardwareBuffer.Usage)value);
//    }
//  }

//  public void IndexBufferPolicy {
//    set
//    {
//        SetIndexBufferPolicy((HardwareBuffer.Usage)value);
//    }
//  }

  public HardwareBuffer.Usage VertexBufferUsage {
    get
    {
        return GetVertexBufferUsage();
    }
  }

  public HardwareBuffer.Usage IndexBufferUsage {
    get
    {
        return GetIndexBufferUsage();
    }
  }


  public SWIGTYPE_p_Ogre__EdgeData EdgeList {
    get
    {
        return GetEdgeList();
    }
  }


  public bool AutoBuildEdgeLists {
    set
    {
        SetAutoBuildEdgeLists(value);
    }
    get
    {
        return GetAutoBuildEdgeLists();
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





