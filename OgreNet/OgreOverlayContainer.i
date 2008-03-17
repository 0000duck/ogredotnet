%{
#include "OgreOverlayContainer.h"
%}

%rename Ogre::OverlayContainer::getChild                        GetChild;

%typemap(cscode) Ogre::OverlayContainer
%{
    public TextAreaOverlayElement GetChildTextArea(string instanceName)
    {
        OverlayElement el = GetChild(instanceName);
        TextAreaOverlayElement ret = new TextAreaOverlayElement(OverlayElement.getCPtr(el).Handle , false);
        return ret;
    }

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

%include OgreOverlayContainer.h

//        typedef std::map<String, OverlayContainer*> ChildContainerMap;
PTR_REF_TYPEMAPS(OverlayContainer, Ogre::OverlayContainer*)
%template(ChildContainerMap) std::map<std::string, Ogre::OverlayContainer*>;

//        typedef MapIterator<ChildContainerMap> ChildContainerIterator;
MapIteratorWRAP(ChildContainerIteratorWrap, std::map, std::string, Ogre::OverlayContainer*);

//###
//this is the same map and mapIter in OverlayManager, since Container is befor Manager in bindings use these
//
//        typedef std::map<String, OverlayElement*> ChildMap;
PTR_REF_TYPEMAPS(OverlayElement, Ogre::OverlayElement*)
%template(ChildElementMap) std::map<std::string, Ogre::OverlayElement*>;

//        typedef MapIterator<ChildMap> ChildIterator;
MapIteratorWRAP(ChildElementIteratorWrap, std::map, std::string, Ogre::OverlayElement*);
//###
