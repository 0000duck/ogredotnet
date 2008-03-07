%{
#include "OgreVector3.h"
%}

%rename Vector3 OgreVector3;

%ignore Ogre::Vector3::isZeroLength;
%ignore Ogre::Vector3::operator=;
%ignore Ogre::Vector3::operator[];
%ignore Ogre::Vector3::randomDeviant;
%ignore Ogre::Vector3::Vector3(const Real afCoordinate[3]);
%ignore Ogre::Vector3::Vector3(const int afCoordinate[3]);
%ignore Ogre::Vector3::Vector3(Real* const r);

%extend Ogre::Vector3
{
    static Vector3 Multiply(Vector3 * v1, Vector3 * v2)
    {
        return *v1 * *v2;
    }
    
    static Vector3 Divide(Vector3 * v1, Vector3 * v2)
    {
        return *v1 / *v2;
    }
    
    static Vector3 Add(Vector3 * v1, Vector3 * v2)
    {
        return *v1 + *v2;
    }
    
    static Vector3 Subtract(Vector3 * v1, Vector3 * v2)
    {
        return *v1 - *v2;
    }
    
    static bool Equals(Vector3 * v1, Vector3 * v2)
    {
        return (*v1 == *v2);
    }
}

%typemap(cscode) Ogre::Vector3 %{
    /*public Math3D.Vector3 ToMath3DVector3()
    {
        return new Math3D.Vector3(this.x, this.y, this.z);
    }
    
    public static Vector3 FromMath3DVector3(Math3D.Vector3 v)
    {
        return new Vector3(v.x, v.y, v.z);
    }*/
    
    public static Math3D.Vector3 ToVector3(OgreDotNet.OgreVector3 v)
    {
        return new Math3D.Vector3(v.x, v.y, v.z);
    }
    
    public static OgreDotNet.OgreVector3 FromVector3(Math3D.Vector3 v)
    {
        return new OgreDotNet.OgreVector3(v.x, v.y, v.z);
    }
%}

%typemap(cstype) const Ogre::Vector3 & "Math3D.Vector3"
%typemap(csin) const Ogre::Vector3 & "OgreVector3.getCPtr(OgreVector3.FromVector3($csinput))"
%typemap(csout) const Ogre::Vector3 &
{
    return OgreVector3.ToVector3(new OgreVector3($imcall, false));
}
%typemap(csvarout) const Ogre::Vector3 &
%{
get
{
    return OgreVector3.ToVector3(new OgreVector3($imcall, false));
}
%}

%typemap(cstype) const Ogre::Vector3 * "Math3D.Vector3"
%typemap(csin) const Ogre::Vector3 * "OgreVector3.getCPtr(OgreVector3.FromVector3($csinput))"
%typemap(csout) const Ogre::Vector3 *
{
    return OgreVector3.ToVector3(new OgreVector3($imcall, false));
}
%typemap(csvarout) const Ogre::Vector3 *
%{
get
{
    return OgreVector3.ToVector3(new OgreVector3($imcall, false));
}
%}

%typemap(cstype) Ogre::Vector3 "Math3D.Vector3"
%typemap(csin) Ogre::Vector3 "OgreVector3.getCPtr(OgreVector3.FromVector3($csinput))"
%typemap(csout) Ogre::Vector3
{
    return OgreVector3.ToVector3(new OgreVector3($imcall, false));
}
%typemap(csvarout) Ogre::Vector3
%{
get
{
    return OgreVector3.ToVector3(new OgreVector3($imcall, false));
}
%}

%include "OgreVector3.h"
