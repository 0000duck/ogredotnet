%{
#include "OgreTextureUnitState.h"
#include "TextureUnitState.h"
%}

%ignore Ogre::TextureUnitState::_load(void);
%ignore Ogre::TextureUnitState::_unload(void);
%ignore Ogre::TextureUnitState::_notifyNeedsRecompile(void);
%ignore Ogre::TextureUnitState::_notifyParent(Pass* parent);
%ignore Ogre::TextureUnitState::_getTexturePtr(void);
%ignore Ogre::TextureUnitState::_getTexturePtr(size_t frame);
%ignore Ogre::TextureUnitState::_setTexturePtr(const TexturePtr& texptr);
%ignore Ogre::TextureUnitState::_setTexturePtr(const TexturePtr& texptr, size_t frame);
%ignore Ogre::TextureUnitState::_getAnimController();

%ignore Ogre::TextureUnitState::EffectMap;
%ignore Ogre::TextureUnitState::getEffects;
%ignore Ogre::TextureUnitState::addEffect;
%ignore Ogre::TextureUnitState::getTextureAddressingMode;
%ignore Ogre::TextureUnitState::setTextureAddressingMode(const UVWAddressingMode& uvw);

%newobject Ogre::TextureUnitState::GetEffects;
%newobject Ogre::TextureUnitState::GetTextureAddressingMode;

%nodefault Ogre::TUSTextureEffectMap;

%newobject Ogre::TUSTextureEffectMap::getFirst;
%newobject Ogre::TUSTextureEffectMap::getLast;
%newobject Ogre::TUSTextureEffectMap::getByIndex;
%newobject Ogre::TUSTextureEffectMap::getItem;

%rename Ogre::TextureUnitState::getTextureName GetTextureName;
%rename Ogre::TextureUnitState::setTextureName SetTextureName;
%rename Ogre::TextureUnitState::setCubicTextureName SetCubicTextureName;
%rename Ogre::TextureUnitState::setAnimatedTextureName SetAnimatedTextureName;
%rename Ogre::TextureUnitState::getTextureDimensions GetTextureDimensions;
%rename Ogre::TextureUnitState::setCurrentFrame SetCurrentFrame;
%rename Ogre::TextureUnitState::getCurrentFrame GetCurrentFrame;
%rename Ogre::TextureUnitState::getFrameTextureName GetFrameTextureName;
%rename Ogre::TextureUnitState::setFrameTextureName SetFrameTextureName;
%rename Ogre::TextureUnitState::addFrameTextureName AddFrameTextureName;
%rename Ogre::TextureUnitState::deleteFrameTextureName DeleteFrameTextureName;
%rename Ogre::TextureUnitState::getNumFrames GetNumFrames;
%rename Ogre::TextureUnitState::setBindingType SetBindingType;
%rename Ogre::TextureUnitState::getBindingType GetBindingType;
%rename Ogre::TextureUnitState::setContentType SetContentType;
%rename Ogre::TextureUnitState::getContentType GetContentType;
%rename Ogre::TextureUnitState::isCubic IsCubic;
%rename Ogre::TextureUnitState::is3D Is3D;
%rename Ogre::TextureUnitState::getTextureType GetTextureType;
%rename Ogre::TextureUnitState::setDesiredFormat SetDesiredFormat;
%rename Ogre::TextureUnitState::getDesiredFormat GetDesiredFormat;
%rename Ogre::TextureUnitState::setNumMipmaps SetNumMipmaps;
%rename Ogre::TextureUnitState::getNumMipmaps GetNumMipmaps;
%rename Ogre::TextureUnitState::setIsAlpha SetIsAlpha;
%rename Ogre::TextureUnitState::getIsAlpha GetIsAlpha;
%rename Ogre::TextureUnitState::getTextureCoordSet GetTextureCoordSet;
%rename Ogre::TextureUnitState::setTextureCoordSet SetTextureCoordSet;
%rename Ogre::TextureUnitState::setTextureTransform SetTextureTransform;
%rename Ogre::TextureUnitState::getTextureTransform GetTextureTransform;
%rename Ogre::TextureUnitState::setTextureScroll SetTextureScroll;
%rename Ogre::TextureUnitState::setTextureUScroll SetTextureUScroll;
%rename Ogre::TextureUnitState::getTextureUScroll GetTextureUScroll;
%rename Ogre::TextureUnitState::setTextureVScroll SetTextureVScroll;
%rename Ogre::TextureUnitState::getTextureVScroll GetTextureVScroll;
%rename Ogre::TextureUnitState::setTextureUScale SetTextureUScale;
%rename Ogre::TextureUnitState::getTextureUScale GetTextureUScale;
%rename Ogre::TextureUnitState::setTextureVScale SetTextureVScale;
%rename Ogre::TextureUnitState::getTextureVScale GetTextureVScale;
%rename Ogre::TextureUnitState::setTextureScale SetTextureScale;
%rename Ogre::TextureUnitState::setTextureRotate SetTextureRotate;
%rename Ogre::TextureUnitState::getTextureRotate GetTextureRotate;
%rename Ogre::TextureUnitState::setTextureBorderColour SetTextureBorderColour;
%rename Ogre::TextureUnitState::getTextureBorderColour GetTextureBorderColour;
%rename Ogre::TextureUnitState::setColourOperationEx SetColourOperationEx;
%rename Ogre::TextureUnitState::setColourOperation SetColourOperation;
%rename Ogre::TextureUnitState::setColourOpMultipassFallback SetColourOpMultipassFallback;
%rename Ogre::TextureUnitState::getColourBlendMode GetColourBlendMode;
%rename Ogre::TextureUnitState::getAlphaBlendMode GetAlphaBlendMode;
%rename Ogre::TextureUnitState::getColourBlendFallbackSrc GetColourBlendFallbackSrc;
%rename Ogre::TextureUnitState::getColourBlendFallbackDest GetColourBlendFallbackDest;
%rename Ogre::TextureUnitState::setAlphaOperation SetAlphaOperation;
%rename Ogre::TextureUnitState::setEnvironmentMap SetEnvironmentMap;
%rename Ogre::TextureUnitState::setScrollAnimation SetScrollAnimation;
%rename Ogre::TextureUnitState::setRotateAnimation SetRotateAnimation;
%rename Ogre::TextureUnitState::setTransformAnimation SetTransformAnimation;
%rename Ogre::TextureUnitState::setProjectiveTexturing SetProjectiveTexturing;
%rename Ogre::TextureUnitState::removeAllEffects RemoveAllEffects;
%rename Ogre::TextureUnitState::removeEffect RemoveEffect;
%rename Ogre::TextureUnitState::isBlank IsBlank;
%rename Ogre::TextureUnitState::setBlank SetBlank;
%rename Ogre::TextureUnitState::isTextureLoadFailing IsTextureLoadFailing;
%rename Ogre::TextureUnitState::retryTextureLoad RetryTextureLoad;
%rename Ogre::TextureUnitState::getAnimationDuration GetAnimationDuration;
%rename Ogre::TextureUnitState::setTextureFiltering SetTextureFiltering;
%rename Ogre::TextureUnitState::getTextureFiltering GetTextureFiltering;
%rename Ogre::TextureUnitState::setTextureAnisotropy SetTextureAnisotropy;
%rename Ogre::TextureUnitState::getTextureAnisotropy GetTextureAnisotropy;
%rename Ogre::TextureUnitState::setTextureMipmapBias SetTextureMipmapBias;
%rename Ogre::TextureUnitState::getTextureMipmapBias GetTextureMipmapBias;
%rename Ogre::TextureUnitState::getParent GetParent;
%rename Ogre::TextureUnitState::hasViewRelativeTextureCoordinateGeneration HasViewRelativeTextureCoordinateGeneration;
%rename Ogre::TextureUnitState::isLoaded IsLoaded;
%rename Ogre::TextureUnitState::setName SetName;
%rename Ogre::TextureUnitState::getName GetName;
%rename Ogre::TextureUnitState::setTextureNameAlias SetTextureNameAlias;
%rename Ogre::TextureUnitState::getTextureNameAlias GetTextureNameAlias;
%rename Ogre::TextureUnitState::applyTextureAliases ApplyTextureAliases;
%rename Ogre::TextureUnitState::setTextureAddressingMode  SetTextureAddressingMode;

