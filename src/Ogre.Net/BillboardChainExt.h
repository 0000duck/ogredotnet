//BillboardChainExt.h
#ifndef __BillboardChainExt_H_
#define __BillboardChainExt_H_

namespace Ogre
{
    class BbChainElement
    {
    protected:
        Ogre::BillboardChain::Element *myOBJ;
        bool mICreated;
    public:
        BbChainElement()
        { 
            myOBJ = new Ogre::BillboardChain::Element();
            mICreated=true;
        }
        BbChainElement(Vector3 position, Real width, Real texCoord, ColourValue colour)
        {
            myOBJ = new Ogre::BillboardChain::Element(position, width, texCoord, colour);
            mICreated=true;
        }
        BbChainElement(Ogre::BillboardChain::Element *p)
        {
            myOBJ=p;
            mICreated=false;
        }
        virtual ~BbChainElement()
        {
            if ((mICreated))
                delete myOBJ;
        }
        //## these functions Not for swig
        Ogre::BillboardChain::Element * get_myOBJ()    { return myOBJ; }
        bool getICreated() { return mICreated; }
        //##
        
        const Ogre::Vector3& getPosition()
        {  if (myOBJ!=0)   return myOBJ->position;   else   return Ogre::Vector3::ZERO;  }
        void setPosition(const Ogre::Vector3& position)
        {  if (myOBJ!=0)   myOBJ->position = position;  }
        
        Real getWidth()
        {  if (myOBJ!=0)   return myOBJ->width;   else   return 0;  }
        void setWidth(Real width)
        {  if (myOBJ!=0)   myOBJ->width = width;  }
        
        Real getTexCoord()
        {  if (myOBJ!=0)   return myOBJ->texCoord;   else   return 0;  }
        void setTexCoord(Real texCoord)
        {  if (myOBJ!=0)   myOBJ->texCoord = texCoord;  }
        
        const Ogre::ColourValue& getColour()
        {  if (myOBJ!=0)   return myOBJ->colour;   else   return Ogre::ColourValue::ZERO;  }
        void setColour(const Ogre::ColourValue& colour)
        {  if (myOBJ!=0)   myOBJ->colour = colour;  }
    };

    //typedef std::vector<Element> ElementList;
    class BbChainElementList
    {
    protected:
        //typedef std::vector<StaticGeometry::SubMeshLodGeometryLink> tVECTOR;
        Ogre::BillboardChain::ElementList *myOBJ;
        bool mICreated;
        bool mShouldRelease;
    public:
        BbChainElementList()
        {
            myOBJ= new Ogre::BillboardChain::ElementList;
            mICreated=true;
            mShouldRelease=true;
        }
        BbChainElementList(Ogre::BillboardChain::ElementList *p)
        {
            myOBJ=p;
            mICreated=false;
            mShouldRelease=false;
        }
        virtual ~BbChainElementList()
        {
            if ((mICreated) && (mShouldRelease))
                delete myOBJ;
        }
        //## these functions Not for swig
        Ogre::BillboardChain::ElementList * get_myOBJ()    { return myOBJ; }
        bool getICreated() { return mICreated; }
        bool getShouldRelease() { return mShouldRelease; }
        void setShouldRelease(bool value) { mShouldRelease = value; }
        //##

        size_t size()
        {    if (myOBJ==0)    return 0;
            return myOBJ->size();
        }
        void addItem(BbChainElement *pnewItem)
        {
            if (myOBJ==0)
                return;
            // a vector of non ptr types creates a new copy of the object
            myOBJ->push_back(*pnewItem->get_myOBJ());
        }
        BbChainElement *getFirst()
        {
            if (myOBJ==0)
                return 0;
            Ogre::BillboardChain::ElementList::iterator it =myOBJ->begin();
            if (it == myOBJ->end())
                return 0;
            else
                return new BbChainElement((Ogre::BillboardChain::Element*)&(*it));
        }
        BbChainElement *getLast()
        {
            if (myOBJ==0)
                return 0;
            Ogre::BillboardChain::ElementList::reverse_iterator rit =myOBJ->rbegin();
            if (rit == myOBJ->rend())
                return 0;
            else
                return new BbChainElement((Ogre::BillboardChain::Element*)&(*rit));
        }
        BbChainElement *getByIndex(int index)
        {
            if (myOBJ==0)
                return 0;
            Ogre::BillboardChain::ElementList::iterator it =myOBJ->begin();
            if (it == myOBJ->end())        return 0;
            std::advance(it, index);
            if (it == myOBJ->end())        return 0;
            else                        return new BbChainElement((Ogre::BillboardChain::Element*)&(*it));
        }
    };
}

#endif  //__BillboardChainExt_H_
