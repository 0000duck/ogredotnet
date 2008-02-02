%{
#include "OgreBillboardChain.h"
#include "BillboardChainExt.h"
%}


//ignore because of RenderOperation is private
%ignore Ogre::BillboardChain::getRenderOperation;

//custom wrapped
%ignore Ogre::BillboardChain::addChainElement;
%ignore Ogre::BillboardChain::updateChainElement;
%ignore Ogre::BillboardChain::getChainElement;

// TODO returns a Real* to array of floats (Real mOtherTexCoordRange[2];)
%ignore Ogre::BillboardChain::getOtherTextureCoordRange;

%newobject Ogre::BillboardChain::GetChainElement;

%include "OgreBillboardChain.h"

namespace Ogre
{
	class BbChainElement
	{
	public:
		BbChainElement();
		BbChainElement(Vector3 position, Real width, Real texCoord, ColourValue colour);
		virtual ~BbChainElement();
		const Ogre::Vector3& getPosition();
		void setPosition( const Ogre::Vector3& position);
		Real getWidth();
		void setWidth( Real width);
		Real getTexCoord();
		void setTexCoord( Real texCoord);
		const Ogre::ColourValue& getColour();
		void setColour( const Ogre::ColourValue& colour);
	};

	class  BbChainElementList
	{
	public:
		BbChainElementList();
		virtual ~BbChainElementList();
		size_t size();
		void addItem(BbChainElement *pnewItem);
		BbChainElement *getFirst();
		BbChainElement *getLast();
		BbChainElement *getByIndex(int index);
	};
}




%extend Ogre::BillboardChain {
	Renderable * GetAsRenderable()	{
		return (Renderable*)self;
	}

	void AddChainElement(size_t chainIndex, Ogre::BbChainElement* billboardChainElement)
	{
		self->addChainElement(chainIndex, *billboardChainElement->get_myOBJ() );
	}

	void UpdateChainElement(size_t chainIndex, size_t elementIndex, Ogre::BbChainElement* billboardChainElement)
	{
		self->updateChainElement(chainIndex, elementIndex, *billboardChainElement->get_myOBJ() );
	}

	Ogre::BbChainElement* GetChainElement(size_t chainIndex, size_t elementIndex)
	{
		Ogre::BbChainElement* p = new Ogre::BbChainElement( (Ogre::BillboardChain::Element*)&self->getChainElement(chainIndex, elementIndex) );
		return p;
	}

};
