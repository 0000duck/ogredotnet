
%ignore Ga::GaMat3x3::GaMat3x3(const GaFloat *v);
%ignore Ga::GaMat3x3::operator=;
%ignore Ga::GaMat3x3::operator[];
%ignore Ga::GaMat3x3::m;

%typemap(cscode) Ga::GaMat3x3 %{
		public static Math3D.Matrix3 ToMatrix3( GaMat3x3 m )
		{
			Math3D.Matrix3 mat = Math3D.Matrix3.Identity;
			
			GaVec3 v = m.GetRow(0);
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

		public static GaMat3x3 FromMatrix3(Math3D.Matrix3 mat)
		{
			return new GaMat3x3(mat.m00, mat.m01, mat.m02, mat.m10, mat.m11, mat.m12, mat.m20, mat.m21,
				mat.m22);
		}
%}

%extend Ga::GaMat3x3
{
	inline Ga::GaVec3 * GetRow(int row)
	{
		return new Ga::GaVec3(self->operator[](row));
	}
}



//const ref
%typemap(cstype) const Ga::GaMat3x3 & "Math3D.Matrix3"
%typemap(csin) const Ga::GaMat3x3 & "GaMat3x3.getCPtr(GaMat3x3.FromMatrix3($csinput))"
%typemap(csout) const Ga::GaMat3x3 &
{
	return GaMat3x3.ToMatrix3(new GaMat3x3($imcall, false));
}
%typemap(csvarout) const Ga::GaMat3x3 &
%{
get
{
	return GaMat3x3.ToMatrix3(new GaMat3x3($imcall, false));
}
%}
%typemap(out) const Ga::GaMat3x3 & %{ $result = (void *)$1; %}



//ref 
%typemap(cstype) Ga::GaMat3x3 & "Math3D.Matrix3"
%typemap(csin) Ga::GaMat3x3 & "GaMat3x3.getCPtr(GaMat3x3.FromMatrix3($csinput))"
%typemap(csout) Ga::GaMat3x3 &
{
	return GaMat3x3.ToMatrix3(new GaMat3x3($imcall, false));
}
%typemap(csvarout) Ga::GaMat3x3 &
%{
get
{
	return GaMat3x3.ToMatrix3(new GaMat3x3($imcall, false));
}
%}
%typemap(out) Ga::GaMat3x3 & %{ $result = (void *)$1; %}




//const ptr
%typemap(cstype) const Ga::GaMat3x3 * "Math3D.Matrix3"
%typemap(csin) const Ga::GaMat3x3 * "GaMat3x3.getCPtr(GaMat3x3.FromMatrix3($csinput))"
%typemap(csout) const Ga::GaMat3x3 *
{
	return GaMat3x3.ToMatrix3(new GaMat3x3($imcall, false));
}
%typemap(csvarout) const Ga::GaMat3x3 *
%{
get
{
	return GaMat3x3.ToMatrix3(new GaMat3x3($imcall, false));
}
%}
%typemap(out) const Ga::GaMat3x3 * %{ $result = (void *)$1; %}



//default
%typemap(cstype) Ga::GaMat3x3 "Math3D.Matrix3"
%typemap(csin) Ga::GaMat3x3 "GaMat3x3.getCPtr(GaMat3x3.FromMatrix3($csinput))"
%typemap(csout) Ga::GaMat3x3
{
	return GaMat3x3.ToMatrix3(new GaMat3x3($imcall, false));
}
%typemap(csvarout) Ga::GaMat3x3
%{
get
{
	return GaMat3x3.ToMatrix3(new GaMat3x3($imcall, false));
}
%}
%typemap(out) Ga::GaMat3x3 %{ $result = (void *)&$1; %}

