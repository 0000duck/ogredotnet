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
            return GetAspectRatio();
        }
        set
        {
            SetAspectRatio(value);
        }
    }

    public float NearClipDistance
    {
        get
        {
            return GetNearClipDistance();
        }
        set
        {
            SetNearClipDistance(value);
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
            return GetSceneManager();
        }
    }

    public string Name {
        get
        {
            return GetName();
        }
    }

    public PolygonMode DetailLevel {
        get
        {
            return GetPolygonMode();
        }

        set
        {
            SetPolygonMode((PolygonMode)value);
        }
    }

    public Math3D.Vector3 Direction {
        get
        {
            return GetDirection();
        }
        set
        {
            SetDirection(value);
        }
    }


    public Math3D.Vector3 Up {
        get
        {
            return GetUp();
        }
    }

    public Math3D.Vector3 Right {
        get
        {
            return GetRight();
        }
    }

    public Math3D.Quaternion Orientation {
        get
        {
            return GetOrientation();
        }
        set
        {
            SetOrientation(value);
        }
    }

    public Math3D.Quaternion DerivedOrientation {
        get
        {
            return GetDerivedOrientation();
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

    public string MovableType {
        get
        {
            return GetMovableType();
        }
    }

    public float LodBias {
        get
        {
            return GetLodBias();
        }
        set
        {
            SetLodBias((float)value);
        }
    }

    public PlaneVector WindowPlanes {
        get
        {
            return GetWindowPlanes();
        }
    }

    public float BoundingRadius {
        get
        {
            return GetBoundingRadius();
        }
    }

    public SceneNode AutoTrackTarget {
        get
        {
            return GetAutoTrackTarget();
        }
    }

    public Math3D.Vector3 AutoTrackOffset {
        get
        {
            return GetAutoTrackOffset();
        }
    }

    public Viewport Viewport {
        get
        {
            return GetViewport();
        }
    }

    public bool AutoAspectRatio {
        get
        {
            return GetAutoAspectRatio();
        }
        set
        {
            SetAutoAspectRatio((bool)value);
        }
    }
%}

%include "OgreCamera.h"

//const std::vector<Plane>& getWindowPlanes(void) const;
SWIG_STD_VECTOR_SPECIALIZE_MINIMUM(Plane, Ogre::Plane)
%template(PlaneVector) std::vector<Ogre::Plane>;
