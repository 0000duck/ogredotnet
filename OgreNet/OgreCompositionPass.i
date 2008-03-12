%{
#include "OgreCompositionPass.h"
%}

%include "OgreCompositionPass.h"


    //typedef std::vector<CompositionPass *> Passes;
SWIG_STD_VECTOR_SPECIALIZE_MINIMUM(CompositionPass, Ogre::CompositionPass*)
%template(CompositionPasses) std::vector<Ogre::CompositionPass*>;

    //typedef VectorIterator<Passes> PassIterator;
VectorIteratorWRAP(CompositionPassesIteratorWrap, std::vector, Ogre::CompositionPass*);
