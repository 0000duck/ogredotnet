using System;
using System.Collections;
using System.Drawing;

using Math3D;
using OgreDotNet;
using CeguiDotNet;
using OgreDotNet.Cegui;


namespace DemoCompositor
{
	
	public class HeatVisionListener : OgreDotNet.CompositorInstanceListenerDirector
	{
		protected OgreDotNet.GpuProgramParametersSharedPtr fpParams=null;
		protected float start, end, curr;
		protected OgreDotNet.Timer timer=null;
		
		public HeatVisionListener()
		{
			this.SubscribeEvents();
			this.evtNotifyMaterialRender += new CompositorInstanceListenerDirector.CILD_Delegate(notifyMaterialRender);
			this.evtNotifyMaterialSetup += new CompositorInstanceListenerDirector.CILD_Delegate(notifyMaterialSetup);

			timer = OgreDotNet.PlatformManager.getSingleton().createTimer();
			start = end = curr = 0.0f;
		}
		~HeatVisionListener()
		{
			this.Dispose();
		}
		public override void Dispose()
		{
			if (timer!=null)
				OgreDotNet.PlatformManager.getSingleton().destroyTimer( timer );
			timer = null;
			base.Dispose();
		}

		public override void notifyMaterialSetup(uint pass_id, OgreDotNet.MaterialPtr mat)
		{
			if(pass_id == 0xDEADBABE)
			{
				timer.reset();
				fpParams = mat.Get().GetTechnique(0).getPass(0).getFragmentProgramParameters();
			}
		}
		public override void notifyMaterialRender(uint pass_id, OgreDotNet.MaterialPtr mat)
		{
			if(pass_id == 0xDEADBABE)
			{
				// "random_fractions" parameter
				fpParams.Get().setNamedConstant("random_fractions", 
					new Math3D.Vector4( OgreDotNet.OgreMath.RangeRandom(0.0f, 1.0f),
						OgreDotNet.OgreMath.RangeRandom(0.0f, 1.0f), 0.0f, 0.0f)
					);

				// "depth_modulator" parameter
				float inc = (float)this.timer.getMicroseconds() / 1000.0f;
				if ( ( (float)System.Math.Abs(curr-end) <= 0.001f) )	{
					// take a new value to reach
					end = OgreDotNet.OgreMath.RangeRandom(0.95f, 1.0f);
					start = curr;
				} else {
					if (curr > end) curr -= inc;
					else curr += inc;
				}
				timer.reset();

				fpParams.setNamedConstant("depth_modulator", new Math3D.Vector4(curr, 0.0f, 0.0f, 0.0f));
			}
		}
	}

	public class HDRListener : OgreDotNet.CompositorInstanceListenerDirector
	{
		protected int mVpWidth=0, mVpHeight=0;
		protected int[] mLumSize = new int[5];
		protected int mBloomSize=0;
		// Array params - have to pack in groups of 4 since this is how Cg generates them
		// also prevents dependent texture read problems if ops don't require swizzle
		protected float[] mBloomTexWeights = new float[15*4];
		protected float[] mBloomTexOffsetsHorz = new float[15*4];
		protected float[] mBloomTexOffsetsVert = new float[15*4];

