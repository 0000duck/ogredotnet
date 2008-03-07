%{
#include "OgreQuaternion.h"
%}

%ignore Ogre::Quaternion::Quaternion(Real* valptr);
%ignore Ogre::Quaternion::operator=;
%ignore Ogre::Quaternion::randomDeviant;

%typemap(cscode) Ogre::Quaternion %{
    public static Math3D.Quaternion ToQuaternion(OgreDotNet.OgreQuaternion v)
    {
        return new Math3D.Quaternion(v.w, v.x, v.y, v.z);
    }
    
    public static OgreDotNet.OgreQuaternion FromQuaternion(Math3D.Quaternion v)
    {
        return new OgreDotNet.OgreQuaternion(v.w, v.x, v.y, v.z);
    }
%}

%typemap(cstype) const Ogre::Quaternion & "Math3D.Quaternion"
%typemap(csin) const Ogre::Quaternion & "OgreQuaternion.getCPtr(OgreQuaternion.FromQuaternion($csinput))"
%typemap(csout) const Ogre::Quaternion &
{
    return OgreQuaternion.ToQuaternion(new OgreQuaternion($imcall, false));
}
%typemap(csvarout) const Ogre::Quaternion &
%{
get
{
    return OgreQuaternion.ToQuaternion(new OgreQuaternion($imcall, false));
}
%}

%typemap(cstype) Ogre::Quaternion "Math3D.Quaternion"
%typemap(csin) Ogre::Quaternion "OgreQuaternion.getCPtr(OgreQuaternion.FromQuaternion($csinput))"
%typemap(csout) Ogre::Quaternion
{
    return OgreQuaternion.ToQuaternion(new OgreQuaternion($imcall, false));
}

%rename Quaternion OgreQuaternion;

%include "OgreQuaternion.h"
