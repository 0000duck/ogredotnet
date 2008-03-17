%{
#include "OgrePlane.h"
%}

#ifndef PYOGRE_ALLOW_WARNINGS
%warnfilter(503) Ogre::Plane;
#endif

//%apply Ogre::Vector3 *VECTOR3PTRIN {Ogre::Vector3 *normal};

%rename Ogre::Plane::getSide     GetSide;
%rename Ogre::Plane::getDistance GetDistance;
%rename Ogre::Plane::redefine    Redefine;
%rename Ogre::Plane::normal      Normal;
%rename Ogre::Plane::d           D;

%extend Ogre::Plane
{
    Plane(Real x, Real y, Real z, Real d);
};

%{
    inline Ogre::Plane *new_Ogre_Plane(Ogre::Real x, Ogre::Real y, Ogre::Real z, Ogre::Real d)
    {
        return new Ogre::Plane(Ogre::Vector3(x,y,z), d);
    }
%}

%include "OgrePlane.h"
//%clear Ogre::Vector3 *normal;
