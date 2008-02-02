
%ignore Ga::GaVec3::GaVec3(const GaFloat *v);
%ignore Ga::GaVec3::operator=;
%ignore Ga::GaVec3::operator[];

%extend Ga::GaVec3
{
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
	
	static Ga::GaVec3 Multiply( Ga::GaVec3 * v1, Ga::GaVec3 * v2 )
	{
		return *v1 * *v2;
	}
	
	static Ga::GaVec3 Add( Ga::GaVec3 * v1, Ga::GaVec3 * v2 )
	{
		return *v1 + *v2;
	}
	
	static Ga::GaVec3 Subtract( Ga::GaVec3 * v1, Ga::GaVec3 * v2 )
	{
		return *v1 - *v2;
	}
	
	static bool Equals( Ga::GaVec3 * v1, Ga::GaVec3 * v2 )
	{
		return ( *v1 == *v2 );
	}
}

%typemap(cscode) Ga::GaVec3 %{
	public float x
	{
		get
		{
			return getX();
		}
		set
		{
			setX( value );
		}
	}
	
	public float y
	{
		get
		{
			return getY();
		}
		set
		{
			setY( value );
		}
	}
	
	public float z
	{
		get
		{
			return getZ();
		}
		set
		{
			setZ( value );
		}
	}
	
	public static Math3D.Vector3 ToVector3( GangstaDotNet.GaVec3 v )
	{
		return new Math3D.Vector3(v.x, v.y, v.z);
	}
	
	public static GangstaDotNet.GaVec3 FromVector3( Math3D.Vector3 v )
	{
		return new GangstaDotNet.GaVec3(v.x, v.y, v.z);
	}
%}


//const ref
%typemap(cstype) const Ga::GaVec3 & "Math3D.Vector3"
%typemap(csin) const Ga::GaVec3 & "GaVec3.getCPtr(GaVec3.FromVector3($csinput))"
%typemap(csout) const Ga::GaVec3 &
{
	return GaVec3.ToVector3(new GaVec3($imcall, false));
}
%typemap(csvarout) const Ga::GaVec3 &
%{
get
{
	return GaVec3.ToVector3(new GaVec3($imcall, false));
}
%}
%typemap(out) const Ga::GaVec3 & %{ $result = (void *)$1; %}



//ref
%typemap(cstype) Ga::GaVec3 & "Math3D.Vector3"
%typemap(csin) Ga::GaVec3 & "GaVec3.getCPtr(GaVec3.FromVector3($csinput))"
%typemap(csout) Ga::GaVec3 &
{
	return GaVec3.ToVector3(new GaVec3($imcall, false));
}
%typemap(csvarout) Ga::GaVec3 &
%{
get
{
	return GaVec3.ToVector3(new GaVec3($imcall, false));
}
%}
%typemap(out) Ga::GaVec3 & %{ $result = (void *)$1; %}



//const ptr
%typemap(cstype) const Ga::GaVec3 * "Math3D.Vector3"
%typemap(csin) const Ga::GaVec3 * "GaVec3.getCPtr(GaVec3.FromVector3($csinput))"
%typemap(csout) const Ga::GaVec3 *
{
	return GaVec3.ToVector3(new GaVec3($imcall, false));
}
%typemap(csvarout) const Ga::GaVec3 *
%{
get
{
	return GaVec3.ToVector3(new GaVec3($imcall, false));
}
%}
%typemap(out) const Ga::GaVec3 * %{ $result = (void *)$1; %}



//default
%typemap(cstype) Ga::GaVec3 "Math3D.Vector3"
%typemap(csin) Ga::GaVec3 "GaVec3.getCPtr(GaVec3.FromVector3($csinput))"
%typemap(csout) Ga::GaVec3
{
	return GaVec3.ToVector3(new GaVec3($imcall, false));
}
%typemap(csvarout) Ga::GaVec3
%{
get
{
	return GaVec3.ToVector3(new GaVec3($imcall, false));
}
%}
%typemap(out) Ga::GaVec3 %{ $result = (void *)&$1; %}

