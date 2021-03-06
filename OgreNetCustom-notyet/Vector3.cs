using System;

namespace OgreDotNet
{
    public struct Vector3 
    {
        /// <summary>X component.</summary>
        public float x;
        /// <summary>Y component.</summary>
        public float y;
        /// <summary>Z component.</summary>
        public float z;

        private static readonly Vector3 zeroVector = new Vector3(0.0f, 0.0f, 0.0f);
        private static readonly Vector3 unitX = new Vector3(1.0f, 0.0f, 0.0f);
        private static readonly Vector3 unitY = new Vector3(0.0f, 1.0f, 0.0f);
        private static readonly Vector3 unitZ = new Vector3(0.0f, 0.0f, 1.0f);
        private static readonly Vector3 negativeUnitX = new Vector3(-1.0f, 0.0f, 0.0f);
        private static readonly Vector3 negativeUnitY = new Vector3(0.0f, -1.0f, 0.0f);
        private static readonly Vector3 negativeUnitZ = new Vector3(0.0f, 0.0f, -1.0f);
        private static readonly Vector3 unitVector = new Vector3(1.0f, 1.0f, 1.0f);


        /// <summary>
        ///        Creates a new 3 dimensional Vector.
        /// </summary>
        public Vector3(float x, float y, float z) 
        {
            this.x = x;
            this.y = y;
            this.z = z;
        }

        public Vector3(OgreVector3 v)
        {
            x = v.x;
            y = v.y;
            z = v.z;
        }

        public OgreVector3 ToOgreVector3()
        {
            return new OgreVector3(x, y, z);
        }

        /// <summary>
        ///        User to compare two Vector3 instances for equality.
        /// </summary>
        /// <param name="left"></param>
        /// <param name="right"></param>
        /// <returns>true or false</returns>
        public static bool operator == (Vector3 left, Vector3 right) 
        {
            return (left.x == right.x && left.y == right.y && left.z == right.z);
        }

        /// <summary>
        ///        User to compare two Vector3 instances for inequality.
        /// </summary>
        /// <param name="left"></param>
        /// <param name="right"></param>
        /// <returns>true or false</returns>
        public static bool operator != (Vector3 left, Vector3 right) 
        {
            return (left.x != right.x || left.y != right.y || left.z != right.z);
        }

        /// <summary>
        ///        Used when a Vector3 is multiplied by another vector.
        /// </summary>
        /// <param name="left"></param>
        /// <param name="right"></param>
        /// <returns></returns>
        public static Vector3 Multiply (Vector3 left, Vector3 right) 
        {
            return left * right;
        }
        
        /// <summary>
        ///        Used when a Vector3 is multiplied by another vector.
        /// </summary>
        /// <param name="left"></param>
        /// <param name="right"></param>
        /// <returns></returns>
        public static Vector3 operator * (Vector3 left, Vector3 right) 
        {
            return new Vector3(left.x * right.x, left.y * right.y, left.z * right.z);
        }

        /// <summary>
        /// Used to divide a vector by a scalar value.
        /// </summary>
        /// <param name="left"></param>
        /// <param name="scalar"></param>
        /// <returns></returns>
        public static Vector3 Divide (Vector3 left, float scalar) 
        {
            return left / scalar;
        }
        
        /// <summary>
        /// Used to divide a vector by a scalar value.
        /// </summary>
        /// <param name="left"></param>
        /// <param name="scalar"></param>
        /// <returns></returns>
        public static Vector3 operator / (Vector3 left, float scalar) 
        {
            Vector3 vector = new Vector3();

            // get the inverse of the scalar up front to avoid doing multiple divides later
            float inverse = 1.0f / scalar;

            vector.x = left.x * inverse;
            vector.y = left.y * inverse;
            vector.z = left.z * inverse;

            return vector;
        }

        /// <summary>
        ///        Used when a Vector3 is added to another Vector3.
        /// </summary>
        /// <param name="left"></param>
        /// <param name="right"></param>
        /// <returns></returns>
        public static Vector3 Add (Vector3 left, Vector3 right) 
        {
            return left + right;
        }
        
        /// <summary>
        ///        Used when a Vector3 is added to another Vector3.
        /// </summary>
        /// <param name="left"></param>
        /// <param name="right"></param>
        /// <returns></returns>
        public static Vector3 operator + (Vector3 left, Vector3 right) 
        {
            return new Vector3(left.x + right.x, left.y + right.y, left.z + right.z);
        }

