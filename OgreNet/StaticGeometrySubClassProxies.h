//StaticGeometrySubClassProxies.h
#ifndef _StaticGeometrySubClassProxies__H_
#define _StaticGeometrySubClassProxies__H_

namespace Ogre
{
	//every thing below are  classes for sub things to Ogre::StaticGeometry
	// swig does not pickup sub classes or structs. So we need custom  classes

	class SGSubMeshLodGeometryLink;		//a sub struct
	class SGSubMeshLodGeometryLinkList;	//a typedef vector of SubMeshLodGeometryLink
	class SGQueuedSubMesh;					//a sub struct
	class SGQueuedGeometry;				//a sub struct

	class SGLODBucketVectorIterator;		//a VectorIterator 
	class SGMaterialBucketMapIterator;		//a MapIterator 
	class SGGeometryBucketVectorIterator;	//a VectorIterator 

	class SGGeometryBucket;				//a sub class
	class SGMaterialBucket;				//a sub class
	class SGLODBucket;						//a sub class
	class SGRegion;						//a sub class



	class  SGSubMeshLodGeometryLink
	{
	protected:
		StaticGeometry::SubMeshLodGeometryLink *myOBJ;
		bool mICreated;
		bool mShouldRelease;
	public:
		SGSubMeshLodGeometryLink()		{ 
			myOBJ = new StaticGeometry::SubMeshLodGeometryLink();
			mICreated=true;
			mShouldRelease=true;
		}
		SGSubMeshLodGeometryLink(StaticGeometry::SubMeshLodGeometryLink *p)		{
			myOBJ=p;
			mICreated=false;
			mShouldRelease=false;
		}
		virtual ~SGSubMeshLodGeometryLink()	{
			if ( (mICreated) && (mShouldRelease) )
				delete myOBJ;
		}

		//## these functions Not for swig
		StaticGeometry::SubMeshLodGeometryLink * get_myOBJ()	{	return myOBJ; }
		bool getICreated() { return mICreated; }
		bool getShouldRelease() { return mShouldRelease; }
		void setShouldRelease(bool value) { mShouldRelease = value; }
		//##

		VertexData* getVertexData()
		{ if (myOBJ!=0) return myOBJ->vertexData; else return 0; }
		void setVertexData(VertexData* value)
		{ if (myOBJ!=0) myOBJ->vertexData = value; }

		IndexData* getIndexData()
		{ if (myOBJ!=0) return myOBJ->indexData; else return 0; }
		void setIndexData(IndexData* value)
		{ if (myOBJ!=0) myOBJ->indexData = value; }

	};




	//typedef std::vector<SubMeshLodGeometryLink> SubMeshLodGeometryLinkList;
	class  SGSubMeshLodGeometryLinkList
	{
	protected:
		typedef std::vector<StaticGeometry::SubMeshLodGeometryLink> tVECTOR;
		tVECTOR  *myOBJ;
		bool mICreated;
		bool mShouldRelease;
	public:
		SGSubMeshLodGeometryLinkList()		{ 
			myOBJ= new std::vector<StaticGeometry::SubMeshLodGeometryLink>;
			mICreated=true;
			mShouldRelease=true;
		}
		SGSubMeshLodGeometryLinkList(std::vector<StaticGeometry::SubMeshLodGeometryLink> *p)		{
			myOBJ=p;
			mICreated=false;
			mShouldRelease=false;
		}
		virtual ~SGSubMeshLodGeometryLinkList()	{
			if ( (mICreated) && (mShouldRelease) )
				delete myOBJ;
		}
		//## these functions Not for swig
		std::vector<StaticGeometry::SubMeshLodGeometryLink> * get_myOBJ()	{ return myOBJ; }
		bool getICreated() { return mICreated; }
		bool getShouldRelease() { return mShouldRelease; }
		void setShouldRelease(bool value) { mShouldRelease = value; }
		//##

