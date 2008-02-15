%{
#include "OgreStaticGeometry.h"
#include "StaticGeometrySubClassProxies.h"
%}

//Custom wrapped
%ignore Ogre::StaticGeometry::RegionIterator;
%ignore Ogre::StaticGeometry::getRegionIterator;


%nodefault Ogre::SGLODBucketVectorIterator;
%nodefault Ogre::SGMaterialBucketMapIterator;
%nodefault Ogre::SGGeometryBucketVectorIterator;
%nodefault Ogre::SGRegionMapIterator;

//all these proxy class returns need %newobject because they are new objects holding pointers
// wish there were an easer way
%newobject Ogre::SGSubMeshLodGeometryLinkList::getFirst;
%newobject Ogre::SGSubMeshLodGeometryLinkList::getLast;
%newobject Ogre::SGSubMeshLodGeometryLinkList::getByIndex;
%newobject Ogre::SGQueuedSubMesh::getGeometryLodList;
%newobject Ogre::SGQueuedGeometry::getGeometry;
%newobject Ogre::SGLODBucketVectorIterator::peekNext;
%newobject Ogre::SGLODBucketVectorIterator::getNext;
%newobject Ogre::SGLODBucketVectorIterator::next;
%newobject Ogre::SGMaterialBucketMapIterator::peekNextValue;
%newobject Ogre::SGMaterialBucketMapIterator::getNext;
%newobject Ogre::SGMaterialBucketMapIterator::next;
%newobject Ogre::SGGeometryBucketVectorIterator::peekNext;
%newobject Ogre::SGGeometryBucketVectorIterator::getNext;
%newobject Ogre::SGGeometryBucketVectorIterator::next;
%newobject Ogre::SGGeometryBucket::getParent;
%newobject Ogre::SGMaterialBucket::getParent;
%newobject Ogre::SGMaterialBucket::getGeometryIterator;
%newobject Ogre::SGLODBucket::getParent;
%newobject Ogre::SGLODBucket::getMaterialIterator;
%newobject Ogre::SGRegion::getLODIterator;
%newobject Ogre::SGRegionMapIterator::peekNextValue;
%newobject Ogre::SGRegionMapIterator::getNext;
%newobject Ogre::SGRegionMapIterator::next;
%newobject Ogre::StaticGeometry::GetRegionIterator;    //yes even this




%include OgreStaticGeometry.h

namespace Ogre
{
    class SGSubMeshLodGeometryLink;        //a sub struct
    class SGSubMeshLodGeometryLinkList;    //a typedef vector of SubMeshLodGeometryLink
    class SGQueuedSubMesh;                    //a sub struct
    class SGQueuedGeometry;                //a sub struct

    class SGLODBucketVectorIterator;        //a VectorIterator 
    class SGMaterialBucketMapIterator;        //a MapIterator 
    class SGGeometryBucketVectorIterator;    //a VectorIterator 

    class SGGeometryBucket;                //a sub class
    class SGMaterialBucket;                //a sub class
    class SGLODBucket;                        //a sub class
    class SGRegion;                        //a sub class

    class  SGSubMeshLodGeometryLink
    {
    public:
        SGSubMeshLodGeometryLink();
        virtual ~SGSubMeshLodGeometryLink();

        VertexData* getVertexData();
        void setVertexData(VertexData* value);
        IndexData* getIndexData();
        void setIndexData(IndexData* value);
    };


    class  SGSubMeshLodGeometryLinkList
    {
    public:
        SGSubMeshLodGeometryLinkList();
        virtual ~SGSubMeshLodGeometryLinkList();

        size_t size();
        void addItem(SGSubMeshLodGeometryLink *pnewItem);
        SGSubMeshLodGeometryLink *getFirst();
        SGSubMeshLodGeometryLink *getLast();
        SGSubMeshLodGeometryLink *getByIndex(int index);
    };


    //----------------------------------------------------------------
    // custom code to handle StaticGeometry::QueuedSubMesh
    class SGQueuedSubMesh
    {
    public:
        SGQueuedSubMesh();
        virtual ~SGQueuedSubMesh();

