%{
#include "OgreQuaternion.h"
%}

%ignore Ogre::Quaternion::Quaternion(Real* valptr);
%ignore Ogre::Quaternion::operator=;
%ignore Ogre::Quaternion::randomDeviant;


%typemap(cscode) Ogre::Quaternion %{

	public float w {
		get { return getW(); }
		set { setW( value ); }
	}

	public float x {
		get { return getX(); }
		set { setX( value ); }
	}

	public float y { 
		get { return getY(); }
		set { setY( value ); }
	}

	public float z {
		get { return getZ(); }
		set { setZ( value ); }
	}

	public static Math3D.Quaternion ToQuaternion( OgreDotNet.OgreQuaternion v )
	{
		return new Math3D.Quaternion(v.w, v.x, v.y, v.z);
	}
	
	public static OgreDotNet.OgreQuaternion FromQuaternion( Math3D.Quaternion v )
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


%extend Ogre::Quaternion
{
	inline float getW( void )
	{
		return self->w;
	}
	inline void setW( float W )
	{
		self->w = W;
	}

	inline float getX( void )
	{
		return self->x;
	}
	inline void setX( float X )
	{
		self->x = X;
	}
	
	inline float getY( void )
	{
		return self->y;
	}
	inline void setY( float Y )
	{
		self->y = Y;
	}
	
	inline float getZ( void )
	{
		return self->z;
	}
	inline void setZ( float Z )
	{
		self->z = Z;
	}
}



%include "OgreQuaternion.h"



