//TextureUnitState.h
#ifndef __TextureUnitState_H_
#define __TextureUnitState_H_

namespace Ogre
{
	
	//----------------------------------------------------------------
	// custom code to handle TextureUnitState::TextureEffect
	class TUSUVWAddressingMode {
	protected:
		TextureUnitState::UVWAddressingMode *mObj;
		bool mICreated;
	public:
		TUSUVWAddressingMode()	{ mObj = new TextureUnitState::UVWAddressingMode();		mICreated=true;		}
		TUSUVWAddressingMode(TextureUnitState::UVWAddressingMode *p)	{ mObj=p;			mICreated=false;	}
		
		~TUSUVWAddressingMode()	{	if (mICreated==true) delete mObj;	}
		
		TextureUnitState::UVWAddressingMode * get_mObj()
			{	return mObj; }
		
		
		TextureUnitState::TextureAddressingMode getU()
		{   if (mObj!=0) return mObj->u;    else return TextureUnitState::TAM_WRAP;   }
		void setU(TextureUnitState::TextureAddressingMode value)
		{   if (mObj!=0) mObj->u = value;   }
		
		TextureUnitState::TextureAddressingMode getV()
		{   if (mObj!=0) return mObj->v;    else return TextureUnitState::TAM_WRAP;   }
		void setV(TextureUnitState::TextureAddressingMode value)
		{   if (mObj!=0) mObj->v = value;   }
		
		TextureUnitState::TextureAddressingMode getW()
		{   if (mObj!=0) return mObj->w;    else return TextureUnitState::TAM_WRAP;   }
		void setW(TextureUnitState::TextureAddressingMode value)
		{   if (mObj!=0) mObj->w = value;   }
		
	};
	
	
	
	//----------------------------------------------------------------
	// custom code to handle TextureUnitState::TextureEffect
	class TUSTextureEffect {
	protected:
		TextureUnitState::TextureEffect *mObj;
		bool mICreated;
	public:
		TUSTextureEffect()	{ mObj = new TextureUnitState::TextureEffect();		mICreated=true;		}
		TUSTextureEffect(TextureUnitState::TextureEffect *p)	{ mObj=p;			mICreated=false;	}
		
		~TUSTextureEffect()	{	if (mICreated==true) delete mObj;	}
		
		TextureUnitState::TextureEffect * get_mObj()
			{	return mObj; }
		
		
		TextureUnitState::TextureEffectType getType()
			{ if (mObj!=0) return mObj->type; else return TextureUnitState::ET_ENVIRONMENT_MAP; }
		void setType(TextureUnitState::TextureEffectType value)
			{ if (mObj!=0) mObj->type = value; }
		
		int getSubtype()
			{ if (mObj!=0) return mObj->subtype; else return 0; }
		void setSubtype(int value)
			{ if (mObj!=0) mObj->subtype = value; }
		
		Real getArg1()
			{ if (mObj!=0) return mObj->arg1; else return 0; }
		void setArg1(Real value)
			{ if (mObj!=0) mObj->arg1 = value; }
		
		Real getArg2()
			{ if (mObj!=0) return mObj->arg2; else return 0; }
		void setArg2(Real value)
			{ if (mObj!=0) mObj->arg2 = value; }
		
		WaveformType getWaveType()
			{ if (mObj!=0) return mObj->waveType; else return WFT_SINE; }
		void setWaveType(WaveformType value)
			{ if (mObj!=0) mObj->waveType = value; }
		
		Real getBase()
			{ if (mObj!=0) return mObj->base; else return 0; }
		void setBase(Real value)
			{ if (mObj!=0) mObj->base = value; }
		
		Real getFrequency()
			{ if (mObj!=0) return mObj->frequency; else return 0; }
		void setFrequency(Real value)
			{ if (mObj!=0) mObj->frequency = value; }
		
		Real getPhase()
			{ if (mObj!=0) return mObj->phase; else return 0; }
		void setPhase(Real value)
			{ if (mObj!=0) mObj->phase = value; }
		
		Real getAmplitude()
			{ if (mObj!=0) return mObj->amplitude; else return 0; }
		void setAmplitude(Real value)
			{ if (mObj!=0) mObj->amplitude = value; }
		
		
		Controller<Real>* getController()
			{ if (mObj!=0) return mObj->controller; else return 0; }
		void setController(Controller<Real>* value)
			{ if (mObj!=0) mObj->controller = value; }
		
		const Frustum* getFrustum()
			{ if (mObj!=0) return mObj->frustum; else return 0; }
		void setFrustum(const Frustum* value)
			{ if (mObj!=0) mObj->frustum = value; }
		
	};
	
	
	class TUSTextureEffectMap {
	protected:
		//   typedef std::multimap<TextureEffectType, TextureEffect> EffectMap;
		TextureUnitState::EffectMap  *mObj;
	public:
		TUSTextureEffectMap() { mObj=0; }
		TUSTextureEffectMap( TextureUnitState::EffectMap *p)   { mObj=p; }
		
		size_t size()
		{	if (mObj==0)	return 0;
			return mObj->size();
		}
		
		TUSTextureEffect *getFirst()
		{	if (mObj==0)	return 0;
			TextureUnitState::EffectMap::iterator it =mObj->begin();
			if (it == mObj->end())			return 0;
			else							return new TUSTextureEffect( (TextureUnitState::TextureEffect*)&it->second );
		}
		
		TUSTextureEffect *getLast()
		{	if (mObj==0)	return 0;
			TextureUnitState::EffectMap::reverse_iterator rit =mObj->rbegin();
			if (rit == mObj->rend())			return 0;
			else							return new TUSTextureEffect( (TextureUnitState::TextureEffect*)&rit->second );
		}
		
		TUSTextureEffect *getByIndex(int index)
		{	if (mObj==0)	return 0;
			TextureUnitState::EffectMap::iterator it =mObj->begin();
			if (it == mObj->end())
				return 0;
			std::advance(it, index);
			if (it == mObj->end())
				return 0;
			else
				return new TUSTextureEffect( (TextureUnitState::TextureEffect*)&it->second );
		}
		
		
		TUSTextureEffect *getItem(TextureUnitState::TextureEffectType key)
		{	if (mObj==0)	return 0;
			TextureUnitState::EffectMap::iterator it =mObj->find(key);
			if (it == mObj->end())
				return 0;
			else
				return new TUSTextureEffect( (TextureUnitState::TextureEffect*)&it->second );
		}
	};
}



#endif //__TextureUnitState_H_

