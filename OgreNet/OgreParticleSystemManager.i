%{
#include <OgreParticleSystemManager.h>
%}

//%rename Ogre::ParticleSystemManager::addEmitterFactory          AddEmitterFactory;
//%rename Ogre::ParticleSystemManager::addAffectorFactory         AddAffectorFactory;
//%rename Ogre::ParticleSystemManager::addRendererFactory         AddRendererFactory;
%rename Ogre::ParticleSystemManager::addTemplate                AddTemplate;
%rename Ogre::ParticleSystemManager::createTemplate             CreateTemplate;
%rename Ogre::ParticleSystemManager::getTemplate                GetTemplate;
%rename Ogre::ParticleSystemManager::createSystem               CreateSystem;
%rename Ogre::ParticleSystemManager::destroySystem              DestroySystem;
%rename Ogre::ParticleSystemManager::getSystem                  GetSystem;
%rename Ogre::ParticleSystemManager::getScriptPatterns          GetScriptPatterns;
%rename Ogre::ParticleSystemManager::parseScript                ParseScript;
%rename Ogre::ParticleSystemManager::getLoadingOrder            GetLoadingOrder;
//%rename Ogre::ParticleSystemManager::getAffectorFactoryIterator GetAffectorFactoryIterator;
//%rename Ogre::ParticleSystemManager::getEmitterFactoryIterator  GetEmitterFactoryIterator;
//%rename Ogre::ParticleSystemManager::getRendererFactoryIterator GetRendererFactoryIterator;
%rename Ogre::ParticleSystemManager::getTimeFactor              GetTimeFactor;
%rename Ogre::ParticleSystemManager::setTimeFactor              SetTimeFactor;
%rename Ogre::ParticleSystemManager::getTemplateIterator        GetTemplateIterator;
%rename Ogre::ParticleSystemManager::getSingleton               GetSingleton;
%rename Ogre::ParticleSystemManager::getSingletonPtr            GetSingletonPtr;


%ignore Ogre::ParticleSystemManager::frameStarted;
%ignore Ogre::ParticleSystemManager::frameEnded;


//TODO FactoryObj, ignoring these untill we can deal with FactoryObj
%ignore Ogre::ParticleSystemManager::ParticleAffectorFactoryMap;
%ignore Ogre::ParticleSystemManager::ParticleEmitterFactoryMap;
%ignore Ogre::ParticleSystemManager::ParticleSystemRendererFactoryMap;
%ignore Ogre::ParticleSystemManager::addEmitterFactory;
%ignore Ogre::ParticleSystemManager::addAffectorFactory;
%ignore Ogre::ParticleSystemManager::addRendererFactory;
%ignore Ogre::ParticleSystemManager::ParticleAffectorFactoryIterator;
%ignore Ogre::ParticleSystemManager::ParticleEmitterFactoryIterator;
%ignore Ogre::ParticleSystemManager::ParticleRendererFactoryIterator;
%ignore Ogre::ParticleSystemManager::getAffectorFactoryIterator;
%ignore Ogre::ParticleSystemManager::getEmitterFactoryIterator;
%ignore Ogre::ParticleSystemManager::getRendererFactoryIterator;



%typemap(cscode) Ogre::ParticleSystemManager
%{
	public static ParticleSystemManager Instance
	{
		get
		{
			return new ParticleSystemManager(OgreBindingsPINVOKE.ParticleSystemManager_GetSingleton(), false);
		}
	}
%}

%include "OgreParticleSystemManager.h"


//typedef std::map<String, ParticleSystem*> ParticleTemplateMap;
//typedef MapIterator<ParticleTemplateMap> ParticleSystemTemplateIterator;
MapIteratorWRAP(ParticleSystemTemplateIteratorWrap, std::map, std::string, Ogre::ParticleSystem*);


//typedef std::map<String, ParticleAffectorFactory*> ParticleAffectorFactoryMap;
//typedef MapIterator<ParticleAffectorFactoryMap> ParticleAffectorFactoryIterator;
//typedef std::map<String, ParticleEmitterFactory*> ParticleEmitterFactoryMap;
//typedef MapIterator<ParticleEmitterFactoryMap> ParticleEmitterFactoryIterator;
//typedef std::map<String, ParticleSystemRendererFactory*> ParticleSystemRendererFactoryMap;
//typedef MapIterator<ParticleSystemRendererFactoryMap> ParticleRendererFactoryIterator;

