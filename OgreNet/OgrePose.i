%{
#include "OgrePose.h"
%}

%include OgrePose.h



//		typedef MapIterator<VertexOffsetMap> VertexOffsetIterator;
MapIteratorWRAP(VertexOffsetIteratorWrap, std::map, size_t, Ogre::Vector3 );


//		typedef ConstMapIterator<VertexOffsetMap> ConstVertexOffsetIterator;
ConstMapIteratorWRAP(VertexOffsetConstIteratorWrap, std::map, size_t, Ogre::Vector3 );


//	typedef std::vector<Pose*> PoseList;
//swig.29     PTR_REF_TYPEMAPS(Pose, Ogre::Pose*)
SWIG_STD_VECTOR_SPECIALIZE_MINIMUM(Pose, Ogre::Pose*)
%template(PoseList) std::vector<Ogre::Pose*>;

