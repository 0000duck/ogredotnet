%{
#include "OgreCamera.h"
%}

%ignore Ogre::Camera::operator<<;

%typemap(cscode) Ogre::Camera
%{
    public float AspectRatio
    {
        get
        {
            return getAspectRatio();
        }
        set
        {
            setAspectRatio(value);
        }
    }

    public float NearClipDistance
    {
        get
        {
            return getNearClipDistance();
        }
        set
        {
            setNearClipDistance(value);
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
    
    public Math3D.Vector3 LookAt
    {
        set
        {
            _lookAt(value);
        }
    }

    public SceneManager SceneManager {
        get
        {
            return getSceneManager();
        }
    }

    public string Name {
        get
        {
            return getName();
        }
    }

    public PolygonMode DetailLevel {
        get
        {
            return getPolygonMode();
        }

        set
        {
            setPolygonMode((PolygonMode)value);
        }
    }

    public Math3D.Vector3 Direction {
        get
        {
            return getDirection();
        }
        set
        {
            setDirection(value);
        }
    }


    public Math3D.Vector3 Up {
        get
        {
            return getUp();
        }
    }

    public Math3D.Vector3 Right {
        get
        {
            return getRight();
        }
    }

    public Math3D.Quaternion Orientation {
        get
        {
            return getOrientation();
        }
        set
        {
            setOrientation(value);
        }
    }

    public Math3D.Quaternion DerivedOrientation {
        get
        {
            return getDerivedOrientation();
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

    public string MovableType {
        get
        {
            return getMovableType();
        }
    }

    public float LodBias {
        get
        {
            return getLodBias();
        }
        set
        {
            setLodBias((float)value);
        }
    }

    public PlaneVector WindowPlanes {
        get
        {
            return getWindowPlanes();
        }
    }

    public float BoundingRadius {
        get
        {
            return getBoundingRadius();
        }
    }

    public SceneNode AutoTrackTarget {
        get
        {
            return getAutoTrackTarget();
        }
    }

    public Math3D.Vector3 AutoTrackOffset {
        get
        {
            return getAutoTrackOffset();
        }
    }

    public Viewport Viewport {
        get
        {
            return getViewport();
        }
    }

    public bool AutoAspectRatio {
        get
        {
            return getAutoAspectRatio();
        }
        set
        {
            setAutoAspectRatio((bool)value);
        }
    }
%}

%include "OgreCamera.h"

//const std::vector<Plane>& getWindowPlanes(void) const;
SWIG_STD_VECTOR_SPECIALIZE_MINIMUM(Plane, Ogre::Plane)
%template(PlaneVector) std::vector<Ogre::Plane>;
