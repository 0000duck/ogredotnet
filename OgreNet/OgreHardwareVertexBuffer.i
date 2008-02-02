%{
#include "OgreHardwareVertexBuffer.h"
%}

//there are 5 overloaded function all not need
//  pointers to pointers are dificult in DotNet, use MeshBuilderHelper class
%ignore Ogre::VertexElement::baseVertexPointerToElement;  

//static void convertColourValue(VertexElementType srcType,VertexElementType dstType, uint32* ptr);
%apply unsigned int *INOUT { Ogre::uint32 *ptr };

//virtual const VertexBufferBindingMap& getBindings(void) const;
%ignore Ogre::VertexBufferBinding::getBindings;




%include OgreHardwareVertexBuffer.h




//lot of trouble with templating the SharedPtr + we dont need 2 of them.
// so just the autocreated one some functions
%extend Ogre::HardwareVertexBufferSharedPtr
{
	Ogre::HardwareVertexBuffer* Get()
	{
		return (Ogre::HardwareVertexBuffer*)self->get();
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



//	typedef std::list<VertexElement> VertexElementList;
SWIG_STD_LIST_SPECIALIZE(VertexElement, Ogre::VertexElement)
%template(VertexElementList) std::list<Ogre::VertexElement>;

//TODO build error
//typedef std::map<unsigned short, HardwareVertexBufferSharedPtr> VertexBufferBindingMap;
//%template(VertexBufferBindingMap) std::map< unsigned short, Ogre::HardwareVertexBufferSharedPtr >;


