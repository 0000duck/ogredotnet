%{
#include "OgreMeshManager.h"
%}

//single inheritance problem.
%ignore Ogre::MeshManager::loadResource;

%typemap(cscode) Ogre::MeshManager
%{
    public static MeshManager Instance    {
        get    {
            return new MeshManager(OgreBindingsPINVOKE.MeshManager_getSingleton(), false);
        }
    }

    public bool PrepareAllMeshesForShadowVolumes {
        get { return getPrepareAllMeshesForShadowVolumes(); }
        set { setPrepareAllMeshesForShadowVolumes((bool)value); }
    }

    public float BoundsPaddingFactor {
        get { return getBoundsPaddingFactor(); }
        set { setBoundsPaddingFactor((float)value); }
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
