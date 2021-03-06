using System;

namespace OgreDotNet
{
    public struct Quaternion 
    {
        #region Private member variables and constants

        const float EPSILON = 1e-03f;

        public float w, x, y, z;

        private static readonly Quaternion identityQuat = new Quaternion(1.0f, 0.0f, 0.0f, 0.0f);
        private static readonly Quaternion zeroQuat = new Quaternion(0.0f, 0.0f, 0.0f, 0.0f);
        private static readonly int[] next = new int[3]{ 1, 2, 0 };
        
        #endregion

        #region Constructors

        //        public Quaternion()
        //        {
        //            this.w = 1.0f;
        //        }

        /// <summary>
        ///        Creates a new Quaternion.
        /// </summary>
        public Quaternion(float w, float x, float y, float z) 
        {
            this.w = w;
            this.x = x;
            this.y = y;
            this.z = z;
        }

        public Quaternion(OgreQuaternion q)
        {
            this.x = q.x;
            this.y = q.y;
            this.z = q.z;
            this.w = q.w;
        }

        public OgreQuaternion ToOgreQuaternion()
        {
            return new OgreQuaternion(this.w, this.x, this.y, this.z);
        }

        #endregion

        #region Operator Overloads + CLS compliant method equivalents

        /// <summary>
        /// Used to multiply 2 Quaternions together.
        /// </summary>
        /// <remarks>
        ///        Quaternion multiplication is not communative in most cases.
        ///        i.e. p*q != q*p
        /// </remarks>
        /// <param name="left"></param>
        /// <param name="right"></param>
        /// <returns></returns>
        public static Quaternion Multiply (Quaternion left, Quaternion right) 
        {
            return left * right;
        }

        /// <summary>
        /// Used to multiply 2 Quaternions together.
        /// </summary>
        /// <remarks>
        ///        Quaternion multiplication is not communative in most cases.
        ///        i.e. p*q != q*p
        /// </remarks>
        /// <param name="left"></param>
        /// <param name="right"></param>
        /// <returns></returns>
        public static Quaternion operator * (Quaternion left, Quaternion right) 
        {
            Quaternion q = new Quaternion();

            q.w = left.w * right.w - left.x * right.x - left.y * right.y - left.z * right.z;
            q.x = left.w * right.x + left.x * right.w + left.y * right.z - left.z * right.y;
            q.y = left.w * right.y + left.y * right.w + left.z * right.x - left.x * right.z;
            q.z = left.w * right.z + left.z * right.w + left.x * right.y - left.y * right.x;

//             return new Quaternion
//                 (
//                 left.w * right.w - left.x * right.x - left.y * right.y - left.z * right.z,
//                 left.w * right.x + left.x * right.w + left.y * right.z - left.z * right.y,
//                 left.w * right.y + left.y * right.w + left.z * right.x - left.x * right.z,
//                 left.w * right.z + left.z * right.w + left.x * right.y - left.y * right.x
//                 );

            return q;
        }


        /// <summary>
        /// 
        /// </summary>
        /// <param name="quat"></param>
        /// <param name="vector"></param>
        /// <returns></returns>
        public static Vector3 Multiply (Quaternion quat, Vector3 vector) 
        {
            return quat * vector;
        }
        
        /// <summary>
        /// 
        /// </summary>
        /// <param name="quat"></param>
        /// <param name="vector"></param>
        /// <returns></returns>
        public static Vector3 operator*(Quaternion quat, Vector3 vector) 
        {
            // nVidia SDK implementation
            Vector3 uv, uuv;
            Vector3 qvec = new Vector3(quat.x, quat.y, quat.z);

            uv = qvec.Cross(vector); 
            uuv = qvec.Cross(uv); 
            uv *= (2.0f * quat.w); 
            uuv *= 2.0f; 
        
            return vector + uv + uuv;

            // get the rotation matrix of the Quaternion and multiply it times the vector
            //return quat.ToRotationMatrix() * vector;
        }

        /// <summary>
        /// Used when a float value is multiplied by a Quaternion.
        /// </summary>
        /// <param name="scalar"></param>
        /// <param name="right"></param>
        /// <returns></returns>
        public static Quaternion Multiply (float scalar, Quaternion right) 
        {
            return scalar * right;
        }
        