%include OgreTextureUnitState.h

namespace Ogre
{
    class TUSUVWAddressingMode
    {
    public:
        TUSUVWAddressingMode();
        ~TUSUVWAddressingMode();
        
        TextureUnitState::TextureAddressingMode getU();
        void setU(TextureUnitState::TextureAddressingMode value);
        TextureUnitState::TextureAddressingMode getV();
        void setV(TextureUnitState::TextureAddressingMode value);
        TextureUnitState::TextureAddressingMode getW();
        void setW(TextureUnitState::TextureAddressingMode value);
    };
    
    class TUSTextureEffect
    {
    public:
        TUSTextureEffect();
        ~TUSTextureEffect();
        
        TextureUnitState::TextureEffectType getType();
        void setType(TextureUnitState::TextureEffectType value);
        int getSubtype();
        void setSubtype(int value);
        Real getArg1();
        void setArg1(Real value);
        Real getArg2();
        void setArg2(Real value);
        WaveformType getWaveType();
        void setWaveType(WaveformType value);
        Real getBase();
        void setBase(Real value);
        Real getFrequency();
        void setFrequency(Real value);
        Real getPhase();
        void setPhase(Real value);
        Real getAmplitude();
        void setAmplitude(Real value);
        Controller<Real>* getController();
        void setController(Controller<Real>* value);
        const Frustum* getFrustum();
        void setFrustum(const Frustum* value);
    };
    
    class TUSTextureEffectMap
    {
    public:
        size_t size();
        TUSTextureEffect *getFirst();
        TUSTextureEffect *getLast();
        TUSTextureEffect *getByIndex(int index);
        TUSTextureEffect *getItem(TextureUnitState::TextureEffectType key);
    };
}

//  const UVWAddressingMode& getTextureAddressingMode(void) const;
//  void setTextureAddressingMode(const UVWAddressingMode& uvw);
//   typedef std::multimap<TextureEffectType, TextureEffect> EffectMap;
//   const EffectMap& getEffects(void) const;
//  void addEffect(TextureEffect& effect);
%extend Ogre::TextureUnitState
{
    Ogre::TUSUVWAddressingMode * GetTextureAddressingMode()
    {
        Ogre::TUSUVWAddressingMode *p=0;
        p = new Ogre::TUSUVWAddressingMode((Ogre::TextureUnitState::UVWAddressingMode*)&self->getTextureAddressingMode());
        return p;
    }
    
    void SetTextureAddressingMode(Ogre::TUSUVWAddressingMode * uvw)
    {
        self->setTextureAddressingMode(*uvw->get_mObj());
    }
    
    Ogre::TUSTextureEffectMap * GetEffects()
    {
        Ogre::TUSTextureEffectMap *p=0;
        p = new Ogre::TUSTextureEffectMap((Ogre::TextureUnitState::EffectMap*)&self->getEffects());
        return p;
    }
    
    void AddEffect(Ogre::TUSTextureEffect * ppe)
    {
        Ogre::TextureUnitState::TextureEffect *p = ppe->get_mObj();
        if (p != 0)
            self->addEffect(*p);
    }
};