        SubMesh* getSubmesh();
        void setSubmesh(SubMesh* value);
        SGSubMeshLodGeometryLinkList* getGeometryLodList();
        void setGeometryLodList(SGSubMeshLodGeometryLinkList* value);
        const String& getMaterialName();
        void setMaterialName(const String& value);
        const Vector3& getPosition();
        void setPosition(const Vector3& value);
        const Quaternion& getOrientation();
        void setOrientation(const Quaternion& value);
        const Vector3& getScale();
        void setScale(const Vector3& value);
        AxisAlignedBox* getWorldBounds();
    };


    /// Structure recording a queued geometry for low level builds
    class SGQueuedGeometry
    {
    public:
        SGQueuedGeometry();
        virtual ~SGQueuedGeometry();

        SGSubMeshLodGeometryLink* getGeometry();
        void setGeometry(SGSubMeshLodGeometryLink* value);
        const Vector3& getPosition();
        void setPosition(const Vector3& value);
        const Quaternion& getOrientation();
        void setOrientation(const Quaternion& value);
        const Vector3& getScale();
        void setScale(const Vector3& value);
    };


    /***
    * a custom VectorIterator proxy for StaticGeometry::Region::LODIterator
    * typedef std::vector<LODBucket*> LODBucketList;
    * typedef VectorIterator<LODBucketList> LODIterator;
    ***/
    class SGLODBucketVectorIterator
    {
    public:
        //SGLODBucketVectorIterator();
        virtual ~SGLODBucketVectorIterator();
        bool hasMoreElements(void) const;
        void moveNext(void);
        SGLODBucket *peekNext(void);
        SGLODBucket *getNext(void);
        SGLODBucket *next();
    };


    /***
    * a custom MapIterator proxy for StaticGeometry::LODBucket::MaterialIterator
    * typedef std::map<String, MaterialBucket*> MaterialBucketMap;
    * typedef MapIterator<MaterialBucketMap> MaterialIterator;
    ***/
    class SGMaterialBucketMapIterator
    {
    public:
        //SGMaterialBucketMapIterator();
        virtual ~SGMaterialBucketMapIterator();
        bool hasMoreElements(void) const;
        void moveNext(void);
        const String& peekNextKey(void);
        SGMaterialBucket* peekNextValue(void);
        SGMaterialBucket* getNext(void);
        SGMaterialBucket* next();
    };


    /***
    * a custom VectorIterator proxy for StaticGeometry::MaterialBucket::GeometryIterator
    * typedef std::vector<GeometryBucket*> GeometryBucketList;
    * typedef VectorIterator<GeometryBucketList> GeometryIterator;
    ***/
    class SGGeometryBucketVectorIterator
    {
    public:
        //SGGeometryBucketVectorIterator();
        virtual ~SGGeometryBucketVectorIterator();
        bool hasMoreElements(void) const;
        void moveNext(void);
        SGGeometryBucket *peekNext(void);
        SGGeometryBucket *getNext(void);
        SGGeometryBucket *next();
    };


    //----------------------------------------------------------------
    // custom code to handle StaticGeometry::GeometryBucket
    class SGGeometryBucket                //StaticGeometry::GeometryBucket is a Renderable
    {
    public:
        SGGeometryBucket(SGMaterialBucket* parent, const String& formatString, const VertexData* vData, const IndexData* iData);
        virtual ~SGGeometryBucket();

        Ogre::Renderable * GetMeAsRenderable();
        SGMaterialBucket* getParent(void);
        const VertexData* getVertexData(void) const;
        const IndexData* getIndexData(void) const;
        const MaterialPtr& getMaterial(void) const;
        Technique* getTechnique(void) const;

        //########## RenderOperation access
        //because RenderOperation is not exported use these to access its fields
        const Renderable * GetRO_Renderable();
        IndexData * GetRO_IndexData();
        void SetRO_IndexData(IndexData * v);
        bool GetRO_UseIndexes();
        void SetRO_UseIndexes(bool v);
        int GetRO_OperationType();
        void SetRO_OperationType(int v);
        VertexData * GetRO_VertexData();
        void SetRO_VertexData(VertexData * v);
        //########## RenderOperation access

