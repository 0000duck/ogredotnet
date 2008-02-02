%{
#include "OgreOverlayElement.h"
%}

%typemap(cscode) Ogre::OverlayElement
%{
	static public OverlayElement GetOverlayElementFrom( OverlayContainer c )
	{
		OverlayElement ret = new OverlayElement( OverlayContainer.getCPtr(c).Handle , false );
		return ret;
	}

	static public OverlayElement GetOverlayElementFrom( TextAreaOverlayElement c )
	{
		OverlayElement ret = new OverlayElement( TextAreaOverlayElement.getCPtr(c).Handle , false );
		return ret;
	}

	static public OverlayElement GetOverlayElementFrom( PanelOverlayElement c )
	{
		OverlayElement ret = new OverlayElement( PanelOverlayElement.getCPtr(c).Handle , false );
		return ret;
	}





	static public OverlayContainer GetOverlayContainerFrom( OverlayElement c )
	{
		OverlayContainer ret = new OverlayContainer( OverlayElement.getCPtr(c).Handle , false );
		return ret;
	}

	static public TextAreaOverlayElement GetTextAreaOverlayElementFrom( OverlayElement c )
	{
		TextAreaOverlayElement ret = new TextAreaOverlayElement( OverlayElement.getCPtr(c).Handle , false );
		return ret;
	}

	static public OverlayElement GetPanelOverlayElementFrom( OverlayElement c )
	{
		PanelOverlayElement ret = new PanelOverlayElement( OverlayElement.getCPtr(c).Handle , false );
		return ret;
	}
%}

%include OgreOverlayElement.h

%extend Ogre::OverlayElement {
	Renderable * GetAsRenderable()	{
		return (Renderable*)self;
	}
};
