%{
#include "OgreSceneQuery.h"
#include "SceneQueryExt.h"
%}


//%ignore Ogre::SceneQuery::getSupportedWorldFragmentTypes;
%ignore Ogre::RaySceneQueryListener::queryResult;	//ignores both
%ignore Ogre::SceneQueryListener::queryResult;	//ignores both
%ignore Ogre::RegionSceneQuery::queryResult;	//ignores both
%ignore Ogre::RaySceneQuery::queryResult;			// ignores both
%ignore Ogre::RaySceneQueryResultEntry::worldFragment;
%ignore Ogre::SceneQueryResult::worldFragments;
%ignore Ogre::IntersectionSceneQueryListener::queryResult;	//ignores both
%ignore Ogre::IntersectionSceneQuery::queryResult;	//ignores both
%ignore Ogre::IntersectionSceneQueryResult::movables2world;

%ignore Ogre::SceneQueryMovableObjectWorldFragmentPair;
%ignore Ogre::SceneQueryMovableWorldFragmentIntersectionList;


%newobject Ogre::RaySceneQueryResultEntry::getWorldFragment;
%newobject Ogre::SceneQueryResult::getWorldFragments;
%newobject Ogre::IntersectionSceneQueryResult::getmovables2world;



%include OgreSceneQuery.h

%nodefault Ogre::WFragment;
%nodefault Ogre::ListWFragment;
%nodefault Ogre::PairMovableObjectWFragment;
%nodefault Ogre::ListPairMovableObjectWFragment;

%newobject Ogre::ListWFragment::getFirst;
%newobject Ogre::ListWFragment::getLast;
%newobject Ogre::ListWFragment::getByIndex;
%newobject Ogre::PairMovableObjectWFragment::second;
%newobject Ogre::ListPairMovableObjectWFragment::getFirst;
%newobject Ogre::ListPairMovableObjectWFragment::getLast;
%newobject Ogre::ListPairMovableObjectWFragment::getByIndex;



%typemap(cscode) Ogre::RaySceneQueryListenerDirector %{
	public delegate bool RSQLQueryResultMODelegate( MovableObject obj, float distance );
	public delegate bool RSQLQueryResultWFDelegate( WFragment fragment, float distance );

	protected delegate bool _RSQL_queryResultMO_Delegate( IntPtr mo, float distance);
	protected delegate bool _RSQL_queryResultWF_Delegate( IntPtr wf, float distance);
	
	public void SubscribeEvents()
	{
		mQueryResultMODelegate = new _RSQL_queryResultMO_Delegate(Handle_QueryResultMO);
		SetQueryResultMOFunction(swigCPtr, mQueryResultMODelegate);
		
		mQueryResultWFDelegate = new _RSQL_queryResultWF_Delegate(Handle_QueryResultWF);
		SetQueryResultWFFunction(swigCPtr, mQueryResultWFDelegate);
	}
	
	public event RSQLQueryResultMODelegate QueryResultMO = null;
	public event RSQLQueryResultWFDelegate QueryResultWF = null;

	protected _RSQL_queryResultMO_Delegate mQueryResultMODelegate = null;
	protected _RSQL_queryResultWF_Delegate mQueryResultWFDelegate = null;


	[DllImport("OgreBindings", EntryPoint="RSQL_queryResultMO_Function")]
	protected static extern void SetQueryResultMOFunction( HandleRef rsqListenerDirector, _RSQL_queryResultMO_Delegate fn );

	[DllImport("OgreBindings", EntryPoint="RSQL_queryResultWF_Function")]
	protected static extern void SetQueryResultWFFunction( HandleRef rsqListenerDirector, _RSQL_queryResultWF_Delegate fn );



	protected bool Handle_QueryResultMO( IntPtr obj, float distance )
	{
		MovableObject mo = new MovableObject( obj, false );
		if( QueryResultMO != null )
			return QueryResultMO(mo,distance );
		return false;
	}

	protected bool Handle_QueryResultWF( IntPtr fragment, float distance )
	{
		WFragment wf = new WFragment( fragment, false );
		if( QueryResultWF != null )
			return QueryResultWF(wf, distance);
		return false;
	}
%}


