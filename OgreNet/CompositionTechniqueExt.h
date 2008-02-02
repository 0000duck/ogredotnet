//CompositionTechniqueExt.h
#ifndef _CompositionTechniqueExt__H_
#define _CompositionTechniqueExt__H_

namespace Ogre
{

    class CTTextureDefinition
    {
	protected:
		CompositionTechnique::TextureDefinition *myOBJ;
	public:
		CTTextureDefinition(CompositionTechnique::TextureDefinition *p)	{
			myOBJ=p;
		}
		virtual ~CTTextureDefinition()	{}
		//## these functions Not for swig
		CompositionTechnique::TextureDefinition * get_myOBJ()	{	return myOBJ; }
		//##

	public:
        const String& getName()
		{ if (myOBJ!=0) return myOBJ->name; else return ""; }
        void setName(const String& v)
		{ if (myOBJ!=0) myOBJ->name = v; }

        size_t getWidth()
		{ if (myOBJ!=0) return myOBJ->width; else return 0; }
        void setWidth(size_t v)
		{ if (myOBJ!=0) myOBJ->width = v; }

        size_t getHeight()
		{ if (myOBJ!=0) return myOBJ->height; else return 0; }
        void setHeight(size_t v)
		{ if (myOBJ!=0) myOBJ->height = v; }

        PixelFormat getFormat()
		{ if (myOBJ!=0) return myOBJ->format; else return PF_R8G8B8A8; }
        void setFormat(PixelFormat v)
		{ if (myOBJ!=0) myOBJ->format = v; }
    };


	/***
	* a custom VectorIterator proxy for CompositionTechnique::TextureDefinitionIterator
    * typedef std::vector<TextureDefinition*> TextureDefinitions;
	* typedef VectorIterator<TextureDefinitions> TextureDefinitionIterator;
	***/
	class  CTTextureDefinitionsIterator
	{
	private:
		CompositionTechnique::TextureDefinitionIterator *myOBJ;
	public:
		CTTextureDefinitionsIterator()	{ myOBJ = 0; }
		CTTextureDefinitionsIterator(CompositionTechnique::TextureDefinitionIterator *p)	{ myOBJ = p; }
		virtual ~CTTextureDefinitionsIterator()	{
			if (myOBJ != 0)
				delete myOBJ;
		}
		bool hasMoreElements(void) const	{
			if (myOBJ==0) return false;
			return myOBJ->hasMoreElements();
		}
		void moveNext(void)					{
			if (myOBJ==0) return;
			myOBJ->moveNext();
		}
		CTTextureDefinition* peekNext(void)	{
			if (myOBJ==0) return 0;
			return new CTTextureDefinition( (CompositionTechnique::TextureDefinition*)myOBJ->peekNext() );
		}
		CTTextureDefinition* getNext(void)		{
			if (myOBJ==0) return 0;
			return new CTTextureDefinition( (CompositionTechnique::TextureDefinition*)myOBJ->getNext() );
		}
		CTTextureDefinition* next() {
			if (myOBJ==0) return 0;
			if (myOBJ->hasMoreElements())
				return new CTTextureDefinition( (CompositionTechnique::TextureDefinition*)myOBJ->getNext() );
			else
				throw( Ogre::Exception( Exception::ERR_ITEM_NOT_FOUND, "StopIteration at end", "CTTextureDefinitionsIterator", __FILE__, __LINE__ ) );
		}
	};

}

#endif //_StaticGeometrySubClassProxies__H_
