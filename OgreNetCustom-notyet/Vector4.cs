using System;

namespace OgreDotNet
{
    public struct Vector4 
    {
        #region Member variables

        public float x, y, z ,w;

        #endregion

        #region Constructors

        /// <summary>
        ///        Creates a new 4 dimensional Vector.
        /// </summary>
        public Vector4(float x, float y, float z, float w) 
        {
            this.x = x;
            this.y = y;
            this.z = z;
            this.w = w;
        }

        public Vector4(OgreVector4 v)
        {
            this.x = v.x;
            this.y = v.y;
            this.z = v.z;
            this.w = v.w;
        }

        public OgreVector4 ToOgreVector4()
        {
            return new OgreVector4(this.x, this.y, this.z, this.w);
        }

        #endregion

        #region Methods

        /// <summary>
        ///     Calculates the dot (scalar) product of this vector with another.
        /// </summary>
        /// <param name="vec">
        ///     Vector with which to calculate the dot product (together with this one).
        /// </param>
        /// <returns>A float representing the dot product value.</returns>
        public float Dot(Vector4 vec) 
        {
            return x * vec.x + y * vec.y + z * vec.z + w * vec.w;
        }

        #endregion Methods

        #region Operator overloads + CLS compliant method equivalents

        /// <summary>
        ///        
        /// </summary>
        /// <param name="vector"></param>
        /// <param name="matrix"></param>
        /// <returns></returns>
        public static Vector4 Multiply (Vector4 vector, Matrix4 matrix) 
        {
            return vector * matrix;
        }
        /// <summary>
        ///        
        /// </summary>
        /// <param name="vector"></param>
        /// <param name="matrix"></param>
        /// <returns></returns>
        public static Vector4 operator * (Matrix4 matrix, Vector4 vector) 
        {
            Vector4 result = new Vector4();
            
            result.x = vector.x * matrix.m00 + vector.y * matrix.m01 + vector.z * matrix.m02 + vector.w * matrix.m03;
            result.y = vector.x * matrix.m10 + vector.y * matrix.m11 + vector.z * matrix.m12 + vector.w * matrix.m13;
            result.z = vector.x * matrix.m20 + vector.y * matrix.m21 + vector.z * matrix.m22 + vector.w * matrix.m23;
            result.w = vector.x * matrix.m30 + vector.y * matrix.m31 + vector.z * matrix.m32 + vector.w * matrix.m33;

            return result;
        }

        // TODO: Find the signifance of having 2 overloads with opposite param lists that do transposed operations
        public static Vector4 operator * (Vector4 vector, Matrix4 matrix) 
        {
            Vector4 result = new Vector4();
            
            result.x = vector.x * matrix.m00 + vector.y * matrix.m10 + vector.z * matrix.m20 + vector.w * matrix.m30;
            result.y = vector.x * matrix.m01 + vector.y * matrix.m11 + vector.z * matrix.m21 + vector.w * matrix.m31;
            result.z = vector.x * matrix.m02 + vector.y * matrix.m12 + vector.z * matrix.m22 + vector.w * matrix.m32;
            result.w = vector.x * matrix.m03 + vector.y * matrix.m13 + vector.z * matrix.m23 + vector.w * matrix.m33;

            return result;
        }

        /// <summary>
        ///        Multiplies a Vector4 by a scalar value.
        /// </summary>
        /// <param name="vector"></param>
        /// <param name="scalar"></param>
        /// <returns></returns>
        public static Vector4 operator * (Vector4 vector, float scalar) 
        {
            Vector4 result = new Vector4();

            result.x = vector.x * scalar;
            result.y = vector.y * scalar;
            result.z = vector.z * scalar;
            result.w = vector.w * scalar;

            return result;
        }

        /// <summary>
        ///        User to compare two Vector4 instances for equality.
        /// </summary>
        /// <param name="left"></param>
        /// <param name="right"></param>
        /// <returns>true or false</returns>
        public static bool operator == (Vector4 left, Vector4 right) 
        {
            return (left.x == right.x && 
                left.y == right.y && 
                left.z == right.z && 
                left.w == right.w);
        }

        /// <summary>
        ///        Used to negate the elements of a vector.
        /// </summary>
        /// <param name="left"></param>
        /// <returns></returns>
        public static Vector4 operator - (Vector4 left) 
        {
            return new Vector4(-left.x, -left.y, -left.z, -left.w);
        }

        /// <summary>
        ///        User to compare two Vector4 instances for inequality.
        /// </summary>
        /// <param name="left"></param>
        /// <param name="right"></param>
        /// <returns>true or false</returns>
        public static bool operator != (Vector4 left, Vector4 right) 
        {
            return (left.x != right.x || 
                left.y != right.y || 
                left.z != right.z ||
                left.w != right.w);
        }

        /// <summary>
        ///        Used to access a Vector by index 0 = this.x, 1 = this.y, 2 = this.z, 3 = this.w.  
        /// </summary>
        /// <remarks>
        ///        Uses unsafe pointer arithmetic to reduce the code required.
        ///    </remarks>
        public float this[int index] 
        {
            get 
            {
                // using pointer arithmetic here for less code.  Otherwise, we'd have a big switch statement.
                unsafe 
                {
                    fixed(float* pX = &x)
                        return *(pX + index);
                }
            }
            set 
            {
                // using pointer arithmetic here for less code.  Otherwise, we'd have a big switch statement.
                unsafe 
                {
                    fixed(float* pX = &x)
                        *(pX + index) = value;
                }
            }
        }

        #endregion

        #region Object overloads

        /// <summary>
        ///        Overrides the Object.ToString() method to provide a text representation of 
        ///        a Vector4.
        /// </summary>
        /// <returns>A string representation of a Vector4.</returns>
        public override string ToString() 
        {
            return string.Format("<{0},{1},{2},{3}>", this.x, this.y, this.z, this.w);
        }

        /// <summary>
        ///        Provides a unique hash code based on the member variables of this
        ///        class.  This should be done because the equality operators (==, !=)
        ///        have been overriden by this class.
        ///        <p/>
        ///        The standard implementation is a simple XOR operation between all local
        ///        member variables.
        /// </summary>
        /// <returns></returns>
        public override int GetHashCode() 
        {
            return (int)this.x ^ (int)this.y ^ (int)this.z ^ (int)this.w;
        }

        /// <summary>
        ///        Compares this Vector to another object.  This should be done because the 
        ///        equality operators (==, !=) have been overriden by this class.
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public override bool Equals(object obj) 
        {
            if(obj is Vector4)
                return (this == (Vector4)obj);
            else
                return false;
        }

        #endregion

        public static implicit operator OgreVector4(Vector4 v)
        {
            return v.ToOgreVector4();
        }

        public static implicit operator Vector4(OgreVector4 v)
        {
            return new Vector4(v);
        }
    }
}
