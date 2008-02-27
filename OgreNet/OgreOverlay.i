%{
#include "OgreOverlay.h"
%}

%rename Ogre::Overlay::getChild                        GetChild;


%typemap(cscode) Ogre::Overlay
%{
    public PanelOverlayElement GetChildPanel(string instanceName)
    {
        OverlayElement el = GetChild(instanceName);
        PanelOverlayElement ret = new PanelOverlayElement(OverlayElement.getCPtr(el).Handle , false);
        return ret;
    }

    public OverlayContainer GetChildContainer(string instanceName)
    {
        OverlayElement el = GetChild(instanceName);
        OverlayContainer ret = new OverlayContainer(OverlayElement.getCPtr(el).Handle , false);
        return ret;
    }
%}


%include OgreOverlay.h


//        typedef std::list<OverlayContainer*> OverlayContainerList;
PTR_REF_TYPEMAPS(OverlayContainer, Ogre::OverlayContainer*)
SWIG_STD_LIST_SPECIALIZE(OverlayContainer, Ogre::OverlayContainer*)
%template(OverlayContainerList) std::list<Ogre::OverlayContainer*>;

//        typedef VectorIterator<OverlayContainerList> Overlay2DElementsIterator ;
VectorIteratorWRAP(Overlay2DElementsIteratorWrap, std::list, Ogre::OverlayContainer*);


