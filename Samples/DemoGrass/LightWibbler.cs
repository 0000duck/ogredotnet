using System;
using System.Drawing;

using Math3D;
using OgreDotNet;


namespace DemoGrass
{
	/// <summary>
	/// Summary description for LightWibbler.
	/// </summary>
	public class LightWibbler : IDisposable
	{
		protected Light mLight;
		protected Billboard mBillboard;
		protected ColourValue mColourRange;
		protected ColourValue mHalfColour;
		protected float mMinSize;
		protected float mSizeRange;
		protected float intensity;
		public ControllerValueFloatDirector  mCVFH;
	

		public LightWibbler (Light light, Billboard billboard, Color minColour,
			Color maxColour, float minSize, float maxSize)
			: base()
		{
			mCVFH = new ControllerValueFloatDirector();
			mCVFH.SubscribeEvents();
			mCVFH.GetValueFunction += new CVFHGetValueDelegate( GetValue );
			mCVFH.SetValueFunction += new CVFHSetValueDelegate( SetValue );

			mLight = light;
			mBillboard = billboard;
			mColourRange = new OgreDotNet.ColourValue();
			mHalfColour = new OgreDotNet.ColourValue();

			mColourRange.r = ((maxColour.R - minColour.R)/255.0f) * 0.5f;
			mColourRange.g = ((maxColour.G - minColour.G)/255.0f) * 0.5f;
			mColourRange.b = ((maxColour.B - minColour.B)/255.0f) * 0.5f;

			mHalfColour.r = Converter.ToColourValue(minColour).r + mColourRange.r;
			mHalfColour.g = Converter.ToColourValue(minColour).g + mColourRange.g;
			mHalfColour.b = Converter.ToColourValue(minColour).b + mColourRange.b;

			mMinSize = minSize;
			mSizeRange = maxSize - minSize;
			intensity=1;
		}

		public void Dispose()
		{
			mCVFH.Dispose();
			mCVFH=null;
		}

		public virtual float GetValue ()
		{
			return intensity;
		}
	
		public virtual void SetValue (float value)
		{
			intensity = value;
	
			ColourValue newColour = new OgreDotNet.ColourValue();
	
			// Attenuate the brightness of the light
			newColour.r = mHalfColour.r + (mColourRange.r * intensity);
			newColour.g = mHalfColour.g + (mColourRange.g * intensity);
			newColour.b = mHalfColour.b + (mColourRange.b * intensity);
	
			mLight.SetDiffuseColour( Converter.ToColor(newColour) );
			mBillboard.SetColour( Converter.ToColor(newColour) );
			// set billboard size
			float newSize = mMinSize + (intensity * mSizeRange);
			mBillboard.SetDimensions( newSize, newSize );
			newColour = null;

		}
	}

}
