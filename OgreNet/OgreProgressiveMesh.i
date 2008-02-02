%{
#include "OgreProgressiveMesh.h"
%}

%include OgreProgressiveMesh.h

//        typedef std::vector<IndexData*> LODFaceList;
//swig.29     PTR_REF_TYPEMAPS(IndexData, Ogre::IndexData*)
SWIG_STD_VECTOR_SPECIALIZE_MINIMUM(IndexData, Ogre::IndexData*)
%template(LODFaceList) std::vector<Ogre::IndexData*>;
