%{
#include "OgreRenderWindow.h"
%}

%rename Ogre::RenderWindow::create               Create;
%rename Ogre::RenderWindow::destroy              Destroy;
%rename Ogre::RenderWindow::resize               Resize;
%rename Ogre::RenderWindow::windowMovedOrResized WindowMovedOrResized;
%rename Ogre::RenderWindow::reposition           Reposition;
%rename Ogre::RenderWindow::isVisible            IsVisible;
%rename Ogre::RenderWindow::isActive             IsActive;
%rename Ogre::RenderWindow::isClosed             IsClosed;
%rename Ogre::RenderWindow::isPrimary            IsPrimary;
%rename Ogre::RenderWindow::swapBuffers          SwapBuffers;
%rename Ogre::RenderWindow::update               Update;
%rename Ogre::RenderWindow::isFullScreen         IsFullScreen;
%rename Ogre::RenderWindow::getMetrics           GetMetrics;
%rename Ogre::RenderWindow::setFullscreen        SetFullscreen;

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
