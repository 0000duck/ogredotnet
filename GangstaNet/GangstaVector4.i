//Gangsta does not have a GaVec4 but we need one for Mat4x4::getRow
// that we will create. so lets create one in GangstaDotNet
%{
namespace Ga {
	class GaVec4
	{
	public:
		float x,y,z,w;
		GaVec4() { x=0.0f; y=0.0f; z=0.0f; w=0.0f; }
		GaVec4(GaFloat _x, GaFloat _y, GaFloat _z, GaFloat _w)
		{ x=_x; y=_y; z=_z; w=_w; }
		GaVec4( const GaFloat *v )	//GangstaDotNet does not need to see this 
		{
			x=v[0];
			y=v[1];
			z=v[2];
			w=v[3];
		}
	};
}
%}


%typemap(cscode) Ga::GaVec4 %{
	public static Math3D.Vector4 ToVector4( GangstaDotNet.GaVec4 v )
	{
		return new Math3D.Vector4(v.x, v.y, v.z, v.w);
	}
	
	public static GangstaDotNet.GaVec4 FromVector4( Math3D.Vector4 v )
	{
		return new GangstaDotNet.GaVec4(v.x, v.y, v.z, v.w);
	}
%}





//const ref
%typemap(cstype) const Ga::GaVec4 & "Math3D.Vector4"
%typemap(csin) const Ga::GaVec4 & "GaVec4.getCPtr(GaVec4.FromVector4($csinput))"
%typemap(csout) const Ga::GaVec4 &
{
	return GaVec4.ToVector4(new GaVec4($imcall, false));
}
%typemap(csvarout) const Ga::GaVec4 &
%{
get
{
	return GaVec4.ToVector4(new GaVec4($imcall, false));
}
%}
%typemap(out) const Ga::GaVec4 & %{ $result = (void *)$1; %}



//ref
%typemap(cstype) Ga::GaVec4 & "Math3D.Vector4"
%typemap(csin) Ga::GaVec4 & "GaVec4.getCPtr(GaVec4.FromVector4($csinput))"
%typemap(csout) Ga::GaVec4 &
{
	return GaVec4.ToVector4(new GaVec4($imcall, false));
}
%typemap(csvarout) Ga::GaVec4 &
%{
get
{
	return GaVec4.ToVector4(new GaVec4($imcall, false));
}
%}
%typemap(out) Ga::GaVec4 & %{ $result = (void *)$1; %}



//const ptr
%typemap(cstype) const Ga::GaVec4 * "Math3D.Vector4"
%typemap(csin) const Ga::GaVec4 * "GaVec4.getCPtr(GaVec4.FromVector4($csinput))"
%typemap(csout) const Ga::GaVec4 *
{
	return GaVec4.ToVector4(new GaVec4($imcall, false));
}
%typemap(csvarout) const Ga::GaVec4 *
%{
get
{
	return GaVec4.ToVector4(new GaVec4($imcall, false));
}
%}
%typemap(out) const Ga::GaVec4 * %{ $result = (void *)$1; %}



//defualt
%typemap(cstype) Ga::GaVec4 "Math3D.Vector4"
%typemap(csin) Ga::GaVec4 "GaVec4.getCPtr(GaVec4.FromVector4($csinput))"
%typemap(csout) Ga::GaVec4
{
	return GaVec4.ToVector4(new GaVec4($imcall, false));
}
%typemap(csvarout) Ga::GaVec4
%{
get
{
	return GaVec4.ToVector4(new GaVec4($imcall, false));
}
%}
%typemap(out) Ga::GaVec4 %{ $result = (void *)&$1; %}



namespace Ga {
	class GaVec4
	{
	public:
		float x,y,z,w;
		GaVec4();
		GaVec4(GaFloat _x, GaFloat _y, GaFloat _z, GaFloat _w);
	};
}
