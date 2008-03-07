%{
#include "OgreMath.h"
%}

%ignore Ogre::Radian::operator=;
%ignore Ogre::Degree::operator=;
%rename(toRadian) Ogre::Angle::operator Ogre::Radian;
%rename(toDegree) Ogre::Angle::operator Ogre::Degree;

%rename Math OgreMath;
%ignore Ogre::OgreMath::setAngleUnit;
%ignore Ogre::OgreMath::getAngleUnit;

// static bool intersects(const Ray& ray, const AxisAlignedBox& box, Real* d1, Real* d2);
%apply float *INOUT { Ogre::Real* d1, Ogre::Real* d2 };

%include "OgreMath.h"
