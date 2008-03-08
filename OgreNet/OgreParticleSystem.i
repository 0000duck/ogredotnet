%{
#include "OgreParticleSystem.h"
%}

%typemap(cscode) Ogre::ParticleSystem
%{
    public string MaterialName    {
        get { return getMaterialName(); }
        set { setMaterialName(value); }
    }
%}

%include "OgreParticleSystem.h"

%extend Ogre::ParticleSystem {
    MovableObject * GetAsMovableObject()    {
        return (MovableObject*)self;
    }
};
