%{
#include "OgreMatrix4.h"
%}

%ignore Ogre::Matrix4::operator=;

%typemap(cscode) Ogre::Matrix4 %{
    public static Math3D.Matrix4 ToMatrix4(OgreMatrix4 m)
    {
        Math3D.Matrix4 mat = Math3D.Matrix4.Identity;
            
        OgreVector4 v = m.GetRow(0);
        mat.m00 = v.x;
        mat.m01 = v.y;
        mat.m02 = v.z;
        mat.m03 = v.w;

        v = m.GetRow(1);
        mat.m10 = v.x;
        mat.m11 = v.y;
        mat.m12 = v.z;
        mat.m13 = v.w;

        v = m.GetRow(2);
        mat.m20 = v.x;
        mat.m21 = v.y;
        mat.m22 = v.z;
        mat.m23 = v.w;

        v = m.GetRow(3);
        mat.m30 = v.x;
        mat.m31 = v.y;
        mat.m32 = v.z;
        mat.m33 = v.w;
            
        return mat;
    }

    public static OgreMatrix4 FromMatrix4(Math3D.Matrix4 mat)
    {
        return new OgreMatrix4(mat.m00, mat.m01, mat.m02, mat.m03, mat.m10, mat.m11, mat.m12, mat.m13,
                               mat.m20, mat.m21, mat.m22, mat.m23, mat.m30, mat.m31, mat.m32, mat.m33);
    }
%}

%extend Ogre::Matrix4
{
    inline Ogre::Vector4 * GetRow(int row)
    {
        return new Ogre::Vector4(self->operator[](row));
    }
}

%rename Matrix4 OgreMatrix4;

%typemap(cstype)   const Ogre::Matrix4 &  "Math3D.Matrix4"
%typemap(csin)     const Ogre::Matrix4 &  "OgreMatrix4.getCPtr(OgreMatrix4.FromMatrix4($csinput))"
%typemap(csout)    const Ogre::Matrix4 &
{
    return OgreMatrix4.ToMatrix4(new OgreMatrix4($imcall, false));
}
%typemap(csvarout) const Ogre::Matrix4 &
%{
get
{
    return OgreMatrix4.ToMatrix4(new OgreMatrix4($imcall, false));
}
%}

%typemap(cstype)   const Ogre::Matrix4 *,  Ogre::Matrix4 *  "Math3D.Matrix4"
%typemap(csin)     const Ogre::Matrix4 *,  Ogre::Matrix4 *  "OgreMatrix4.getCPtr(OgreMatrix4.FromMatrix4($csinput))"
%typemap(csout)    const Ogre::Matrix4 *,  Ogre::Matrix4 *  
{
    return OgreMatrix4.ToMatrix4(new OgreMatrix4($imcall, false));
}
%typemap(csvarout) const Ogre::Matrix4 *,  Ogre::Matrix4 * 
%{
get
{
    return OgreMatrix4.ToMatrix4(new OgreMatrix4($imcall, false));
}
%}

%typemap(cstype)   Ogre::Matrix4  "Math3D.Matrix4"
%typemap(csin)     Ogre::Matrix4  "OgreMatrix4.getCPtr(OgreMatrix4.FromMatrix4($csinput))"
%typemap(csout)    Ogre::Matrix4
{
    return OgreMatrix4.ToMatrix4(new OgreMatrix4($imcall, false));
}
%typemap(csvarout) Ogre::Matrix4
%{
get
{
    return OgreMatrix4.ToMatrix4(new OgreMatrix4($imcall, false));
}
%}

%include "OgreMatrix4.h"
