%{
#include "OgrePass.h"
%}

//params is a keyword in C#.  there is a %extend for this function
%ignore Ogre::Pass::setVertexProgramParameters;
%ignore Ogre::Pass::setShadowCasterVertexProgramParameters;
%ignore Ogre::Pass::setShadowReceiverVertexProgramParameters;
%ignore Ogre::Pass::setShadowReceiverFragmentProgramParameters;
%ignore Ogre::Pass::setFragmentProgramParameters;

// TODO: problems with nested struct HashFunc
%ignore Ogre::Pass::setHashFunction(BuiltinHashFunction builtin);
%ignore Ogre::Pass::setHashFunction(HashFunc* hashFunc);
%ignore Ogre::Pass::getHashFunction();

%include OgrePass.h

%extend Ogre::Pass
{
    void SetVertexProgramParameters(GpuProgramParametersSharedPtr vparams)
    {
        self->setVertexProgramParameters(vparams);
    }
    
    void SetShadowCasterVertexProgramParameters(GpuProgramParametersSharedPtr vparams)
    {
        self->setShadowCasterVertexProgramParameters(vparams);
    }
    
    void SetShadowReceiverVertexProgramParameters(GpuProgramParametersSharedPtr vparams)
    {
        self->setShadowReceiverVertexProgramParameters(vparams);
    }
    
    void SetShadowReceiverFragmentProgramParameters(GpuProgramParametersSharedPtr vparams)
    {
        self->setShadowReceiverFragmentProgramParameters(vparams);
    }
    
    void SetFragmentProgramParameters(GpuProgramParametersSharedPtr vparams)
    {
        self->setFragmentProgramParameters(vparams);
    }
};

//        typedef std::set<Pass*> PassSet;
SWIG_STD_SET_SPECIALIZE_MINIMUM(Pass, Ogre::Pass*)
%template(PassSet) std::set<Ogre::Pass*>;

//        typedef std::vector<TextureUnitState*> TextureUnitStates;
//swig.29     PTR_REF_TYPEMAPS(TextureUnitState, Ogre::TextureUnitState*)
SWIG_STD_VECTOR_SPECIALIZE_MINIMUM(TextureUnitState, Ogre::TextureUnitState*)
%template(TextureUnitStatesList) std::vector<Ogre::TextureUnitState*>;

//        typedef VectorIterator<TextureUnitStates> TextureUnitStateIterator;
VectorIteratorWRAP(TextureUnitStateIteratorWrap, std::vector, Ogre::TextureUnitState*);


//        typedef ConstVectorIterator<TextureUnitStates> ConstTextureUnitStateIterator;
ConstVectorIteratorWRAP(ConstTextureUnitStateIteratorWrap, std::vector, Ogre::TextureUnitState*);

//        typedef std::vector<IlluminationPass*> IlluminationPassList;
//swig.29     PTR_REF_TYPEMAPS(IlluminationPass, Ogre::IlluminationPass*)
SWIG_STD_VECTOR_SPECIALIZE_MINIMUM(IlluminationPass, Ogre::IlluminationPass*)
%template(IlluminationPassList) std::vector<Ogre::IlluminationPass*>;
