%{
#include "OgreTechnique.h"
%}


%include OgreTechnique.h

// TODO check, this is private
//        typedef std::vector<Pass*> Passes;
//swig.29     PTR_REF_TYPEMAPS(Pass, Ogre::Pass*)
SWIG_STD_VECTOR_SPECIALIZE_MINIMUM(Pass, Ogre::Pass*)
%template(Passes) std::vector<Ogre::Pass*>;


//        typedef VectorIterator<Passes> PassIterator;
VectorIteratorWRAP(PassIteratorWrap, std::vector, Ogre::Pass*);

//        typedef VectorIterator<IlluminationPassList> IlluminationPassIterator;
VectorIteratorWRAP(IlluminationPassListWrap, std::vector, Ogre::IlluminationPass*);


