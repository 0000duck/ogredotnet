%{
#include "OgreRay.h"
%}

%extend Ogre::Ray
{
    Ray(const Ray &copy);
};

%{
    inline Ogre::Ray *new_Ogre_Ray(const Ogre::Ray &copy)
    {
        return new Ogre::Ray(copy.getOrigin(), copy.getDirection());
    }
%}

%include "OgreRay.h"
