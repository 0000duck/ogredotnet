%{
#include "OgreRenderWindow.h"
%}

// virtual void getMetrics(unsigned int& width, unsigned int& height, unsigned int& colourDepth, int& left, int& top);
%apply int &OUTPUT { int& left, int& top };
%apply unsigned int &OUTPUT { unsigned int& width, unsigned int& height, unsigned int& colourDepth };

%typemap(cscode) Ogre::RenderWindow
%{
    public HandleRef HandleRef
    {
        get { return swigCPtr; }
    }

    public bool Closed
    {
        get { return isClosed(); }
    }
    
    public bool Visible
    {
        get { return isVisible(); }
    }

    public bool Active
    {
        get { return isActive(); }
    }

    public bool Primary
    {
        get { return isPrimary(); }
    }

    public bool FullScreen
    {
        get { return isFullScreen(); }
    }
%}

%include "OgreRenderWindow.h"
