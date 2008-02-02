using System;
using System.Drawing;

namespace OgreDotNet
{
	/// <summary>
	/// Summary description for Converter.
	/// </summary>
	public sealed class Converter
	{
		public static ColourValue ToColourValue( Color c )
		{
			return new ColourValue( c.R/255.0f, c.G/255.0f, c.B/255.0f, c.A/255.0f );
		}

		public static System.Drawing.Color ToColor( ColourValue c )
		{
			return Color.FromArgb((int)(c.GetA()*255.0f), 
				(int)(c.GetR()*255.0f), 
				(int)(c.GetG()*255.0f), 
				(int)(c.GetB()*255.0f));
		}

		public static System.Drawing.Color GetColor( float r, float g, float b, float a )
		{
			return Color.FromArgb( (int)(a*255.0f), (int)(r*255.0f), (int)(g*255.0f), (int)(b*255.0f) );
		}

		public static System.Drawing.Color GetColor( float r, float g, float b )
		{
			return Color.FromArgb( 255, (int)(r*255.0f), (int)(g*255.0f), (int)(b*255.0f) );
		}
	}
}