		size_t size()
		{	if (myOBJ==0)	return 0;
			return myOBJ->size();
		}
		void addItem(SGSubMeshLodGeometryLink *pnewItem)
		{	if (myOBJ==0) return;
			// a vector of non ptr types creates a new copy of the object
			myOBJ->push_back( *pnewItem->get_myOBJ() );
		}
		SGSubMeshLodGeometryLink *getFirst()
		{	if (myOBJ==0)	return 0;
			tVECTOR::iterator it =myOBJ->begin();
			if (it == myOBJ->end())		return 0;
			else						return new SGSubMeshLodGeometryLink( (StaticGeometry::SubMeshLodGeometryLink*)&(*it) );
		}
		SGSubMeshLodGeometryLink *getLast()
		{	if (myOBJ==0)	return 0;
			tVECTOR::reverse_iterator rit =myOBJ->rbegin();
			if (rit == myOBJ->rend())	return 0;
			else						return new SGSubMeshLodGeometryLink( (StaticGeometry::SubMeshLodGeometryLink*)&(*rit) );
		}
		SGSubMeshLodGeometryLink *getByIndex(int index)
		{	if (myOBJ==0)	return 0;
			tVECTOR::iterator it =myOBJ->begin();
			if (it == myOBJ->end())		return 0;
			std::advance(it, index);
			if (it == myOBJ->end())		return 0;
			else						return new SGSubMeshLodGeometryLink( (StaticGeometry::SubMeshLodGeometryLink*)&(*it) );
		}
	};
	//typedef std::map<SubMesh*, SubMeshLodGeometryLinkList*> SubMeshGeometryLookup;




	//----------------------------------------------------------------
	// custom code to handle StaticGeometry::QueuedSubMesh
	class  SGQueuedSubMesh
	{
	protected:
		StaticGeometry::QueuedSubMesh *myOBJ;
		bool mICreated;
		bool mShouldRelease;
	public:
		SGQueuedSubMesh()	{
			myOBJ = new StaticGeometry::QueuedSubMesh();
			mICreated=true;
			mShouldRelease = true;
		}
		SGQueuedSubMesh(StaticGeometry::QueuedSubMesh *p)	{
			myOBJ=p;
			mICreated=false;
			mShouldRelease = false;
		}
		virtual ~SGQueuedSubMesh()	{
			if ( (mICreated) && (mShouldRelease) )
				delete myOBJ;
		}
		//## these functions Not for swig
		StaticGeometry::QueuedSubMesh * get_myOBJ()	{	return myOBJ; }
		bool getICreated() { return mICreated; }
		bool getShouldRelease() { return mShouldRelease; }
		void setShouldRelease(bool value) { mShouldRelease = value; }
		//##

		SubMesh* getSubmesh()
		{ if (myOBJ!=0) return myOBJ->submesh; else return 0; }
		void setSubmesh(SubMesh* value)
		{ if (myOBJ!=0) myOBJ->submesh = value; }

		SGSubMeshLodGeometryLinkList* getGeometryLodList()
		{	if (myOBJ!=0) return new SGSubMeshLodGeometryLinkList(myOBJ->geometryLodList );
			else return 0;	}
		void setGeometryLodList(SGSubMeshLodGeometryLinkList* value)
		{
			if (myOBJ==0) return;
			if (value->getICreated())
				value->setShouldRelease(false);
			myOBJ->geometryLodList = value->get_myOBJ();
		}

		const String& getMaterialName()
		{ if (myOBJ!=0) return myOBJ->materialName; else return ""; }
		void setMaterialName(const String& value)
		{ if (myOBJ!=0) myOBJ->materialName = value; }

		const Vector3& getPosition()
		{ if (myOBJ!=0) return myOBJ->position; else return Vector3::ZERO; }
		void setPosition(const Vector3& value)
		{ if (myOBJ!=0) myOBJ->position = value; }

		const Quaternion& getOrientation()
		{ if (myOBJ!=0) return myOBJ->orientation; else return Quaternion::IDENTITY; }
		void setOrientation(const Quaternion& value)
		{ if (myOBJ!=0) myOBJ->orientation = value; }

		const Vector3& getScale()
		{ if (myOBJ!=0) return myOBJ->scale; else return Vector3::ZERO; }
		void setScale(const Vector3& value)
		{ if (myOBJ!=0) myOBJ->scale = value; }

		AxisAlignedBox* getWorldBounds()
		{ if (myOBJ!=0) return &myOBJ->worldBounds; else return 0; }
	};
	//typedef std::vector<QueuedSubMesh*> QueuedSubMeshList;




