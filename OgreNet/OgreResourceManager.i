%{
#include "OgreResourceManager.h"
%}

%rename Ogre::ResourceManager::create      Create;
%rename Ogre::ResourceManager::load        Load;

%include "OgreResourceManager.h"

//typedef unsigned long ResourceHandle;
//typedef std::map<ResourceHandle, ResourcePtr> ResourceHandleMap;
DLLNonePtrType(ResourcePtr, Ogre::SharedPtr<Ogre::Resource>)
%template(ResourceHandleMap) std::map<unsigned long, Ogre::SharedPtr<Ogre::Resource> >;

//typedef MapIterator<ResourceHandleMap> ResourceMapIterator;
MapIteratorWRAP(ResourceMapIteratorWrap, std::map, unsigned long, Ogre::ResourcePtr);
