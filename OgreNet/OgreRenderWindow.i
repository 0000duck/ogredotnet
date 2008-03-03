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
        get { return IsClosed(); }
    }
    
    public bool Visible
    {
        get { return IsVisible(); }
    }

    public bool Active
    {
        get { return IsActive(); }
    }

    public bool Primary
    {
        get { return IsPrimary(); }
    }

    public bool FullScreen
    {
        get { return IsFullScreen(); }
    }
%}

%include "OgreRenderWindow.h"
