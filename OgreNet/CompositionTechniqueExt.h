#ifndef _CompositionTechniqueExt__H_
#define _CompositionTechniqueExt__H_

namespace Ogre
{
    class CTTextureDefinition
    {
    protected:
        CompositionTechnique::TextureDefinition* myObj;
    public:
        CTTextureDefinition(CompositionTechnique::TextureDefinition* p)
        {
            myObj = p;
        }

        virtual ~CTTextureDefinition() {}

        //## these functions Not for swig
        CompositionTechnique::TextureDefinition* getMyObj()  { return myObj; }
        //##

    public:
        const String& getName()
        { return myObj == 0 ? "" : myObj->name; }
        void setName(const String& v)
        { if (myObj!=0) myObj->name = v; }

        size_t getWidth()
        { return myObj == 0 ? 0 : myObj->width; }
        void setWidth(size_t v)
        { if (myObj!=0) myObj->width = v; }

        size_t getHeight()
        { return myObj == 0 ? 0 : myObj->height; }
        void setHeight(size_t v)
        { if (myObj!=0) myObj->height = v; }

        PixelFormat getFormat()
        { return myObj == 0 ? PF_R8G8B8A8 : myObj->format; }
        void setFormat(PixelFormat v)
        { if (myObj!=0) myObj->format = v; }
    };


    /***
    * a custom VectorIterator proxy for CompositionTechnique::TextureDefinitionIterator
    * typedef std::vector<TextureDefinition*> TextureDefinitions;
    * typedef VectorIterator<TextureDefinitions> TextureDefinitionIterator;
    ***/
    class  CTTextureDefinitionsIterator
    {
    private:
        CompositionTechnique::TextureDefinitionIterator* myObj;
    public:
        CTTextureDefinitionsIterator()
        {
            myObj = 0;
        }

        CTTextureDefinitionsIterator(CompositionTechnique::TextureDefinitionIterator* p)
        {
            myObj = p;
        }

        virtual ~CTTextureDefinitionsIterator()
        {
            if (myObj != 0)
                delete myObj;
        }
        
        bool hasMoreElements(void) const
        {
            if (myObj == 0) return false;
            return myObj->hasMoreElements();
        }

        void moveNext(void)
        {
            if (myObj == 0) return;
            myObj->moveNext();
        }

        CTTextureDefinition* peekNext(void)
        {
            if (myObj == 0) return 0;
            return new CTTextureDefinition((CompositionTechnique::TextureDefinition*)myObj->peekNext());
        }

        CTTextureDefinition* getNext(void)
        {
            if (myObj == 0) return 0;
            return new CTTextureDefinition((CompositionTechnique::TextureDefinition*)myObj->getNext());
        }

        CTTextureDefinition* next()
        {
            if (myObj == 0) return 0;
            if (myObj->hasMoreElements())
                return new CTTextureDefinition((CompositionTechnique::TextureDefinition*)myObj->getNext());
            else
                throw(Ogre::Exception(Exception::ERR_ITEM_NOT_FOUND, "StopIteration at end", "CTTextureDefinitionsIterator", __FILE__, __LINE__));
        }
    };
}

#endif
