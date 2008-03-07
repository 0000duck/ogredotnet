%{
#include "OgreRenderSystem.h"
%}

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
        self->_setTextureAddressingMode(unit, *uvw->get_mObj());
    }
};

// typedef std::map< String, RenderTarget * > RenderTargetMap;
PTR_REF_TYPEMAPS(RenderTarget, Ogre::RenderTarget*)
%template(RenderTargetMap) std::map<std::string, Ogre::RenderTarget*>;

// typedef MapIterator<Ogre::RenderTargetMap> RenderTargetIterator;
MapIteratorWRAP(RenderTargetIteratorWrap, std::map, std::string, Ogre::RenderTarget*);
