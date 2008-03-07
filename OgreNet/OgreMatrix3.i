%{
#include "OgreMatrix3.h"
%}

%ignore Ogre::Matrix3::operator=;
%ignore Ogre::Matrix3::Matrix3(const Real arr[3][3]);
%ignore Ogre::Matrix3::EigenSolveSymmetric;

%typemap(cscode) Ogre::Matrix3 %{
    public static Math3D.Matrix3 ToMatrix3(OgreMatrix3 m)
    {
        Math3D.Matrix3 mat = Math3D.Matrix3.Identity;
            
        OgreVector3 v = m.GetRow(0);
        mat.m00 = v.x;
        mat.m01 = v.y;
        mat.m02 = v.z;

        v = m.GetRow(1);
        mat.m10 = v.x;
        mat.m11 = v.y;
        mat.m12 = v.z;

        v = m.GetRow(2);
        mat.m20 = v.x;
        mat.m21 = v.y;
        mat.m22 = v.z;
            
        return mat;
    }

    public static OgreMatrix3 FromMatrix3(Math3D.Matrix3 mat)
    {
        return new OgreMatrix3(mat.m00, mat.m01, mat.m02, mat.m10, mat.m11, mat.m12, mat.m20, mat.m21,
                               mat.m22);
    }
%}

%extend Ogre::Matrix3
{
    inline Ogre::Vector3 * GetRow(int row)
    {
        return new Ogre::Vector3(self->operator[](row));
    }
}

%rename Matrix3 OgreMatrix3;

%typemap(cstype) const Ogre::Matrix3 & "Math3D.Matrix3"
%typemap(csin) const Ogre::Matrix3 & "OgreMatrix3.getCPtr(OgreMatrix3.FromMatrix3($csinput))"
%typemap(csout) const Ogre::Matrix3 &
{
    return OgreMatrix3.ToMatrix3(new OgreMatrix3($imcall, false));
}
%typemap(csvarout) const Ogre::Matrix3 &
%{
get
{
    return OgreMatrix3.ToMatrix3(new OgreMatrix3($imcall, false));
}
%}

%typemap(cstype) const Ogre::Matrix3 * "Math3D.Matrix3"
%typemap(csin) const Ogre::Matrix3 * "OgreMatrix3.getCPtr(OgreMatrix3.FromMatrix3($csinput))"
%typemap(csout) const Ogre::Matrix3 *
{
    return OgreMatrix3.ToMatrix3(new OgreMatrix3($imcall, false));
}
%typemap(csvarout) const Ogre::Matrix3 *
%{
get
{
    return OgreMatrix3.ToMatrix3(new OgreMatrix3($imcall, false));
}
%}

%typemap(cstype) Ogre::Matrix3 "Math3D.Matrix3"
%typemap(csin) Ogre::Matrix3 "OgreMatrix3.getCPtr(OgreMatrix3.FromMatrix3($csinput))"
%typemap(csout) Ogre::Matrix3
{
    return OgreMatrix3.ToMatrix3(new OgreMatrix3($imcall, false));
}
%typemap(csvarout) Ogre::Matrix3
%{
get
{
    return OgreMatrix3.ToMatrix3(new OgreMatrix3($imcall, false));
}
%}

%include "OgreMatrix3.h"
