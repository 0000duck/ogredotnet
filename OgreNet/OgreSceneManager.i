%{
#include "OgreSceneManager.h"
%}

%rename Ogre::SceneManager::getName                                    GetName;
%rename Ogre::SceneManager::getTypeName                                GetTypeName;
%rename Ogre::SceneManager::createCamera                               CreateCamera;
%rename Ogre::SceneManager::getCamera                                  GetCamera;
%rename Ogre::SceneManager::destroyCamera                              DestroyCamera;
%rename Ogre::SceneManager::destroyAllCameras                          DestroyAllCameras;
%rename Ogre::SceneManager::createLight                                CreateLight;
%rename Ogre::SceneManager::getLight                                   GetLight;
%rename Ogre::SceneManager::destroyLight                               DestroyLight;
%rename Ogre::SceneManager::destroyAllLights                           DestroyAllLights;
%rename Ogre::SceneManager::createSceneNode                            CreateSceneNode;
%rename Ogre::SceneManager::destroySceneNode                           DestroySceneNode;
%rename Ogre::SceneManager::getRootSceneNode                           GetRootSceneNode;
%rename Ogre::SceneManager::getSceneNode                               GetSceneNode;
%rename Ogre::SceneManager::createEntity                               CreateEntity;
%rename Ogre::SceneManager::getEntity                                  GetEntity;
%rename Ogre::SceneManager::destroyEntity                              DestroyEntity;
%rename Ogre::SceneManager::destroyAllEntities                         DestroyAllEntities;
%rename Ogre::SceneManager::createManualObject                         CreateManualObject;
%rename Ogre::SceneManager::getManualObject                            GetManualObject;
%rename Ogre::SceneManager::destroyManualObject                        DestroyManualObject;
%rename Ogre::SceneManager::destroyAllManualObjects                    DestroyAllManualObjects;
%rename Ogre::SceneManager::createBillboardChain                       CreateBillboardChain;
%rename Ogre::SceneManager::getBillboardChain                          GetBillboardChain;
%rename Ogre::SceneManager::destroyBillboardChain                      DestroyBillboardChain;
%rename Ogre::SceneManager::destroyAllBillboardChains                  DestroyAllBillboardChains;
%rename Ogre::SceneManager::createRibbonTrail                          CreateRibbonTrail;
%rename Ogre::SceneManager::getRibbonTrail                             GetRibbonTrail;
%rename Ogre::SceneManager::destroyRibbonTrail                         DestroyRibbonTrail;
%rename Ogre::SceneManager::destroyAllRibbonTrails                     DestroyAllRibbonTrails;
%rename Ogre::SceneManager::createParticleSystem                       CreateParticleSystem;
%rename Ogre::SceneManager::getParticleSystem                          GetParticleSystem;
%rename Ogre::SceneManager::destroyParticleSystem                      DestroyParticleSystem;
%rename Ogre::SceneManager::destroyAllParticleSystems                  DestroyAllParticleSystems;
%rename Ogre::SceneManager::clearScene                                 ClearScene;
%rename Ogre::SceneManager::setAmbientLight                            SetAmbientLight;
%rename Ogre::SceneManager::getAmbientLight                            GetAmbientLight;
%rename Ogre::SceneManager::setWorldGeometry                           SetWorldGeometry;
%rename Ogre::SceneManager::estimateWorldGeometry                      EstimateWorldGeometry;
%rename Ogre::SceneManager::getSuggestedViewpoint                      GetSuggestedViewpoint;
%rename Ogre::SceneManager::setOption                                  SetOption;
%rename Ogre::SceneManager::getOption                                  GetOption;
%rename Ogre::SceneManager::hasOption                                  HasOption;
%rename Ogre::SceneManager::getOptionValues                            GetOptionValues;
%rename Ogre::SceneManager::getOptionKeys                              GetOptionKeys;
%rename Ogre::SceneManager::setSkyPlane                                SetSkyPlane;