        /// <summary>
        /// Used when a float value is multiplied by a Quaternion.
        /// </summary>
        /// <param name="scalar"></param>
        /// <param name="right"></param>
        /// <returns></returns>
        public static Quaternion operator*(float scalar, Quaternion right) 
        {
            return new Quaternion(scalar * right.w, scalar * right.x, scalar * right.y, scalar * right.z);
        }

        /// <summary>
        /// Used when a Quaternion is multiplied by a float value.
        /// </summary>
        /// <param name="left"></param>
        /// <param name="scalar"></param>
        /// <returns></returns>
        public static Quaternion Multiply (Quaternion left, float scalar) 
        {
            return left * scalar;
        }
        
        /// <summary>
        /// Used when a Quaternion is multiplied by a float value.
        /// </summary>
        /// <param name="left"></param>
        /// <param name="scalar"></param>
        /// <returns></returns>
        public static Quaternion operator*(Quaternion left, float scalar) 
        {
            return new Quaternion(scalar * left.w, scalar * left.x, scalar * left.y, scalar * left.z);
        }

        /// <summary>
        /// Used when a Quaternion is added to another Quaternion.
        /// </summary>
        /// <param name="left"></param>
        /// <param name="right"></param>
        /// <returns></returns>
        public static Quaternion Add (Quaternion left, Quaternion right) 
        {
            return left + right;
        }
        
        /// <summary>
        /// Used when a Quaternion is added to another Quaternion.
        /// </summary>
        /// <param name="left"></param>
        /// <param name="right"></param>
        /// <returns></returns>
        public static Quaternion operator+(Quaternion left, Quaternion right) 
        {
            return new Quaternion(left.w + right.w, left.x + right.x, left.y + right.y, left.z + right.z);
        }

        /// <summary>
        ///     Negates a Quaternion, which simply returns a new Quaternion
        ///     with all components negated.
        /// </summary>
        /// <param name="right"></param>
        /// <returns></returns>
        public static Quaternion operator - (Quaternion right) 
        {
            return new Quaternion(-right.w, -right.x, -right.y, -right.z);
        }

        public static bool operator == (Quaternion left, Quaternion right) 
        {
            return (left.w == right.w && left.x == right.x && left.y == right.y && left.z == right.z);
        }

        public static bool operator != (Quaternion left, Quaternion right) 
        {
            return !(left == right);
        }

        #endregion

        #region Properties

        /// <summary>
        ///    An Identity Quaternion.
        /// </summary>
        public static Quaternion Identity 
        {
            get 
            { 
                return identityQuat; 
            }
        }

        /// <summary>
        ///    A Quaternion with all elements set to 0.0f;
        /// </summary>
        public static Quaternion Zero 
        {
            get 
            { 
                return zeroQuat; 
            }
        }

        /// <summary>
        ///        Squared 'length' of this quaternion.
        /// </summary>
        public float Norm 
        {
            get 
            {
                return x * x + y * y + z * z + w * w;
            }
        }

        /// <summary>
        ///    Local X-axis portion of this rotation.
        /// </summary>
        public Vector3 XAxis 
        {
            get 
            {
                float fTx  = 2.0f * x;
                float fTy  = 2.0f * y;
                float fTz  = 2.0f * z;
                float fTwy = fTy * w;
                float fTwz = fTz * w;
                float fTxy = fTy * x;
                float fTxz = fTz * x;
                float fTyy = fTy * y;
                float fTzz = fTz * z;

                return new Vector3(1.0f - (fTyy + fTzz), fTxy + fTwz, fTxz - fTwy);
            }
        }

        /// <summary>
        ///    Local Y-axis portion of this rotation.
        /// </summary>
        public Vector3 YAxis 
        {
            get 
            {
                float fTx  = 2.0f * x;
                float fTy  = 2.0f * y;
                float fTz  = 2.0f * z;
                float fTwx = fTx * w;
                float fTwz = fTz * w;
                float fTxx = fTx * x;
                float fTxy = fTy * x;
                float fTyz = fTz * y;
                float fTzz = fTz * z;

                return new Vector3(fTxy - fTwz, 1.0f - (fTxx + fTzz), fTyz + fTwx);
            }
        }

