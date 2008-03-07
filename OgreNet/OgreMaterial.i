%{
#include "OgreMaterial.h"
%}

%ignore Ogre::Material::touch;

%typemap(cscode) Ogre::Material
%{
    public bool ReceiveShadows    {
        get { return GetReceiveShadows(); }
        set { SetReceiveShadows(value); }
    }
    
    public bool TransparencyCastsShadows    {
        get { return GetTransparencyCastsShadows(); }
        set { SetTransparencyCastsShadows(value); }
    }
    
    public int NumTechniques    {
        get { return GetNumTechniques(); }
    }
    
    public int NumSupportedTechniques    {
        get { return GetNumSupportedTechniques(); }
    }
    
    public System.Drawing.Color Ambient    {
        set { SetAmbient(value); }
    }
    
    public System.Drawing.Color Diffuse    {
        set { SetDiffuse(value); }
    }
    
    public System.Drawing.Color Specular    {
        set { SetSpecular(value); }
    }
    
    public float Shininess    {
        set { SetShininess(value); }
    }
    
    public System.Drawing.Color SelfIllumination    {
        set { SetSelfIllumination(value); }
    }
    
    public bool DepthCheckEnabled    {
        set { SetDepthCheckEnabled(value); }
    }
    
    public bool DepthWriteEnabled    {
        set { SetDepthWriteEnabled(value); }
    }
    
    public CompareFunction DepthFunction    {
        set { SetDepthFunction(value); }
    }
    
    public bool ColourWriteEnabled    {
        set { SetColourWriteEnabled(value); }
    }
    
    public CullingMode CullingMode    {
        set { SetCullingMode(value); }
    }
    
    public ManualCullingMode ManualCullingMode    {
        set { SetManualCullingMode(value); }
    }

    public bool LightingEnabled    {
        set { SetLightingEnabled(value); }
    }
    
    public ShadeOptions ShadingMode    {
        set { SetShadingMode(value); }
    }
    
    public UInt16 DepthBias    {
        set        { SetDepthBias(value); }
    }
    
    public TextureFilterOptions TextureFiltering {
        set    { SetTextureFiltering(value); }
    }
    
    public int TextureAnisotropy    {
        set { SetTextureAnisotropy(value); }
    }
    
    public SceneBlendType SceneBlending    {
        set    { SetSceneBlending(value); }
    }
    
    public VecFloats LodLevels    {
        set { SetLodLevels(value); }
    }
%}

%include OgreMaterial.h

//class _OgreExport MaterialPtr : public SharedPtr<Material>
//lot of trouble with templating the SharedPtr + we dont need 2 of them.
// so just the autocreated one some functions
%extend Ogre::MaterialPtr
{
    Ogre::Material* Get()
    {
        return (Ogre::Material*)self->get();
    }
    bool IsUnique()
    {
        return self->unique();
    }
    unsigned int UseCount()
    {
        return self->useCount();
    }
    bool IsNull()
    {
        return self->isNull();
    }
    void SetNull()
    {
        return self->setNull();
    }
};

//        typedef ConstVectorIterator<LodDistanceList> LodDistanceIterator;
ConstVectorIteratorWRAP(LodDistanceIteratorWrap, std::vector, Ogre::Real);

//protected:        typedef std::vector<Technique*> Techniques;
//PTR_REF_TYPEMAPS(Technique, Ogre::Technique*)
//SWIG_STD_VECTOR_SPECIALIZE_MINIMUM(Technique, Ogre::Technique*)
//%template(TechniquesList) std::vector<Ogre::Technique*>;

//        typedef VectorIterator<Techniques> TechniqueIterator;
VectorIteratorWRAP(TechniqueIteratorWrap, std::vector, Ogre::Technique*);
