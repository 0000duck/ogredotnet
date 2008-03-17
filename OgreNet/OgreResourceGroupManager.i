%{
#include "OgreResourceGroupManager.h"
#include "ResourceGroupManagerExt.h"
%}

//ignore functions that use ResourceGroupManager::ResourceDeclaration
%ignore Ogre::ResourceGroupManager::ResourceDeclarationList;
%ignore Ogre::ResourceGroupManager::getResourceDeclarationList;

//custom wrapped 
%ignore Ogre::ResourceGroupManager::openResources;

// ResourceGroup is a subclass 
%ignore Ogre::ResourceGroupManager::resourceExists(ResourceGroup* group, const String& filename);

%newobject Ogre::ResourceGroupManager::GetResourceDeclarationList;

%typemap(cscode) Ogre::ResourceGroupManager
%{
    public static ResourceGroupManager Instance
    {
        get
        {
            return new ResourceGroupManager(OgreBindingsPINVOKE.ResourceGroupManager_getSingleton(), false);
        }
    }

    public static ResourceGroupManager Singleton
    {
        get { return getSingleton(); }
    }
%}

%include OgreResourceGroupManager.h

%nodefault Ogre::RGMResourceDeclaration;
%nodefault Ogre::RGMResourceDeclarationList;

%newobject Ogre::RGMResourceDeclarationList::getFirst;
%newobject Ogre::RGMResourceDeclarationList::getLast;
%newobject Ogre::RGMResourceDeclarationList::getByIndex;

%newobject Ogre::ResourceGroupManager::OpenResources;

namespace Ogre
{
    // declarations for custom code to handle ResourceGroupManager::ResourceDeclaration
    class RGMResourceDeclaration {
    public:
        RGMResourceDeclaration();
        String getResourceName();
        void setResourceName(String v);
        String getResourceType();
        void setResourceType(String v);
        ManualResourceLoader* getLoader();
        NameValuePairList* getParameters();
    };

    // declarations for custom code to handle ResourceGroupManager::ResourceDeclarationList
    class RGMResourceDeclarationList {
    public:
        RGMResourceDeclarationList();
        size_t size();
        RGMResourceDeclaration *getFirst();
        RGMResourceDeclaration *getLast();
        RGMResourceDeclaration *getByIndex(int index);
    };
}

%extend Ogre::ResourceGroupManager {
    //declare new functions to use RGMResourceDeclaration in place of ResourceGroupManager::ResourceDeclaration
    //  ResourceDeclarationList getResourceDeclarationList(const String& groupName);
    Ogre::RGMResourceDeclarationList *GetResourceDeclarationList(const String& groupName)
    {
        return new Ogre::RGMResourceDeclarationList(&self->getResourceDeclarationList(groupName));
    }
    
    DataStreamListSharedPtr *OpenResources(const String& pattern, const String& groupName = DEFAULT_RESOURCE_GROUP_NAME)
    {
        return new DataStreamListSharedPtr(self->openResources(pattern, groupName));
    }
};
