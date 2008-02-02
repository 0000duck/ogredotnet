
%ignore Ga::GaMat4x4::GaMat4x4(const GaFloat *v);
%ignore Ga::GaMat4x4::operator=;
%ignore Ga::GaMat4x4::operator[];
%ignore Ga::GaMat4x4::m;
%ignore Ga::GaMat4x4::toFloatMatrix;

%typemap(cscode) Ga::GaMat4x4 %{
		public static Math3D.Matrix4 ToMatrix4( GaMat4x4 m )
		{
			Math3D.Matrix4 mat = Math3D.Matrix4.Identity;
			
			GaVec4 v = m.GetRow(0);
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

		public static GaMat4x4 FromMatrix4(Math3D.Matrix4 mat)
		{
			return new GaMat4x4(mat.m00, mat.m01, mat.m02, mat.m03, mat.m10, mat.m11, mat.m12, mat.m13,
				mat.m20, mat.m21, mat.m22, mat.m23, mat.m30, mat.m31, mat.m32, mat.m33);
		}
%}

%extend Ga::GaMat4x4
{
	inline Ga::GaVec4 * GetRow(int row)
	{
		return new Ga::GaVec4(self->operator[](row));
	}
}




//const ref
%typemap(cstype) const Ga::GaMat4x4 & "Math3D.Matrix4"
%typemap(csin) const Ga::GaMat4x4 & "GaMat4x4.getCPtr(GaMat4x4.FromMatrix4($csinput))"
%typemap(csout) const Ga::GaMat4x4 &
{
	return GaMat4x4.ToMatrix4(new GaMat4x4($imcall, false));
}
%typemap(csvarout) const Ga::GaMat4x4 &
%{
get
{
	return GaMat4x4.ToMatrix4(new GaMat4x4($imcall, false));
}
%}
%typemap(out) const Ga::GaMat4x4 & %{ $result = (void *)$1; %}



//ref
%typemap(cstype) Ga::GaMat4x4 & "Math3D.Matrix4"
%typemap(csin) Ga::GaMat4x4 & "GaMat4x4.getCPtr(GaMat4x4.FromMatrix4($csinput))"
%typemap(csout) Ga::GaMat4x4 &
{
	return GaMat4x4.ToMatrix4(new GaMat4x4($imcall, false));
}
%typemap(csvarout) Ga::GaMat4x4 &
%{
get
{
	return GaMat4x4.ToMatrix4(new GaMat4x4($imcall, false));
}
%}
%typemap(out) Ga::GaMat4x4 & %{ $result = (void *)$1; %}



//const ptr
%typemap(cstype) const Ga::GaMat4x4 * "Math3D.Matrix4"
%typemap(csin) const Ga::GaMat4x4 * "GaMat4x4.getCPtr(GaMat4x4.FromMatrix4($csinput))"
%typemap(csout) const Ga::GaMat4x4 *
{
	return GaMat4x4.ToMatrix4(new GaMat4x4($imcall, false));
}
%typemap(csvarout) const Ga::GaMat4x4 *
%{
get
{
	return GaMat4x4.ToMatrix4(new GaMat4x4($imcall, false));
}
%}
%typemap(out) const Ga::GaMat4x4 * %{ $result = (void *)$1; %}



//default
%typemap(cstype) Ga::GaMat4x4 "Math3D.Matrix4"
%typemap(csin) Ga::GaMat4x4 "GaMat4x4.getCPtr(GaMat4x4.FromMatrix4($csinput))"
%typemap(csout) Ga::GaMat4x4
{
	return GaMat4x4.ToMatrix4(new GaMat4x4($imcall, false));
}
%typemap(csvarout) Ga::GaMat4x4
%{
get
{
	return GaMat4x4.ToMatrix4(new GaMat4x4($imcall, false));
}
%}
%typemap(out) Ga::GaMat4x4 %{ $result = (void *)&$1; %}

