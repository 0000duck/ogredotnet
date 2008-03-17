%{
#include "OgreCamera.h"
%}

%rename Ogre::Camera::setPolygonMode         SetPolygonMode;
%rename Ogre::Camera::getPolygonMode         GetPolygonMode;
%rename Ogre::Camera::getPosition            GetPosition;
%rename Ogre::Camera::getSceneManager        GetSceneManager;
%rename Ogre::Camera::move                   Move;
%rename Ogre::Camera::moveRelative           MoveRelative;
%rename Ogre::Camera::setDirection           SetDirection;
%rename Ogre::Camera::getDirection           GetDirection;
%rename Ogre::Camera::getUp                  GetUp;
%rename Ogre::Camera::getRight               GetRight;
%rename Ogre::Camera::lookAt                 LookAt;
%rename Ogre::Camera::roll                   Roll;
%rename Ogre::Camera::yaw                    Yaw;
%rename Ogre::Camera::pitch                  Pitch;
%rename Ogre::Camera::rotate                 Rotate;
%rename Ogre::Camera::setFixedYawAxis        SetFixedYawAxis;
%rename Ogre::Camera::getOrientation         GetOrientation;
%rename Ogre::Camera::setOrientation         SetOrientation;
%rename Ogre::Camera::getDerivedOrientation  GetDerivedOrientation;
%rename Ogre::Camera::getDerivedPosition     GetDerivedPosition;
%rename Ogre::Camera::getMovableType         GetMovableType;
%rename Ogre::Camera::setAutoTracking        SetAutoTracking;
%rename Ogre::Camera::setLodBias             SetLodBias;
%rename Ogre::Camera::getCameraToViewportRay GetCameraToViewportRay;
%rename Ogre::Camera::setWindow              SetWindow;
%rename Ogre::Camera::resetWindow            ResetWindow;
%rename Ogre::Camera::isWindowSet            IsWindowSet;
%rename Ogre::Camera::getWindowPlanes        GetWindowPlanes;
%rename Ogre::Camera::getBoundingRadius      GetBoundingRadius;
%rename Ogre::Camera::getAutoTrackTarget     GetAutoTrackTarget;
%rename Ogre::Camera::getAutoTrackOffset     GetAutoTrackOffset;
%rename Ogre::Camera::getViewport            GetViewport;
%rename Ogre::Camera::setAutoAspectRatio     SetAutoAspectRatio;
%rename Ogre::Camera::getAutoAspectRatio     GetAutoAspectRatio;
%rename Ogre::Camera::getName                GetName;
%rename Ogre::Camera::setPosition            SetPosition;
%rename Ogre::Camera::getDerivedDirection    GetDerivedDirection;
%rename Ogre::Camera::getLodBias             GetLodBias;

%ignore Ogre::Camera::operator<<;

%typemap(cscode) Ogre::Camera
%{
    public override float AspectRatio
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

    public override float NearClipDistance
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
    
    public SceneManager SceneManager {
        get
        {
            return GetSceneManager();
        }
    }

    public override string Name {
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

    public override string MovableType {
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

    public override float BoundingRadius {
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
