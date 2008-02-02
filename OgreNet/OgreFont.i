%{
#include "OgreFont.h"
%}


//single inheritance problem.
%ignore Ogre::Font::loadResource;

// inline void getGlyphTexCoords(OgreChar id, Real& u1, Real& v1, Real& u2, Real& v2 ) const
%apply float &INOUT { Ogre::Real &u1, Ogre::Real &v1, Ogre::Real &u2, Ogre::Real &v2 };



%include OgreFont.h



%extend Ogre::Font
{
	void LoadResource(Ogre::Resource* resource)
	{
		self->loadResource(resource);
	}
};



//class _OgreExport FontPtr : public SharedPtr<Font>
//lot of trouble with templating the SharedPtr + we dont need 2 of them.
// so just the autocreated one some functions
%extend Ogre::FontPtr
{
	Ogre::Font* Get()
	{
		return (Ogre::Font*)self->get();
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


