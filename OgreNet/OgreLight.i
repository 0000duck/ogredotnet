%{
#include "OgreLight.h"
%}

// enum LightTypes
#define LT_POINT        Point
#define LT_DIRECTIONAL  Directional
#define LT_SPOTLIGHT    Spot

//override problem,  Light does not derive from Animbale because of single inheritance. 
%ignore Ogre::Light::createAnimableValue; 

%typemap(cscode) Ogre::Light
%{
    public Math3D.Vector3 Direction
    {
        get
        {
            return GetDirection();
        }
        set
        {
            SetDirection(value);    
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
            SetPosition(value);    
        }
    }
    
    public System.Drawing.Color DiffuseColor
    {
        get
        {
            return GetDiffuseColour();
        }
        set
        {
            SetDiffuseColour(value);
        }
    }

    
    public override string Name {
        get
        {
            return GetName();
        }
    }

    public Light.LightTypes Type {
        get
        {
            return GetLightType();
        }
        set
        {
            SetLightType(value);
        }    
    }


    public System.Drawing.Color SpecularColour {
        get
        {
            return GetSpecularColour();
        }
        set
        {
            SetSpecularColour(value);
        }    
    }

    public float AttenuationRange {
        get
        {
            return GetAttenuationRange();
        }
    }

    public float AttenuationConstant {
        get
        {
            return GetAttenuationConstant();
        }
    }

    public float AttenuationLinear {
        get
        {
            return GetAttenuationLinear();
        }
    }

    public float AttenuationQuadric {
        get
        {
            return GetAttenuationQuadric();
        }
    }

//  public OgreVector3 Position {
//    get
//    {
//        return GetPosition();
//    }
//    set
//    {
//        SetPosition((OgreVector3)value);
//    }    
//  }

//  public OgreVector3 Direction {
//    get
//    {
//        return GetDirection();
//    }
//    set
//    {
//        SetDirection((OgreVector3)value);
//    }    
//  }

    public Radian SpotlightInnerAngle {
        get
        {
            return GetSpotlightInnerAngle();
        }
    }

    public Radian SpotlightOuterAngle {
        get
        {
            return GetSpotlightOuterAngle();
        }
    }

    public float SpotlightFalloff {
        get
        {
            return GetSpotlightFalloff();
        }
    }

    public override AxisAlignedBox BoundingBox {
        get
        {
            return GetBoundingBox();
        }
    }

    public string MovableType {
        get
        {
            return GetMovableType();
        }
    }

    public Math3D.Vector3 DerivedPosition {
        get
        {
            return GetDerivedPosition();
        }
    }

    public Math3D.Vector3 DerivedDirection {
        get
        {
            return GetDerivedDirection();
        }
    }

//  public void Visible {
//    set
//    {
//        SetVisible((bool)value);
//    }
//  }

    public float BoundingRadius {
        get
        {
            return GetBoundingRadius();
        }
    }

    public Math3D.Vector4 As4DVector {
        get
        {
            return GetAs4DVector();
        }
    }
%}

%include "OgreLight.h"
