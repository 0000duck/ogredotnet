%{
#include "OgreShadowCaster.h"
%}

%rename Ogre::ShadowCaster::getCastShadows                    GetCastShadows;
%rename Ogre::ShadowCaster::getEdgeList                       GetEdgeList;
%rename Ogre::ShadowCaster::getWorldBoundingBox               GetWorldBoundingBox;
%rename Ogre::ShadowCaster::getWorldBoundingBox               GetWorldBoundingBox;
%rename Ogre::ShadowCaster::getLightCapBounds                 GetLightCapBounds;
%rename Ogre::ShadowCaster::getDarkCapBounds                  GetDarkCapBounds;
%rename Ogre::ShadowCaster::getShadowVolumeRenderableIterator GetShadowVolumeRenderableIterator;
%rename Ogre::ShadowCaster::extrudeVertices                   ExtrudeVertices;
%rename Ogre::ShadowCaster::getPointExtrusionDistance         GetPointExtrusionDistance;


//ignore because of RenderOperation is private
%ignore Ogre::ShadowRenderable::getRenderOperation;
%ignore Ogre::ShadowRenderable::getRenderOperationForUpdate;


%typemap(cscode) Ogre::ShadowCaster
%{
	static public ShadowCaster GetShadowCasterFrom( MovableObject obj )
	{
		ShadowCaster ret = new ShadowCaster( MovableObject.getCPtr(obj).Handle , false );
		return ret;
	}
	
	static public ShadowCaster GetShadowCasterFrom( BillboardSet obj )
	{
		ShadowCaster ret = new ShadowCaster( BillboardSet.getCPtr(obj).Handle , false );
		return ret;
	}
	
	static public ShadowCaster GetShadowCasterFrom( Entity obj )
	{
		ShadowCaster ret = new ShadowCaster( Entity.getCPtr(obj).Handle , false );
		return ret;
	}
	
	static public ShadowCaster GetShadowCasterFrom( Frustum obj )
	{
		ShadowCaster ret = new ShadowCaster( Frustum.getCPtr(obj).Handle , false );
		return ret;
	}
	
	static public ShadowCaster GetShadowCasterFrom( Light obj )
	{
		ShadowCaster ret = new ShadowCaster( Light.getCPtr(obj).Handle , false );
		return ret;
	}
	
	static public ShadowCaster GetShadowCasterFrom( MovablePlane obj )
	{
		ShadowCaster ret = new ShadowCaster( MovablePlane.getCPtr(obj).Handle , false );
		return ret;
	}
	
	static public ShadowCaster GetShadowCasterFrom( ParticleSystem obj )
	{
		ShadowCaster ret = new ShadowCaster( ParticleSystem.getCPtr(obj).Handle , false );
		return ret;
	}
	
	static public ShadowCaster GetShadowCasterFrom( SimpleRenderable obj )
	{
		ShadowCaster ret = new ShadowCaster( SimpleRenderable.getCPtr(obj).Handle , false );
		return ret;
	}
	
%}

%include OgreShadowCaster.h


%extend Ogre::ShadowRenderable {
	Renderable * GetAsRenderable()	{
		return (Renderable*)self;
	}
};

//typedef std::vector<ShadowRenderable*> ShadowRenderableList;
//swig.29     PTR_REF_TYPEMAPS(ShadowRenderable, Ogre::ShadowRenderable*)
SWIG_STD_VECTOR_SPECIALIZE_MINIMUM(ShadowRenderable, Ogre::ShadowRenderable*)
%template(ShadowRenderableList) std::vector<Ogre::ShadowRenderable*>;

//typedef VectorIterator<ShadowRenderableList> ShadowRenderableListIterator;
VectorIteratorWRAP(ShadowRenderableListIteratorWrap, std::vector, Ogre::ShadowRenderable*);
