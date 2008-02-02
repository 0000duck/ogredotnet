%{
#include "OgreCompositionTargetPass.h"
%}

//out is a keyword 
//void setOutputName(const String &out);
%ignore Ogre::CompositionTargetPass::setOutputName;


%include "OgreCompositionTargetPass.h"


%extend Ogre::CompositionTargetPass
{
	void SetOutputName(const String &strOutPutName)
	{
		self->setOutputName(strOutPutName);
	}
};

        
	//typedef std::vector<CompositionTargetPass *> TargetPasses;
SWIG_STD_VECTOR_SPECIALIZE_MINIMUM(CompositionTargetPass, Ogre::CompositionTargetPass*)
%template(CompositionTargetPasses) std::vector<Ogre::CompositionTargetPass*>;

	//typedef VectorIterator<TargetPasses> TargetPassIterator;
VectorIteratorWRAP(CompositionTargetPassesIteratorWrap, std::vector, Ogre::CompositionTargetPass*);


