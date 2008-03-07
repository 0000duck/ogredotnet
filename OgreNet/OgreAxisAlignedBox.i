%{
#include "OgreAxisAlignedBox.h"
%}

%typemap(cscode) Ogre::AxisAlignedBox
%{
    public Math3D.Vector3 Minimum
    {
        get
        {
            return getMinimum();
        }
    }  

    public Math3D.Vector3 Maximum
    {
        get
        {
            return getMaximum();
        }
    }
%}

// use __nonzero__ instead:
%ignore Ogre::AxisAlignedBox::isNull;

%include "OgreAxisAlignedBox.h"
