%{
#include "OgreMovablePlane.h"
%}

//single inheritance problem.
%ignore Ogre::MovablePlane::_notifyCurrentCamera;
%ignore Ogre::MovablePlane::getBoundingBox;
%ignore Ogre::MovablePlane::getBoundingRadius;
%ignore Ogre::MovablePlane::_updateRenderQueue;
%ignore Ogre::MovablePlane::getMovableType;

%typemap(cscode) MovablePlane
%{
    static public MovablePlane FromMovableObject(MovableObject obj)
    {
        MovablePlane r = new MovablePlane(MovableObject.getCPtr(obj).Handle , false);
        return r;
    }
    static public MovablePlane FromPlane(Plane obj)
    {
        MovablePlane r = new MovablePlane(Plane.getCPtr(obj).Handle , false);
        return r;
    }
%}

%include "OgreMovablePlane.h"

%extend Ogre::MovablePlane {
    MovableObject * GetAsMovableObject()    {
        return (MovableObject*)self;
    }
};
