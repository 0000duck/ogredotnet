%{
#include "OgreRibbonTrail.h"
%}



%include "OgreRibbonTrail.h"

// typedef std::vector<Node*> NodeList;
//swig.29     PTR_REF_TYPEMAPS(Node, Ogre::Node*)
SWIG_STD_VECTOR_SPECIALIZE_MINIMUM(Node, Ogre::Node*)
%template(NodeList) std::vector<Ogre::Node*>;


// typedef ConstVectorIterator<NodeList> NodeIterator;
ConstVectorIteratorWRAP(NodeIteratorWrap, std::vector, Ogre::Node*);


