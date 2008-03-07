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
            setBackgroundColour(value);
        }
    }
    
    public int ActualWidth
    {
        get
        {
            return getActualWidth();
        }
    }
    
    public int ActualHeight
    {
        get
        {
            return getActualHeight();
        }
    }
    
    public RenderTarget Target {
        get
        {
            return getTarget();
        }
    }

    public Camera Camera {
        get
        {
            return getCamera();
        }
        set
        {
            setCamera((Camera)value);
        }
    }

    public int ZOrder {
        get
        {
            return getZOrder();
        }
    }

    public float Left {
        get
        {
            return getLeft();
        }
    }

    public float Top {
        get
        {
            return getTop();
        }
    }

    public float Width {
        get
        {
            return getWidth();
        }
    }

    public float Height {
        get
        {
            return getHeight();
        }
    }

    public int ActualLeft {
        get
        {
            return getActualLeft();
        }
    }

    public int ActualTop {
        get
        {
            return getActualTop();
        }
    }

    public bool ClearEveryFrame {
        get
        {
            return getClearEveryFrame();
        }
        set
        {
            setClearEveryFrame((bool)value);
        }
    }

    public bool OverlaysEnabled {
        get
        {
            return getOverlaysEnabled();
        }
        set
        {
            setOverlaysEnabled((bool)value);
        }
    }
%}

%include "OgreViewport.h"