	/// Structure recording a queued geometry for low level builds
	class  SGQueuedGeometry
	{
	protected:
		StaticGeometry::QueuedGeometry *myOBJ;
		bool mICreated;
		bool mShouldRelease;
	public:
		SGQueuedGeometry()	{
			myOBJ = new StaticGeometry::QueuedGeometry();
			mICreated=true;
			mShouldRelease = true;
		}
		SGQueuedGeometry(StaticGeometry::QueuedGeometry *p)	{
			myOBJ=p;
			mICreated=false;
			mShouldRelease = false;
		}
		virtual ~SGQueuedGeometry()	{
			if ( (mICreated) && (mShouldRelease) )
				delete myOBJ;
		}
		//## these functions Not for swig
		StaticGeometry::QueuedGeometry * get_myOBJ()	{	return myOBJ; }
		bool getICreated() { return mICreated; }
		bool getShouldRelease() { return mShouldRelease; }
		void setShouldRelease(bool value) { mShouldRelease = value; }
		//##

		SGSubMeshLodGeometryLink* getGeometry()
		{	if (myOBJ!=0) return new SGSubMeshLodGeometryLink(myOBJ->geometry );
			else return 0;	}
		void setGeometry(SGSubMeshLodGeometryLink* value)
		{ if (myOBJ!=0) myOBJ->geometry = value->get_myOBJ(); }

		const Vector3& getPosition()
		{ if (myOBJ!=0) return myOBJ->position; else return Vector3::ZERO; }
		void setPosition(const Vector3& value)
		{ if (myOBJ!=0) myOBJ->position = value; }

		const Quaternion& getOrientation()
		{ if (myOBJ!=0) return myOBJ->orientation; else return Quaternion::IDENTITY; }
		void setOrientation(const Quaternion& value)
		{ if (myOBJ!=0) myOBJ->orientation = value; }

		const Vector3& getScale()
		{ if (myOBJ!=0) return myOBJ->scale; else return Vector3::ZERO; }
		void setScale(const Vector3& value)
		{ if (myOBJ!=0) myOBJ->scale = value; }

	};
	//typedef std::vector<QueuedGeometry*> QueuedGeometryList;




	//----------------------------------------------------------------
	// custom code to handle StaticGeometry::GeometryBucket
	class  SGGeometryBucket	//StaticGeometry::GeometryBucket is a Renderable
	{
	protected:
		StaticGeometry::GeometryBucket *myOBJ;
		bool mICreated;
		bool mShouldRelease;
	public:
		SGGeometryBucket(SGMaterialBucket* parent, const String& formatString, const VertexData* vData, const IndexData* iData);
		SGGeometryBucket(StaticGeometry::GeometryBucket *p)		{
			myOBJ=p;
			mICreated=false;
			mShouldRelease=false;
		}
		virtual ~SGGeometryBucket()		{
			if ( (mICreated) && (mShouldRelease) )
				delete myOBJ;
		}

		//## these functions Not for swig
		StaticGeometry::GeometryBucket * get_myOBJ()		{ return myOBJ; }
		bool getICreated()							{ return mICreated; }
		bool getShouldRelease()						{ return mShouldRelease; }
		void setShouldRelease(bool value)			{ mShouldRelease = value; }
		//##

		Ogre::Renderable * GetMeAsRenderable()		{
			return (Ogre::Renderable *)myOBJ;
		}
		SGMaterialBucket* getParent(void);

		const VertexData* getVertexData(void) const			{
			if (myOBJ==0) return 0;
			return myOBJ->getVertexData();
		}
		const IndexData* getIndexData(void) const			{ 
			if (myOBJ==0) return 0;
			return myOBJ->getIndexData();
		}
		const MaterialPtr& getMaterial(void) const			{ 
			//if (myOBJ==0) return 0;
			return myOBJ->getMaterial();
		}
		Technique* getTechnique(void) const					{ 
			if (myOBJ==0) return 0;
			return myOBJ->getTechnique();
		}

