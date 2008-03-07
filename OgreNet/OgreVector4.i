%{
#include "OgreVector4.h"
%}

%rename Vector4 OgreVector4;
%ignore Ogre::Vector4::Vector4(const Real afCoordinate[4]);
%ignore Ogre::Vector4::Vector4(const int afCoordinate[4]);
%ignore Ogre::Vector4::Vector4(Real* const r);

%extend Ogre::Vector4
{
    static Vector4 Multiply(Vector4 * v1, Vector4 * v2)
    {
        return *v1 * *v2;
    }
    
    static Vector4 Divide(Vector4 * v1, Vector4 * v2)
    {
        return *v1 / *v2;
    }
    
    static Vector4 Add(Vector4 * v1, Vector4 * v2)
    {
        return *v1 + *v2;
    }
    
    static Vector4 Subtract(Vector4 * v1, Vector4 * v2)
    {
        return *v1 - *v2;
    }
    
    static bool Equals(Vector4 * v1, Vector4 * v2)
    {
        return (*v1 == *v2);
    }
}

%typemap(cscode) Ogre::Vector4 %{
    public static Math3D.Vector4 ToVector4(OgreDotNet.OgreVector4 v)
    {
        return new Math3D.Vector4(v.x, v.y, v.z, v.w);
    }
    
    public static OgreDotNet.OgreVector4 FromVector4(Math3D.Vector4 v)
    {
        return new OgreDotNet.OgreVector4(v.x, v.y, v.z, v.w);
    }
%}

%ignore Ogre::Vector4::isZeroLength;
%ignore Ogre::Vector4::operator=;
%ignore Ogre::Vector4::operator[];

%typemap(cstype) const Ogre::Vector4 & "Math3D.Vector4"
%typemap(csin) const Ogre::Vector4 & "OgreVector4.getCPtr(OgreVector4.FromVector4($csinput))"
%typemap(csout) const Ogre::Vector4 &
{
    return OgreVector4.ToVector4(new OgreVector4($imcall, false));
}
%typemap(csvarout) const Ogre::Vector4 &
%{
get
{
    return OgreVector4.ToVector4(new OgreVector4($imcall, false));
}
%}

%typemap(cstype) Ogre::Vector4 "Math3D.Vector4"
%typemap(csin) Ogre::Vector4 "OgreVector4.getCPtr(OgreVector4.FromVector4($csinput))"
%typemap(csout) Ogre::Vector4
{
    return OgreVector4.ToVector4(new OgreVector4($imcall, false));
}

%include "OgreVector4.h"
