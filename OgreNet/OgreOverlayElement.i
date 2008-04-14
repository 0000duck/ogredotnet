%{
#include "OgreOverlayElement.h"
%}

%typemap(cscode) Ogre::OverlayElement
%{
    static public OverlayElement GetOverlayElementFrom(OverlayContainer c)
    {
        return new OverlayElement(OverlayContainer.getCPtr(c).Handle, false);
    }

    static public OverlayElement GetOverlayElementFrom(TextAreaOverlayElement c)
    {
        return new OverlayElement(TextAreaOverlayElement.getCPtr(c).Handle, false);
    }

    static public OverlayElement GetOverlayElementFrom(PanelOverlayElement c)
    {
        return new OverlayElement(PanelOverlayElement.getCPtr(c).Handle, false);
    }

    static public OverlayContainer GetOverlayContainerFrom(OverlayElement c)
    {
        return new OverlayContainer(OverlayElement.getCPtr(c).Handle, false);
    }

    static public TextAreaOverlayElement GetTextAreaOverlayElementFrom(OverlayElement c)
    {
        return new TextAreaOverlayElement(OverlayElement.getCPtr(c).Handle, false);
    }

    static public OverlayElement GetPanelOverlayElementFrom(OverlayElement c)
    {
        return new PanelOverlayElement(OverlayElement.getCPtr(c).Handle, false);
    }
%}

%include OgreOverlayElement.h

%extend Ogre::OverlayElement
{
    Renderable* GetAsRenderable()
    {
        return (Renderable*)self;
    }
};