		//void getRenderOperation(RenderOperation& op)		{ return myOBJ->getParent();		}
		//########## RenderOperation access
		//because RenderOperation is not exported use these to access its fields
		const Renderable * GetRO_Renderable()		{
			RenderOperation op;
			myOBJ->getRenderOperation(op);
			return op.srcRenderable;
		}
		IndexData * GetRO_IndexData()		{
			RenderOperation op;
			myOBJ->getRenderOperation(op);
			return op.indexData;
		}
		void SetRO_IndexData(IndexData * v)		{
			RenderOperation op;
			myOBJ->getRenderOperation(op);
			op.indexData = v;
		}
		bool GetRO_UseIndexes()		{
			RenderOperation op;
			myOBJ->getRenderOperation(op);
			return op.useIndexes;
		}
		void SetRO_UseIndexes(bool v)		{
			RenderOperation op;
			myOBJ->getRenderOperation(op);
			op.useIndexes = v;
		}
		int GetRO_OperationType()		{
			RenderOperation op;
			myOBJ->getRenderOperation(op);
			return (int)op.operationType;
		}
		void SetRO_OperationType(int v)		{
			RenderOperation op;
			myOBJ->getRenderOperation(op);
			op.operationType = (RenderOperation::OperationType)v;
		}
		VertexData * GetRO_VertexData()		{
			RenderOperation op;
			myOBJ->getRenderOperation(op);
			return op.vertexData;
		}
		void SetRO_VertexData(VertexData * v)		{
			RenderOperation op;
			myOBJ->getRenderOperation(op);
			op.vertexData = v;
		}
		//########## RenderOperation access


		void getWorldTransforms(Matrix4* xform) const		{ 
			if (myOBJ==0) return;
			myOBJ->getWorldTransforms(xform);
		}
		const Quaternion& getWorldOrientation(void) const	{ 
			//if (myOBJ==0) return 0;
			return myOBJ->getWorldOrientation();
		}
		const Vector3& getWorldPosition(void) const			{ 
			//if (myOBJ==0) return 0;
			return myOBJ->getWorldPosition();
		}
		Real getSquaredViewDepth(const Camera* cam) const	{ 
			if (myOBJ==0) return 0;
			return myOBJ->getSquaredViewDepth(cam);
		}
		const LightList& getLights(void) const				{ 
			//if (myOBJ==0) return 0;
			return myOBJ->getLights();
		}
		bool getCastsShadows(void) const					{ 
			if (myOBJ==0) return false;
			return myOBJ->getCastsShadows();
		}
		bool assign(SGQueuedGeometry* qsm)
		{
			if (myOBJ==0) return false;
			//this is a vector of Ptr objects, make sure the  does not delete when it is distroied.
			if (qsm->getICreated())
				qsm->setShouldRelease(false);
			return myOBJ->assign( qsm->get_myOBJ() );
		}
		void build(bool stencilShadows)						{ 
			if (myOBJ==0) return;
			myOBJ->build(stencilShadows);
		}
	};




	/***
	* a custom VectorIterator proxy for StaticGeometry::MaterialBucket::GeometryIterator
	* typedef std::vector<GeometryBucket*> GeometryBucketList;
	* typedef VectorIterator<GeometryBucketList> GeometryIterator;
	***/
	class  SGGeometryBucketVectorIterator
	{
	private:
		StaticGeometry::MaterialBucket::GeometryIterator *myOBJ;
	public:
		SGGeometryBucketVectorIterator()	{ myOBJ = 0; }
		SGGeometryBucketVectorIterator(StaticGeometry::MaterialBucket::GeometryIterator *p)	{ myOBJ = p; }
		virtual ~SGGeometryBucketVectorIterator()	{
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
		SGGeometryBucket* peekNext(void)	{
			if (myOBJ==0) return 0;
			return new SGGeometryBucket( (StaticGeometry::GeometryBucket*)myOBJ->peekNext() );
		}
		SGGeometryBucket* getNext(void)		{
			if (myOBJ==0) return 0;
			return new SGGeometryBucket( (StaticGeometry::GeometryBucket*)myOBJ->getNext() );
		}
		SGGeometryBucket* next() {
			if (myOBJ==0) return 0;
			if (myOBJ->hasMoreElements())
				return new SGGeometryBucket( (StaticGeometry::GeometryBucket*)myOBJ->getNext() );
			else
				throw( Ogre::Exception( Exception::ERR_ITEM_NOT_FOUND, "StopIteration at end", "SGGeometryBucketVectorIterator", __FILE__, __LINE__ ) );
		}
	};