        /// <summary>
        ///        Used when a Vector3 is multiplied by a scalar value.
        /// </summary>
        /// <param name="left"></param>
        /// <param name="scalar"></param>
        /// <returns></returns>
        public static Vector3 Multiply (Vector3 left, float scalar) 
        {
            return left * scalar;
        }
        
        /// <summary>
        ///        Used when a Vector3 is multiplied by a scalar value.
        /// </summary>
        /// <param name="left"></param>
        /// <param name="scalar"></param>
        /// <returns></returns>
        public static Vector3 operator * (Vector3 left, float scalar) 
        {
            return new Vector3(left.x * scalar, left.y * scalar, left.z * scalar);
        }

        /// <summary>
        ///        Used when a scalar value is multiplied by a Vector3.
        /// </summary>
        /// <param name="scalar"></param>
        /// <param name="right"></param>
        /// <returns></returns>
        public static Vector3 Multiply (float scalar, Vector3 right) 
        {
            return scalar * right;
        }
        
        /// <summary>
        ///        Used when a scalar value is multiplied by a Vector3.
        /// </summary>
        /// <param name="scalar"></param>
        /// <param name="right"></param>
        /// <returns></returns>
        public static Vector3 operator * (float scalar, Vector3 right) 
        {
            return new Vector3(right.x * scalar, right.y * scalar, right.z * scalar);
        }

        /// <summary>
        ///        Used to subtract a Vector3 from another Vector3.
        /// </summary>
        /// <param name="left"></param>
        /// <param name="right"></param>
        /// <returns></returns>
        public static Vector3 Subtract (Vector3 left, Vector3 right) 
        {
            return left - right;
        }
        
        /// <summary>
        ///        Used to subtract a Vector3 from another Vector3.
        /// </summary>
        /// <param name="left"></param>
        /// <param name="right"></param>
        /// <returns></returns>
        public static Vector3 operator - (Vector3 left, Vector3 right) 
        {
            return new Vector3(left.x - right.x, left.y - right.y, left.z - right.z);
        }


        /// <summary>
        ///        Used to negate the elements of a vector.
        /// </summary>
        /// <param name="left"></param>
        /// <returns></returns>
        public static Vector3 Negate (Vector3 left) 
        {
            return -left;
        }
        
        /// <summary>
        ///        Used to negate the elements of a vector.
        /// </summary>
        /// <param name="left"></param>
        /// <returns></returns>
        public static Vector3 operator - (Vector3 left) 
        {
            return new Vector3(-left.x, -left.y, -left.z);
        }

        /// <summary>
        ///    Returns true if the vector's scalar components are all smaller
        ///    that the ones of the vector it is compared against.
        /// </summary>
        /// <param name="left"></param>
        /// <param name="right"></param>
        /// <returns></returns>
        public static bool operator > (Vector3 left, Vector3 right) 
        {
            if(left.x > right.x && left.y > right.y && left.z > right.z) 
            {
                return true;
            }

            return false;
        }

        /// <summary>
        ///    Returns true if the vector's scalar components are all greater
        ///    that the ones of the vector it is compared against.
        /// </summary>
        /// <param name="left"></param>
        /// <param name="right"></param>
        /// <returns></returns>
        public static bool operator < (Vector3 left, Vector3 right) 
        {
            if(left.x < right.x && left.y < right.y && left.z < right.z) 
            {
                return true;
            }

            return false;
        }

        /// <summary>
        ///    
        /// </summary>
        /// <param name="vec3"></param>
        /// <returns></returns>
        public static explicit operator Vector4 (Vector3 vec3) 
        {
            return new Vector4(vec3.x, vec3.y, vec3.z, 1.0f);
        }

        /// <summary>
        ///        Used to access a Vector by index 0 = x, 1 = y, 2 = z.  
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

        /// <summary>
        ///        Performs a Dot Product operation on 2 vectors, which produces the angle between them.
        /// </summary>
        /// <param name="vector">The vector to perform the Dot Product against.</param>
        /// <returns>The angle between the 2 vectors.</returns>
        public float Dot(Vector3 vector) 
        {
            double dotProduct = 0.0f;

            dotProduct += this.x * vector.x;
            dotProduct += this.y * vector.y;
            dotProduct += this.z * vector.z;

            return (float)dotProduct;
        }

