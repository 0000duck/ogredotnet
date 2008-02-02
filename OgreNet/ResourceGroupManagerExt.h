//ResourceGroupManagerExt.h
#ifndef __ResourceGroupManagerExt_H_
#define __ResourceGroupManagerExt_H_

namespace Ogre
{
	//----------------------------------------------------------------
	// custom code to handle ResourceGroupManager::ResourceDeclaration
	class RGMResourceDeclaration {
	protected:
		ResourceGroupManager::ResourceDeclaration *mRD;
	public:
		RGMResourceDeclaration() { mRD=0; }
		RGMResourceDeclaration(ResourceGroupManager::ResourceDeclaration *p) { mRD=p; }
		
		String getResourceName()
		{ if (mRD!=0) return mRD->resourceName; else return String(""); }
		
		void setResourceName(String v)
		{ if (mRD!=0) mRD->resourceName = v; }


		String getResourceType()
		{ if (mRD!=0) return mRD->resourceType; else return String(""); }
		
		void setResourceType(String v)
		{ if (mRD!=0) mRD->resourceType = v; }
		
		ManualResourceLoader* getLoader()
		{ if (mRD!=0) return mRD->loader; else return 0; }
		
		NameValuePairList* getParameters()
		{ if (mRD!=0) return &mRD->parameters; else return 0; }
	};



	//----------------------------------------------------------------
	// custom code to handle ResourceGroupManager::ResourceDeclarationList
	class RGMResourceDeclarationList {
	protected:
		//typedef std::list<ResourceDeclaration> ResourceDeclarationList;
		ResourceGroupManager::ResourceDeclarationList *mList;
	public:
		RGMResourceDeclarationList() { mList=0; }
		RGMResourceDeclarationList(ResourceGroupManager::ResourceDeclarationList *p)   { mList=p; }
		
		size_t size()
		{	if (mList==0)	return 0;
			return mList->size();
		}
		RGMResourceDeclaration *getFirst()
		{	if (mList==0)	return 0;
			ResourceGroupManager::ResourceDeclarationList::iterator it =mList->begin();
			if (it == mList->end())			return 0;
			else							return new RGMResourceDeclaration( (ResourceGroupManager::ResourceDeclaration*)&(*it) );
		}
		RGMResourceDeclaration *getLast()
		{	if (mList==0)	return 0;
			ResourceGroupManager::ResourceDeclarationList::reverse_iterator rit =mList->rbegin();
			if (rit == mList->rend())			return 0;
			else							return new RGMResourceDeclaration( (ResourceGroupManager::ResourceDeclaration*)&(*rit) );
		}
		RGMResourceDeclaration *getByIndex(int index)
		{	if (mList==0)	return 0;
			ResourceGroupManager::ResourceDeclarationList::iterator it =mList->begin();
			if (it == mList->end())
				return 0;
			std::advance(it, index);
			if (it == mList->end())
				return 0;
			else
				return new RGMResourceDeclaration( (ResourceGroupManager::ResourceDeclaration*)&(*it) );
		}
	};
}


#endif //__ResourceGroupManagerExt_H_
