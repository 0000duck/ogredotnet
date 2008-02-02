%{
#include "OgreRenderQueueSortingGrouping.h"
namespace Ogre
{
	/***
	* a custom MapIterator proxy for RenderQueueGroup::PriorityMapIterator
	* typedef std::map<ushort, RenderPriorityGroup*, std::less<ushort> > PriorityMap;
	* typedef MapIterator<PriorityMap> PriorityMapIterator;
	***/
	class  RQGPriorityMapIterator
	{
	private:
		RenderQueueGroup::PriorityMapIterator *myOBJ;
	public:
		RQGPriorityMapIterator()	{ myOBJ = 0; }
		RQGPriorityMapIterator(RenderQueueGroup::PriorityMapIterator *p)	{ myOBJ = p; }
		virtual ~RQGPriorityMapIterator()	{
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
		ushort peekNextKey(void)		{
			if (myOBJ==0) return 0;
			return myOBJ->peekNextKey();
		}
		RenderPriorityGroup* peekNextValue(void)	{
			if (myOBJ==0) return 0;
			return (Ogre::RenderPriorityGroup*)myOBJ->peekNextValue();
		}
		RenderPriorityGroup* getNext(void)	{
			if (myOBJ==0) return 0;
			return (Ogre::RenderPriorityGroup*)myOBJ->getNext();
		}
		RenderPriorityGroup* next() {
			if (myOBJ==0) return 0;
			if (myOBJ->hasMoreElements())
				return (Ogre::RenderPriorityGroup*)myOBJ->getNext();
			else
				throw( Ogre::Exception( Exception::ERR_ITEM_NOT_FOUND, "StopIteration at end", "RQGPriorityMapIterator", __FILE__, __LINE__ ) );
		}
	};
}
%}

//custom wrap for PriorityMapIterator 
%ignore Ogre::RenderQueueGroup::PriorityMap;
%ignore Ogre::RenderQueueGroup::PriorityMapIterator;
%ignore Ogre::RenderQueueGroup::getIterator;

%nodefault Ogre::RQGPriorityMapIterator;
%newobject Ogre::RenderQueueGroup::GetIterator;



%include "OgreRenderQueueSortingGrouping.h"

namespace Ogre
{
	class  RQGPriorityMapIterator
	{
	public:
		bool hasMoreElements(void) const;
		void moveNext(void);
		ushort peekNextKey(void);
		RenderPriorityGroup* peekNextValue(void);
		RenderPriorityGroup* getNext(void);
		RenderPriorityGroup* next();
	};
}



%extend Ogre::RenderQueueGroup
{
	Ogre::RQGPriorityMapIterator* GetIterator()
	{
		Ogre::RenderQueueGroup::PriorityMapIterator * jresult;
		
		// typedef std::map<ushort, RenderPriorityGroup*, std::less<ushort> > PriorityMap;
		// typedef MapIterator<PriorityMap> PriorityMapIterator;
		SwigValueWrapper<Ogre::MapIterator< std::map<Ogre::ushort, Ogre::RenderPriorityGroup*, std::less<Ogre::ushort> > > > result;
		
		result = self->getIterator();
		jresult = new Ogre::RenderQueueGroup::PriorityMapIterator( (Ogre::RenderQueueGroup::PriorityMapIterator&)result ); 
		
		return new Ogre::RQGPriorityMapIterator( jresult );
	}
};

