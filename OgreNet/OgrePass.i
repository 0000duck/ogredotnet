%{
#include "OgrePass.h"
%}

// TODO: convert get/set methods to properties
%rename Ogre::Pass::isProgrammable IsProgrammable;
%rename Ogre::Pass::hasVertexProgram HasVertexProgram;
%rename Ogre::Pass::hasFragmentProgram HasFragmentProgram;
%rename Ogre::Pass::hasShadowCasterVertexProgram HasShadowCasterVertexProgram;
%rename Ogre::Pass::hasShadowReceiverVertexProgram HasShadowReceiverVertexProgram;
%rename Ogre::Pass::hasShadowReceiverFragmentProgram HasShadowReceiverFragmentProgram;
%rename Ogre::Pass::getIndex GetIndex;
%rename Ogre::Pass::setName SetName;
%rename Ogre::Pass::getName GetName;
%rename Ogre::Pass::setAmbient SetAmbient;
%rename Ogre::Pass::setDiffuse SetDiffuse;
%rename Ogre::Pass::setSpecular SetSpecular;
%rename Ogre::Pass::setShininess SetShininess;
%rename Ogre::Pass::setSelfIllumination SetSelfIllumination;
%rename Ogre::Pass::setVertexColourTracking SetVertexColourTracking;
%rename Ogre::Pass::getPointSize GetPointSize;
%rename Ogre::Pass::setPointSize SetPointSize;
%rename Ogre::Pass::setPointSpritesEnabled SetPointSpritesEnabled;
%rename Ogre::Pass::getPointSpritesEnabled GetPointSpritesEnabled;
%rename Ogre::Pass::setPointAttenuation SetPointAttenuation;
%rename Ogre::Pass::isPointAttenuationEnabled IsPointAttenuationEnabled;
%rename Ogre::Pass::getPointAttenuationConstant GetPointAttenuationConstant;
%rename Ogre::Pass::getPointAttenuationLinear GetPointAttenuationLinear;
%rename Ogre::Pass::getPointAttenuationQuadratic GetPointAttenuationQuadratic;
%rename Ogre::Pass::setPointMinSize SetPointMinSize;
%rename Ogre::Pass::getPointMinSize GetPointMinSize;
%rename Ogre::Pass::setPointMaxSize SetPointMaxSize;
%rename Ogre::Pass::getPointMaxSize GetPointMaxSize;
%rename Ogre::Pass::getAmbient GetAmbient;
%rename Ogre::Pass::getDiffuse GetDiffuse;
%rename Ogre::Pass::getSpecular GetSpecular;
%rename Ogre::Pass::getSelfIllumination GetSelfIllumination;
%rename Ogre::Pass::getShininess GetShininess;
%rename Ogre::Pass::getVertexColourTracking GetVertexColourTracking;
%rename Ogre::Pass::createTextureUnitState CreateTextureUnitState;
%rename Ogre::Pass::addTextureUnitState AddTextureUnitState;
%rename Ogre::Pass::getTextureUnitState GetTextureUnitState;
%rename Ogre::Pass::getTextureUnitStateIndex GetTextureUnitStateIndex;
%rename Ogre::Pass::getTextureUnitStateIterator GetTextureUnitStateIterator;
%rename Ogre::Pass::removeTextureUnitState RemoveTextureUnitState;
%rename Ogre::Pass::removeAllTextureUnitStates RemoveAllTextureUnitStates;
%rename Ogre::Pass::getNumTextureUnitStates GetNumTextureUnitStates;
%rename Ogre::Pass::setSceneBlending SetSceneBlending;
%rename Ogre::Pass::getSourceBlendFactor GetSourceBlendFactor;
%rename Ogre::Pass::getDestBlendFactor GetDestBlendFactor;
%rename Ogre::Pass::isTransparent IsTransparent;
%rename Ogre::Pass::setDepthCheckEnabled SetDepthCheckEnabled;
%rename Ogre::Pass::getDepthCheckEnabled GetDepthCheckEnabled;
%rename Ogre::Pass::setDepthWriteEnabled SetDepthWriteEnabled;
%rename Ogre::Pass::getDepthWriteEnabled GetDepthWriteEnabled;
%rename Ogre::Pass::setDepthFunction SetDepthFunction;
%rename Ogre::Pass::getDepthFunction GetDepthFunction;
%rename Ogre::Pass::setColourWriteEnabled SetColourWriteEnabled;
%rename Ogre::Pass::getColourWriteEnabled GetColourWriteEnabled;
%rename Ogre::Pass::setCullingMode SetCullingMode;
%rename Ogre::Pass::getCullingMode GetCullingMode;
%rename Ogre::Pass::setManualCullingMode SetManualCullingMode;
%rename Ogre::Pass::getManualCullingMode GetManualCullingMode;
%rename Ogre::Pass::setLightingEnabled SetLightingEnabled;
%rename Ogre::Pass::getLightingEnabled GetLightingEnabled;
%rename Ogre::Pass::setMaxSimultaneousLights SetMaxSimultaneousLights;
%rename Ogre::Pass::getMaxSimultaneousLights GetMaxSimultaneousLights;
%rename Ogre::Pass::setStartLight SetStartLight;
%rename Ogre::Pass::getStartLight GetStartLight;
%rename Ogre::Pass::setShadingMode SetShadingMode;
%rename Ogre::Pass::getShadingMode GetShadingMode;
%rename Ogre::Pass::setPolygonMode SetPolygonMode;
%rename Ogre::Pass::getPolygonMode GetPolygonMode;
%rename Ogre::Pass::setFog SetFog;
%rename Ogre::Pass::getFogOverride GetFogOverride;
%rename Ogre::Pass::getFogMode GetFogMode;
%rename Ogre::Pass::getFogColour GetFogColour;
%rename Ogre::Pass::getFogStart GetFogStart;
%rename Ogre::Pass::getFogEnd GetFogEnd;
%rename Ogre::Pass::getFogDensity GetFogDensity;
%rename Ogre::Pass::setDepthBias SetDepthBias;
%rename Ogre::Pass::getDepthBiasConstant GetDepthBiasConstant;
%rename Ogre::Pass::getDepthBiasSlopeScale GetDepthBiasSlopeScale;
%rename Ogre::Pass::setAlphaRejectSettings SetAlphaRejectSettings;
%rename Ogre::Pass::setAlphaRejectFunction SetAlphaRejectFunction;
%rename Ogre::Pass::setAlphaRejectValue SetAlphaRejectValue;
%rename Ogre::Pass::getAlphaRejectFunction GetAlphaRejectFunction;
%rename Ogre::Pass::getAlphaRejectValue GetAlphaRejectValue;
%rename Ogre::Pass::setIteratePerLight SetIteratePerLight;
%rename Ogre::Pass::getIteratePerLight GetIteratePerLight;
%rename Ogre::Pass::getRunOnlyForOneLightType GetRunOnlyForOneLightType;
%rename Ogre::Pass::getOnlyLightType GetOnlyLightType;
%rename Ogre::Pass::setLightCountPerIteration SetLightCountPerIteration;
%rename Ogre::Pass::getLightCountPerIteration GetLightCountPerIteration;
%rename Ogre::Pass::getParent GetParent;
%rename Ogre::Pass::getResourceGroup GetResourceGroup;
%rename Ogre::Pass::setVertexProgram SetVertexProgram;
%rename Ogre::Pass::getVertexProgramParameters GetVertexProgramParameters;
%rename Ogre::Pass::getVertexProgramName GetVertexProgramName;
%rename Ogre::Pass::getVertexProgram GetVertexProgram;
%rename Ogre::Pass::setShadowCasterVertexProgram SetShadowCasterVertexProgram;
%rename Ogre::Pass::getShadowCasterVertexProgramName GetShadowCasterVertexProgramName;
%rename Ogre::Pass::getShadowCasterVertexProgramParameters GetShadowCasterVertexProgramParameters;
%rename Ogre::Pass::getShadowCasterVertexProgram GetShadowCasterVertexProgram;
%rename Ogre::Pass::setShadowReceiverVertexProgram SetShadowReceiverVertexProgram;
%rename Ogre::Pass::setShadowReceiverFragmentProgram SetShadowReceiverFragmentProgram;
%rename Ogre::Pass::getShadowReceiverVertexProgramName GetShadowReceiverVertexProgramName;
%rename Ogre::Pass::getShadowReceiverVertexProgramParameters GetShadowReceiverVertexProgramParameters;
%rename Ogre::Pass::getShadowReceiverVertexProgram GetShadowReceiverVertexProgram;
%rename Ogre::Pass::getShadowReceiverFragmentProgramName GetShadowReceiverFragmentProgramName;
%rename Ogre::Pass::getShadowReceiverFragmentProgramParameters GetShadowReceiverFragmentProgramParameters;
%rename Ogre::Pass::getShadowReceiverFragmentProgram GetShadowReceiverFragmentProgram;
%rename Ogre::Pass::setFragmentProgram SetFragmentProgram;
%rename Ogre::Pass::getFragmentProgram GetFragmentProgram;
%rename Ogre::Pass::getFragmentProgramParameters GetFragmentProgramParameters;
%rename Ogre::Pass::getFragmentProgramName GetFragmentProgramName;
%rename Ogre::Pass::isLoaded IsLoaded;
%rename Ogre::Pass::getHash GetHash;
%rename Ogre::Pass::setTextureFiltering SetTextureFiltering;
%rename Ogre::Pass::setTextureAnisotropy SetTextureAnisotropy;
%rename Ogre::Pass::getDirtyHashList GetDirtyHashList;
%rename Ogre::Pass::getPassGraveyard GetPassGraveyard;
%rename Ogre::Pass::clearDirtyHashList ClearDirtyHashList;
%rename Ogre::Pass::processPendingPassUpdates ProcessPendingPassUpdates;
%rename Ogre::Pass::queueForDeletion QueueForDeletion;
%rename Ogre::Pass::isAmbientOnly IsAmbientOnly;
%rename Ogre::Pass::setPassIterationCount SetPassIterationCount;
%rename Ogre::Pass::getPassIterationCount GetPassIterationCount;
%rename Ogre::Pass::applyTextureAliases ApplyTextureAliases;

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

// internal functions
%ignore Ogre::Pass::_split(unsigned short numUnits);
%ignore Ogre::Pass::_notifyIndex(unsigned short index);
%ignore Ogre::Pass::_load(void);
%ignore Ogre::Pass::_unload(void);
%ignore Ogre::Pass::_dirtyHash(void);
%ignore Ogre::Pass::_recalculateHash(void);
%ignore Ogre::Pass::_notifyNeedsRecompile(void);
%ignore Ogre::Pass::_updateAutoParamsNoLights(const AutoParamDataSource& source) const;
%ignore Ogre::Pass::_updateAutoParamsLightsOnly(const AutoParamDataSource& source) const;
%ignore Ogre::Pass::_getTextureUnitWithContentTypeIndex(TextureUnitState::ContentType contentType, unsigned short index) const;

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
