using System;
using System.Text;

namespace OgreDotNet
{
    public struct Matrix4 
    {
        #region Member variables

        public float m00, m01, m02, m03;
        public float m10, m11, m12, m13;
        public float m20, m21, m22, m23;
        public float m30, m31, m32, m33;

        private readonly static Matrix4 zeroMatrix = new Matrix4(
            0,0,0,0,
            0,0,0,0,
            0,0,0,0,
            0,0,0,0);
        private readonly static Matrix4 identityMatrix = new Matrix4(
            1,0,0,0,
            0,1,0,0,
            0,0,1,0,
            0,0,0,1);

        private readonly static Matrix4 clipSpace2dToImageSpace = new Matrix4(
            0.5f,        0,        0,        0.5f, 
            0,        -0.5f,        0,        0.5f, 
            0,            0,        1,        0,
            0,            0,        0,        1);

        #endregion

        #region Constructors

        /// <summary>
        ///        Creates a new Matrix4 with all the specified parameters.
        /// </summary>
        public Matrix4(float m00, float m01, float m02, float m03, 
            float m10, float m11, float m12, float m13,
            float m20, float m21, float m22, float m23,
            float m30, float m31, float m32, float m33) 
        {
            this.m00 = m00; this.m01 = m01; this.m02 = m02; this.m03 = m03;
            this.m10 = m10; this.m11 = m11; this.m12 = m12; this.m13 = m13;
            this.m20 = m20; this.m21 = m21; this.m22 = m22; this.m23 = m23;
            this.m30 = m30; this.m31 = m31; this.m32 = m32; this.m33 = m33;
        }

        public Matrix4(OgreMatrix4 m)
        {
            OgreVector4 v = m.GetRow(0);
            this.m00 = v.x;
            this.m01 = v.y;
            this.m02 = v.z;
            this.m03 = v.w;

            v = m.GetRow(1);
            this.m10 = v.x;
            this.m11 = v.y;
            this.m12 = v.z;
            this.m13 = v.w;

            v = m.GetRow(2);
            this.m20 = v.x;
            this.m21 = v.y;
            this.m22 = v.z;
            this.m23 = v.w;

            v = m.GetRow(3);
            this.m30 = v.x;
            this.m31 = v.y;
            this.m32 = v.z;
            this.m33 = v.w;
        }

        public OgreMatrix4 ToOgreMatrix4()
        {
            return new OgreMatrix4(this.m00, this.m01, this.m02, this.m03, this.m10, this.m11, this.m12, this.m13,
                this.m20, this.m21, this.m22, this.m23, this.m30, this.m31, this.m32, this.m33);
        }

        #endregion

        #region Static properties
        /// <summary>
        ///    Returns a matrix with the following form:
        ///    | 1,0,0,0 |
        ///    | 0,1,0,0 |
        ///    | 0,0,1,0 |
        ///    | 0,0,0,1 |
        /// </summary>
        public static Matrix4 Identity 
        {
            get 
            { 
                return identityMatrix; 
            }
        }

        /// <summary>
        ///    Returns a matrix with all elements set to 0.
        /// </summary>
        public static Matrix4 Zero 
        {
            get 
            { 
                return zeroMatrix; 
            }
        }

        public static Matrix4 ClipSpace2DToImageSpace 
        {
            get 
            {
                return clipSpace2dToImageSpace;
            }
        }

        #endregion

        #region Public properties

        /// <summary>
        ///        Gets/Sets the Translation portion of the matrix.
        ///        | 0 0 0 Tx|
        ///        | 0 0 0 Ty|
        ///        | 0 0 0 Tz|
        ///        | 0 0 0  1 |
        /// </summary>
        public Vector3 Translation 
        {
            get 
            {
                return new Vector3(this.m03, this.m13, this.m23);
            }
            set 
            {
                this.m03 = value.x;
                this.m13 = value.y;
                this.m23 = value.z;
            }
        }

        /// <summary>
        ///        Gets/Sets the Translation portion of the matrix.
        ///        |Sx 0  0  0 |
        ///        | 0 Sy 0  0 |
        ///        | 0  0 Sz 0 |
        ///        | 0  0  0  0 |
        /// </summary>
        public Vector3 Scale 
        {
            get 
            {
                return new Vector3(this.m00, this.m11, this.m22);
            }
            set 
            {
                this.m00 = value.x;
                this.m11 = value.y;
                this.m22 = value.z;
            }
        }

