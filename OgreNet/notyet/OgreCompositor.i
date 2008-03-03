%{
#include "OgreCompositor.h"
%}



%include "OgreCompositor.h"


//the base class for Compositor is in another swig call.
// So we to make it easy, use the extended function GetAsResource to access those functions
%extend Ogre::Compositor
{
    Ogre::Resource* GetAsResource(void)
    {
        return (Ogre::Resource*)self;
    }
};


//just do the same as others in the main swig
//class _OgreExport CompositorPtr : public SharedPtr<Compositor> 
//lot of trouble with templating the SharedPtr + we dont need 2 of them.
// so just the autocreated one some functions    
%extend Ogre::CompositorPtr
{
    Ogre::Compositor* Get()
    {
        return (Ogre::Compositor*)self->get();
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
