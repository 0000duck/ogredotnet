
%ignore Ga::GaQuat::operator=;

%typemap(cscode) Ga::GaQuat %{
	public static Math3D.Quaternion ToQuaternion( GangstaDotNet.GaQuat v )
	{
		return new Math3D.Quaternion(v.w, v.v.x, v.v.y, v.v.z);
	}
	
	public static GangstaDotNet.GaQuat FromQuaternion( Math3D.Quaternion v )
	{
		return new GangstaDotNet.GaQuat(v.w, v.x, v.y, v.z);
	}
%}


//const ref
%typemap(cstype) const Ga::GaQuat & "Math3D.Quaternion"
%typemap(csin) const Ga::GaQuat & "GaQuat.getCPtr(GaQuat.FromQuaternion($csinput))"
%typemap(csout) const Ga::GaQuat &
{
	return GaQuat.ToQuaternion(new GaQuat($imcall, false));
}
%typemap(csvarout) const Ga::GaQuat &
%{
get
{
	return GaQuat.ToQuaternion(new GaQuat($imcall, false));
}
%}
%typemap(out) const Ga::GaQuat & %{ $result = (void *)$1; %}



//ref
%typemap(cstype) Ga::GaQuat & "Math3D.Quaternion"
%typemap(csin) Ga::GaQuat & "GaQuat.getCPtr(GaQuat.FromQuaternion($csinput))"
%typemap(csout) Ga::GaQuat &
{
	return GaQuat.ToQuaternion(new GaQuat($imcall, false));
}
%typemap(csvarout) Ga::GaQuat &
%{
get
{
	return GaQuat.ToQuaternion(new GaQuat($imcall, false));
}
%}
%typemap(out) Ga::GaQuat & %{ $result = (void *)$1; %}



//const ptr
%typemap(cstype) const Ga::GaQuat * "Math3D.Quaternion"
%typemap(csin) const Ga::GaQuat * "GaQuat.getCPtr(GaQuat.FromQuaternion($csinput))"
%typemap(csout) const Ga::GaQuat *
{
	return GaQuat.ToVector4(new GaQuat($imcall, false));
}
%typemap(csvarout) const Ga::GaQuat *
%{
get
{
	return GaQuat.ToQuaternion(new GaQuat($imcall, false));
}
%}
%typemap(out) const Ga::GaQuat * %{ $result = (void *)$1; %}



//default
%typemap(cstype) Ga::GaQuat "Math3D.Quaternion"
%typemap(csin) Ga::GaQuat "GaQuat.getCPtr(GaQuat.FromQuaternion($csinput))"
%typemap(csout) Ga::GaQuat
{
	return GaQuat.ToQuaternion(new GaQuat($imcall, false));
}
%typemap(csvarout) Ga::GaQuat
%{
get
{
	return GaQuat.ToQuaternion(new GaQuat($imcall, false));
}
%}
%typemap(out) Ga::GaQuat %{ $result = (void *)&$1; %}