	//		class _OgreExport MaterialBucket
	class  SGMaterialBucket
	{
	protected:
		StaticGeometry::MaterialBucket *myOBJ;
		bool mICreated;
		bool mShouldRelease;
	public:
		SGMaterialBucket(SGLODBucket* parent, const String& materialName);
		SGMaterialBucket(StaticGeometry::MaterialBucket *p)		{
			myOBJ=p;
			mICreated=false;
			mShouldRelease=false;
		}
		virtual ~SGMaterialBucket()		{
			if ( (mICreated) && (mShouldRelease) )
				delete myOBJ;
		}

		//## these functions Not for swig
		StaticGeometry::MaterialBucket * get_myOBJ()		{ return myOBJ; }
		bool getICreated()							{ return mICreated; }
		bool getShouldRelease()						{ return mShouldRelease; }
		void setShouldRelease(bool value)			{ mShouldRelease = value; }
		//##

		SGLODBucket* getParent(void);
		const String& getMaterialName(void) const		{
			if (myOBJ==0) return "";
			return myOBJ->getMaterialName();
		}
		void assign(SGQueuedGeometry* qsm)				{
			if (myOBJ==0) return;
			if (qsm->getICreated())
				qsm->setShouldRelease(false);
			return myOBJ->assign(qsm->get_myOBJ());
		}
		void build(bool stencilShadows)					{
			if (myOBJ==0) return;
			myOBJ->build(stencilShadows);
		}
		void addRenderables(RenderQueue* queue, RenderQueueGroupID group, Real camSquaredDist)	{
			if (myOBJ==0) return;
			myOBJ->addRenderables(queue, group, camSquaredDist);
		}
		const MaterialPtr& getMaterial(void) const		{

			return myOBJ->getMaterial();
		}
		
		//typedef std::vector<GeometryBucket*> GeometryBucketList;
		//typedef VectorIterator<GeometryBucketList> GeometryIterator;
		//GeometryIterator getGeometryIterator(void);
		SGGeometryBucketVectorIterator* getGeometryIterator(void)	{
			if (myOBJ==0) return 0;
			Ogre::StaticGeometry::MaterialBucket::GeometryIterator * jresult;
			SwigValueWrapper<Ogre::VectorIterator<std::vector<Ogre::StaticGeometry::GeometryBucket*> > > result;

			result = myOBJ->getGeometryIterator();
			jresult = new Ogre::StaticGeometry::MaterialBucket::GeometryIterator((Ogre::StaticGeometry::MaterialBucket::GeometryIterator &)result); 
			
			return new SGGeometryBucketVectorIterator( jresult );
		}

		Technique* getCurrentTechnique(void) const		{
			if (myOBJ==0) return 0;
			return myOBJ->getCurrentTechnique();
		}
	};




	/***
	* a custom MapIterator proxy for StaticGeometry::LODBucket::MaterialIterator
	* typedef std::map<String, MaterialBucket*> MaterialBucketMap;
	* typedef MapIterator<MaterialBucketMap> MaterialIterator;
	***/
	class  SGMaterialBucketMapIterator
	{
	private:
		StaticGeometry::LODBucket::MaterialIterator *myOBJ;
	public:
		SGMaterialBucketMapIterator()	{ myOBJ = 0; }
		SGMaterialBucketMapIterator(StaticGeometry::LODBucket::MaterialIterator *p)	{ myOBJ = p; }
		virtual ~SGMaterialBucketMapIterator()	{
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
		const String& peekNextKey(void)		{
			if (myOBJ==0) return "";
			return myOBJ->peekNextKey();
		}
		SGMaterialBucket* peekNextValue(void)	{
			if (myOBJ==0) return 0;
			return new SGMaterialBucket( (StaticGeometry::MaterialBucket*)myOBJ->peekNextValue() );
		}
		SGMaterialBucket* getNext(void)			{
			if (myOBJ==0) return 0;
			return new SGMaterialBucket( (StaticGeometry::MaterialBucket*)myOBJ->getNext() );
		}
		SGMaterialBucket* next() {
			if (myOBJ==0) return 0;
			if (myOBJ->hasMoreElements())
				return new SGMaterialBucket( (StaticGeometry::MaterialBucket*)myOBJ->getNext() );
			else
				throw( Ogre::Exception( Exception::ERR_ITEM_NOT_FOUND, "StopIteration at end", "SGMaterialBucketMapIterator", __FILE__, __LINE__ ) );
		}
	};