        #endregion

        #region Public methods

        /// <summary>
        ///    Returns a 3x3 portion of this 4x4 matrix.
        /// </summary>
        /// <returns></returns>
        public Matrix3 GetMatrix3() 
        {
            return
                new Matrix3(
                this.m00, this.m01, this.m02,
                this.m10, this.m11, this.m12,
                this.m20, this.m21, this.m22);
        }

        /// <summary>
        ///    Returns an inverted 4d matrix.
        /// </summary>
        /// <returns></returns>
        public Matrix4 Inverse() 
        {
            return Adjoint() * (1.0f / this.Determinant);
        }

        /// <summary>
        ///    Swap the rows of the matrix with the columns.
        /// </summary>
        /// <returns>A transposed Matrix.</returns>
        public Matrix4 Transpose() 
        {
            return new Matrix4(this.m00, this.m10, this.m20, this.m30,
                this.m01, this.m11, this.m21, this.m31,
                this.m02, this.m12, this.m22, this.m32,
                this.m03, this.m13, this.m23, this.m33);
        }

        #endregion

        #region Operator overloads + CLS compliant method equivalents

        /// <summary>
        ///        Used to multiply (concatenate) two 4x4 Matrices.
        /// </summary>
        /// <param name="left"></param>
        /// <param name="right"></param>
        /// <returns></returns>
        public static Matrix4 Multiply (Matrix4 left, Matrix4 right) 
        {
            return left * right;
        }
        
        /// <summary>
        ///        Used to multiply (concatenate) two 4x4 Matrices.
        /// </summary>
        /// <param name="left"></param>
        /// <param name="right"></param>
        /// <returns></returns>
        public static Matrix4 operator * (Matrix4 left, Matrix4 right) 
        {
            Matrix4 result = new Matrix4();

            result.m00 = left.m00 * right.m00 + left.m01 * right.m10 + left.m02 * right.m20 + left.m03 * right.m30;
            result.m01 = left.m00 * right.m01 + left.m01 * right.m11 + left.m02 * right.m21 + left.m03 * right.m31;
            result.m02 = left.m00 * right.m02 + left.m01 * right.m12 + left.m02 * right.m22 + left.m03 * right.m32;
            result.m03 = left.m00 * right.m03 + left.m01 * right.m13 + left.m02 * right.m23 + left.m03 * right.m33;

            result.m10 = left.m10 * right.m00 + left.m11 * right.m10 + left.m12 * right.m20 + left.m13 * right.m30;
            result.m11 = left.m10 * right.m01 + left.m11 * right.m11 + left.m12 * right.m21 + left.m13 * right.m31;
            result.m12 = left.m10 * right.m02 + left.m11 * right.m12 + left.m12 * right.m22 + left.m13 * right.m32;
            result.m13 = left.m10 * right.m03 + left.m11 * right.m13 + left.m12 * right.m23 + left.m13 * right.m33;

            result.m20 = left.m20 * right.m00 + left.m21 * right.m10 + left.m22 * right.m20 + left.m23 * right.m30;
            result.m21 = left.m20 * right.m01 + left.m21 * right.m11 + left.m22 * right.m21 + left.m23 * right.m31;
            result.m22 = left.m20 * right.m02 + left.m21 * right.m12 + left.m22 * right.m22 + left.m23 * right.m32;
            result.m23 = left.m20 * right.m03 + left.m21 * right.m13 + left.m22 * right.m23 + left.m23 * right.m33;

            result.m30 = left.m30 * right.m00 + left.m31 * right.m10 + left.m32 * right.m20 + left.m33 * right.m30;
            result.m31 = left.m30 * right.m01 + left.m31 * right.m11 + left.m32 * right.m21 + left.m33 * right.m31;
            result.m32 = left.m30 * right.m02 + left.m31 * right.m12 + left.m32 * right.m22 + left.m33 * right.m32;
            result.m33 = left.m30 * right.m03 + left.m31 * right.m13 + left.m32 * right.m23 + left.m33 * right.m33;

            return result;
        }

