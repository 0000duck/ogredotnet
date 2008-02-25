%{
#include "OgreParticleSystemRenderer.h"
%}

%ignore Ogre::ParticleSystemRenderer::_updateRenderQueue;

%ignore Ogre::ParticleSystemRendererFactory;
//%template(SharedParticleSystemRendererFactoryPtr) Ogre::FactoryObj<Ogre::ParticleSystemRendererFactory>;

%include OgreParticleSystemRenderer.h