	//		class _OgreExport LODBucket
	class  SGLODBucket
	{
	protected:
		StaticGeometry::LODBucket *myOBJ;
		bool mICreated;
		bool mShouldRelease;
	public:
		SGLODBucket(SGRegion* parent, unsigned short lod, Real lodDist);
		SGLODBucket(StaticGeometry::LODBucket *p)		{
			myOBJ=p;
			mICreated=false;
			mShouldRelease=false;
		}
		virtual ~SGLODBucket()		{
			if ( (mICreated) && (mShouldRelease) )
				delete myOBJ;
		}

		//## these functions Not for swig
		StaticGeometry::LODBucket * get_myOBJ()		{ return myOBJ; }
		bool getICreated()							{ return mICreated; }
		bool getShouldRelease()						{ return mShouldRelease; }
		void setShouldRelease(bool value)			{ mShouldRelease = value; }
		//##

		SGRegion* getParent(void);
		SGMaterialBucketMapIterator* getMaterialIterator(void);
		unsigned short getLod(void) const						{
			if (myOBJ==0) return 0;
			return myOBJ->getLod();
		}
		Real getSquaredDistance(void) const				{
			if (myOBJ==0) return 0;
			return myOBJ->getSquaredDistance();
		}
		void assign(SGQueuedSubMesh* qsm, unsigned short atLod)		{
			if (myOBJ==0) return;
			if (qsm->getICreated())
				qsm->setShouldRelease(false);
			return myOBJ->assign(qsm->get_myOBJ(), atLod);
		}
		void build(bool stencilShadows)					{
			if (myOBJ==0) return;
			myOBJ->build(stencilShadows);
		}
		void addRenderables(RenderQueue* queue, RenderQueueGroupID group, Real camSquaredDistance)	{
			if (myOBJ==0) return;
			myOBJ->addRenderables(queue, group, camSquaredDistance);
		}
	};



	/***
	* a custom VectorIterator proxy for StaticGeometry::Region::LODIterator
	* typedef std::vector<LODBucket*> LODBucketList;
	* typedef VectorIterator<LODBucketList> LODIterator;
	***/
	class  SGLODBucketVectorIterator
	{
	private:
		StaticGeometry::Region::LODIterator *myOBJ;
	public:
		SGLODBucketVectorIterator()	{ myOBJ = 0; }
		SGLODBucketVectorIterator(StaticGeometry::Region::LODIterator *p)	{ myOBJ = p; }
		virtual ~SGLODBucketVectorIterator()	{
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
		SGLODBucket* peekNext(void)	{
			if (myOBJ==0) return 0;
			return new SGLODBucket( (StaticGeometry::LODBucket*)myOBJ->peekNext() );
		}
		SGLODBucket* getNext(void)		{
			if (myOBJ==0) return 0;
			return new SGLODBucket( (StaticGeometry::LODBucket*)myOBJ->getNext() );
		}
		SGLODBucket* next() {
			if (myOBJ==0) return 0;
			if (myOBJ->hasMoreElements())
				return new SGLODBucket( (StaticGeometry::LODBucket*)myOBJ->getNext() );
			else
				throw( Ogre::Exception( Exception::ERR_ITEM_NOT_FOUND, "StopIteration at end", "SGLODBucketVectorIterator", __FILE__, __LINE__ ) );
		}

	};



