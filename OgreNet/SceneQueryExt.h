//SceneQueryExt.h
#ifndef __SceneQueryExt_H_
#define __SceneQueryExt_H_

namespace Ogre
{
	//----------------------------------------------------------------
	// custom code to handle SceneQuery::WorldFragment
	class WFragment {
	protected:
		SceneQuery::WorldFragment *mWF;
	public:
		WFragment() { mWF=0; }
		WFragment(SceneQuery::WorldFragment *p) { mWF=p; }
		
		SceneQuery::WorldFragmentType getFragmentType()
		{ if (mWF!=0) return mWF->fragmentType; else return SceneQuery::WFT_NONE; }
		
		Vector3 getSingleIntersection()
		{ if (mWF!=0) return mWF->singleIntersection; else return Ogre::Vector3::ZERO; }

		std::list<Plane>* getPlanes()
		{ if (mWF!=0) return mWF->planes; else return 0; }

		void* getGeometry()
		{ if (mWF!=0) return (void*)mWF->geometry; else return 0; }


		//RenderOperation* renderOp;
		//void* getRenderOp()
		//{ if (mWF!=0) return (void*)mWF->renderOp; else return 0; }
	};

	class ListWFragment {
	protected:
		//typedef std::list<SceneQuery::WorldFragment*> SceneQueryResultWorldFragmentList;
		SceneQueryResultWorldFragmentList *mList;
	public:
		ListWFragment() { mList=0; }
		ListWFragment(SceneQueryResultWorldFragmentList *p)   { mList=p; }
		
		size_t size()
		{	if (mList==0)	return 0;
			return mList->size();
		}
		WFragment *getFirst()
		{	if (mList==0)	return 0;
			SceneQueryResultWorldFragmentList::iterator it =mList->begin();
			if (it == mList->end())			return 0;
			else							return new WFragment( (SceneQuery::WorldFragment*)(*it) );
		}
		WFragment *getLast()
		{	if (mList==0)	return 0;
			SceneQueryResultWorldFragmentList::reverse_iterator rit =mList->rbegin();
			if (rit == mList->rend())			return 0;
			else							return new WFragment( (SceneQuery::WorldFragment*)(*rit) );
		}
		WFragment *getByIndex(int index)
		{	if (mList==0)	return 0;
			SceneQueryResultWorldFragmentList::iterator it =mList->begin();
			if (it == mList->end())
				return 0;
			std::advance(it, index);
			if (it == mList->end())
				return 0;
			else
				return new WFragment( (SceneQuery::WorldFragment*)(*it) );
		}
	};
	
	class PairMovableObjectWFragment {
	protected:
		//typedef std::pair<MovableObject*, SceneQuery::WorldFragment*> SceneQueryMovableObjectWorldFragmentPair;
		SceneQueryMovableObjectWorldFragmentPair *mObj;
	public:
		PairMovableObjectWFragment() { mObj=0; }
		PairMovableObjectWFragment(SceneQueryMovableObjectWorldFragmentPair *p)   { mObj=p; }
		
		MovableObject *first()		{
			return mObj->first;
		}
		WFragment *second()		{
			return new WFragment( mObj->second );
		}
	};

	class ListPairMovableObjectWFragment {
	protected:
		//typedef std::list<SceneQueryMovableObjectWorldFragmentPair> SceneQueryMovableWorldFragmentIntersectionList;
		SceneQueryMovableWorldFragmentIntersectionList *mList;
	public:
		ListPairMovableObjectWFragment() { mList=0; }
		ListPairMovableObjectWFragment(SceneQueryMovableWorldFragmentIntersectionList *p)   { mList=p; }
		
		size_t size()
		{	if (mList==0)	return 0;
			return mList->size();
		}
		PairMovableObjectWFragment *getFirst()
		{	if (mList==0)	return 0;
			SceneQueryMovableWorldFragmentIntersectionList::iterator it =mList->begin();
			if (it == mList->end())			return 0;
			else							return new PairMovableObjectWFragment( (SceneQueryMovableObjectWorldFragmentPair*)&(*it) );
		}
		PairMovableObjectWFragment *getLast()
		{	if (mList==0)	return 0;
			SceneQueryMovableWorldFragmentIntersectionList::reverse_iterator rit =mList->rbegin();
			if (rit == mList->rend())			return 0;
			else							return new PairMovableObjectWFragment( (SceneQueryMovableObjectWorldFragmentPair*)&(*rit) );
		}
		PairMovableObjectWFragment *getByIndex(int index)
		{	if (mList==0)	return 0;
			SceneQueryMovableWorldFragmentIntersectionList::iterator it =mList->begin();
			if (it == mList->end())
				return 0;
			std::advance(it, index);
			if (it == mList->end())
				return 0;
			else
				return new PairMovableObjectWFragment( (SceneQueryMovableObjectWorldFragmentPair*)&(*it) );
		}
	};


