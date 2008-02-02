%{
#include "OgreCompositionTechnique.h"
#include "CompositionTechniqueExt.h"
%}

%ignore Ogre::CompositionTechnique::createTextureDefinition;
%ignore Ogre::CompositionTechnique::getTextureDefinition;
%ignore Ogre::CompositionTechnique::getTextureDefinitionIterator;

%nodefault Ogre::CTTextureDefinition;
%nodefault Ogre::CTTextureDefinitionsIterator;

%newobject Ogre::CTTextureDefinitionsIterator::peekNext;
%newobject Ogre::CTTextureDefinitionsIterator::getNext;
%newobject Ogre::CTTextureDefinitionsIterator::next;


%include "OgreCompositionTechnique.h"

namespace Ogre
{
    class CTTextureDefinition
    {
	public:
        const String& getName();
        void setName(const String& v);
		
        size_t getWidth();
        void setWidth(size_t v);
		
        size_t getHeight();
        void setHeight(size_t v);
		
        PixelFormat getFormat();
        void setFormat(PixelFormat v);
    };
    
	class CTTextureDefinitionsIterator
	{
	public:
		bool hasMoreElements(void) const;
		void moveNext(void);
		CTTextureDefinition* peekNext(void);
		CTTextureDefinition* getNext(void);
		CTTextureDefinition* next();
	};

}




%extend Ogre::CompositionTechnique
{
	Ogre::CTTextureDefinition *CreateTextureDefinition(const String &name)
	{
		return new CTTextureDefinition( self->createTextureDefinition(name) );
	}
	
	Ogre::CTTextureDefinition *GetTextureDefinition(size_t idx)
	{
		return new CTTextureDefinition( self->getTextureDefinition(idx) );
	}

	Ogre::CTTextureDefinitionsIterator* GetTextureDefinitionIterator(void)
	{
		Ogre::CompositionTechnique::TextureDefinitionIterator * jresult;

        //typedef std::vector<TextureDefinition*> TextureDefinitions;
        //typedef VectorIterator<TextureDefinitions> TextureDefinitionIterator;
        
		SwigValueWrapper<Ogre::VectorIterator<std::vector<Ogre::CompositionTechnique::TextureDefinition * > > > result;

		result = self->getTextureDefinitionIterator();
		jresult = new Ogre::CompositionTechnique::TextureDefinitionIterator((Ogre::CompositionTechnique::TextureDefinitionIterator &)result); 

		return new Ogre::CTTextureDefinitionsIterator( jresult );
	}
};




	//typedef std::vector<CompositionTechnique *> Techniques;
SWIG_STD_VECTOR_SPECIALIZE_MINIMUM(CompositionTechnique, Ogre::CompositionTechnique*)
%template(CompositionTechniques) std::vector<Ogre::CompositionTechnique*>;

	
	//typedef VectorIterator<Techniques> TechniqueIterator;
VectorIteratorWRAP(CompositionTechniquesIteratorWrap, std::vector, Ogre::CompositionTechnique*);