	//----------------------------------------------------------------
	// custom code to handle StaticGeometry::Region
	class  SGRegion	//StaticGeometry::Region is a MovableObject
	{
	protected:
		StaticGeometry::Region *myOBJ;
		bool mICreated;
		bool mShouldRelease;
	public:
		SGRegion(StaticGeometry* parent, const String& name, SceneManager* mgr, uint32 regionID, const Vector3& centre)		{
			myOBJ = new StaticGeometry::Region(parent, name, mgr, regionID, centre);
			mICreated=true;
			mShouldRelease=true;
		}
		SGRegion(StaticGeometry::Region *p)		{
			myOBJ=p;
			mICreated=false;
			mShouldRelease=false;
		}
		virtual ~SGRegion()		{
			if ( (mICreated) && (mShouldRelease) )
				delete myOBJ;
		}

		//## these functions Not for swig
		StaticGeometry::Region * get_myOBJ()		{	return myOBJ; }
		bool getICreated()							{ return mICreated; }
		bool getShouldRelease()						{ return mShouldRelease; }
		void setShouldRelease(bool value)			{ mShouldRelease = value; }
		//##

		Ogre::MovableObject * GetMeAsMovableObject()			{	return (Ogre::MovableObject *)myOBJ; }
		// more fields can be added in subclasses
		StaticGeometry* getParent(void) const		{ return myOBJ->getParent(); }
		/// Assign a queued mesh to this region, read for final build
		void assign(SGQueuedSubMesh* qmesh)	{
			//this is a vector of Ptr objects, make sure the  does not delete when it is distroied.
			if (qmesh->getICreated())
				qmesh->setShouldRelease(false);
			return myOBJ->assign(qmesh->get_myOBJ());
		}
		void build(bool stencilShadows)						{	myOBJ->build( stencilShadows );	}
		uint32 getID(void) const							{ return myOBJ->getID(); }
		const Vector3& getCentre(void) const				{ return myOBJ->getCentre(); }
		const String& getName(void) const					{ return myOBJ->getName(); }
		const String& getMovableType(void) const			{ return myOBJ->getMovableType(); }
		void _notifyCurrentCamera(Camera* cam)				{ return myOBJ->_notifyCurrentCamera(cam); }
		const AxisAlignedBox& getBoundingBox(void) const	{ return myOBJ->getBoundingBox(); }
		Real getBoundingRadius(void) const					{ return myOBJ->getBoundingRadius(); }
		void _updateRenderQueue(RenderQueue* queue)			{ return myOBJ->_updateRenderQueue(queue); }
		bool isVisible(void) const							{ return myOBJ->isVisible(); }
		//typedef std::vector<LODBucket*> LODBucketList;
		//typedef VectorIterator<LODBucketList> LODIterator;
		//LODIterator getLODIterator(void);
		SGLODBucketVectorIterator * getLODIterator(void)	{
			if (myOBJ==0) return 0;
			Ogre::StaticGeometry::Region::LODIterator * jresult;
			SwigValueWrapper<Ogre::VectorIterator<std::vector<Ogre::StaticGeometry::LODBucket * > > > result;

			result = myOBJ->getLODIterator();
			jresult = new Ogre::StaticGeometry::Region::LODIterator((Ogre::StaticGeometry::Region::LODIterator &)result); 
			
			return new SGLODBucketVectorIterator( jresult );
		}
		const LightList& getLights(void) const				{ return myOBJ->getLights(); }

		/// @copydoc ShadowCaster::getShadowVolumeRenderableIterator
		//typedef std::vector<ShadowRenderable*> ShadowRenderableList;
		//typedef VectorIterator<ShadowRenderableList> ShadowRenderableListIterator;
		Ogre::ShadowCaster::ShadowRenderableListIterator getShadowVolumeRenderableIterator(
			ShadowTechnique shadowTechnique, const Light* light, 
			HardwareIndexBufferSharedPtr* indexBuffer, 
			bool extrudeVertices, Real extrusionDistance, unsigned long flags = 0 )
		{
			Ogre::ShadowCaster::ShadowRenderableListIterator * jresult;
			SwigValueWrapper<Ogre::VectorIterator<std::vector<Ogre::ShadowRenderable * > > > result;

			result = myOBJ->getShadowVolumeRenderableIterator(shadowTechnique, light, indexBuffer,
				extrudeVertices, extrusionDistance, flags );
			jresult = new Ogre::ShadowCaster::ShadowRenderableListIterator((Ogre::ShadowCaster::ShadowRenderableListIterator &)result); 
			
			return *jresult;
		}
		/// Overridden from MovableObject
		//EdgeData* getEdgeList(void);
	};




