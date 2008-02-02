%{
#include "OgrePanelOverlayElement.h"
%}

%rename Ogre::PanelOverlayElement::getChild						GetChild;

//ignore because of RenderOperation is private
%ignore Ogre::PanelOverlayElement::getRenderOperation;

//        void getUV(Real& u1, Real& v1, Real& u2, Real& v2) const;
%apply float &INOUT { Ogre::Real& u1, Ogre::Real& v1, Ogre::Real& u2, Ogre::Real& v2  };

%typemap(cscode) Ogre::PanelOverlayElement
%{
	public TextAreaOverlayElement GetChildTextArea(string instanceName)
	{
		OverlayElement el = GetChild(instanceName);
		TextAreaOverlayElement ret = new TextAreaOverlayElement( OverlayElement.getCPtr(el).Handle , false );
		return ret;
	}

	public PanelOverlayElement GetChildPanel(string instanceName)
	{
		OverlayElement el = GetChild(instanceName);
		PanelOverlayElement ret = new PanelOverlayElement( OverlayElement.getCPtr(el).Handle , false );
		return ret;
	}

	public OverlayContainer GetChildContainer(string instanceName)
	{
		OverlayElement el = GetChild(instanceName);
		OverlayContainer ret = new OverlayContainer( OverlayElement.getCPtr(el).Handle , false );
		return ret;
	}
%}



%include OgrePanelOverlayElement.h
