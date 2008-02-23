%{
#include "OgreTexture.h"
%}

%ignore Ogre::TextureUsage;


enum TextureUsage
{
    Static = HardwareBuffer.Usage.HBU_STATIC,
    Dynamic = HardwareBuffer.Usage.HBU_DYNAMIC,
    WriteOnly = HardwareBuffer.Usage.HBU_WRITE_ONLY,
    StaticWriteOnly = HardwareBuffer.Usage.HBU_STATIC_WRITE_ONLY,
    DynamicWriteOnly = HardwareBuffer.Usage.HBU_DYNAMIC_WRITE_ONLY,
    DynamicWriteOnlyDiscardable = HardwareBuffer.Usage.HBU_DYNAMIC_WRITE_ONLY_DISCARDABLE,
    AutoMipMap = 0x100,
    RenderTarget = 0x200,
    Default = AutoMipMap | StaticWriteOnly
};


%include OgreTexture.h


//lot of trouble with templating the SharedPtr + we dont need 2 of them.
// so just the autocreated one some functions
%extend Ogre::TexturePtr
{
    Ogre::Texture* Get()
    {
        return (Ogre::Texture*)self->get();
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