	//----------------------------------------------------------------
	typedef bool (SWIGSTDCALL *RSQL_queryResultMO_FunctionPointer)( Ogre::MovableObject*, Real );
	typedef bool (SWIGSTDCALL *RSQL_queryResultWF_FunctionPointer)( Ogre::WFragment*, Real);
	class RaySceneQueryListenerDirector : public RaySceneQueryListener
	{
	public:
		RSQL_queryResultMO_FunctionPointer mFPqueryResultMO;
		RSQL_queryResultWF_FunctionPointer mFPqueryResultWF;

		RaySceneQueryListenerDirector()
		{
			mFPqueryResultMO =0;
			mFPqueryResultWF =0;
		}
		bool queryResult(MovableObject* obj, Real distance)
		{
			if( mFPqueryResultMO )
				return mFPqueryResultMO(obj, distance);
			else
				return false;		//'false' to abandon any further results from the current query
		}
		bool queryResult(SceneQuery::WorldFragment* fragment, Real distance)
		{
			WFragment *wf = new WFragment(fragment);
			if( mFPqueryResultWF )
				return mFPqueryResultWF(wf, distance);
			else
				return false;		//'false' to abandon any further results from the current query
		}
	};

	//----------------------------------------------------------------
	typedef bool (SWIGSTDCALL *ISQL_queryResultMOMO_FunctionPointer)( Ogre::MovableObject*, Ogre::MovableObject* );
	typedef bool (SWIGSTDCALL *ISQL_queryResultMOWF_FunctionPointer)( Ogre::MovableObject*, Ogre::WFragment*);
	class IntersectionSceneQueryListenerDirector : public IntersectionSceneQueryListener
	{
	public:
		ISQL_queryResultMOMO_FunctionPointer mFPqueryResultMOMO;
		ISQL_queryResultMOWF_FunctionPointer mFPqueryResultMOWF;

		IntersectionSceneQueryListenerDirector()
		{
			mFPqueryResultMOMO =0;
			mFPqueryResultMOWF =0;
		}
		
		bool queryResult(MovableObject* first, MovableObject* second)
		{
			if( mFPqueryResultMOMO )
				return mFPqueryResultMOMO(first, second);
			else
				return false;		//'false' to abandon any further results from the current query
		}
		
		bool queryResult(MovableObject* movable, SceneQuery::WorldFragment* fragment)
		{
			WFragment *wf = new WFragment(fragment);
			if( mFPqueryResultMOWF )
				return mFPqueryResultMOWF(movable, wf);
			else
				return false;		//'false' to abandon any further results from the current query
		}
	};
}

extern "C" SWIGEXPORT void RSQL_queryResultMO_Function( void * sqld, void * fn )		{
	((RaySceneQueryListenerDirector*)sqld)->mFPqueryResultMO = (RSQL_queryResultMO_FunctionPointer)fn;
}

extern "C" SWIGEXPORT void RSQL_queryResultWF_Function( void * sqld, void * fn )		{
	((RaySceneQueryListenerDirector*)sqld)->mFPqueryResultWF = (RSQL_queryResultWF_FunctionPointer)fn;
}

extern "C" SWIGEXPORT void ISQL_queryResultMOMO_Function( void * sqld, void * fn )		{
	((IntersectionSceneQueryListenerDirector*)sqld)->mFPqueryResultMOMO = (ISQL_queryResultMOMO_FunctionPointer)fn;
}

extern "C" SWIGEXPORT void ISQL_queryResultMOWF_Function( void * sqld, void * fn )		{
	((IntersectionSceneQueryListenerDirector*)sqld)->mFPqueryResultMOWF = (ISQL_queryResultMOWF_FunctionPointer)fn;
}


#endif //__SceneQueryExt_H_