        void getWorldTransforms(Matrix4* xform) const;
        const Quaternion& getWorldOrientation(void) const;
        const Vector3& getWorldPosition(void) const;
        Real getSquaredViewDepth(const Camera* cam) const;
        const LightList& getLights(void) const;
        bool getCastsShadows(void) const;
        bool assign(SGQueuedGeometry* qsm);
        void build(bool stencilShadows);
    };


    //        class _OgreExport MaterialBucket
    class SGMaterialBucket
    {
    public:
        SGMaterialBucket(SGLODBucket* parent, const String& materialName);
        virtual ~SGMaterialBucket();

        SGLODBucket* getParent(void);
        const String& getMaterialName(void) const;
        void assign(SGQueuedGeometry* qsm);
        void build(bool stencilShadows);
        void addRenderables(RenderQueue* queue, RenderQueueGroupID group, Real camSquaredDist);
        const MaterialPtr& getMaterial(void) const;
        SGGeometryBucketVectorIterator* getGeometryIterator(void);
        Technique* getCurrentTechnique(void) const;
    };


    //        class _OgreExport LODBucket
    class SGLODBucket
    {
    public:
        SGLODBucket(SGRegion* parent, unsigned short lod, Real lodDist);
        virtual ~SGLODBucket();

        SGRegion* getParent(void);
        
        SGMaterialBucketMapIterator* getMaterialIterator(void);
        unsigned short getLod(void) const;
        Real getSquaredDistance(void) const;
        void assign(SGQueuedSubMesh* qsm, unsigned short atLod);
        void build(bool stencilShadows);
        void addRenderables(RenderQueue* queue, RenderQueueGroupID group, Real camSquaredDistance);
    };


    //----------------------------------------------------------------
    // custom code to handle StaticGeometry::Region
    class SGRegion                    //StaticGeometry::Region is a MovableObject
    {
    public:
        SGRegion(StaticGeometry* parent, const String& name, SceneManager* mgr, uint32 regionID, const Vector3& centre);
        virtual ~SGRegion();
        
        Ogre::MovableObject * GetMeAsMovableObject();
        
        StaticGeometry* getParent(void) const;
        void assign(SGQueuedSubMesh* qmesh);
        void build(bool stencilShadows);
        uint32 getID(void) const;
        const Vector3& getCentre(void) const;
        const String& getName(void) const;
        const String& getMovableType(void) const;
        void _notifyCurrentCamera(Camera* cam);
        const AxisAlignedBox& getBoundingBox(void) const;
        Real getBoundingRadius(void) const;
        void _updateRenderQueue(RenderQueue* queue);
        bool isVisible(void) const;
        SGLODBucketVectorIterator * getLODIterator(void);
        const LightList& getLights(void) const;

        Ogre::ShadowCaster::ShadowRenderableListIterator getShadowVolumeRenderableIterator(
            ShadowTechnique shadowTechnique, const Light* light, 
            HardwareIndexBufferSharedPtr* indexBuffer, 
            bool extrudeVertices, Real extrusionDistance, unsigned long flags = 0);
    };


    /***
    * a custom MapIterator proxy for StaticGeometry::RegionIterator
    * typedef std::map<uint32, Region*> RegionMap;
    * typedef MapIterator<RegionMap> RegionIterator;
    ***/
    class SGRegionMapIterator
    {
    public:
        //SGRegionMapIterator();
        virtual ~SGRegionMapIterator();
        bool hasMoreElements(void) const;
        void moveNext(void);
        uint32 peekNextKey(void);
        SGRegion* peekNextValue(void);
        SGRegion* getNext(void);
        SGRegion* next();
    };
}


%extend Ogre::StaticGeometry {
    Ogre::SGRegionMapIterator* GetRegionIterator()    {
        Ogre::StaticGeometry::RegionIterator * jresult;
        
        //typedef std::map<uint32, Region*> RegionMap;
        //typedef MapIterator<RegionMap> RegionIterator;
        SwigValueWrapper<Ogre::MapIterator<std::map<Ogre::uint32, Ogre::StaticGeometry::Region * > > > result;

        result = self->getRegionIterator();
        jresult = new Ogre::StaticGeometry::RegionIterator((Ogre::StaticGeometry::RegionIterator &)result); 
        
        return new Ogre::SGRegionMapIterator(jresult);
    }
};


