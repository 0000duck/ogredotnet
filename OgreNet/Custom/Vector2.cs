using System;

namespace OgreDotNet
{
	public struct Vector2 
	{
		#region Fields

		public float x, y;

		#endregion Fields

		#region Constructors

		/// <summary>
		///     Constructor.
		/// </summary>
		/// <param name="x">X position.</param>
		/// <param name="y">Y position</param>
		public Vector2(float x, float y) 
		{
			this.x = x;
			this.y = y;
		}

		public Vector2( OgreVector2 v )
		{
			this.x = v.x;
			this.y = v.y;
		}

		public OgreVector2 ToOgreVector2()
		{
			return new OgreVector2( this.x, this.y );
		}

		#endregion Constructors

		/// <summary>
		///		Used when a Vector2 is added to another Vector2.
		/// </summary>
		/// <param name="left"></param>
		/// <param name="right"></param>
		/// <returns></returns>
		public static Vector2 Add (Vector2 left, Vector2 right) 
		{
			return left + right;
		}
        
		/// <summary>
		///		Used when a Vector2 is added to another Vector2.
		/// </summary>
		/// <param name="left"></param>
		/// <param name="right"></param>
		/// <returns></returns>
		public static Vector2 operator + (Vector2 left, Vector2 right) 
		{
			return new Vector2(left.x + right.x, left.y + right.y);
		}

		/// <summary>
		///		Used to subtract a Vector2 from another Vector2.
		/// </summary>
		/// <param name="left"></param>
		/// <param name="right"></param>
		/// <returns></returns>
		public static Vector2 Subtract (Vector2 left, Vector2 right) 
		{
			return left - right;
		}
        
		/// <summary>
		///		Used to subtract a Vector2 from another Vector2.
		/// </summary>
		/// <param name="left"></param>
		/// <param name="right"></param>
		/// <returns></returns>
		public static Vector2 operator - (Vector2 left, Vector2 right) 
		{
			return new Vector2(left.x - right.x, left.y - right.y);
		}

		/// <summary>
		///		Used when a Vector2 is multiplied by a scalar value.
		/// </summary>
		/// <param name="left"></param>
		/// <param name="scalar"></param>
		/// <returns></returns>
		public static Vector2 Multiply (Vector2 left, float scalar) 
		{
			return left * scalar;
		}
        
		/// <summary>
		///		Used when a Vector2 is multiplied by a scalar value.
		/// </summary>
		/// <param name="left"></param>
		/// <param name="scalar"></param>
		/// <returns></returns>
		public static Vector2 operator * (Vector2 left, float scalar) 
		{
			return new Vector2(left.x * scalar, left.y * scalar);
		}

		/// <summary>
		///		Used when a scalar value is multiplied by a Vector2.
		/// </summary>
		/// <param name="scalar"></param>
		/// <param name="right"></param>
		/// <returns></returns>
		public static Vector2 Multiply (float scalar, Vector2 right) 
		{
			return scalar * right;
		}
        
		/// <summary>
		///		Used when a scalar value is multiplied by a Vector2.
		/// </summary>
		/// <param name="scalar"></param>
		/// <param name="right"></param>
		/// <returns></returns>
		public static Vector2 operator * (float scalar, Vector2 right) 
		{
			return new Vector2(right.x * scalar, right.y * scalar);
		}

		/// <summary>
		///		Used to negate the elements of a vector.
		/// </summary>
		/// <param name="left"></param>
		/// <returns></returns>
		public static Vector2 Negate (Vector2 left) 
		{
			return -left;
		}
        
		/// <summary>
		///		Used to negate the elements of a vector.
		/// </summary>
		/// <param name="left"></param>
		/// <returns></returns>
		public static Vector2 operator - (Vector2 left) 
		{
			return new Vector2(-left.x, -left.y);
		}

		public static implicit operator OgreVector2(Vector2 v)
		{
			return v.ToOgreVector2();
		}

		public static implicit operator Vector2(OgreVector2 v)
		{
			return new Vector2(v);
		}
	}

}