        /// <summary>
        ///        Performs a Cross Product operation on 2 vectors, which returns a vector that is perpendicular
        ///        to the intersection of the 2 vectors.  Useful for finding face normals.
        /// </summary>
        /// <param name="vector">A vector to perform the Cross Product against.</param>
        /// <returns>A new Vector3 perpedicular to the 2 original vectors.</returns>
        public Vector3 Cross(Vector3 vector) 
        {
            Vector3 cross = new Vector3();

            cross.x = (this.y * vector.z) - (this.z * vector.y);
            cross.y = (this.z * vector.x) - (this.x * vector.z);
            cross.z = (this.x * vector.y) - (this.y * vector.x);

            return cross;
        }

        /// <summary>
        ///        Finds a vector perpendicular to this one.
        /// </summary>
        /// <returns></returns>
        public Vector3 Perpendicular() 
        {
            Vector3 result = this.Cross(Vector3.UnitX);

            // check length
            if(result.LengthSquared < float.Epsilon) 
            {
                // This vector is the Y axis multiplied by a scalar, so we have to use another axis
                result = this.Cross(Vector3.UnitY);
            }

            return result;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="angle"></param>
        /// <param name="up"></param>
        /// <returns></returns>
        /*public Vector3 RandomDeviant(float angle, Vector3 up) 
        {
            Vector3 newUp = Vector3.Zero;

            if(up == Vector3.Zero)
                newUp = this.Perpendicular();
            else
                newUp = up;

            // rotate up vector by random amount around this
            Quaternion q = Quaternion.FromAngleAxis(Math.UnitRandom() * MathUtil.TWO_PI, this);
            newUp = q * newUp;

            // finally, rotate this by given angle around randomized up vector
            q = Quaternion.FromAngleAxis(angle, newUp);

            return q * this;
        }*/

        /// <summary>
        ///        Finds the midpoint between the supplied Vector and this vector.
        /// </summary>
        /// <param name="vector"></param>
        /// <returns></returns>
        public Vector3 MidPoint(Vector3 vector) 
        {
            return new Vector3((this.x + vector.x) * 0.5f, 
                (this.y + vector.y) * 0.5f, 
                (this.z + vector.z) * 0.5f);
        }

        /// <summary>
        ///        Compares the supplied vector and updates it's x/y/z components of they are higher in value.
        /// </summary>
        /// <param name="compare"></param>
        public void Ceil(Vector3 compare) 
        {
            if(compare.x >  x) 
                x = compare.x;
            if(compare.y >  y) 
                y = compare.y;
            if(compare.z >  z) 
                z = compare.z;
        }

        /// <summary>
        ///        Compares the supplied vector and updates it's x/y/z components of they are lower in value.
        /// </summary>
        /// <param name="compare"></param>
        /// <returns></returns>
        public void Floor(Vector3 compare) 
        {
            if(compare.x <  x) 
                x = compare.x;
            if(compare.y <  y) 
                y = compare.y;
            if(compare.z <  z) 
                z = compare.z;
        }

        /// <summary>
        ///        Gets the shortest arc quaternion to rotate this vector to the destination vector. 
        /// </summary>
        /// <remarks>
        ///        Don't call this if you think the dest vector can be close to the inverse
        ///        of this vector, since then ANY axis of rotation is ok.
        ///    </remarks>
        public Quaternion GetRotationTo(Vector3 destination) 
        {
            // Based on Stan Melax's article in Game Programming Gems
            Quaternion q = new Quaternion();

            Vector3 v0 = new Vector3(this.x, this.y, this.z);
            Vector3 v1 = destination;

            // normalize both vectors 
            v0.Normalize();
            v1.Normalize();

            // get the cross product of the vectors
            Vector3 c = v0.Cross(v1);

            // If the cross product approaches zero, we get unstable because ANY axis will do
            // when v0 == -v1
            float d = v0.Dot(v1);

            // If dot == 1, vectors are the same
            if (d >= 1.0f) 
            {
                return Quaternion.Identity;
            }

            float s = (float)Math.Sqrt((1+d) * 2);
            float inverse = 1 / s;

            q.x = c.x * inverse;
            q.y = c.y * inverse;
            q.z = c.z * inverse;
            q.w = s * 0.5f;

            return q;
        }

        /// <summary>
        ///        Normalizes the vector.
        /// </summary>
        /// <remarks>
        ///        This method normalises the vector such that it's
        ///        length / magnitude is 1. The result is called a unit vector.
        ///        <p/>
        ///        This function will not crash for zero-sized vectors, but there
        ///        will be no changes made to their components.
        ///    </remarks>
        ///    <returns>The previous length of the vector.</returns>
        public float Normalize() 
        {
            float length = (float)Math.Sqrt(this.x * this.x + this.y * this.y + this.z * this.z);

            // Will also work for zero-sized vectors, but will change nothing
            if (length > float.Epsilon) 
            {
                float inverseLength = 1.0f / length;

                this.x *= inverseLength;
                this.y *= inverseLength;
                this.z *= inverseLength;
            }

            return length;
        }

        /// <summary>
        ///    Calculates a reflection vector to the plane with the given normal.
        /// </summary>
        /// <remarks>
        ///    Assumes this vector is pointing AWAY from the plane, invert if not.
        /// </remarks>
        /// <param name="normal">Normal vector on which this vector will be reflected.</param>
        /// <returns></returns>
        public Vector3 Reflect(Vector3 normal) 
        {
            return this - (2 * this.Dot(normal) * normal);
        }

        /// <summary>
        ///    Gets the length (magnitude) of this Vector3.  The Sqrt operation is expensive, so 
        ///    only use this if you need the exact length of the Vector.  If vector lengths are only going
        ///    to be compared, use LengthSquared instead.
        /// </summary>
        public float Length 
        {
            get 
            { 
                return (float)Math.Sqrt(this.x * this.x + this.y * this.y + this.z * this.z); 
            }
        }

        /// <summary>
        ///    Returns the length (magnitude) of the vector squared.
        /// </summary>
        public float LengthSquared 
        {
            get 
            { 
                return (this.x * this.x + this.y * this.y + this.z * this.z); 
            }
        }

        /// <summary>
        ///        Gets a Vector3 with all components set to 0.
        /// </summary>
        public static Vector3 Zero 
        {
            get 
            { 
                return zeroVector; 
            }
        }
        
        /// <summary>
        ///        Gets a Vector3 with all components set to 1.
        /// </summary>
        public static Vector3 UnitScale 
        {
            get 
            { 
                return unitVector; 
            }
        }

        /// <summary>
        ///        Gets a Vector3 with the X set to 1, and the others set to 0.
        /// </summary>
        public static Vector3 UnitX 
        {
            get 
            { 
                return unitX; 
            }
        }

        /// <summary>
        ///        Gets a Vector3 with the Y set to 1, and the others set to 0.
        /// </summary>
        public static Vector3 UnitY 
        {
            get 
            { 
                return unitY; 
            }
        }

        /// <summary>
        ///        Gets a Vector3 with the Z set to 1, and the others set to 0.
        /// </summary>
        public static Vector3 UnitZ 
        {
            get 
            { 
                return unitZ; 
            }
        }

        /// <summary>
        ///        Gets a Vector3 with the X set to -1, and the others set to 0.
        /// </summary>
        public static Vector3 NegativeUnitX 
        {
            get 
            { 
                return negativeUnitX; 
            }
        }

        /// <summary>
        ///        Gets a Vector3 with the Y set to -1, and the others set to 0.
        /// </summary>
        public static Vector3 NegativeUnitY 
        {
            get 
            { 
                return negativeUnitY; 
            }
        }

        /// <summary>
        ///        Gets a Vector3 with the Z set to -1, and the others set to 0.
        /// </summary>
        public static Vector3 NegativeUnitZ 
        {
            get 
            { 
                return negativeUnitZ; 
            }
        }

        /// <summary>
        ///        Overrides the Object.ToString() method to provide a text representation of 
        ///        a Vector3.
        /// </summary>
        /// <returns>A string representation of a vector3.</returns>
        public override string ToString() 
        {
            return string.Format("Vector3({0}, {1}, {2})", this.x, this.y, this.z);
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
            return x.GetHashCode() ^ (y.GetHashCode() ^ (~z.GetHashCode())); 
        } 

        /// <summary>
        ///        Compares this Vector to another object.  This should be done because the 
        ///        equality operators (==, !=) have been overriden by this class.
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public override bool Equals(object obj) 
        {
            if(obj is Vector3)
                return (this == (Vector3)obj);
            else
                return false;
        }

        public static implicit operator OgreVector3(Vector3 v)
        {
            return v.ToOgreVector3();
        }

        public static implicit operator Vector3(OgreVector3 v)
        {
            return new Vector3(v);
        }
    }
}
