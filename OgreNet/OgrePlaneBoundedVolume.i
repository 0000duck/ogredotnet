%{
#include "OgrePlaneBoundedVolume.h"
%}


%include "OgrePlaneBoundedVolume.h"



//typedef std::vector<Plane> PlaneList;
//swig.29     PTR_REF_TYPEMAPS(Plane, Ogre::Plane*)
SWIG_STD_VECTOR_SPECIALIZE_MINIMUM(Plane, Ogre::Plane*)
%template(PlaneList) std::vector<Ogre::Plane*>;

//   typedef std::vector<PlaneBoundedVolume> PlaneBoundedVolumeList;
SWIG_STD_VECTOR_SPECIALIZE_MINIMUM(PlaneBoundedVolume, Ogre::PlaneBoundedVolume)
%template(PlaneBoundedVolumeList) std::vector<Ogre::PlaneBoundedVolume>;
