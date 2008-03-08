%{
#include "OgreSceneManager.h"
%}

//ignore because of RenderOperation is private
%ignore Ogre::SceneManager::manualRender;

//params is a keyword in C#.  there is a %extend for this function
%ignore Ogre::SceneManager::createMovableObject;

//TODO need custom wrap for sub structs
%ignore Ogre::SceneManager::getSkyPlaneGenParameters;
%ignore Ogre::SceneManager::getSkyDomeGenParameters;
%ignore Ogre::SceneManager::getSkyBoxGenParameters;

// TODO: problems with private default constructor
%ignore Ogre::SceneManager::getAnimationStateIterator;
%ignore Ogre::SceneManager::getShadowTextureConfigIterator;

// TODO: problems with inner class
%ignore Ogre::SceneManager::setQueuedRenderableVisitor;
%ignore Ogre::SceneManager::getQueuedRenderableVisitor;

SIMPLE_TYPEMAP(SceneTypeMask,  unsigned short,   UInt16)

// enum SceneType
#define ST_GENERIC             Generic
#define ST_EXTERIOR_CLOSE      ExteriorClose
#define ST_EXTERIOR_FAR        ExteriorFar
#define ST_EXTERIOR_REAL_FAR   ExteriorRealFar
#define ST_INTERIOR            Interior

%typemap(cscode) Ogre::SceneManager
%{
    public System.Drawing.Color AmbientLightColor {
        set { setAmbientLight(value); }
    }

    public virtual SceneNode RootSceneNode {
        get { return getRootSceneNode(); }
    }

    public System.Drawing.Color AmbientLight {
        get { return getAmbientLight(); }
        set { setAmbientLight(value); }
    }

    public virtual FogMode FogMode {
        get { return getFogMode(); }
    }

    public virtual System.Drawing.Color FogColour {
        get { return getFogColour(); }
    }

    public virtual float FogStart {
        get { return getFogStart(); }
    }

    public virtual float FogEnd {
        get { return getFogEnd(); }
    }

    public virtual float FogDensity {
        get { return getFogDensity(); }
    }

    public virtual RenderQueueGroupID WorldGeometryRenderQueue {
        get { return (RenderQueueGroupID)(int)getWorldGeometryRenderQueue(); }
        set { setWorldGeometryRenderQueue((byte)value); }
    }

    public virtual ShadowTechnique ShadowTechnique {
        get { return getShadowTechnique(); }
        set { setShadowTechnique((ShadowTechnique)value); }
    }

    public virtual bool ShowDebugShadows {
        get { return getShowDebugShadows(); }
        set { setShowDebugShadows((bool)value); }
    }

    public virtual System.Drawing.Color ShadowColour {
        get { return getShadowColour(); }
        set { setShadowColour(value); }
    }

    public virtual float ShadowDirectionalLightExtrusionDistance {
        get { return getShadowDirectionalLightExtrusionDistance(); }
        set { setShadowDirectionalLightExtrusionDistance((float)value); }
    }

    public virtual float ShadowFarDistance {
        get { return getShadowFarDistance(); }
        set { setShadowFarDistance((float)value); }
    }

    public virtual UInt32 ShadowIndexBufferSize {
        get { return getShadowIndexBufferSize(); }
        set { setShadowIndexBufferSize(value); }
    }

    public UInt32 ShadowTextureCount {
        get { return getShadowTextureCount(); }
        set { setShadowTextureCount((UInt16)value); }
    }
%}

%include "OgreSceneManager.h"

%extend Ogre::SceneManager
{
    MovableObject* CreateMovableObject(const String& name, const String& typeName, const NameValuePairList* vparams = 0)
    {
        return self->createMovableObject(name, typeName, vparams);
    }
};

//        typedef std::map<String, Camera* > CameraList;
PTR_REF_TYPEMAPS(Camera, Ogre::Camera*)
%template(CameraList) std::map<std::string, Ogre::Camera*>;

//        typedef std::map<String, Animation*> AnimationList;
PTR_REF_TYPEMAPS(Animation, Ogre::Animation*)
%template(AnimationList) std::map<std::string, Ogre::Animation*>;

//defined in OgreEntity.i
//        typedef std::map<String, MovableObject*> MovableObjectMap;
//        typedef MapIterator<MovableObjectMap> MovableObjectIterator;


//        typedef MapIterator<CameraList> CameraIterator;
MapIteratorWRAP(CameraIteratorWrap, std::map, std::string, Ogre::Camera*);

//        typedef MapIterator<AnimationList> AnimationIterator;
MapIteratorWRAP(AnimationIteratorWrap, std::map, std::string, Ogre::Animation*);