        /// <summary>
        ///        Transforms the given 3-D vector by the matrix, projecting the 
        ///        result back into <i>w</i> = 1.
        ///        <p/>
        ///        This means that the initial <i>w</i> is considered to be 1.0,
        ///        and then all the tree elements of the resulting 3-D vector are
        ///        divided by the resulting <i>w</i>.
        /// </summary>
        /// <param name="matrix">A Matrix4.</param>
        /// <param name="vector">A Vector3.</param>
        /// <returns>A new vector.</returns>
        public static Vector3 Multiply (Matrix4 matrix, Vector3 vector) 
        {
            return matrix * vector;
        }

        /// <summary>
        ///        Transforms a plane using the specified transform.
        /// </summary>
        /// <param name="matrix">Transformation matrix.</param>
        /// <param name="plane">Plane to transform.</param>
        /// <returns>A transformed plane.</returns>
        /*public static Plane Multiply(Matrix4 matrix, Plane plane) 
        {
            return matrix * plane;
        }*/
        
        /// <summary>
        ///        Transforms the given 3-D vector by the matrix, projecting the 
        ///        result back into <i>w</i> = 1.
        ///        <p/>
        ///        This means that the initial <i>w</i> is considered to be 1.0,
        ///        and then all the tree elements of the resulting 3-D vector are
        ///        divided by the resulting <i>w</i>.
        /// </summary>
        /// <param name="matrix">A Matrix4.</param>
        /// <param name="vector">A Vector3.</param>
        /// <returns>A new vector.</returns>
        public static Vector3 operator * (Matrix4 matrix, Vector3 vector) 
        {
            Vector3 result = new Vector3();

            float inverseW = 1.0f / (matrix.m30 + matrix.m31 + matrix.m32 + matrix.m33);

            result.x = ((matrix.m00 * vector.x) + (matrix.m01 * vector.y) + (matrix.m02 * vector.z) + matrix.m03) * inverseW;
            result.y = ((matrix.m10 * vector.x) + (matrix.m11 * vector.y) + (matrix.m12 * vector.z) + matrix.m13) * inverseW;
            result.z = ((matrix.m20 * vector.x) + (matrix.m21 * vector.y) + (matrix.m22 * vector.z) + matrix.m23) * inverseW;

            return result;
        }

        /// <summary>
        ///        Used to multiply a Matrix4 object by a scalar value..
        /// </summary>
        /// <param name="left"></param>
        /// <param name="right"></param>
        /// <returns></returns>
        public static Matrix4 operator * (Matrix4 left, float scalar) 
        {
            Matrix4 result = new Matrix4();

            result.m00 = left.m00 * scalar;
            result.m01 = left.m01 * scalar;
            result.m02 = left.m02 * scalar;
            result.m03 = left.m03 * scalar;

            result.m10 = left.m10 * scalar;
            result.m11 = left.m11 * scalar;
            result.m12 = left.m12 * scalar;
            result.m13 = left.m13 * scalar;

            result.m20 = left.m20 * scalar;
            result.m21 = left.m21 * scalar;
            result.m22 = left.m22 * scalar;
            result.m23 = left.m23 * scalar;

            result.m30 = left.m30 * scalar;
            result.m31 = left.m31 * scalar;
            result.m32 = left.m32 * scalar;
            result.m33 = left.m33 * scalar;

            return result;
        }

        /// <summary>
        ///        Used to multiply a transformation to a Plane.
        /// </summary>
        /// <param name="left"></param>
        /// <param name="plane"></param>
        /// <returns></returns>
        /*public static Plane operator * (Matrix4 left, Plane plane) 
        {
            Plane result = new Plane();

            Vector3 planeNormal = plane.Normal;

            result.Normal = new Vector3(
                left.m00 * planeNormal.x + left.m01 * planeNormal.y + left.m02 * planeNormal.z,
                left.m10 * planeNormal.x + left.m11 * planeNormal.y + left.m12 * planeNormal.z,
                left.m20 * planeNormal.x + left.m21 * planeNormal.y + left.m22 * planeNormal.z);

            Vector3 pt = planeNormal * -plane.D;
            pt = left * pt;

            result.D = -pt.Dot(result.Normal);

            return result;
        }*/

