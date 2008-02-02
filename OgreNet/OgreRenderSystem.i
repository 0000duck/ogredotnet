%{
#include "OgreRenderSystem.h"
%}

%rename Ogre::RenderSystem::getName                      GetName;
%rename Ogre::RenderSystem::getConfigOptions             GetConfigOptions;
%rename Ogre::RenderSystem::setConfigOption              SetConfigOption;
%rename Ogre::RenderSystem::createHardwareOcclusionQuery CreateHardwareOcclusionQuery;
%rename Ogre::RenderSystem::validateConfigOptions        ValidateConfigOptions;
%rename Ogre::RenderSystem::initialise                   Initialise;
%rename Ogre::RenderSystem::reinitialise                 Reinitialise;
%rename Ogre::RenderSystem::shutdown                     Shutdown;
%rename Ogre::RenderSystem::setAmbientLight              SetAmbientLight;
%rename Ogre::RenderSystem::setShadingType               SetShadingType;
%rename Ogre::RenderSystem::setLightingEnabled           SetLightingEnabled;
%rename Ogre::RenderSystem::setWBufferEnabled            SetWBufferEnabled;
%rename Ogre::RenderSystem::getWBufferEnabled            GetWBufferEnabled;
%rename Ogre::RenderSystem::createRenderWindow           CreateRenderWindow;
%rename Ogre::RenderSystem::createRenderTexture          CreateRenderTexture;
%rename Ogre::RenderSystem::destroyRenderWindow          DestroyRenderWindow;
%rename Ogre::RenderSystem::destroyRenderTexture         DestroyRenderTexture;
%rename Ogre::RenderSystem::destroyRenderTarget          DestroyRenderTarget;
%rename Ogre::RenderSystem::attachRenderTarget           AttachRenderTarget;
%rename Ogre::RenderSystem::getRenderTarget              GetRenderTarget;
%rename Ogre::RenderSystem::detachRenderTarget           DetachRenderTarget;
%rename Ogre::RenderSystem::getErrorDescription          GetErrorDescription;
%rename Ogre::RenderSystem::setWaitForVerticalBlank      SetWaitForVerticalBlank;
%rename Ogre::RenderSystem::getWaitForVerticalBlank      GetWaitForVerticalBlank;
//%rename Ogre::RenderSystem::convertColourValue           ConvertColourValue;
%rename Ogre::RenderSystem::setStencilCheckEnabled       SetStencilCheckEnabled;
%rename Ogre::RenderSystem::setStencilBufferParams       SetStencilBufferParams;
%rename Ogre::RenderSystem::setStencilBufferParams       SetStencilBufferParams;
%rename Ogre::RenderSystem::setVertexDeclaration         SetVertexDeclaration;
%rename Ogre::RenderSystem::setVertexBufferBinding       SetVertexBufferBinding;
%rename Ogre::RenderSystem::setNormaliseNormals          SetNormaliseNormals;
%rename Ogre::RenderSystem::getCapabilities              GetCapabilities;
%rename Ogre::RenderSystem::bindGpuProgram               BindGpuProgram;
%rename Ogre::RenderSystem::unbindGpuProgram             UnbindGpuProgram;
%rename Ogre::RenderSystem::setClipPlanes                SetClipPlanes;
%rename Ogre::RenderSystem::setClipPlane                 SetClipPlane;
%rename Ogre::RenderSystem::enableClipPlane              EnableClipPlane;
%rename Ogre::RenderSystem::setInvertVertexWinding       SetInvertVertexWinding;
%rename Ogre::RenderSystem::setScissorTest               SetScissorTest;
%rename Ogre::RenderSystem::clearFrameBuffer             ClearFrameBuffer;
%rename Ogre::RenderSystem::getHorizontalTexelOffset     GetHorizontalTexelOffset;
%rename Ogre::RenderSystem::getVerticalTexelOffset       GetVerticalTexelOffset;
%rename Ogre::RenderSystem::getMinimumDepthInputValue    GetMinimumDepthInputValue;
%rename Ogre::RenderSystem::getMaximumDepthInputValue    GetMaximumDepthInputValue;


%ignore Ogre::RenderSystem::bindGpuProgramParameters;

//ignore because of RenderOperation is private
%ignore Ogre::RenderSystem::_render;

//custom wrapped
%ignore Ogre::RenderSystem::_setTextureAddressingMode;


//TODO this exspects a list of uint32
%ignore Ogre::RenderSystem::convertColourValue;

//TODO for ogre 1.0.6 >  a new inner class that will need to be custom wrapped
%ignore Ogre::RenderSystem::addListener;
%ignore Ogre::RenderSystem::removeListener;



%typemap(cscode) Ogre::RenderSystem
%{
	public virtual string Name {
		get { return GetName(); }
	}
	
	public ShadeOptions ShadingType {
		set { SetShadingType(value); }
	}
	
	public bool LightingEnabled {
		set { SetLightingEnabled(value); }
	}
	
	public bool WBufferEnabled {
		get { return GetWBufferEnabled(); }
		set { SetWBufferEnabled((bool)value); }
	}
	
	public bool WaitForVerticalBlank {
		get { return GetWaitForVerticalBlank(); }
		set { SetWaitForVerticalBlank((bool)value); }
	}
	
	public virtual Viewport Viewport {
		get { return _getViewport(); }
		set { _setViewport((Viewport)value); }
	}
	
	public virtual CullingMode CullingMode {
		get { return _getCullingMode(); }
		set { _setCullingMode((CullingMode)value); }
	}
	
	public virtual UInt32 FaceCount {
		get { return _getFaceCount(); }
	}
	
	public virtual UInt32 VertexCount {
		get { return _getVertexCount(); }
	}
	
	public bool StencilCheckEnabled {
		set { SetStencilCheckEnabled(value); }
	}
	
	public VertexDeclaration vertexdeclaration {
		set { SetVertexDeclaration(value); }
	}
	
	public VertexBufferBinding vertexbufferbinding {
		set { SetVertexBufferBinding(value); }
	}
	
	public bool NormaliseNormals {
		set { SetNormaliseNormals(value); }
	}
	
	public RenderSystemCapabilities Capabilities {
		get { return GetCapabilities(); }
	}
	
	public bool InvertVertexWinding {
		set { SetInvertVertexWinding(value); }
	}
	
	public virtual float HorizontalTexelOffset {
		get { return GetHorizontalTexelOffset(); }
	}
	
	public virtual float VerticalTexelOffset {
		get { return GetVerticalTexelOffset(); }
	}
	
	public virtual float MinimumDepthInputValue {
		get { return GetMinimumDepthInputValue(); }
	}
	
	public virtual float MaximumDepthInputValue {
		get { return GetMaximumDepthInputValue(); }
	}
%}


%include OgreRenderSystem.h


%extend Ogre::RenderSystem {
	void _SetTextureAddressingMode(size_t unit, Ogre::TUSUVWAddressingMode * uvw)
	{
		self->_setTextureAddressingMode(unit, *uvw->get_mObj() );
	}
};



// typedef std::map< String, RenderTarget * > RenderTargetMap;
PTR_REF_TYPEMAPS(RenderTarget, Ogre::RenderTarget*)
%template(RenderTargetMap) std::map<std::string, Ogre::RenderTarget*>;

// typedef MapIterator<Ogre::RenderTargetMap> RenderTargetIterator;
MapIteratorWRAP(RenderTargetIteratorWrap, std::map, std::string, Ogre::RenderTarget*);

