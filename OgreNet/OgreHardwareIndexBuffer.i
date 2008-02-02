%{
#include "OgreHardwareIndexBuffer.h"
%}



%include OgreHardwareIndexBuffer.h

//lot of trouble with templating the SharedPtr + we dont need 2 of them.
// so just the autocreated one some functions
%extend Ogre::HardwareIndexBufferSharedPtr
{
	inline Ogre::HardwareIndexBuffer * Get()
	{
		return (Ogre::HardwareIndexBuffer*)self->get();
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
