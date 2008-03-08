%{
#include "OgreParticleSystem.h"
%}

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