%rename Ogre::SceneManager::setSkyBox                                  SetSkyBox;
%rename Ogre::SceneManager::setSkyDome                                 SetSkyDome;
%rename Ogre::SceneManager::setFog                                     SetFog;
%rename Ogre::SceneManager::getFogMode                                 GetFogMode;
%rename Ogre::SceneManager::getFogColour                               GetFogColour;
%rename Ogre::SceneManager::getFogStart                                GetFogStart;
%rename Ogre::SceneManager::getFogEnd                                  GetFogEnd;
%rename Ogre::SceneManager::getFogDensity                              GetFogDensity;
%rename Ogre::SceneManager::createBillboardSet                         CreateBillboardSet;
%rename Ogre::SceneManager::getBillboardSet                            GetBillboardSet;
%rename Ogre::SceneManager::removeBillboardSet                         RemoveBillboardSet;
%rename Ogre::SceneManager::removeAllBillboardSets                     RemoveAllBillboardSets;
%rename Ogre::SceneManager::setDisplaySceneNodes                       SetDisplaySceneNodes;
%rename Ogre::SceneManager::createAnimation                            CreateAnimation;
%rename Ogre::SceneManager::getAnimation                               GetAnimation;
%rename Ogre::SceneManager::destroyAnimation                           DestroyAnimation;
%rename Ogre::SceneManager::destroyAllAnimations                       DestroyAllAnimations;
%rename Ogre::SceneManager::createAnimationState                       CreateAnimationState;
%rename Ogre::SceneManager::getAnimationState                          GetAnimationState;
%rename Ogre::SceneManager::destroyAnimationState                      DestroyAnimationState;
%rename Ogre::SceneManager::destroyAllAnimationStates                  DestroyAllAnimationStates;
%rename Ogre::SceneManager::addRenderQueueListener                     AddRenderQueueListener;
%rename Ogre::SceneManager::removeRenderQueueListener                  RemoveRenderQueueListener;
%rename Ogre::SceneManager::addSpecialCaseRenderQueue                  AddSpecialCaseRenderQueue;
%rename Ogre::SceneManager::removeSpecialCaseRenderQueue               RemoveSpecialCaseRenderQueue;
%rename Ogre::SceneManager::clearSpecialCaseRenderQueues               ClearSpecialCaseRenderQueues;
%rename Ogre::SceneManager::setSpecialCaseRenderQueueMode              SetSpecialCaseRenderQueueMode;
%rename Ogre::SceneManager::getSpecialCaseRenderQueueMode              GetSpecialCaseRenderQueueMode;
%rename Ogre::SceneManager::isRenderQueueToBeProcessed                 IsRenderQueueToBeProcessed;
%rename Ogre::SceneManager::setWorldGeometryRenderQueue                SetWorldGeometryRenderQueue;
%rename Ogre::SceneManager::getWorldGeometryRenderQueue                GetWorldGeometryRenderQueue;
%rename Ogre::SceneManager::showBoundingBoxes                          ShowBoundingBoxes;
%rename Ogre::SceneManager::getShowBoundingBoxes                       GetShowBoundingBoxes;
%rename Ogre::SceneManager::createAABBQuery                            CreateAABBQuery;
%rename Ogre::SceneManager::createSphereQuery                          CreateSphereQuery;
%rename Ogre::SceneManager::createPlaneBoundedVolumeQuery              CreatePlaneBoundedVolumeQuery;
%rename Ogre::SceneManager::createRayQuery                             CreateRayQuery;
%rename Ogre::SceneManager::createIntersectionQuery                    CreateIntersectionQuery;
%rename Ogre::SceneManager::destroyQuery                               DestroyQuery;
%rename Ogre::SceneManager::getCameraIterator                          GetCameraIterator;
%rename Ogre::SceneManager::getAnimationIterator                       GetAnimationIterator;
%rename Ogre::SceneManager::getAnimationStateIterator                  GetAnimationStateIterator;
%rename Ogre::SceneManager::getMovableObject                           GetMovableObject;
%rename Ogre::SceneManager::getMovableObjectIterator                   GetMovableObjectIterator;
%rename Ogre::SceneManager::setShadowTechnique                         SetShadowTechnique;
%rename Ogre::SceneManager::getShadowTechnique                         GetShadowTechnique;
%rename Ogre::SceneManager::setShowDebugShadows                        SetShowDebugShadows;
%rename Ogre::SceneManager::getShowDebugShadows                        GetShowDebugShadows;
%rename Ogre::SceneManager::setShadowColour                            SetShadowColour;
%rename Ogre::SceneManager::getShadowColour                            GetShadowColour;
%rename Ogre::SceneManager::setShadowDirectionalLightExtrusionDistance SetShadowDirectionalLightExtrusionDistance;
%rename Ogre::SceneManager::getShadowDirectionalLightExtrusionDistance GetShadowDirectionalLightExtrusionDistance;
%rename Ogre::SceneManager::setShadowFarDistance                       SetShadowFarDistance;
%rename Ogre::SceneManager::getShadowFarDistance                       GetShadowFarDistance;
%rename Ogre::SceneManager::setShadowIndexBufferSize                   SetShadowIndexBufferSize;
%rename Ogre::SceneManager::getShadowIndexBufferSize                   GetShadowIndexBufferSize;
%rename Ogre::SceneManager::setShadowTextureSize                       SetShadowTextureSize;
%rename Ogre::SceneManager::getShadowTextureSize                       GetShadowTextureSize;
%rename Ogre::SceneManager::setShadowTexturePixelFormat                SetShadowTexturePixelFormat;
%rename Ogre::SceneManager::getShadowTexturePixelFormat                GetShadowTexturePixelFormat;
%rename Ogre::SceneManager::setShadowTextureCount                      SetShadowTextureCount;
%rename Ogre::SceneManager::getShadowTextureCount                      GetShadowTextureCount;
%rename Ogre::SceneManager::setShadowTextureSettings                   SetShadowTextureSettings;
%rename Ogre::SceneManager::setShadowDirLightTextureOffset             SetShadowDirLightTextureOffset;
%rename Ogre::SceneManager::setShadowTextureFadeStart                  SetShadowTextureFadeStart;
%rename Ogre::SceneManager::setShadowTextureFadeEnd                    SetShadowTextureFadeEnd;
%rename Ogre::SceneManager::setShadowTextureSelfShadow                 SetShadowTextureSelfShadow;
%rename Ogre::SceneManager::getShadowTextureSelfShadow                 GetShadowTextureSelfShadow;
%rename Ogre::SceneManager::setShadowTextureCasterMaterial             SetShadowTextureCasterMaterial;
%rename Ogre::SceneManager::setShadowTextureReceiverMaterial           SetShadowTextureReceiverMaterial;
%rename Ogre::SceneManager::setShadowUseInfiniteFarPlane               SetShadowUseInfiniteFarPlane;
%rename Ogre::SceneManager::createStaticGeometry                       CreateStaticGeometry;
%rename Ogre::SceneManager::getStaticGeometry                          GetStaticGeometry;
%rename Ogre::SceneManager::removeStaticGeometry                       RemoveStaticGeometry;
%rename Ogre::SceneManager::removeAllStaticGeometry                    RemoveAllStaticGeometry;

//ignore because of RenderOperation is private
%ignore Ogre::SceneManager::manualRender;

//params is a keyword in C#.  there is a %extend for this function
%ignore Ogre::SceneManager::createMovableObject;

//TODO need custom wrap for sub structs
%ignore Ogre::SceneManager::getSkyPlaneGenParameters;
%ignore Ogre::SceneManager::getSkyDomeGenParameters;
%ignore Ogre::SceneManager::getSkyBoxGenParameters;


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
		set { SetAmbientLight( value ); }
	}

	public virtual SceneNode RootSceneNode {
		get { return GetRootSceneNode(); }
	}

	public System.Drawing.Color AmbientLight {
		get { return GetAmbientLight(); }
		set { SetAmbientLight(value); }
	}

	public virtual FogMode FogMode	{
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
//		typedef std::map<String, MovableObject*> MovableObjectMap;
//		typedef MapIterator<MovableObjectMap> MovableObjectIterator;




//        typedef MapIterator<CameraList> CameraIterator;
MapIteratorWRAP(CameraIteratorWrap, std::map, std::string, Ogre::Camera*);

//        typedef MapIterator<AnimationList> AnimationIterator;
MapIteratorWRAP(AnimationIteratorWrap, std::map, std::string, Ogre::Animation*);




