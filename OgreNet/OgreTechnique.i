%{
#include "OgreTechnique.h"
%}

// TODO: convert get/set methods to properties
%rename Ogre::Technique::isSupported IsSupported;
%rename Ogre::Technique::createPass CreatePass;
%rename Ogre::Technique::getPass GetPass;
%rename Ogre::Technique::getNumPasses GetNumPasses;
%rename Ogre::Technique::removePass RemovePass;
%rename Ogre::Technique::removeAllPasses RemoveAllPasses;
%rename Ogre::Technique::movePass MovePass;
%rename Ogre::Technique::getPassIterator GetPassIterator;
%rename Ogre::Technique::getIlluminationPassIterator GetIlluminationPassIterator;
%rename Ogre::Technique::getParent GetParent;
%rename Ogre::Technique::getResourceGroup GetResourceGroup;
%rename Ogre::Technique::isTransparent IsTransparent;
%rename Ogre::Technique::isLoaded IsLoaded;
%rename Ogre::Technique::setPointSize SetPointSize;
%rename Ogre::Technique::setAmbient SetAmbient;
%rename Ogre::Technique::setAmbient SetAmbient;
%rename Ogre::Technique::setDiffuse SetDiffuse;
%rename Ogre::Technique::setDiffuse SetDiffuse;
%rename Ogre::Technique::setSpecular SetSpecular;
%rename Ogre::Technique::setShininess SetShininess;
%rename Ogre::Technique::setSelfIllumination SetSelfIllumination;
%rename Ogre::Technique::setDepthCheckEnabled SetDepthCheckEnabled;
%rename Ogre::Technique::setDepthWriteEnabled SetDepthWriteEnabled;
%rename Ogre::Technique::setDepthFunction SetDepthFunction;
%rename Ogre::Technique::setColourWriteEnabled SetColourWriteEnabled;
%rename Ogre::Technique::setCullingMode SetCullingMode;
%rename Ogre::Technique::setManualCullingMode SetManualCullingMode;
%rename Ogre::Technique::setLightingEnabled SetLightingEnabled;
%rename Ogre::Technique::setShadingMode SetShadingMode;
%rename Ogre::Technique::setFog SetFog;
%rename Ogre::Technique::setDepthBias SetDepthBias;
%rename Ogre::Technique::setTextureFiltering SetTextureFiltering;
%rename Ogre::Technique::setTextureAnisotropy SetTextureAnisotropy;
%rename Ogre::Technique::setSceneBlending SetSceneBlending;
%rename Ogre::Technique::setLodIndex SetLodIndex;
%rename Ogre::Technique::getLodIndex GetLodIndex;
%rename Ogre::Technique::setSchemeName SetSchemeName;
%rename Ogre::Technique::getSchemeName GetSchemeName;
%rename Ogre::Technique::isDepthWriteEnabled IsDepthWriteEnabled;
%rename Ogre::Technique::isDepthCheckEnabled IsDepthCheckEnabled;
%rename Ogre::Technique::hasColourWriteDisabled HasColourWriteDisabled;
%rename Ogre::Technique::setName SetName;
%rename Ogre::Technique::getName GetName;
%rename Ogre::Technique::applyTextureAliases ApplyTextureAliases;

// internal functions
%ignore Ogre::Technique::_getSchemeIndex(void);
%ignore Ogre::Technique::_compile(bool autoManageTextureUnits);
%ignore Ogre::Technique::_compileIlluminationPasses(void);
%ignore Ogre::Technique::_load(void);
%ignore Ogre::Technique::_unload(void);
%ignore Ogre::Technique::_notifyNeedsRecompile(void);

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
