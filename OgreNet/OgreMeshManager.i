%{
#include "OgreMeshManager.h"
%}

//single inheritance problem.
%ignore Ogre::MeshManager::loadResource;

%typemap(cscode) Ogre::MeshManager
%{
    public static MeshManager Instance    {
        get    {
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
