%{
#include "OgreTextureUnitState.h"
#include "TextureUnitState.h"
%}

%rename Ogre::TextureUnitState::setTextureAddressingMode  SetTextureAddressingMode;

%ignore Ogre::TextureUnitState::EffectMap;
%ignore Ogre::TextureUnitState::getEffects;
%ignore Ogre::TextureUnitState::addEffect;
%ignore Ogre::TextureUnitState::getTextureAddressingMode;
%ignore Ogre::TextureUnitState::setTextureAddressingMode( const UVWAddressingMode& uvw);

%newobject Ogre::TextureUnitState::GetEffects;
%newobject Ogre::TextureUnitState::GetTextureAddressingMode;

%nodefault Ogre::TUSTextureEffectMap;

%newobject Ogre::TUSTextureEffectMap::getFirst;
%newobject Ogre::TUSTextureEffectMap::getLast;
%newobject Ogre::TUSTextureEffectMap::getByIndex;
%newobject Ogre::TUSTextureEffectMap::getItem;



%include OgreTextureUnitState.h

namespace Ogre
{
	class TUSUVWAddressingMode {
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
	
	
	class TUSTextureEffect {
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
	
	
	class TUSTextureEffectMap {
	public:
		size_t size();
		TUSTextureEffect *getFirst();
		TUSTextureEffect *getLast();
		TUSTextureEffect *getByIndex(int index);
		TUSTextureEffect *getItem(TextureUnitState::TextureEffectType key);
	};
}


//  const UVWAddressingMode& getTextureAddressingMode(void) const;
//  void setTextureAddressingMode( const UVWAddressingMode& uvw);
//   typedef std::multimap<TextureEffectType, TextureEffect> EffectMap;
//   const EffectMap& getEffects(void) const;
//  void addEffect(TextureEffect& effect);
%extend Ogre::TextureUnitState {
	Ogre::TUSUVWAddressingMode * GetTextureAddressingMode()
	{
		Ogre::TUSUVWAddressingMode *p=0;
		p = new Ogre::TUSUVWAddressingMode( (Ogre::TextureUnitState::UVWAddressingMode*)&self->getTextureAddressingMode() );
		return p;
	}
	
	void SetTextureAddressingMode(Ogre::TUSUVWAddressingMode * uvw )
	{
		self->setTextureAddressingMode( *uvw->get_mObj() );
	}
	
	Ogre::TUSTextureEffectMap * GetEffects()
	{
		Ogre::TUSTextureEffectMap *p=0;
		p = new Ogre::TUSTextureEffectMap( (Ogre::TextureUnitState::EffectMap*)&self->getEffects() );
		return p;
	}
	
	void AddEffect(Ogre::TUSTextureEffect * ppe)
	{
		Ogre::TextureUnitState::TextureEffect *p = ppe->get_mObj();
		if (p != 0)
			self->addEffect( *p );
	}
};


