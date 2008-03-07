%{
#include "OgreViewport.h"
%}

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
