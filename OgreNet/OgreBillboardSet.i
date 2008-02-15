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


%rename Ogre::BillboardSet::createBillboard           CreateBillboard;
%rename Ogre::BillboardSet::getNumBillboards          GetNumBillboards;
%rename Ogre::BillboardSet::setAutoextend             SetAutoextend;
%rename Ogre::BillboardSet::getAutoextend             GetAutoextend;
%rename Ogre::BillboardSet::setSortingEnabled         SetSortingEnabled;
%rename Ogre::BillboardSet::getSortingEnabled         GetSortingEnabled;
%rename Ogre::BillboardSet::setPoolSize               SetPoolSize;
%rename Ogre::BillboardSet::getPoolSize               GetPoolSize;
%rename Ogre::BillboardSet::clear                     Clear;
%rename Ogre::BillboardSet::getBillboard              GetBillboard;
%rename Ogre::BillboardSet::removeBillboard           RemoveBillboard;
%rename Ogre::BillboardSet::setBillboardOrigin        SetBillboardOrigin;
%rename Ogre::BillboardSet::getBillboardOrigin        GetBillboardOrigin;
%rename Ogre::BillboardSet::setBillboardRotationType  SetBillboardRotationType;
%rename Ogre::BillboardSet::getBillboardRotationType  GetBillboardRotationType;
%rename Ogre::BillboardSet::setDefaultDimensions      SetDefaultDimensions;
%rename Ogre::BillboardSet::setDefaultWidth           SetDefaultWidth;
%rename Ogre::BillboardSet::getDefaultWidth           GetDefaultWidth;
%rename Ogre::BillboardSet::setDefaultHeight          SetDefaultHeight;
%rename Ogre::BillboardSet::getDefaultHeight          GetDefaultHeight;
%rename Ogre::BillboardSet::setMaterialName           SetMaterialName;
%rename Ogre::BillboardSet::getMaterialName           GetMaterialName;
%rename Ogre::BillboardSet::beginBillboards           BeginBillboards;
%rename Ogre::BillboardSet::injectBillboard           InjectBillboard;
%rename Ogre::BillboardSet::endBillboards             EndBillboards;
%rename Ogre::BillboardSet::setBounds                 SetBounds;
%rename Ogre::BillboardSet::getCullIndividually       GetCullIndividually;
%rename Ogre::BillboardSet::setCullIndividually       SetCullIndividually;
%rename Ogre::BillboardSet::setBillboardType          SetBillboardType;
%rename Ogre::BillboardSet::getBillboardType          GetBillboardType;
%rename Ogre::BillboardSet::setCommonDirection        SetCommonDirection;
%rename Ogre::BillboardSet::getCommonDirection        GetCommonDirection;
%rename Ogre::BillboardSet::setCommonUpVector        SetCommonUpVector;
%rename Ogre::BillboardSet::getCommonUpVector        GetCommonUpVector;
%rename Ogre::BillboardSet::setUseAccurateFacing     SetUseAccurateFacing;
%rename Ogre::BillboardSet::getUseAccurateFacing     GetUseAccurateFacing;
%rename Ogre::BillboardSet::setBillboardsInWorldSpace    SetBillboardsInWorldSpace;
%rename Ogre::BillboardSet::setTextureCoords             SetTextureCoords;
%rename Ogre::BillboardSet::setTextureStacksAndSlices    SetTextureStacksAndSlices;
%rename Ogre::BillboardSet::getTextureCoords             GetTextureCoords;
%rename Ogre::BillboardSet::setPointRenderingEnabled     SetPointRenderingEnabled;
%rename Ogre::BillboardSet::isPointRenderingEnabled      IsPointRenderingEnabled;


%rename Ogre::BillboardSet::_notifyBillboardResized                 m_NotifyBillboardResized;
%rename Ogre::BillboardSet::_notifyBillboardTextureCoordsModified    m_NotifyBillboardTextureCoordsModified;
%rename Ogre::BillboardSet::_updateBounds                           m_UpdateBounds;


//Overridden from MovableObject
%rename Ogre::BillboardSet::getBoundingBox            GetBoundingBox;
%rename Ogre::BillboardSet::getBoundingRadius         GetBoundingRadius;
%rename Ogre::BillboardSet::getMaterial               GetMaterial;
%rename Ogre::BillboardSet::getMovableType            GetMovableType;

//Overridden from Renderable
%rename Ogre::BillboardSet::getWorldTransforms        GetWorldTransforms;
%rename Ogre::BillboardSet::getWorldOrientation       GetWorldOrientation;
%rename Ogre::BillboardSet::getWorldPosition          GetWorldPosition;
%rename Ogre::BillboardSet::getSquaredViewDepth       GetSquaredViewDepth;
%rename Ogre::BillboardSet::getLights                 GetLights;


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
        return GetNumBillboards();
    }
  }

  public virtual bool Autoextend {
    get
    {
        return GetAutoextend();
    }

    set
    {
        SetAutoextend((bool)value);
    }
  }

  public virtual UInt32 PoolSize {
    get
    {
        return GetPoolSize();
    }

    set
    {
        SetPoolSize((UInt32)value);
    }
  }

  public virtual BillboardOrigin BillboardOrigin {
    get
    {
         return GetBillboardOrigin();
    }
    set
    { 
         SetBillboardOrigin((BillboardOrigin)value);
    }
  }

  public virtual float DefaultWidth {
    get
    {
        return GetDefaultWidth();
    }
    set
    {
        SetDefaultWidth((float)value);
    }
  }

  public virtual float DefaultHeight {
    get
    {
        return GetDefaultHeight();
    }

    set
    {
        SetDefaultHeight((float)value);
    }
  }

//  public virtual void MaterialName {
//    set
//    {
//        SetMaterialName((string)value);
//    }
//  }

  public override AxisAlignedBox BoundingBox {
    get
    {
        return GetBoundingBox();
    }
  }

  public override float BoundingRadius {
    get
    {
        return GetBoundingRadius();
    }
  }

  public virtual MaterialPtr Material {
    get
    {
        return GetMaterial();
    }
  }

  public Math3D.Quaternion WorldOrientation {
    get
    {
        return GetWorldOrientation();
    }
  }

  public Math3D.Vector3 WorldPosition {
    get
    {
        return GetWorldPosition();
    }
  }

  public virtual bool CullIndividually {
    get
    {
        return GetCullIndividually();
    }
    set
    {
       SetCullIndividually((bool)value);
    }  
  }

  public virtual BillboardType BillboardType {
    get
    {
        return GetBillboardType();
    }

    set
    {
        SetBillboardType((BillboardType)value);
    }
  }

  public virtual Math3D.Vector3 CommonDirection {
    get
    {
        return GetCommonDirection();
    }
    set
    {
        SetCommonDirection(value);
    }
  }

  public override string Name {
    get
    {
        return GetName();
    }
  }

  public override string MovableType {
    get
    {
        return GetMovableType();
    }
  }

  public LightList Lights {
    get
    {
        return GetLights();
    }
  }
%}


%include OgreBillboardSet.h

%extend Ogre::BillboardSet {
    Renderable * GetAsRenderable()    {
        return (Renderable*)self;
    }
};
