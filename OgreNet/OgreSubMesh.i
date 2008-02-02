%{
#include "OgreSubMesh.h"
%}

%rename Ogre::SubMesh::setMaterialName				SetMaterialName;
%rename Ogre::SubMesh::getMaterialName				GetMaterialName;
%rename Ogre::SubMesh::isMatInitialised				IsMatInitialised;
%rename Ogre::SubMesh::addBoneAssignment			AddBoneAssignment;
%rename Ogre::SubMesh::clearBoneAssignments			ClearBoneAssignments;


//TODO is multimap working?  below is the template
//swig is having some problem with "struct" Ogre::VertexBoneAssignment being in a multimap and MapIterator
//have to custom wrap this function because swig cant see it right.
%ignore Ogre::SubMesh::getBoneAssignmentIterator;


//typedef std::multimap<size_t, VertexBoneAssignment> VertexBoneAssignmentList;
PTR_REF_TYPEMAPS(VertexBoneAssignment, VertexBoneAssignment)
%template(VertexBoneAssignmentList) std::multimap<size_t, Ogre::VertexBoneAssignment>;

%typemap(ctype)   std::multimap<size_t, Ogre::VertexBoneAssignment> &       "void *"
%typemap(imtype)  std::multimap<size_t, Ogre::VertexBoneAssignment> &       "IntPtr"
%typemap(cstype)  std::multimap<size_t, Ogre::VertexBoneAssignment> &       "VertexBoneAssignmentList"
%typemap(csin)    std::multimap<size_t, Ogre::VertexBoneAssignment> &       "VertexBoneAssignmentList.getCPtr($csinput).Handle"
%typemap(out)     std::multimap<size_t, Ogre::VertexBoneAssignment> &       %{ $result = (void *)&$1; %}
%typemap(csout)   std::multimap<size_t, Ogre::VertexBoneAssignment> &
{
    IntPtr cPtr = $imcall;
    return (cPtr == IntPtr.Zero) ? null : new VertexBoneAssignmentList(cPtr, $owner);
}
%typemap(in)      std::multimap<size_t, Ogre::VertexBoneAssignment> & 
%{
    $1 = (std::multimap<size_t, Ogre::VertexBoneAssignment> *)$input;
%}


//typedef MapIterator<VertexBoneAssignmentList> BoneAssignmentIterator;
MapIteratorWRAP(BoneAssignmentIteratorWrap, std::multimap, size_t, Ogre::VertexBoneAssignment);
%typemap(ctype)   Ogre::MapIterator<std::multimap<size_t, Ogre::VertexBoneAssignment> > *      "void *"
%typemap(imtype)  Ogre::MapIterator<std::multimap<size_t, Ogre::VertexBoneAssignment> > *      "IntPtr"
%typemap(cstype)  Ogre::MapIterator<std::multimap<size_t, Ogre::VertexBoneAssignment> > *      "BoneAssignmentIteratorWrap"
%typemap(out)     Ogre::MapIterator<std::multimap<size_t, Ogre::VertexBoneAssignment> > *
%{
	$result = (void *)$1;
%}
%typemap(csout)   Ogre::MapIterator<std::multimap<size_t, Ogre::VertexBoneAssignment> > * 
{
    IntPtr cPtr = $imcall;
    return (cPtr == IntPtr.Zero) ? null : new BoneAssignmentIteratorWrap(cPtr, $owner);
}



//ignore because of RenderOperation is private
%ignore Ogre::SubMesh::_getRenderOperation;
%ignore Ogre::SubMesh::operationType;




%typemap(cscode) Ogre::SubMesh
%{
	public string MaterialName
	{
		set { SetMaterialName(value); }
		get { return GetMaterialName(); }
	}
%}


%include OgreSubMesh.h


%extend Ogre::SubMesh
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


//typedef std::map<String, String> AliasTextureNamePairList;
//typedef ConstMapIterator<AliasTextureNamePairList> AliasTextureIterator;
ConstMapIteratorWRAP(AliasTextureIteratorWrap, std::map, std::string, std::string );