        /// <summary>
        ///    Local Z-axis portion of this rotation.
        /// </summary>
        public Vector3 ZAxis 
        {
            get 
            {
                float fTx  = 2.0f * x;
                float fTy  = 2.0f * y;
                float fTz  = 2.0f * z;
                float fTwx = fTx * w;
                float fTwy = fTy * w;
                float fTxx = fTx * x;
                float fTxz = fTz * x;
                float fTyy = fTy * y;
                float fTyz = fTz * y;

                return new Vector3(fTxz + fTwy, fTyz - fTwx, 1.0f - (fTxx+fTyy));
            }
        }

        #endregion

        #region Static methods

        public static Quaternion Slerp(float time, Quaternion quatA, Quaternion quatB) 
        {
            return Slerp(time, quatA, quatB, false);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="time"></param>
        /// <param name="quatA"></param>
        /// <param name="quatB"></param>
        /// <param name="useShortestPath"></param>
        /// <returns></returns>
        public static Quaternion Slerp(float time, Quaternion quatA, Quaternion quatB, bool useShortestPath) 
        {
            float cos = quatA.Dot(quatB);

            float angle = (float)Math.Acos(cos);

            if(Math.Abs(angle) < EPSILON) 
            {
                return quatA;
            }

            float sin = (float)Math.Sin(angle);
            float inverseSin = 1.0f / sin;
            float coeff0 = (float)Math.Sin((1.0f - time) * angle) * inverseSin;
            float coeff1 = (float)Math.Sin(time * angle) * inverseSin;

            Quaternion result;

            if(cos < 0.0f && useShortestPath) 
            {
                coeff0 = -coeff0;
                // taking the complement requires renormalisation
                Quaternion t = coeff0 * quatA + coeff1 * quatB;
                t.Normalize();
                result = t;
            }
            else 
            {
                result = (coeff0 * quatA + coeff1 * quatB);
            }

            return result;
        }

        /// <summary>
        /// Creates a Quaternion from a supplied angle and axis.
        /// </summary>
        /// <param name="angle">Value of an angle in radians.</param>
        /// <param name="axis">Arbitrary axis vector.</param>
        /// <returns></returns>
        public static Quaternion FromAngleAxis(float angle, Vector3 axis) 
        {
            Quaternion quat = new Quaternion();

            float halfAngle = 0.5f * angle;
            float sin = (float)Math.Sin(halfAngle);

            quat.w = (float)Math.Cos(halfAngle);
            quat.x = sin * axis.x; 
            quat.y = sin * axis.y; 
            quat.z = sin * axis.z; 

            return quat;
        }

        public static Quaternion Squad(float t, Quaternion p, Quaternion a, Quaternion b, Quaternion q) 
        {
            return Squad(t, p, a, b, q, false);
        }

        /// <summary>
        ///        Performs spherical quadratic interpolation.
        /// </summary>
        /// <param name="t"></param>
        /// <param name="p"></param>
        /// <param name="a"></param>
        /// <param name="b"></param>
        /// <param name="q"></param>
        /// <returns></returns>
        public static Quaternion Squad(float t, Quaternion p, Quaternion a, Quaternion b, Quaternion q, bool useShortestPath) 
        {
            float slerpT = 2.0f * t * (1.0f - t);

            // use spherical linear interpolation
            Quaternion slerpP = Slerp(t, p, q, useShortestPath);
            Quaternion slerpQ = Slerp(t, a, b);

            // run another Slerp on the results of the first 2, and return the results
            return Slerp(slerpT, slerpP, slerpQ);
        }

        #endregion

        #region Public methods
        
        /// <summary>
        /// Performs a Dot Product operation on 2 Quaternions.
        /// </summary>
        /// <param name="quat"></param>
        /// <returns></returns>
        public float Dot(Quaternion quat) 
        {
            return this.w * quat.w + this.x * quat.x + this.y * quat.y + this.z * quat.z;
        }

        /// <summary>
        ///        Normalizes elements of this quaterion to the range [0,1].
        /// </summary>
        public void Normalize() 
        {
            float factor = 1.0f / (float)Math.Sqrt(this.Norm);

            w = w * factor;
            x = x * factor;
            y = y * factor;
            z = z * factor;
        }

        /// <summary>
        ///    
        /// </summary>
        /// <param name="angle"></param>
        /// <param name="axis"></param>
        /// <returns></returns>
        public void ToAngleAxis(ref float angle, ref Vector3 axis) 
        {
            // The quaternion representing the rotation is
            //   q = cos(A/2)+sin(A/2)*(x*i+y*j+z*k)

            float sqrLength = x * x + y * y + z * z;

            if(sqrLength >0.0f) 
            {
                angle = 2.0f * (float)Math.Acos(w);
                float invLength = -(float)Math.Sqrt(sqrLength);
                axis.x = x * invLength;
                axis.y = y * invLength;
                axis.z = z * invLength;
            }
            else 
            {
                angle = 0.0f;
                axis.x = 1.0f;
                axis.y = 0.0f;
                axis.z = 0.0f;
            }
        }

        /// <summary>
        /// Gets a 3x3 rotation matrix from this Quaternion.
        /// </summary>
        /// <returns></returns>
        public Matrix3 ToRotationMatrix() 
        {
            Matrix3 rotation = new Matrix3();

            float tx  = 2.0f * this.x;
            float ty  = 2.0f * this.y;
            float tz  = 2.0f * this.z;
            float twx = tx * this.w;
            float twy = ty * this.w;
            float twz = tz * this.w;
            float txx = tx * this.x;
            float txy = ty * this.x;
            float txz = tz * this.x;
            float tyy = ty * this.y;
            float tyz = tz * this.y;
            float tzz = tz * this.z;

            rotation.m00 = 1.0f-(tyy+tzz);
            rotation.m01 = txy-twz;
            rotation.m02 = txz+twy;
            rotation.m10 = txy+twz;
            rotation.m11 = 1.0f-(txx+tzz);
            rotation.m12 = tyz-twx;
            rotation.m20 = txz-twy;
            rotation.m21 = tyz+twx;
            rotation.m22 = 1.0f-(txx+tyy);

            return rotation;
        }

        /// <summary>
        /// Computes the inverse of a Quaternion.
        /// </summary>
        /// <returns></returns>
        public Quaternion Inverse() 
        {
            float norm = this.w * this.w + this.x * this.x + this.y * this.y + this.z * this.z;
            if (norm > 0.0f) 
            {
                float inverseNorm = 1.0f / norm;
                return new Quaternion(this.w * inverseNorm, -this.x * inverseNorm, -this.y * inverseNorm, -this.z * inverseNorm);
            }
            else 
            {
                // return an invalid result to flag the error
                return Quaternion.Zero;
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="xAxis"></param>
        /// <param name="yAxis"></param>
        /// <param name="zAxis"></param>
        public void ToAxes (out Vector3 xAxis, out Vector3 yAxis, out Vector3 zAxis) 
        {
            xAxis = new Vector3();
            yAxis = new Vector3();
            zAxis = new Vector3();

            Matrix3 rotation = this.ToRotationMatrix();

            xAxis.x = rotation.m00;
            xAxis.y = rotation.m10;
            xAxis.z = rotation.m20;

            yAxis.x = rotation.m01;
            yAxis.y = rotation.m11;
            yAxis.z = rotation.m21;

            zAxis.x = rotation.m02;
            zAxis.y = rotation.m12;
            zAxis.z = rotation.m22;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="xAxis"></param>
        /// <param name="yAxis"></param>
        /// <param name="zAxis"></param>
        public void FromAxes(Vector3 xAxis, Vector3 yAxis, Vector3 zAxis) 
        {
            Matrix3 rotation = new Matrix3();

            rotation.m00 = xAxis.x;
            rotation.m10= xAxis.y;
            rotation.m20 = xAxis.z;

            rotation.m01 = yAxis.x;
            rotation.m11 = yAxis.y;
            rotation.m21 = yAxis.z;

            rotation.m02 = zAxis.x;
            rotation.m12 = zAxis.y;
            rotation.m22 = zAxis.z;

            // set this quaternions values from the rotation matrix built
            FromRotationMatrix(rotation);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="matrix"></param>
        public void FromRotationMatrix(Matrix3 matrix) 
        {
            // Algorithm in Ken Shoemake's article in 1987 SIGGRAPH course notes
            // article "Quaternion Calculus and Fast Animation".

            float trace = matrix.m00 + matrix.m11 + matrix.m22;

            float root = 0.0f;

            if (trace > 0.0f) 
            {
                // |this.w| > 1/2, may as well choose this.w > 1/2
                root = (float)Math.Sqrt(trace + 1.0f);  // 2w
                this.w = 0.5f * root;
                
                root = 0.5f / root;  // 1/(4w)

                this.x = (matrix.m21 - matrix.m12) * root;
                this.y = (matrix.m02 - matrix.m20) * root;
                this.z = (matrix.m10 - matrix.m01) * root;
            }
            else 
            {
                // |this.w| <= 1/2

                int i = 0;
                if (matrix.m11 > matrix.m00)
                    i = 1;
                if (matrix.m22 > matrix[i,i])
                    i = 2;

                int j = next[i];
                int k = next[j];

                root = (float)Math.Sqrt(matrix[i,i] - matrix[j,j] - matrix[k,k] + 1.0f);

                unsafe 
                {
                    fixed(float* apkQuat = &this.x) 
                    {
                        apkQuat[i] = 0.5f * root;
                        root = 0.5f / root;
                    
                        this.w = (matrix[k,j] - matrix[j,k]) * root;
                    
                        apkQuat[j] = (matrix[j,i] + matrix[i,j]) * root;
                        apkQuat[k] = (matrix[k,i] + matrix[i,k]) * root;
                    }
                }
            }
        }

        /// <summary>
        ///        Calculates the logarithm of a Quaternion.
        /// </summary>
        /// <returns></returns>
        public Quaternion Log() 
        {
            // BLACKBOX: Learn this
            // If q = cos(A)+sin(A)*(x*i+y*j+z*k) where (x,y,z) is unit length, then
            // log(q) = A*(x*i+y*j+z*k).  If sin(A) is near zero, use log(q) =
            // sin(A)*(x*i+y*j+z*k) since sin(A)/A has limit 1.

            // start off with a zero quat
            Quaternion result = Quaternion.Zero;

            if(Math.Abs(w) < 1.0f) 
            {
                float angle = (float)Math.Acos(w);
                float sin = (float)Math.Sin(angle);

                if(Math.Abs(sin) >= EPSILON) 
                {
                    float coeff = angle / sin;
                    result.x = coeff * x;
                    result.y = coeff * y;
                    result.z = coeff * z;
                }
                else 
                {
                    result.x = x;
                    result.y = y;
                    result.z = z;
                }
            }

            return result;
        }

        /// <summary>
        ///        Calculates the Exponent of a Quaternion.
        /// </summary>
        /// <returns></returns>
        public Quaternion Exp() 
        {
            // If q = A*(x*i+y*j+z*k) where (x,y,z) is unit length, then
            // exp(q) = cos(A)+sin(A)*(x*i+y*j+z*k).  If sin(A) is near zero,
            // use exp(q) = cos(A)+A*(x*i+y*j+z*k) since A/sin(A) has limit 1.

            float angle = (float)Math.Sqrt(x * x + y * y + z * z);
            float sin = (float)Math.Sin(angle);

            // start off with a zero quat
            Quaternion result = Quaternion.Zero;

            result.w = (float)Math.Cos(angle);

            if (Math.Abs(sin) >= EPSILON) 
            {
                float coeff = sin / angle;

                result.x = coeff * x;
                result.y = coeff * y;
                result.z = coeff * z;
            }
            else 
            {
                result.x = x;
                result.y = y;
                result.z = z;
            }

            return result;
        }

        #endregion

        #region Object overloads

        /// <summary>
        ///        Overrides the Object.ToString() method to provide a text representation of 
        ///        a Quaternion.
        /// </summary>
        /// <returns>A string representation of a Quaternion.</returns>
        public override string ToString() 
        {
            return string.Format("Quaternion({0}, {1}, {2}, {3})", this.x, this.y, this.z, this.w);
        }
        
        public override int GetHashCode() 
        {
            return (int)x ^ (int)y ^ (int)z ^ (int)w;
        }
        public override bool Equals(object obj) 
        {
            Quaternion quat = (Quaternion)obj;
            
            return quat == this;
        }
        
        #endregion    

        public static implicit operator OgreQuaternion(Quaternion q)
        {
            return q.ToOgreQuaternion();
        }

        public static implicit operator Quaternion(OgreQuaternion q)
        {
            return new Quaternion(q);
        }
    }
}
