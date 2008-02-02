%{
#include "OgreBillboard.h"
%}

%rename Ogre::Billboard::mParentSet       ParentSet;
%rename Ogre::Billboard::mRotation        Rotation;
%rename Ogre::Billboard::getRotation      GetRotation;
%rename Ogre::Billboard::setRotation      SetRotation;
%rename Ogre::Billboard::setPosition      SetPosition;
%rename Ogre::Billboard::setPosition      GetPosition;
%rename Ogre::Billboard::setDimensions    SetDimensions;
%rename Ogre::Billboard::resetDimensions  ResetDimensions;
%rename Ogre::Billboard::setColour        SetColour;
%rename Ogre::Billboard::getColour        GetColour;
%rename Ogre::Billboard::hasOwnDimensions HasOwnDimensions;
%rename Ogre::Billboard::getOwnWidth      GetOwnWidth;
%rename Ogre::Billboard::getOwnHeight     GetOwnHeight;

%rename Ogre::Billboard::_notifyOwner     m_NotifyOwner;


%typemap(cscode) Ogre::Billboard
%{
	public Math3D.Vector3 Position	{
		get	{
			return new Math3D.Vector3(mPosition.x, mPosition.y, mPosition.z);
		}
		set	{
			mPosition.x = value.x;
			mPosition.y = value.x;
			mPosition.z = value.x;
		}
	}
	public Math3D.Vector3 Direction	{
		get	{
			return new Math3D.Vector3(mDirection.x, mDirection.y, mDirection.z);
		}
		set	{
			mDirection.x = value.x;
			mDirection.y = value.x;
			mDirection.z = value.x;
		}
	}
	public System.Drawing.Color Colour	{
		get	{
			return System.Drawing.Color.FromArgb((int)(mColour.GetA()*255.0f), 
				(int)(mColour.GetR()*255.0f), 
				(int)(mColour.GetG()*255.0f), 
				(int)(mColour.GetB()*255.0f));
		}
		set	{
			mColour.SetR( (float)value.R/255.0f);
			mColour.SetG( (float)value.G/255.0f);
			mColour.SetB( (float)value.B/255.0f);
			mColour.SetA( (float)value.A/255.0f);
		}
	}
	public float OwnWidth	{
		get	{
			return GetOwnWidth();
		}
	}
	public float OwnHeight	{
		get	{
			return GetOwnHeight();
		}
	}
%}

%include OgreBillboard.h

