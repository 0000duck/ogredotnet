%{
#include "OgreParticleEmitterFactory.h"
%}

%template(SharedParticleEmitterFactoryPtr) Ogre::FactoryObj<Ogre::ParticleEmitterFactory>;

%include OgreParticleEmitterFactory.h
