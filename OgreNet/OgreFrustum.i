%{
#include "OgreFrustum.h"
%}

%rename Ogre::Frustum::setFOVy                     SetFOVy;
%rename Ogre::Frustum::getFOVy                     GetFOVy;
%rename Ogre::Frustum::setNearClipDistance         SetNearClipDistance;
%rename Ogre::Frustum::getNearClipDistance         GetNearClipDistance;
%rename Ogre::Frustum::setFarClipDistance          SetFarClipDistance;
%rename Ogre::Frustum::getFarClipDistance          GetFarClipDistance;
%rename Ogre::Frustum::setAspectRatio              SetAspectRatio;
%rename Ogre::Frustum::getAspectRatio              GetAspectRatio;
%rename Ogre::Frustum::getProjectionMatrix         GetProjectionMatrix;
//%rename Ogre::Frustum::getStandardProjectionMatrix GetStandardProjectionMatri;
%rename Ogre::Frustum::getViewMatrix               GetViewMatrix;
%rename Ogre::Frustum::getFrustumPlane             GetFrustumPlane;
%rename Ogre::Frustum::isVisible                   IsVisible;
%rename Ogre::Frustum::getBoundingBox              GetBoundingBox;
%rename Ogre::Frustum::getBoundingRadius           GetBoundingRadius;
%rename Ogre::Frustum::getMovableType              GetMovableType;
%rename Ogre::Frustum::getName                     GetName;
%rename Ogre::Frustum::getMaterial                 GetMaterial;
%rename Ogre::Frustum::getWorldTransforms          GetWorldTransforms;
%rename Ogre::Frustum::getWorldOrientation         GetWorldOrientation;
%rename Ogre::Frustum::getWorldPosition            GetWorldPosition;
%rename Ogre::Frustum::getSquaredViewDepth         GetSquaredViewDepth;
%rename Ogre::Frustum::getLights                   GetLights;
%rename Ogre::Frustum::getWorldSpaceCorners        GetWorldSpaceCorners;
%rename Ogre::Frustum::setProjectionType           SetProjectionType;
%rename Ogre::Frustum::getProjectionType           GetProjectionType;
%rename Ogre::Frustum::enableReflection            EnableReflection;
%rename Ogre::Frustum::disableReflection           DisableReflection;
%rename Ogre::Frustum::isReflected                 IsReflected;
%rename Ogre::Frustum::getReflectionMatrix         GetReflectionMatrix;
%rename Ogre::Frustum::getReflectionPlane          GetReflectionPlane;
%rename Ogre::Frustum::projectSphere               ProjectSphere;
%rename Ogre::Frustum::enableCustomNearClipPlane   EnableCustomNearClipPlane;
%rename Ogre::Frustum::disableCustomNearClipPlane  DisableCustomNearClipPlane;

//ignore because of RenderOperation is private
%ignore Ogre::Frustum::getRenderOperation;


//  virtual bool projectSphere(const Sphere& sphere, Real* left, Real* top, Real* right, Real* bottom) const;
%apply double *OUTPUT { float *left, float *top, float *right, float *bottom };


//   virtual bool isVisible(const AxisAlignedBox& bound, FrustumPlane* culledBy = 0) const;
//INOUT or OUTPUT?  its output if the function returns false, but in c# out means the function MUST set the varible right?
%apply int *INOUT { Ogre::FrustumPlane* culledBy };



%typemap(cscode) Ogre::Frustum
%{
  public virtual Radian FOVy {
    get
    {
        return GetFOVy();
    }
    set
    {
        SetFOVy((Radian)value);
    }    
  }

  public virtual float NearClipDistance {
    get
    {
        return GetNearClipDistance();
    }
    set
    {
        SetNearClipDistance((float)value);
    }    
  }

  public virtual float FarClipDistance {
    get
    {
        return GetFarClipDistance();
    }
    set
    {
        SetFarClipDistance((float)value);
    }    
  }

  public virtual float AspectRatio {
    get
    {
        return GetAspectRatio();
    }
    set
    {
        SetAspectRatio((float)value);
    }    
  }

  public virtual Math3D.Matrix4 ProjectionMatrix {
    get
    {
        return GetProjectionMatrix();
    }
  }

//  public virtual Math3D.Matrix4 StandardProjectionMatrix {
//    get
//    {
//        return GetStandardProjectionMatrix();
//    }
//  }

  public virtual Math3D.Matrix4 ViewMatrix {
    get
    {
        return GetViewMatrix();
    }
  }

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

  public override string MovableType {
    get
    {
        return GetMovableType();
    }
  }

  public override string Name {
    get
    {
        return GetName();
    }
  }

  public MaterialPtr Material {
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

  public LightList Lights {
    get
    {
        return GetLights();
    }
  }

  public virtual Math3D.Vector3 WorldSpaceCorners {
    get
    {
        return GetWorldSpaceCorners();
    }
  }

  public virtual ProjectionType ProjectionType {
    get
    {
        return GetProjectionType();
    }
    set
    {
        SetProjectionType((ProjectionType)value);
    }
  }

//  public virtual bool IsReflected {
//    get
//    {
//        return IsReflected();
//    }
//  }

  public virtual Math3D.Matrix4 ReflectionMatrix {
    get
    {
        return GetReflectionMatrix();
    }
  }

  public virtual Plane ReflectionPlane {
    get
    {
        return GetReflectionPlane();
    }
  }

%}

%include "OgreFrustum.h"

%extend Ogre::Frustum {
	Renderable * GetAsRenderable()	{
		return (Renderable*)self;
	}
};
