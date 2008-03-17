%{
#include "OgreOverlayManager.h"
%}

%rename Ogre::OverlayManager::createOverlayElement            CreateOverlayElement;

%typemap(cscode) Ogre::OverlayManager
%{
    public static OverlayManager Instance    {
        get    {
            return new OverlayManager(OgreBindingsPINVOKE.OverlayManager_getSingleton(), false);
        }
    }
    
    public TextAreaOverlayElement CreateTextAreaElement(string instanceName, bool isTemplate)
    {
        OverlayElement el = CreateOverlayElement("TextArea", instanceName, isTemplate);
        TextAreaOverlayElement ret = new TextAreaOverlayElement(OverlayElement.getCPtr(el).Handle , false);
        return ret;
    }

    public TextAreaOverlayElement CreateTextAreaElement(string instanceName)
    {
        OverlayElement el = CreateOverlayElement("TextArea", instanceName);
        TextAreaOverlayElement ret = new TextAreaOverlayElement(OverlayElement.getCPtr(el).Handle , false);
        return ret;
    }

    public PanelOverlayElement CreatePanelElement(string instanceName, bool isTemplate)
    {
        OverlayElement el = CreateOverlayElement("Panel", instanceName, isTemplate);
        PanelOverlayElement ret = new PanelOverlayElement(OverlayElement.getCPtr(el).Handle , false);
        return ret;
    }

    public PanelOverlayElement CreatePanelElement(string instanceName)
    {
        OverlayElement el = CreateOverlayElement("Panel", instanceName);
        PanelOverlayElement ret = new PanelOverlayElement(OverlayElement.getCPtr(el).Handle , false);
        return ret;
    }
%}

%include OgreOverlayManager.h

//    typedef std::map<String, Overlay*> OverlayMap;
PTR_REF_TYPEMAPS(Overlay, Ogre::Overlay*)
%template(OverlayMap) std::map<std::string, Ogre::Overlay*>;

//    typedef MapIterator<OverlayMap> OverlayMapIterator;
MapIteratorWRAP(OverlayMapIteratorWrap, std::map, std::string, Ogre::Overlay*);

//already in OverlayContainer.i,  named ChildElementMap ChildElementIteratorWrap
//    typedef std::map<String, OverlayElement*> ElementMap;
//PTR_REF_TYPEMAPS(Overlay, Ogre::OverlayElement*)
//%template(ElementMap) std::map<std::string, Ogre::OverlayElement*>;
//    typedef MapIterator<ElementMap> TemplateIterator;
//MapIteratorWRAP(TemplateIteratorWrap, std::map, std::string, Ogre::OverlayElement*);
