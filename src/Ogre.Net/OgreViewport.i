%{
#include "OgreViewport.h"
%}

%rename Ogre::Viewport::update              Update;
%rename Ogre::Viewport::getTarget           GetTarget;
%rename Ogre::Viewport::getCamera           GetCamera;
%rename Ogre::Viewport::setCamera           SetCamera;
%rename Ogre::Viewport::getZOrder           GetZOrder;
%rename Ogre::Viewport::getLeft             GetLeft;
%rename Ogre::Viewport::getTop              GetTop;
%rename Ogre::Viewport::getWidth            GetWidth;
%rename Ogre::Viewport::getHeight           GetHeight;
%rename Ogre::Viewport::getActualLeft       GetActualLeft;
%rename Ogre::Viewport::getActualTop        GetActualTop;
%rename Ogre::Viewport::getActualWidth      GetActualWidth;
%rename Ogre::Viewport::getActualHeight     GetActualHeight;
%rename Ogre::Viewport::setDimensions       SetDimensions;
%rename Ogre::Viewport::setBackgroundColour SetBackgroundColour;
%rename Ogre::Viewport::getBackgroundColour GetBackgroundColour;
%rename Ogre::Viewport::setClearEveryFrame  SetClearEveryFrame;
%rename Ogre::Viewport::getClearEveryFrame  GetClearEveryFrame;
%rename Ogre::Viewport::getActualDimensions GetActualDimensions;
%rename Ogre::Viewport::setOverlaysEnabled  SetOverlaysEnabled;
%rename Ogre::Viewport::getOverlaysEnabled  GetOverlaysEnabled;

//  void getActualDimensions(int &left, int &top, int &width, int &height) const;
%apply int &OUTPUT { int &left, int &top, int &width, int &height };

%typemap(cscode) Ogre::Viewport
%{
    public System.Drawing.Color BackgroundColor
    {
        set
        {
            SetBackgroundColour(value);
        }
    }
    
    public int ActualWidth
    {
        get
        {
            return GetActualWidth();
        }
    }
    
    public int ActualHeight
    {
        get
        {
            return GetActualHeight();
        }
    }
    
    public RenderTarget Target {
        get
        {
            return GetTarget();
        }
    }

    public Camera Camera {
        get
        {
            return GetCamera();
        }
        set
        {
            SetCamera((Camera)value);
        }
    }

    public int ZOrder {
        get
        {
            return GetZOrder();
        }
    }

    public float Left {
        get
        {
            return GetLeft();
        }
    }

    public float Top {
        get
        {
            return GetTop();
        }
    }

    public float Width {
        get
        {
            return GetWidth();
        }
    }

    public float Height {
        get
        {
            return GetHeight();
        }
    }

    public int ActualLeft {
        get
        {
            return GetActualLeft();
        }
    }

    public int ActualTop {
        get
        {
            return GetActualTop();
        }
    }

    public bool ClearEveryFrame {
        get
        {
            return GetClearEveryFrame();
        }
        set
        {
            SetClearEveryFrame((bool)value);
        }
    }

    public bool OverlaysEnabled {
        get
        {
            return GetOverlaysEnabled();
        }
        set
        {
            SetOverlaysEnabled((bool)value);
        }
    }
%}

%include "OgreViewport.h"
