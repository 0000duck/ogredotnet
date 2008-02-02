%{
#include "OgreParticleEmitter.h"
%}

%rename Ogre::ParticleEmitter::setPosition            SetPosition;
%rename Ogre::ParticleEmitter::getPosition            GetPosition;
%rename Ogre::ParticleEmitter::setDirection           SetDirection;
%rename Ogre::ParticleEmitter::getDirection           GetDirection;
%rename Ogre::ParticleEmitter::setAngle               SetAngle;
%rename Ogre::ParticleEmitter::getAngle               GetAngle;
%rename Ogre::ParticleEmitter::setParticleVelocity    SetParticleVelocity;
%rename Ogre::ParticleEmitter::setParticleVelocity    SetParticleVelocity;
%rename Ogre::ParticleEmitter::setMinParticleVelocity SetMinParticleVelocity;
%rename Ogre::ParticleEmitter::setMaxParticleVelocity SetMaxParticleVelocity;
%rename Ogre::ParticleEmitter::getParticleVelocity    GetParticleVelocity;
%rename Ogre::ParticleEmitter::getMinParticleVelocity GetMinParticleVelocity;
%rename Ogre::ParticleEmitter::getMaxParticleVelocity GetMaxParticleVelocity;
%rename Ogre::ParticleEmitter::setEmissionRate        SetEmissionRate;
%rename Ogre::ParticleEmitter::getEmissionRate        GetEmissionRate;
%rename Ogre::ParticleEmitter::setTimeToLive          SetTimeToLive;
%rename Ogre::ParticleEmitter::setTimeToLive          SetTimeToLive;
%rename Ogre::ParticleEmitter::setMinTimeToLive       SetMinTimeToLive;
%rename Ogre::ParticleEmitter::setMaxTimeToLive       SetMaxTimeToLive;
%rename Ogre::ParticleEmitter::getTimeToLive          GetTimeToLive;
%rename Ogre::ParticleEmitter::getMinTimeToLive       GetMinTimeToLive;
%rename Ogre::ParticleEmitter::getMaxTimeToLive       GetMaxTimeToLive;
%rename Ogre::ParticleEmitter::setColour              SetColour;
%rename Ogre::ParticleEmitter::setColourRangeStart    SetColourRangeStart;
%rename Ogre::ParticleEmitter::setColourRangeEnd      SetColourRangeEnd;
%rename Ogre::ParticleEmitter::getColour              GetColour;
%rename Ogre::ParticleEmitter::getColourRangeStart    GetColourRangeStart;
%rename Ogre::ParticleEmitter::getColourRangeEnd      GetColourRangeEnd;
%rename Ogre::ParticleEmitter::getType                GetEmitterType;	// We cant call it GetType(), because it is a reserved method implemented by each object
%rename Ogre::ParticleEmitter::setEnabled             SetEnabled;
%rename Ogre::ParticleEmitter::getEnabled             GetEnabled;
%rename Ogre::ParticleEmitter::setStartTime           SetStartTime;
%rename Ogre::ParticleEmitter::getStartTime           GetStartTime;
%rename Ogre::ParticleEmitter::setDuration            SetDuration;
%rename Ogre::ParticleEmitter::getDuration            GetDuration;
%rename Ogre::ParticleEmitter::setDuration            SetDuration;
%rename Ogre::ParticleEmitter::setMinDuration         SetMinDuration;
%rename Ogre::ParticleEmitter::setMaxDuration         SetMaxDuration;
%rename Ogre::ParticleEmitter::getMinDuration         GetMinDuration;
%rename Ogre::ParticleEmitter::getMaxDuration         GetMaxDuration;
%rename Ogre::ParticleEmitter::setRepeatDelay         SetRepeatDelay;
%rename Ogre::ParticleEmitter::getRepeatDelay         GetRepeatDelay;
%rename Ogre::ParticleEmitter::setRepeatDelay         SetRepeatDelay;
%rename Ogre::ParticleEmitter::setMinRepeatDelay      SetMinRepeatDelay;
%rename Ogre::ParticleEmitter::setMaxRepeatDelay      SetMaxRepeatDelay;
%rename Ogre::ParticleEmitter::getMinRepeatDelay      GetMinRepeatDelay;
%rename Ogre::ParticleEmitter::getMaxRepeatDelay      GetMaxRepeatDelay;


%typemap(cscode) Ogre::ParticleEmitter
%{
	public float TimeToLive
	{
		get
		{
			return GetTimeToLive();
		}
		set
		{
			SetTimeToLive((float)value);
		}
	}
	
	public float EmissionRate
	{
		get
		{
			return GetEmissionRate();
		}
		set
		{
			SetEmissionRate((float)value );
		}
	}
	
	public float ParticleVelocity
	{
		get
		{
			return GetParticleVelocity();
		}
		set
		{
			SetParticleVelocity((float)value);
		}
	}
	
	public Math3D.Vector3 Direction
	{
		get
		{
			return GetDirection();	
		}
		set
		{
			SetDirection( value );	
		}
	}
	
	public Math3D.Vector3 Position
	{
		get
		{
			return GetPosition();
		}
		set
		{
			SetPosition( value );
		}
	}
	
	public void SetColors( System.Drawing.Color c1, System.Drawing.Color c2 )
	{
		SetColour( c1, c2 );
	}
%}


%include "OgreParticleEmitter.h"