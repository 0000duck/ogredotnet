%{
#include "OgreFrustum.h"
%}

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
            return getFOVy();
        }
        set
        {
            setFOVy((Radian)value);
        }    
    }

    public virtual float NearClipDistance {
        get
        {
            return getNearClipDistance();
        }
        set
        {
            setNearClipDistance((float)value);
        }    
    }

    public virtual float FarClipDistance {
        get
        {
            return getFarClipDistance();
        }
        set
        {
            setFarClipDistance((float)value);
        }    
    }

    public virtual float AspectRatio {
        get
        {
            return getAspectRatio();
        }
        set
        {
            setAspectRatio((float)value);
        }    
    }

    public virtual Math3D.Matrix4 ProjectionMatrix {
        get
        {
            return getProjectionMatrix();
        }
    }

//  public virtual Math3D.Matrix4 StandardProjectionMatrix {
//    get
//    {
//        return getStandardProjectionMatrix();
//    }
//  }

    public virtual Math3D.Matrix4 ViewMatrix {
        get
        {
            return getViewMatrix();
        }
    }

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

    public override string MovableType {
        get
        {
            return getMovableType();
        }
    }

    public override string Name {
        get
        {
            return getName();
        }
    }

    public MaterialPtr Material {
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

    public LightList Lights {
        get
        {
            return getLights();
        }
    }

    public virtual Math3D.Vector3 WorldSpaceCorners {
        get
        {
            return getWorldSpaceCorners();
        }
    }

    public virtual ProjectionType ProjectionType {
        get
        {
            return getProjectionType();
        }
        set
        {
            setProjectionType((ProjectionType)value);
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
            return getReflectionMatrix();
        }
    }

    public virtual Plane ReflectionPlane {
        get
        {
            return getReflectionPlane();
        }
    }

    %}

%include "OgreFrustum.h"

%extend Ogre::Frustum {
    Renderable * GetAsRenderable()    {
        return (Renderable*)self;
    }
};