	/***
	* a custom MapIterator proxy for StaticGeometry::RegionIterator
	* typedef std::map<uint32, Region*> RegionMap;
	* typedef MapIterator<RegionMap> RegionIterator;
	***/
	class  SGRegionMapIterator
	{
	private:
		StaticGeometry::RegionIterator *myOBJ;
	public:
		SGRegionMapIterator()	{ myOBJ = 0; }
		SGRegionMapIterator(StaticGeometry::RegionIterator *p)	{
			myOBJ = p;
			//std::cout << "--SGRegionMapIterator myOBJ=" << (Ogre::uint32)myOBJ << std::endl;
		}
		virtual ~SGRegionMapIterator()	{
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
		uint32 peekNextKey(void)		{
			if (myOBJ==0) return 0;
			return myOBJ->peekNextKey();
		}
		SGRegion* peekNextValue(void)	{
			if (myOBJ==0) return 0;
			return new SGRegion( (StaticGeometry::Region*)myOBJ->peekNextValue() );
		}
		SGRegion* getNext(void)	{
			if (myOBJ==0) return 0;
			return new SGRegion( (StaticGeometry::Region*)myOBJ->getNext() );
		}
		SGRegion* next() {
			if (myOBJ==0) return 0;
			if (myOBJ->hasMoreElements())
				return new SGRegion( (StaticGeometry::Region*)myOBJ->getNext() );
			else
				throw( Ogre::Exception( Exception::ERR_ITEM_NOT_FOUND, "StopIteration at end", "SGRegionMapIterator", __FILE__, __LINE__ ) );
		}
	};




	//------------------------------------------------------------------
	// ### functions that need their body after the class defintions ###
	SGGeometryBucket::SGGeometryBucket(SGMaterialBucket* parent, const String& formatString, const VertexData* vData, const IndexData* iData)	{
		myOBJ = new StaticGeometry::GeometryBucket(parent->get_myOBJ(), formatString, vData, iData);
		mICreated=true;
		mShouldRelease=true;
	}
	SGMaterialBucket* SGGeometryBucket::getParent(void)				{
		if (myOBJ==0) return 0;
		return new SGMaterialBucket( myOBJ->getParent() );
	}



	SGMaterialBucket::SGMaterialBucket(SGLODBucket* parent, const String& materialName)	{
		myOBJ = new StaticGeometry::MaterialBucket(parent->get_myOBJ(), materialName);
		mICreated=true;
		mShouldRelease=true;
	}
	SGLODBucket* SGMaterialBucket::getParent(void)				{
		if (myOBJ==0) return 0;
		return new SGLODBucket( myOBJ->getParent() );
	}



	SGLODBucket::SGLODBucket(SGRegion* parent, unsigned short lod, Real lodDist)	{
		myOBJ = new StaticGeometry::LODBucket(parent->get_myOBJ(), lod, lodDist);
		mICreated=true;
		mShouldRelease=true;
	}
	SGRegion* SGLODBucket::getParent(void)				{
		if (myOBJ==0) return 0;
		return new SGRegion( myOBJ->getParent() );
	}
	//typedef std::map<String, MaterialBucket*> MaterialBucketMap;
	//typedef MapIterator<MaterialBucketMap> MaterialIterator;
	//MaterialIterator getMaterialIterator(void);
	SGMaterialBucketMapIterator* SGLODBucket::getMaterialIterator(void)	{
		if (myOBJ==0) return 0;
		Ogre::StaticGeometry::LODBucket::MaterialIterator * jresult;
		SwigValueWrapper<Ogre::MapIterator<std::map<Ogre::String, Ogre::StaticGeometry::MaterialBucket*> > > result;

		result = myOBJ->getMaterialIterator();
		jresult = new Ogre::StaticGeometry::LODBucket::MaterialIterator((Ogre::StaticGeometry::LODBucket::MaterialIterator &)result); 
		
		return new SGMaterialBucketMapIterator( jresult );
	}
}

#endif //_StaticGeometrySubClassProxies__H_
