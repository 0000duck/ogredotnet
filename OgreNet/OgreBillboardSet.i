%{
#include "OgreBillboardSet.h"
%}

//change enum value names to .net style
//enum BillboardType
#define BBT_POINT                 Point 
#define BBT_ORIENTED_COMMON       OrientedCommon
#define BBT_ORIENTED_SELF         OrientedSelf
#define BBT_PERPENDICULAR_COMMON  PerpendicularCommon
#define BBT_PERPENDICULAR_SELF    PerpendicularSelf
//enum BillboardOrigin
#define BBO_TOP_LEFT      TopLeft
#define BBO_TOP_CENTER    TopCenter
#define BBO_TOP_RIGHT     TopRight
#define BBO_CENTER_LEFT   CenterLeft
#define BBO_CENTER        Center
#define BBO_CENTER_RIGHT  CenterRight
#define BBO_BOTTOM_LEFT   BottomLeft
#define BBO_BOTTOM_CENTER BottomCenter
#define BBO_BOTTOM_RIGHT  BottomRight
//enum BillboardRotationType
#define BBR_VERTEX    BBRotationTypeVertex
#define BBR_TEXCOORD  BBRotationTypeTexCoord

%rename Ogre::BillboardSet::_notifyBillboardResized                 m_NotifyBillboardResized;
%rename Ogre::BillboardSet::_notifyBillboardTextureCoordsModified    m_NotifyBillboardTextureCoordsModified;
%rename Ogre::BillboardSet::_updateBounds                           m_UpdateBounds;

//TODO this retruns an array of FloatRect
// virtual Ogre::FloatRect const * getTextureCoords(uint16 * oNumCoords);
%apply unsigned short *INOUT { Ogre::uint16 * oNumCoords };
//%ignore Ogre::BillboardSet::getTextureCoords;

//ignore because of RenderOperation is private
%ignore Ogre::BillboardSet::getRenderOperation;

%typemap(cscode) Ogre::BillboardSet
%{
    public virtual int NumBillboards {
        get
        {
            return getNumBillboards();
        }
    }

    public virtual bool Autoextend {
        get
        {
            return getAutoextend();
        }

        set
        {
            setAutoextend((bool)value);
        }
    }

    public virtual UInt32 PoolSize {
        get
        {
            return getPoolSize();
        }

        set
        {
            setPoolSize((UInt32)value);
        }
    }

    public virtual BillboardOrigin BillboardOrigin {
        get
        {
            return getBillboardOrigin();
        }
        set
        { 
            setBillboardOrigin((BillboardOrigin)value);
        }
    }

    public virtual float DefaultWidth {
        get
        {
            return getDefaultWidth();
        }
        set
        {
            setDefaultWidth((float)value);
        }
    }

    public virtual float DefaultHeight {
        get
        {
            return getDefaultHeight();
        }

        set
        {
            setDefaultHeight((float)value);
        }
    }

//  public virtual void MaterialName {
//    set
//    {
//        setMaterialName((string)value);
//    }
//  }

    public override AxisAlignedBox BoundingBox {
        get
        {
            return getBoundingBox();
        }
    }

    public override float BoundingRadius {
        get
        {
            return getBoundingRadius();
        }
    }

    public virtual MaterialPtr Material {
        get
        {
            return getMaterial();
        }
    }

    public Math3D.Quaternion WorldOrientation {
        get
        {
            return getWorldOrientation();
        }
    }

    public Math3D.Vector3 WorldPosition {
        get
        {
            return getWorldPosition();
        }
    }

    public virtual bool CullIndividually {
        get
        {
            return getCullIndividually();
        }
        set
        {
            setCullIndividually((bool)value);
        }  
    }

    public virtual BillboardType BillboardType {
        get
        {
            return getBillboardType();
        }

        set
        {
            setBillboardType((BillboardType)value);
        }
    }

    public virtual Math3D.Vector3 CommonDirection {
        get
        {
            return getCommonDirection();
        }
        set
        {
            setCommonDirection(value);
        }
    }

    public override string Name {
        get
        {
            return getName();
        }
    }

    public override string MovableType {
        get
        {
            return getMovableType();
        }
    }

    public LightList Lights {
        get
        {
            return getLights();
        }
    }
%}

%include OgreBillboardSet.h

%extend Ogre::BillboardSet {
    Renderable * GetAsRenderable()    {
        return (Renderable*)self;
    }
};