		public HDRListener()
		{
			this.SubscribeEvents();
			this.evtNotifyMaterialRender += new CompositorInstanceListenerDirector.CILD_Delegate(notifyMaterialRender);
			this.evtNotifyMaterialSetup += new CompositorInstanceListenerDirector.CILD_Delegate( notifyMaterialSetup);
		}
		~HDRListener()
		{
		}
		public void notifyViewportSize(int width, int height)
		{
			mVpWidth = width;
			mVpHeight = height;
		}
		public void notifyCompositor(CompositorInstance instance)
		{
			// Get some RTT dimensions for later calculations
			CTTextureDefinitionsIterator defIter = instance.getTechnique().GetTextureDefinitionIterator();
			while (defIter.hasMoreElements())
			{
				CTTextureDefinition def = defIter.getNext();
				// store the sizes of downscaled textures (size can be tweaked in script)
				if (OgreDotNet.StringUtil.startsWith( def.getName(), "rt_lum", false))
				{
					int idx = System.Convert.ToInt32( def.getName().Substring( 6,1) );
					mLumSize[idx] = (int)def.getWidth(); // should be square
				}
				else if(def.getName() == "rt_bloom0")
				{
					mBloomSize = (int)def.getWidth(); // should be square
					// Calculate gaussian texture offsets & weights
					float deviation = 3.0f;
					float texelSize = 1.0f / (float)mBloomSize;

					// central sample, no offset
					mBloomTexOffsetsHorz[0] = 0.0f;
					mBloomTexOffsetsHorz[1] = 0.0f;
					mBloomTexWeights[0] = mBloomTexWeights[1] = 
						mBloomTexWeights[2] = OgreDotNet.OgreMath.gaussianDistribution( 0, 0, deviation);
					mBloomTexWeights[3] = 1.0f;

					// 'pre' samples
					for(int i = 1; i < 8; ++i)
					{
						mBloomTexWeights[(i*4)+0] = mBloomTexWeights[(i*4)+1] = 
							mBloomTexWeights[(i*4)+2] = 1.25f * OgreDotNet.OgreMath.gaussianDistribution(i, 0, deviation);
						mBloomTexWeights[(i*4)+3] = 1.0f;
						mBloomTexOffsetsHorz[(i*4)+0] = (float)i * texelSize;
						mBloomTexOffsetsHorz[(i*4)+1] = 0.0f;
						mBloomTexOffsetsVert[(i*4)+0] = 0.0f;
						mBloomTexOffsetsVert[(i*4)+1] = (float)i * texelSize;
					}
					// 'post' samples
					for(int i = 8; i < 15; ++i)
					{
						mBloomTexWeights[(i*4)+0] = mBloomTexWeights[(i*4)+1] = 
							mBloomTexWeights[(i*4)+2] = mBloomTexWeights[((i - 7)*4)+0];
						mBloomTexWeights[(i*4)+3] = 1.0f;

						mBloomTexOffsetsHorz[(i*4)+0] = -mBloomTexOffsetsHorz[((i - 7)*4)+0];
						mBloomTexOffsetsHorz[(i*4)+1] = 0.0f;
						mBloomTexOffsetsVert[(i*4)+0] = 0.0f;
						mBloomTexOffsetsVert[(i*4)+1] = -mBloomTexOffsetsVert[((i - 7)*4)+1];
					}
				}
			}
		}

		public override void notifyMaterialSetup(uint pass_id, MaterialPtr mat)
		{
			// Prepare the fragment params offsets
			switch(pass_id)
			{
				//case 994: // rt_lum4
				case 993: // rt_lum3
				case 992: // rt_lum2
				case 991: // rt_lum1
				case 990: // rt_lum0
					{
						// Need to set the texel size
						// Set from source, which is the one higher in the chain
						mat.Get().Load();
						uint idx = pass_id - 990 + 1;
						float texelSize = 1.0f / (float)mLumSize[idx];
						GpuProgramParametersSharedPtr fparams = 
							mat.Get().GetBestTechnique().getPass(0).getFragmentProgramParameters();
						fparams.Get().setNamedConstant("texelSize", texelSize);
					}
					break;
				case 800: // rt_brightpass
					break;
				case 701: // rt_bloom1
					{
						// horizontal bloom
						mat.Get().Load();
						GpuProgramParametersSharedPtr fparams = 
							mat.Get().GetBestTechnique().getPass(0).getFragmentProgramParameters();
						string progName = mat.Get().GetBestTechnique().getPass(0).getFragmentProgramName();
						// A bit hacky - Cg & HLSL index arrays via [0], GLSL does not
						if (progName.IndexOf("GLSL") > -1)
						{
							fparams.setNamedConstant("sampleOffsets", mBloomTexOffsetsHorz, 15);
							fparams.setNamedConstant("sampleWeights", mBloomTexWeights, 15);
						}
						else
						{
							fparams.setNamedConstant("sampleOffsets[0]", mBloomTexOffsetsHorz, 15);
							fparams.setNamedConstant("sampleWeights[0]", mBloomTexWeights, 15);
						}
					}
					break;
				case 700: // rt_bloom0
					{
						// vertical bloom 
						mat.Get().Load();
						GpuProgramParametersSharedPtr fparams = 
							mat.Get().GetTechnique(0).getPass(0).getFragmentProgramParameters();
						string progName = mat.Get().GetBestTechnique().getPass(0).getFragmentProgramName();
						// A bit hacky - Cg & HLSL index arrays via [0], GLSL does not
						if (progName.IndexOf("GLSL") > -1)
						{
							fparams.setNamedConstant("sampleOffsets", mBloomTexOffsetsVert, 15);
							fparams.setNamedConstant("sampleWeights", mBloomTexWeights, 15);
						}
						else
						{
							fparams.setNamedConstant("sampleOffsets[0]", mBloomTexOffsetsVert, 15);
							fparams.setNamedConstant("sampleWeights[0]", mBloomTexWeights, 15);
						}
					}
					break;
			}
		}
		public override void notifyMaterialRender(uint pass_id, MaterialPtr mat)
		{
		}
	}

}
