%{
#include "OgreVector2.h"
%}

%rename Vector2 OgreVector2;
%ignore Ogre::Vector2::Vector2(const Real afCoordinate[2]);
%ignore Ogre::Vector2::Vector2(const int afCoordinate[2]);
%ignore Ogre::Vector2::Vector2(Real* const r);

%extend Ogre::Vector2
{
    inline float getX(void)
    {
        return self->x;
    }
    inline void setX(float X)
    {
        self->x = X;
    }
    
    inline float getY(void)
    {
        return self->y;
    }
    inline void setY(float Y)
    {
        self->y = Y;
    }
    
    static Vector2 Multiply(Vector2 * v1, Vector2 * v2)
    {
        return *v1 * *v2;
    }
    
    static Vector2 Add(Vector2 * v1, Vector2 * v2)
    {
        return *v1 + *v2;
    }
    
    static Vector2 Subtract(Vector2 * v1, Vector2 * v2)
    {
        return *v1 - *v2;
    }
    
    static bool Equals(Vector2 * v1, Vector2 * v2)
    {
        return (*v1 == *v2);
    }
}

%typemap(cscode) Ogre::Vector2 %{
    public float X
    {
        get
        {
            return getX();
        }
        set
        {
            setX(value);
        }
    }
    
    public float Y
    {
        get
        {
            return getY();
        }
        set
        {
            setY(value);
        }
    }
    
    public static Math3D.Vector2 ToVector2(OgreDotNet.OgreVector2 v)
    {
        return new Math3D.Vector2(v.x, v.y);
    }
    
    public static OgreDotNet.OgreVector2 FromVector2(Math3D.Vector2 v)
    {
        return new OgreDotNet.OgreVector2(v.x, v.y);
    }
%}

%ignore Ogre::Vector2::isZeroLength;
%ignore Ogre::Vector2::operator=;
%ignore Ogre::Vector2::operator[];

%ignore Ogre::Vector2::isZeroLength;
%ignore Ogre::Vector2::operator=;
%ignore Ogre::Vector2::operator[];

%typemap(cstype) const Ogre::Vector2 & "Math3D.Vector2"
%typemap(csin) const Ogre::Vector2 & "OgreVector2.getCPtr(OgreVector2.FromVector2($csinput))"
%typemap(csout) const Ogre::Vector2 &
{
    return OgreVector2.ToVector2(new OgreVector2($imcall, false));
}

%typemap(cstype) Ogre::Vector2 "Math3D.Vector2"
%typemap(csin) Ogre::Vector2 "OgreVector2.getCPtr(OgreVector2.FromVector2($csinput))"
%typemap(csout) Ogre::Vector2
{
    return OgreVector2.ToVector2(new OgreVector2($imcall, false));
}
    
%include "OgreVector2.h"
