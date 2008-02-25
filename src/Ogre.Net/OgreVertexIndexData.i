%{
#include "OgreVertexIndexData.h"
%}

// TODO custom wrap sub struct HardwareAnimationData
%ignore Ogre::VertexData::hwAnimationDataList;
%ignore Ogre::VertexData::HardwareAnimationDataList;


%include OgreVertexIndexData.h

//    typedef std::vector<HardwareBuffer::Usage> BufferUsageList;
SWIG_STD_VECTOR_SPECIALIZE_MINIMUM(HardwareBuffer.Usage,  Ogre::HardwareBuffer::Usage)
%template(BufferUsageList) std::vector<Ogre::HardwareBuffer::Usage>;

