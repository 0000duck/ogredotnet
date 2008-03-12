%{
#include "OgreHighLevelGpuProgram.h"
%}


%include OgreHighLevelGpuProgram.h


//lot of trouble with templating the SharedPtr + we dont need 2 of them.
// so just the autocreated one some functions
%extend Ogre::HighLevelGpuProgramPtr
{
    Ogre::HighLevelGpuProgram* Get()
    {
        return (Ogre::HighLevelGpuProgram*)self->get();
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
