%{
#include "OgreParticleAffectorFactory.h"
%}

%template(SharedParticleAffectorFactoryPtr) Ogre::FactoryObj<Ogre::ParticleAffectorFactory>;

%include OgreParticleAffectorFactory.h