        /// <summary>
        ///        Used to add two matrices together.
        /// </summary>
        /// <param name="left"></param>
        /// <param name="right"></param>
        /// <returns></returns>
        public static Matrix4 Add (Matrix4 left, Matrix4 right) 
        {
            return left + right;
        }
        
        /// <summary>
        ///        Used to add two matrices together.
        /// </summary>
        /// <param name="left"></param>
        /// <param name="right"></param>
        /// <returns></returns>
        public static Matrix4 operator + (Matrix4 left, Matrix4 right) 
        {
            Matrix4 result = new Matrix4();

            result.m00 = left.m00 + right.m00;
            result.m01 = left.m01 + right.m01;
            result.m02 = left.m02 + right.m02;
            result.m03 = left.m03 + right.m03;

            result.m10 = left.m10 + right.m10;
            result.m11 = left.m11 + right.m11;
            result.m12 = left.m12 + right.m12;
            result.m13 = left.m13 + right.m13;

            result.m20 = left.m20 + right.m20;
            result.m21 = left.m21 + right.m21;
            result.m22 = left.m22 + right.m22;
            result.m23 = left.m23 + right.m23;

            result.m30 = left.m30 + right.m30;
            result.m31 = left.m31 + right.m31;
            result.m32 = left.m32 + right.m32;
            result.m33 = left.m33 + right.m33;

            return result;
        }

        /// <summary>
        ///        Used to subtract two matrices.
        /// </summary>
        /// <param name="left"></param>
        /// <param name="right"></param>
        /// <returns></returns>
        public static Matrix4 Subtract (Matrix4 left, Matrix4 right) 
        {
            return left - right;
        }
        
        /// <summary>
        ///        Used to subtract two matrices.
        /// </summary>
        /// <param name="left"></param>
        /// <param name="right"></param>
        /// <returns></returns>
        public static Matrix4 operator - (Matrix4 left, Matrix4 right) 
        {
            Matrix4 result = new Matrix4();

            result.m00 = left.m00 - right.m00;
            result.m01 = left.m01 - right.m01;
            result.m02 = left.m02 - right.m02;
            result.m03 = left.m03 - right.m03;

            result.m10 = left.m10 - right.m10;
            result.m11 = left.m11 - right.m11;
            result.m12 = left.m12 - right.m12;
            result.m13 = left.m13 - right.m13;

            result.m20 = left.m20 - right.m20;
            result.m21 = left.m21 - right.m21;
            result.m22 = left.m22 - right.m22;
            result.m23 = left.m23 - right.m23;

            result.m30 = left.m30 - right.m30;
            result.m31 = left.m31 - right.m31;
            result.m32 = left.m32 - right.m32;
            result.m33 = left.m33 - right.m33;

            return result;
        }

        /// <summary>
        /// Compares two Matrix4 instances for equality.
        /// </summary>
        /// <param name="left"></param>
        /// <param name="right"></param>
        /// <returns>true if the Matrix 4 instances are equal, false otherwise.</returns>
        public static bool operator == (Matrix4 left, Matrix4 right) 
        {
            if(
                left.m00 == right.m00 && left.m01 == right.m01 && left.m02 == right.m02 && left.m03 == right.m03 &&
                left.m10 == right.m10 && left.m11 == right.m11 && left.m12 == right.m12 && left.m13 == right.m13 &&
                left.m20 == right.m20 && left.m21 == right.m21 && left.m22 == right.m22 && left.m23 == right.m23 &&
                left.m30 == right.m30 && left.m31 == right.m31 && left.m32 == right.m32 && left.m33 == right.m33)
                return true;

            return false;
        }

        /// <summary>
        /// Compares two Matrix4 instances for inequality.
        /// </summary>
        /// <param name="left"></param>
        /// <param name="right"></param>
        /// <returns>true if the Matrix 4 instances are not equal, false otherwise.</returns>
        public static bool operator != (Matrix4 left, Matrix4 right) 
        {
            return !(left == right);
        }

        /// <summary>
        ///        Used to allow assignment from a Matrix3 to a Matrix4 object.
        /// </summary>
        /// <param name="right"></param>
        /// <returns></returns>
        public static Matrix4 FromMatrix3(Matrix3 right) 
        {
            return right;
        }
        