%typemap(cscode) Ogre::IntersectionSceneQueryListenerDirector %{
	public delegate bool ISQLQueryResultMOMODelegate( MovableObject first, MovableObject second );
	public delegate bool ISQLQueryResultMOWFDelegate( MovableObject mobj, WFragment fragment );

	protected delegate bool _ISQL_queryResultMOMO_Delegate( IntPtr first, IntPtr second );
	protected delegate bool _ISQL_queryResultMOWF_Delegate( IntPtr mobj, IntPtr fragment);
	
	public void SubscribeEvents()
	{
		mQueryResultMOMODelegate = new _ISQL_queryResultMOMO_Delegate(Handle_QueryResultMOMO);
		ISQL_queryResultMOMO_Function(swigCPtr, mQueryResultMOMODelegate);
		
		mQueryResultMOWFDelegate = new _ISQL_queryResultMOWF_Delegate(Handle_QueryResultMOWF);
		ISQL_queryResultMOWF_Function(swigCPtr, mQueryResultMOWFDelegate);
	}
	
	public event ISQLQueryResultMOMODelegate QueryResultMOMO = null;
	public event ISQLQueryResultMOWFDelegate QueryResultMOWF = null;

	protected _ISQL_queryResultMOMO_Delegate mQueryResultMOMODelegate = null;
	protected _ISQL_queryResultMOWF_Delegate mQueryResultMOWFDelegate = null;

	[DllImport("OgreBindings", EntryPoint="ISQL_queryResultMOMO_Function")]
	protected static extern void ISQL_queryResultMOMO_Function( HandleRef isqListenerDirector, _ISQL_queryResultMOMO_Delegate fn );

	[DllImport("OgreBindings", EntryPoint="ISQL_queryResultMOWF_Function")]
	protected static extern void ISQL_queryResultMOWF_Function( HandleRef isqListenerDirector, _ISQL_queryResultMOWF_Delegate fn );

	protected bool Handle_QueryResultMOMO( IntPtr first, IntPtr second )
	{
		MovableObject f = new MovableObject( first, false );
		MovableObject s = new MovableObject( second, false );
		if( QueryResultMOMO != null )
			return QueryResultMOMO(f,s );
		return false;
	}

	protected bool Handle_QueryResultMOWF( IntPtr mobj, IntPtr fragment )
	{
		MovableObject m = new MovableObject( mobj, false );
		WFragment wf = new WFragment( fragment, false );
		if( QueryResultMOWF != null )
			return QueryResultMOWF(m, wf);
		return false;
	}
%}

namespace Ogre
{
	// declarations for custom code to handle callbacks in RaySceneQueryListener
	class RaySceneQueryListenerDirector : public RaySceneQueryListener
	{
	public:
		RaySceneQueryListenerDirector();
	};
	
	// declarations for custom code to handle SceneQuery::WorldFragment
	class WFragment {
	public:
		//WFragment();
		Ogre::SceneQuery::WorldFragmentType getFragmentType();
		Vector3 getSingleIntersection();
		std::list<Plane>* getPlanes();
		void* getGeometry();
		//void* getRenderOp();
	};
	
	class ListWFragment {
	public:
		//ListWFragment();
		size_t size();
		WFragment *getFirst();
		WFragment *getLast();
		WFragment *getByIndex(int index);
	};
	
	class PairMovableObjectWFragment
	{
	public:
		//PairMovableObjectWFragment();
		MovableObject *first();
		WFragment *second();
	};
	
	class ListPairMovableObjectWFragment {
	public:
		//ListPairMovableObjectWFragment();
		size_t size();
		PairMovableObjectWFragment *getFirst();
		PairMovableObjectWFragment *getLast();
		PairMovableObjectWFragment *getByIndex(int index);
	};
	
	class IntersectionSceneQueryListenerDirector : public IntersectionSceneQueryListener
	{
	public:
		IntersectionSceneQueryListenerDirector();
	};
	
}





// extend classes for custom code to handle SceneQuery::WorldFragment
%extend Ogre::RaySceneQueryResultEntry {
    /// The world fragment, or NULL if this is not a fragment result
	Ogre::WFragment *getWorldFragment()
	{	return new Ogre::WFragment(self->worldFragment);   }
};
%extend Ogre::SceneQueryResult {
    /// The world fragment, or NULL if this is not a fragment result
	Ogre::ListWFragment *getWorldFragments()
	{	return new Ogre::ListWFragment(&self->worldFragments);   }
};
%extend Ogre::IntersectionSceneQueryResult {
	Ogre::ListPairMovableObjectWFragment *getmovables2world()
	{	return new Ogre::ListPairMovableObjectWFragment(&self->movables2world);   }
};




//----------------------------------------------------------------
// templates

//in class SceneQuery
//virtual const std::set<WorldFragmentType>* getSupportedWorldFragmentTypes(void) const
SWIG_STD_SET_SPECIALIZE_MINIMUM(SceneQuery.WorldFragmentType, Ogre::SceneQuery::WorldFragmentType)
%template(WorldFragmentSet) std::set<Ogre::SceneQuery::WorldFragmentType>;


//for WFragment aka SceneQuery::WorldFragment
SWIG_STD_LIST_SPECIALIZE_MINIMUM(Plane, Ogre::Plane)
%template(ListPlane) std::list<Ogre::Plane>;

//    typedef std::vector<RaySceneQueryResultEntry> RaySceneQueryResult;
SWIG_STD_VECTOR_SPECIALIZE_MINIMUM(RaySceneQueryResultEntry, Ogre::RaySceneQueryResultEntry)
%template(RaySceneQueryResult) std::vector<Ogre::RaySceneQueryResultEntry>;



PTR_REF_TYPEMAPS(MovableObject, Ogre::MovableObject*)


//    typedef std::list<MovableObject*> SceneQueryResultMovableList;
SWIG_STD_LIST_SPECIALIZE(MovableObject, Ogre::MovableObject*)
%template(ListSceneQueryResultMovable) std::list<Ogre::MovableObject*>;



//    typedef std::pair<MovableObject*, MovableObject*> SceneQueryMovableObjectPair;
//    typedef std::list<SceneQueryMovableObjectPair> SceneQueryMovableIntersectionList;
%template(PairMovableObject) std::pair<Ogre::MovableObject*, Ogre::MovableObject*>;

SWIG_STD_LIST_SPECIALIZE_MINIMUM(PairMovableObject, Ogre::SceneQueryMovableObjectPair)
%template(ListSceneQueryMovableIntersection) std::list<Ogre::SceneQueryMovableObjectPair>;

