%{
#include "OgreAxisAlignedBox.h"
%}

%ignore Ogre::AxisAlignedBox::getMinimum();
%ignore Ogre::AxisAlignedBox::getMaximum();

%rename Ogre::AxisAlignedBox::getAllCorners GetAllCorners;
%rename Ogre::AxisAlignedBox::merge Merge;
%rename Ogre::AxisAlignedBox::transform Transform;
%rename Ogre::AxisAlignedBox::setNull SetNull;
%rename Ogre::AxisAlignedBox::intersects Intersects;
%rename Ogre::AxisAlignedBox::intersection Intersection;
%rename Ogre::AxisAlignedBox::volume Volume;
%rename Ogre::AxisAlignedBox::scale Scale;
%rename Ogre::AxisAlignedBox::getCenter GetCenter;
%rename Ogre::AxisAlignedBox::getMinimum GetMinimum;
%rename Ogre::AxisAlignedBox::getMaximum GetMaximum;
%rename Ogre::AxisAlignedBox::setMinimum SetMinimum;
%rename Ogre::AxisAlignedBox::setMaximum SetMaximum;
%rename Ogre::AxisAlignedBox::setExtents SetExtents;

%typemap(cscode) Ogre::AxisAlignedBox
%{
    public Math3D.Vector3 Minimum
    {
        get
        {
            return GetMinimum();
        }
    }  

    public Math3D.Vector3 Maximum
    {
        get
        {
            return GetMaximum();
        }
    }
%}

// use __nonzero__ instead:
%ignore Ogre::AxisAlignedBox::isNull;

%include "OgreAxisAlignedBox.h"
