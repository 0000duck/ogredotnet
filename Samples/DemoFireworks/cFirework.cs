// created on 11/27/2005 at 12:51 PM
using System;
using System.Drawing;
using System.Collections;
using System.Runtime.InteropServices;

using Math3D;
using OgreDotNet;

namespace DemoFireworks
{
	/// <summary>
	/// cfirework
	/// </summary>
	public class cfirework
	{
		public enum FWType 
		{
			None,
			Fountain01,
			Fountain02,
			Rocket01,
			Rocket02,
			Explode01,
			Explode02,
			Explode03,
			Explode04
		};

		protected SceneManager mSceneManager;
		public string	mName;
		public FWType	mType = FWType.Fountain01;
		public FWType	mExplodeType = FWType.Explode01;
		public float	mTimeAlive=0;
		public float	mTimeToLive=0;
		public bool		isDead=false;
		public bool		mExploded = false;
		public bool		mMoveable=true;
		
		public SceneNode mNode = null;
		public ParticleSystem mPS = null;
		public ParticleSystem mPS2 = null;
		
		protected static float RocketArcXMin=0.0f, RocketArcXMax=0.25f;
		protected static float RocketArcZMin=0.0f, RocketArcZMax=0.25f;
		protected static float RocketSpeedYMin=1.0f, RocketSpeedYMax=1.5f;
		public float mArcX=0.0f, mArcZ=0.0f, mArcXRate=0.0f, mArcZRate=0.0f, mSpeedY=0.0f;

		public cfirework(string name, FWType t, SceneManager sm)
		{
			mName = name;
			mType = t;
			mSceneManager = sm;

			if ( (mType==FWType.Fountain01) || (mType==FWType.Fountain02) )
			{
				mPS = mSceneManager.CreateParticleSystem( mName, "Fireworks/Fountain01");
				mNode = mSceneManager.GetRootSceneNode().CreateChildSceneNode(mName);
				mNode.AttachObject(mPS);
			}
			else if ( (mType==FWType.Rocket01) || (mType==FWType.Rocket02) )
			{
				mPS = mSceneManager.CreateParticleSystem(mName, "Fireworks/RocketTrail");
				mNode = mSceneManager.GetRootSceneNode().CreateChildSceneNode(mName);
				mNode.AttachObject(mPS);
				
				float pn =1.0f;
				if (OgreDotNet.OgreMath.RangeRandom( 0.0f, 1.0f) > 0.5f)
					pn = -1.0f;
				mArcXRate = OgreDotNet.OgreMath.RangeRandom( cfirework.RocketArcXMin * pn, cfirework.RocketArcXMax * pn);

				if (OgreDotNet.OgreMath.RangeRandom( 0.0f, 1.0f) > 0.5f)
					pn = -1.0f;
				mArcZRate = OgreDotNet.OgreMath.RangeRandom( cfirework.RocketArcZMin * pn, cfirework.RocketArcZMax * pn);
				
				this.mSpeedY = OgreDotNet.OgreMath.RangeRandom( cfirework.RocketSpeedYMin  , cfirework.RocketSpeedYMax );
			}
		}
		
		public void Update( float TimeSinceLastFrame )
		{
			//cFireworks.Instance.mLog.LogMessage( string.Format("cfirework " + mName + "  Update 1  {0}", TimeSinceLastFrame) );
			if (mTimeToLive > 0)
				mTimeAlive += TimeSinceLastFrame;
			if ((mTimeToLive >0) && (mTimeAlive >= mTimeToLive))
			{
				if (mExploded)
					this.isDead = true;
				else
					this.ExplodeIt( FWType.Explode01 );
			}
			else if (mMoveable)
			{
				if ( (mType==FWType.Fountain01) || (mType==FWType.Fountain02) )
				{
				}
				else if ( (mType==FWType.Rocket01) || (mType==FWType.Rocket02) )
				{
						mArcX += (mArcXRate * TimeSinceLastFrame);
						mArcZ += (mArcZRate * TimeSinceLastFrame);
						Vector3 delta;
						delta.x=mArcX; delta.y=mSpeedY; delta.z=mArcZ; 
						mNode.Translate( delta, Node.TransformSpace.TS_LOCAL);
				}
			}
		}
		
		public void ExplodeIt(FWType et)
		{
			mExplodeType= et;
			mExploded = true;
			OgreDotNet.ParticleEmitter pe=null;
			if ( (mType==FWType.Fountain01) || (mType==FWType.Fountain02) )
			{
				//make the fountain stop
				pe =  mPS.GetEmitter(0);
				pe.EmissionRate = 0;
				pe.TimeToLive = 1;
				this.isDead = true;
			}
			else if ( (mType==FWType.Rocket01) || (mType==FWType.Rocket02) )
			{
				//let the smoke trail live
				pe =  mPS.GetEmitter(0);
				pe.EmissionRate = 0;
				pe.TimeToLive = 5000;
				mMoveable = false;
				mTimeToLive = OgreDotNet.OgreMath.RangeRandom( 1.0f, 4.0f);
				mTimeAlive=0;
			}
			
			float r=0;
			switch (mExplodeType)
			{
				case FWType.None:
					break;
				case FWType.Explode01:
					mPS2 = mSceneManager.CreateParticleSystem(mName + "ps2", "Fireworks/RocketExplode01");
					pe =  mPS2.GetEmitter(0);
					r = OgreDotNet.OgreMath.RangeRandom( 0.1f, 4.0f);
					pe.SetMinTimeToLive( r );
					pe.SetMaxTimeToLive( r + 2.0f );
					pe.SetParticleVelocity( r * 100.0f );
					pe.SetColour( Converter.GetColor(
						OgreDotNet.OgreMath.RangeRandom( 0.001f, 1.0f),
						OgreDotNet.OgreMath.RangeRandom( 0.001f, 1.0f),
						OgreDotNet.OgreMath.RangeRandom( 0.001f, 1.0f)) );
					mNode.AttachObject(mPS2);
					break;
				case FWType.Explode02:
					mPS2 = mSceneManager.CreateParticleSystem(mName + "ps2", "Fireworks/RocketExplode01");
					mNode.AttachObject(mPS2);
					break;
				case FWType.Explode03:
					mPS2 = mSceneManager.CreateParticleSystem(mName + "ps2", "Fireworks/RocketExplode01");
					mNode.AttachObject(mPS2);
					break;
				case FWType.Explode04:
					mPS2 = mSceneManager.CreateParticleSystem(mName + "ps2", "Fireworks/RocketExplode01");
					mNode.AttachObject(mPS2);
					break;
			}
		}


	}
}
