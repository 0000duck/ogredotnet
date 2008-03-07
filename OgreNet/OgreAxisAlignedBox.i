%{
#include "OgreAxisAlignedBox.h"
%}

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