        /// <summary>
        ///        Used to allow assignment from a Matrix3 to a Matrix4 object.
        /// </summary>
        /// <param name="right"></param>
        /// <returns></returns>
        public static implicit operator Matrix4(Matrix3 right) 
        {
            Matrix4 result = Matrix4.Identity;

            result.m00 = right.m00; result.m01 = right.m01; result.m02 = right.m02;
            result.m10 = right.m10; result.m11 = right.m11; result.m12 = right.m12;
            result.m20 = right.m20; result.m21 = right.m21; result.m22 = right.m22;    

            return result;
        }

        /// <summary>
        ///    Allows the Matrix to be accessed like a 2d array (i.e. matrix[2,3])
        /// </summary>
        /// <remarks>
        ///    This indexer is only provided as a convenience, and is <b>not</b> recommended for use in
        ///    intensive applications.  
        /// </remarks>
        public float this[int row, int col] 
        {
            get 
            {
                //Debug.Assert((row >= 0 && row < 4) && (col >= 0 && col < 4), "Attempt to access Matrix4 indexer out of bounds.");

                unsafe 
                {
                    fixed(float* pM = &m00)
                        return *(pM + ((4*row) + col)); 
                }
            }
            set 
            {     
                //Debug.Assert((row >= 0 && row < 4) && (col >= 0 && col < 4), "Attempt to access Matrix4 indexer out of bounds.");

                unsafe 
                {
                    fixed(float* pM = &m00)
                        *(pM + ((4*row) + col)) = value;
                }
            }
        }

        /// <summary>
        ///        Allows the Matrix to be accessed linearly (m[0] -> m[15]).  
        /// </summary>
        /// <remarks>
        ///    This indexer is only provided as a convenience, and is <b>not</b> recommended for use in
        ///    intensive applications.  
        /// </remarks>
        public float this[int index] 
        {
            get 
            {
                //Debug.Assert(index >= 0 && index < 16, "Attempt to access Matrix4 linear indexer out of bounds.");

                unsafe 
                {
                    fixed(float* pMatrix = &this.m00) 
                    {            
                        return *(pMatrix + index);
                    }
                }
            }
            set 
            {
                //Debug.Assert(index >= 0 && index < 16, "Attempt to access Matrix4 linear indexer out of bounds.");

                unsafe 
                {
                    fixed(float* pMatrix = &this.m00) 
                    {            
                        *(pMatrix + index) = value;
                    }
                }
            }
        } 

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public void MakeFloatArray(float[] floats) 
        {
            unsafe 
            {
                fixed(float* p = &m00) 
                {
                    for(int i = 0; i < 16; i++)
                        floats[i] = *(p + i);
                }
            }
        }

        /// <summary>
        ///    Gets the determinant of this matrix.
        /// </summary>
        public float Determinant 
        {
            get 
            {
                // note: this is an expanded version of the Ogre determinant() method, to give better performance in C#. Generated using a script
                float result = m00 * (m11 * (m22 * m33 - m32 * m23) - m12 * (m21 * m33 - m31 * m23) + m13 * (m21 * m32 - m31 * m22)) - 
                    m01 * (m10 * (m22 * m33 - m32 * m23) - m12 * (m20 * m33 - m30 * m23) + m13 * (m20 * m32 - m30 * m22)) + 
                    m02 * (m10 * (m21 * m33 - m31 * m23) - m11 * (m20 * m33 - m30 * m23) + m13 * (m20 * m31 - m30 * m21)) - 
                    m03 * (m10 * (m21 * m32 - m31 * m22) - m11 * (m20 * m32 - m30 * m22) + m12 * (m20 * m31 - m30 * m21));

                return result;
            }
        }

