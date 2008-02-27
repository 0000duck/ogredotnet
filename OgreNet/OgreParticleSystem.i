%{
#include "OgreParticleSystem.h"
%}

%rename Ogre::ParticleSystem::setDefaultDimensions SetDefaultDimensions;
%rename Ogre::ParticleSystem::addEmitter AddEmitter;
%rename Ogre::ParticleSystem::setRenderer          SetRenderer;
%rename Ogre::ParticleSystem::getRenderer          GetRenderer;
%rename Ogre::ParticleSystem::getRendererName      GetRendererName;
%rename Ogre::ParticleSystem::getEmitter           GetEmitter;
%rename Ogre::ParticleSystem::getNumEmitters       GetNumEmitters;
%rename Ogre::ParticleSystem::removeEmitter        RemoveEmitter;
%rename Ogre::ParticleSystem::addAffector          AddAffector;
%rename Ogre::ParticleSystem::getAffector          GetAffector;
%rename Ogre::ParticleSystem::getNumAffectors      GetNumAffectors;
%rename Ogre::ParticleSystem::removeAffector       RemoveAffector;
%rename Ogre::ParticleSystem::removeAllAffectors   RemoveAllAffectors;
%rename Ogre::ParticleSystem::clear                Clear;
%rename Ogre::ParticleSystem::getNumParticles      GetNumParticles;
%rename Ogre::ParticleSystem::createParticle       CreateParticle;
%rename Ogre::ParticleSystem::getParticle          GetParticle;
%rename Ogre::ParticleSystem::getParticleQuota     GetParticleQuota;
%rename Ogre::ParticleSystem::setParticleQuota     SetParticleQuota;
%rename Ogre::ParticleSystem::setMaterialName      SetMaterialName;
%rename Ogre::ParticleSystem::getMaterialName      GetMaterialName;
%rename Ogre::ParticleSystem::getBoundingRadius    GetBoundingRadius;
%rename Ogre::ParticleSystem::getBoundingBox       GetBoundingBox;
%rename Ogre::ParticleSystem::fastForward          FastForward;
%rename Ogre::ParticleSystem::setSpeedFactor       SetSpeedFactor;
%rename Ogre::ParticleSystem::getSpeedFactor       GetSpeedFactor;
%rename Ogre::ParticleSystem::getMovableType       GetMovableType;
%rename Ogre::ParticleSystem::setDefaultWidth      SetDefaultWidth;
%rename Ogre::ParticleSystem::getDefaultWidth      GetDefaultWidth;
%rename Ogre::ParticleSystem::setDefaultHeight     SetDefaultHeight;
%rename Ogre::ParticleSystem::getDefaultHeight     GetDefaultHeight;
%rename Ogre::ParticleSystem::getCullIndividually  GetCullIndividually;
%rename Ogre::ParticleSystem::setCullIndividually  SetCullIndividually;
%rename Ogre::ParticleSystem::getResourceGroupName GetResourceGroupName;
%rename Ogre::ParticleSystem::getOrigin            GetOrigin;
%rename Ogre::ParticleSystem::setRenderQueueGroup  SetRenderQueueGroup;
%rename Ogre::ParticleSystem::setBounds            SetBounds;
%rename Ogre::ParticleSystem::setBoundsAutoUpdated SetBoundsAutoUpdated;


%typemap(cscode) Ogre::ParticleSystem
%{
    public string MaterialName    {
        get { return GetMaterialName(); }
        set { SetMaterialName(value); }
    }

%}



%include "OgreParticleSystem.h"


%extend Ogre::ParticleSystem {
    MovableObject * GetAsMovableObject()    {
        return (MovableObject*)self;
    }
};


