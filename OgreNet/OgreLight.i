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
            return getDirection();
        }
        set
        {
            setDirection(value);    
        }
    }
    
    public Math3D.Vector3 Position
    {
        get
        {
            return getPosition();
        }
        set
        {
            setPosition(value);    
        }
    }
    
    public System.Drawing.Color DiffuseColor
    {
        get
        {
            return getDiffuseColour();
        }
        set
        {
            setDiffuseColour(value);
        }
    }

    
    public string Name {
        get
        {
            return getName();
        }
    }

    public Light.LightTypes Type {
        get
        {
            return getLightType();
        }
        set
        {
            setLightType(value);
        }    
    }


    public System.Drawing.Color SpecularColour {
        get
        {
            return getSpecularColour();
        }
        set
        {
            setSpecularColour(value);
        }    
    }

    public float AttenuationRange {
        get
        {
            return getAttenuationRange();
        }
    }

    public float AttenuationConstant {
        get
        {
            return getAttenuationConstant();
        }
    }

    public float AttenuationLinear {
        get
        {
            return getAttenuationLinear();
        }
    }

    public float AttenuationQuadric {
        get
        {
            return getAttenuationQuadric();
        }
    }

//  public OgreVector3 Position {
//    get
//    {
//        return getPosition();
//    }
//    set
//    {
//        setPosition((OgreVector3)value);
//    }    
//  }

//  public OgreVector3 Direction {
//    get
//    {
//        return getDirection();
//    }
//    set
//    {
//        setDirection((OgreVector3)value);
//    }    
//  }

    public Radian SpotlightInnerAngle {
        get
        {
            return getSpotlightInnerAngle();
        }
    }

    public Radian SpotlightOuterAngle {
        get
        {
            return getSpotlightOuterAngle();
        }
    }

    public float SpotlightFalloff {
        get
        {
            return getSpotlightFalloff();
        }
    }

    public AxisAlignedBox BoundingBox {
        get
        {
            return getBoundingBox();
        }
    }

    public string MovableType {
        get
        {
            return getMovableType();
        }
    }

    public Math3D.Vector3 DerivedPosition {
        get
        {
            return getDerivedPosition();
        }
    }

    public Math3D.Vector3 DerivedDirection {
        get
        {
            return getDerivedDirection();
        }
    }

//  public void Visible {
//    set
//    {
//        setVisible((bool)value);
//    }
//  }

    public float BoundingRadius {
        get
        {
            return getBoundingRadius();
        }
    }

    public Math3D.Vector4 As4DVector {
        get
        {
            return getAs4DVector();
        }
    }
%}

%include "OgreLight.h"