        /// <summary>
        ///    Used to generate the adjoint of this matrix.  Used internally for <see cref="Inverse"/>.
        /// </summary>
        /// <returns>The adjoint matrix of the current instance.</returns>
        private Matrix4 Adjoint() 
        {
            // note: this is an expanded version of the Ogre adjoint() method, to give better performance in C#. Generated using a script
            float val0 = m11 * (m22 * m33 - m32 * m23) - m12 * (m21 * m33 - m31 * m23) + m13 * (m21 * m32 - m31 * m22);
            float val1 = -(m01 * (m22 * m33 - m32 * m23) - m02 * (m21 * m33 - m31 * m23) + m03 * (m21 * m32 - m31 * m22));
            float val2 = m01 * (m12 * m33 - m32 * m13) - m02 * (m11 * m33 - m31 * m13) + m03 * (m11 * m32 - m31 * m12);
            float val3 = -(m01 * (m12 * m23 - m22 * m13) - m02 * (m11 * m23 - m21 * m13) + m03 * (m11 * m22 - m21 * m12));
            float val4 = -(m10 * (m22 * m33 - m32 * m23) - m12 * (m20 * m33 - m30 * m23) + m13 * (m20 * m32 - m30 * m22));
            float val5 = m00 * (m22 * m33 - m32 * m23) - m02 * (m20 * m33 - m30 * m23) + m03 * (m20 * m32 - m30 * m22);
            float val6 = -(m00 * (m12 * m33 - m32 * m13) - m02 * (m10 * m33 - m30 * m13) + m03 * (m10 * m32 - m30 * m12));
            float val7 = m00 * (m12 * m23 - m22 * m13) - m02 * (m10 * m23 - m20 * m13) + m03 * (m10 * m22 - m20 * m12);
            float val8 = m10 * (m21 * m33 - m31 * m23) - m11 * (m20 * m33 - m30 * m23) + m13 * (m20 * m31 - m30 * m21);
            float val9 = -(m00 * (m21 * m33 - m31 * m23) - m01 * (m20 * m33 - m30 * m23) + m03 * (m20 * m31 - m30 * m21));
            float val10 = m00 * (m11 * m33 - m31 * m13) - m01 * (m10 * m33 - m30 * m13) + m03 * (m10 * m31 - m30 * m11);
            float val11 = -(m00 * (m11 * m23 - m21 * m13) - m01 * (m10 * m23 - m20 * m13) + m03 * (m10 * m21 - m20 * m11));
            float val12 = -(m10 * (m21 * m32 - m31 * m22) - m11 * (m20 * m32 - m30 * m22) + m12 * (m20 * m31 - m30 * m21));
            float val13 = m00 * (m21 * m32 - m31 * m22) - m01 * (m20 * m32 - m30 * m22) + m02 * (m20 * m31 - m30 * m21);
            float val14 = -(m00 * (m11 * m32 - m31 * m12) - m01 * (m10 * m32 - m30 * m12) + m02 * (m10 * m31 - m30 * m11));
            float val15 = m00 * (m11 * m22 - m21 * m12) - m01 * (m10 * m22 - m20 * m12) + m02 * (m10 * m21 - m20 * m11);

            return new Matrix4(val0, val1, val2, val3, val4, val5, val6, val7, val8, val9, val10, val11, val12, val13, val14, val15);
        }

        #endregion

        #region Object overloads

        /// <summary>
        ///        Overrides the Object.ToString() method to provide a text representation of 
        ///        a Matrix4.
        /// </summary>
        /// <returns>A string representation of a vector3.</returns>
        public override string ToString() 
        {
            StringBuilder sb = new StringBuilder();
            
            sb.AppendFormat(" | {0} {1} {2} {3} |\n", this.m00, this.m01, this.m02, this.m03);
            sb.AppendFormat(" | {0} {1} {2} {3} |\n", this.m10, this.m11, this.m12, this.m13);
            sb.AppendFormat(" | {0} {1} {2} {3} |\n", this.m20, this.m21, this.m22, this.m23);
            sb.AppendFormat(" | {0} {1} {2} {3} |\n", this.m30, this.m31, this.m32, this.m33);

            return sb.ToString();
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
            int hashCode = 0;

            unsafe 
            {
                fixed(float* pM = &m00) 
                {
                    for(int i = 0; i < 16; i++)
                        hashCode ^= (int)(*(pM + i));
                }
            }
                    
            return hashCode;
        }

        /// <summary>
        ///        Compares this Matrix to another object.  This should be done because the 
        ///        equality operators (==, !=) have been overriden by this class.
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public override bool Equals(object obj) 
        {
            if(obj is Matrix4)
                return (this == (Matrix4)obj);
            else
                return false;
        }

        #endregion

        public static implicit operator OgreMatrix4(Matrix4 m)
        {
            return m.ToOgreMatrix4();
        }

        public static implicit operator Matrix4(OgreMatrix4 m)
        {
            return new Matrix4(m);
        }
    }
}
