%{
#include "OgreMaterial.h"
%}

%ignore Ogre::Material::touch;

%typemap(cscode) Ogre::Material
%{
    public bool ReceiveShadows    {
        get { return getReceiveShadows(); }
        set { setReceiveShadows(value); }
    }
    
    public bool TransparencyCastsShadows    {
        get { return getTransparencyCastsShadows(); }
        set { setTransparencyCastsShadows(value); }
    }
    
    public int NumTechniques    {
        get { return getNumTechniques(); }
    }
    
    public int NumSupportedTechniques    {
        get { return getNumSupportedTechniques(); }
    }
    
    public System.Drawing.Color Ambient    {
        set { setAmbient(value); }
    }
    
    public System.Drawing.Color Diffuse    {
        set { setDiffuse(value); }
    }
    
    public System.Drawing.Color Specular    {
        set { setSpecular(value); }
    }
    
    public float Shininess    {
        set { setShininess(value); }
    }
    
    public System.Drawing.Color SelfIllumination    {
        set { setSelfIllumination(value); }
    }
    
    public bool DepthCheckEnabled    {
        set { setDepthCheckEnabled(value); }
    }
    
    public bool DepthWriteEnabled    {
        set { setDepthWriteEnabled(value); }
    }
    
    public CompareFunction DepthFunction    {
        set { setDepthFunction(value); }
    }
    
    public bool ColourWriteEnabled    {
        set { setColourWriteEnabled(value); }
    }
    
    public CullingMode CullingMode    {
        set { setCullingMode(value); }
    }
    
    public ManualCullingMode ManualCullingMode    {
        set { setManualCullingMode(value); }
    }

    public bool LightingEnabled    {
        set { setLightingEnabled(value); }
    }
    
    public ShadeOptions ShadingMode    {
        set { setShadingMode(value); }
    }

// TODO: setDepthBias takes 2 parameters    
//     public UInt16 DepthBias    {
//         set        { setDepthBias(value); }
//     }
    
    public TextureFilterOptions TextureFiltering {
        set    { setTextureFiltering(value); }
    }
    
    public int TextureAnisotropy    {
        set { setTextureAnisotropy(value); }
    }
    
    public SceneBlendType SceneBlending    {
        set    { setSceneBlending(value); }
    }
    
    public VecFloats LodLevels    {
        set { setLodLevels(value); }
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
