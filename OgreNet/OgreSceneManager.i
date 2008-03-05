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
        set { SetAmbientLight(value); }
    }

    public virtual SceneNode RootSceneNode {
        get { return GetRootSceneNode(); }
    }

    public System.Drawing.Color AmbientLight {
        get { return GetAmbientLight(); }
        set { SetAmbientLight(value); }
    }

    public virtual FogMode FogMode {
        get { return GetFogMode(); }
    }

    public virtual System.Drawing.Color FogColour {
        get { return GetFogColour(); }
    }

    public virtual float FogStart {
        get { return GetFogStart(); }
    }

    public virtual float FogEnd {
        get { return GetFogEnd(); }
    }

    public virtual float FogDensity {
        get { return GetFogDensity(); }
    }

    public virtual RenderQueueGroupID WorldGeometryRenderQueue {
        get { return (RenderQueueGroupID)(int)GetWorldGeometryRenderQueue(); }
        set { SetWorldGeometryRenderQueue((byte)value); }
    }

    public virtual ShadowTechnique ShadowTechnique {
        get { return GetShadowTechnique(); }
        set { SetShadowTechnique((ShadowTechnique)value); }
    }

    public virtual bool ShowDebugShadows {
        get { return GetShowDebugShadows(); }
        set { SetShowDebugShadows((bool)value); }
    }

    public virtual System.Drawing.Color ShadowColour {
        get { return GetShadowColour(); }
        set { SetShadowColour(value); }
    }

    public virtual float ShadowDirectionalLightExtrusionDistance {
        get { return GetShadowDirectionalLightExtrusionDistance(); }
        set { SetShadowDirectionalLightExtrusionDistance((float)value); }
    }

    public virtual float ShadowFarDistance {
        get { return GetShadowFarDistance(); }
        set { SetShadowFarDistance((float)value); }
    }

    public virtual UInt32 ShadowIndexBufferSize {
        get { return GetShadowIndexBufferSize(); }
        set { SetShadowIndexBufferSize(value); }
    }

    public UInt16 ShadowTextureSize {
        get { return GetShadowTextureSize(); }
        set { SetShadowTextureSize((UInt16)value); }
    }

    public PixelFormat ShadowTexturePixelFormat {
        get { return GetShadowTexturePixelFormat(); }
        set { SetShadowTexturePixelFormat((PixelFormat)value); }
    }

    public UInt16 ShadowTextureCount {
        get { return GetShadowTextureCount(); }
        set { SetShadowTextureCount((UInt16)value); }
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

