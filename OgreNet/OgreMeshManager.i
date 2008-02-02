%{
#include "OgreMeshManager.h"
%}

%rename Ogre::MeshManager::load                                Load;
%rename Ogre::MeshManager::createManual                        CreateManual;
%rename Ogre::MeshManager::createPlane                         CreatePlane;
%rename Ogre::MeshManager::createCurvedIllusionPlane           CreateCurvedIllusionPlane;
%rename Ogre::MeshManager::createCurvedPlane                   CreateCurvedPlane;
%rename Ogre::MeshManager::createBezierPatch                   CreateBezierPatch;
%rename Ogre::MeshManager::setPrepareAllMeshesForShadowVolumes SetPrepareAllMeshesForShadowVolumes;
%rename Ogre::MeshManager::getPrepareAllMeshesForShadowVolumes GetPrepareAllMeshesForShadowVolumes;
%rename Ogre::MeshManager::getSingleton                        GetSingleton;
%rename Ogre::MeshManager::getSingletonPtr                     GetSingletonPtr;
%rename Ogre::MeshManager::getBoundsPaddingFactor              GetBoundsPaddingFactor;
%rename Ogre::MeshManager::setBoundsPaddingFactor              SetBoundsPaddingFactor;

//single inheritance problem.
%ignore Ogre::MeshManager::loadResource;

%typemap(cscode) Ogre::MeshManager
%{
	public static MeshManager Instance	{
		get	{
			return new MeshManager(OgreBindingsPINVOKE.MeshManager_GetSingleton(), false);
		}
	}

	public bool PrepareAllMeshesForShadowVolumes {
		get { return GetPrepareAllMeshesForShadowVolumes(); }
		set { SetPrepareAllMeshesForShadowVolumes((bool)value); }
	}

	public float BoundsPaddingFactor {
		get { return GetBoundsPaddingFactor(); }
		set { SetBoundsPaddingFactor((float)value); }
	}

%}

%include OgreMeshManager.h



%extend Ogre::MeshManager
{
	void LoadResource(Ogre::Resource* resource)
	{
		self->loadResource(resource);
	}
};

