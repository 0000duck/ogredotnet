//SimpleRenderableDirector.h
//
#ifndef _SimpleRenderableDirector_H_
#define _SimpleRenderableDirector_H_

namespace Ogre
{
    //not virtual typedef void        (SWIGSTDCALL *SRD_FP_setMaterial)            (const String&);
    typedef const MaterialPtr&        (SWIGSTDCALL *SRD_FP_getMaterial)            (void);
    //not virtual typedef void         (SWIGSTDCALL *SRD_FP_setWorldTransform)        (const Matrix4&);
    typedef void                     (SWIGSTDCALL *SRD_FP_getWorldTransforms)    (Matrix4*);
    typedef const Quaternion&         (SWIGSTDCALL *SRD_FP_getWorldOrientation)    (void);
    typedef const Vector3&             (SWIGSTDCALL *SRD_FP_getWorldPosition)        (void);
    typedef void                     (SWIGSTDCALL *SRD_FP_notifyCurrentCamera)    (Camera*);
    //not virtual typedef void         (SWIGSTDCALL *SRD_FP_setBoundingBox)        (const AxisAlignedBox&);
    typedef const AxisAlignedBox&    (SWIGSTDCALL *SRD_FP_getBoundingBox)        (void);
    typedef void                     (SWIGSTDCALL *SRD_FP_updateRenderQueue)        (RenderQueue*);
    typedef const String&             (SWIGSTDCALL *SRD_FP_getName)                (void);
    typedef const String&             (SWIGSTDCALL *SRD_FP_getMovableType)        (void);
    typedef const LightList&         (SWIGSTDCALL *SRD_FP_getLights)                (void);

    //from Renderable
    typedef Real                    (SWIGSTDCALL *SRD_FP_getSquaredViewDepth)    (const Camera*);

    //from MovableObject
    typedef Real                    (SWIGSTDCALL *SRD_FP_getBoundingRadius)        (void);

    class SimpleRenderableDirector : public Ogre::SimpleRenderable
    {
    public:
        //SRD_FP_setMaterial            mFP_setMaterial;
        SRD_FP_getMaterial                mFP_getMaterial;
        //SRD_FP_setWorldTransform        mFP_setWorldTransform;
        SRD_FP_getWorldTransforms        mFP_getWorldTransforms;
        SRD_FP_getWorldOrientation        mFP_getWorldOrientation;
        SRD_FP_getWorldPosition            mFP_getWorldPosition;
        SRD_FP_notifyCurrentCamera        mFP_notifyCurrentCamera;
        //SRD_FP_setBoundingBox            mFP_setBoundingBox;
        SRD_FP_getBoundingBox            mFP_getBoundingBox;
        SRD_FP_updateRenderQueue        mFP_updateRenderQueue;
        SRD_FP_getName                    mFP_getName;
        SRD_FP_getMovableType            mFP_getMovableType;
        SRD_FP_getLights                mFP_getLights;

        SRD_FP_getSquaredViewDepth        mFP_getSquaredViewDepth;
        SRD_FP_getBoundingRadius        mFP_getBoundingRadius;

        SimpleRenderableDirector()
        {
            //mFP_setMaterial = 0;
            mFP_getMaterial = 0;
            //mFP_setWorldTransform = 0;
            mFP_getWorldTransforms = 0;
            mFP_getWorldOrientation = 0;
            mFP_getWorldPosition = 0;
            mFP_notifyCurrentCamera = 0;
            //mFP_setBoundingBox = 0;
            mFP_getBoundingBox = 0;
            mFP_updateRenderQueue = 0;
            mFP_getName = 0;
            mFP_getMovableType = 0;
            mFP_getLights = 0;

            mFP_getSquaredViewDepth=0;
            mFP_getBoundingRadius=0;
        }

        //########## RenderOperation access
        //because RenderOperation is not visible use these to access its fields
        const Renderable * GetRO_Renderable()
        {
            return mRenderOp.srcRenderable;
        }

        IndexData * GetRO_IndexData()
        {
            return mRenderOp.indexData;
        }
        void SetRO_IndexData(IndexData * v)
        {
            mRenderOp.indexData = v;
        }

        bool GetRO_UseIndexes()
        {
            return mRenderOp.useIndexes;
        }
        void SetRO_UseIndexes(bool v)
        {
            mRenderOp.useIndexes = v;
        }

        int GetRO_OperationType()
        {
            return (int)mRenderOp.operationType;
        }
        void SetRO_OperationType(int v)
        {
            mRenderOp.operationType = (RenderOperation::OperationType)v;
        }

        VertexData * GetRO_VertexData()
        {
            return mRenderOp.vertexData;
        }
        void SetRO_VertexData(VertexData * v)
        {
            mRenderOp.vertexData = v;
        }
        //########## RenderOperation access

        //##########  overrides for ODN delegates
        virtual const MaterialPtr& getMaterial(void) const
        {
            if(mFP_getMaterial)
                return mFP_getMaterial();
            else
                return SimpleRenderable::getMaterial();
        }

        virtual void getWorldTransforms(Matrix4* xform) const
        {
            if(mFP_getWorldTransforms)
                mFP_getWorldTransforms(xform);
            else
                SimpleRenderable::getWorldTransforms(xform);
        }

        virtual const Quaternion& getWorldOrientation(void) const
        {
            if(mFP_getWorldOrientation)
                return mFP_getWorldOrientation();
            else
                return SimpleRenderable::getWorldOrientation();
        }

        virtual const Vector3& getWorldPosition(void) const
        {
            if(mFP_getWorldPosition)
                return mFP_getWorldPosition();
            else
                return SimpleRenderable::getWorldPosition();
        }

        virtual void _notifyCurrentCamera(Camera* cam)
        {
            if(mFP_notifyCurrentCamera)
                mFP_notifyCurrentCamera(cam);
            else
                SimpleRenderable::_notifyCurrentCamera(cam);
        }

        virtual const AxisAlignedBox& getBoundingBox(void) const
        {
            if(mFP_getBoundingBox)
                return mFP_getBoundingBox();
            else
                return SimpleRenderable::getBoundingBox();
        }

        virtual void _updateRenderQueue(RenderQueue* queue)
        {
            if(mFP_updateRenderQueue)
                mFP_updateRenderQueue(queue);
            else
                SimpleRenderable::_updateRenderQueue(queue);
        }

        virtual const String& getName(void) const
        {
            if(mFP_getName)
                return mFP_getName();
            else
                return SimpleRenderable::getName();
        }

        virtual const String& getMovableType(void) const
        {
            if(mFP_getMovableType)
                return mFP_getMovableType();
            else
                return SimpleRenderable::getMovableType();
        }

        virtual const LightList& getLights(void) const
        {
            if(mFP_getLights)
                return mFP_getLights();
            else
                return SimpleRenderable::getLights();
        }

        virtual Real getSquaredViewDepth(const Camera* cam) const
        {
            if(mFP_getSquaredViewDepth)
                return mFP_getSquaredViewDepth(cam);
            else
                return 0.0f;  //abstract function so just return 0
        }

        virtual Real getBoundingRadius(void) const
        {
            if(mFP_getBoundingRadius)
                return mFP_getBoundingRadius();
            else
                return 0.0f;  //abstract function so just return 0
        }
        //########## 

        //########## basecall for ODN delegates
        //because calling base.xxx will just bounce back to the delegate use these to call the base class
        const MaterialPtr& CallBase_getMaterial(void) const
        {
            return SimpleRenderable::getMaterial();
        }

        void CallBase_getWorldTransforms(Matrix4* xform) const
        {
            SimpleRenderable::getWorldTransforms(xform);
        }

        const Quaternion& CallBase_getWorldOrientation(void) const
        {
            return SimpleRenderable::getWorldOrientation();
        }

        const Vector3& CallBase_getWorldPosition(void) const
        {
            return SimpleRenderable::getWorldPosition();
        }

        void CallBase_notifyCurrentCamera(Camera* cam)
        {
            SimpleRenderable::_notifyCurrentCamera(cam);
        }

        const AxisAlignedBox& CallBase_getBoundingBox(void) const
        {
            return SimpleRenderable::getBoundingBox();
        }

        void CallBase_updateRenderQueue(RenderQueue* queue)
        {
            SimpleRenderable::_updateRenderQueue(queue);
        }

        const String& CallBase_getName(void) const
        {
            return SimpleRenderable::getName();
        }

        const String& CallBase_getMovableType(void) const
        {
            return SimpleRenderable::getMovableType();
        }

        const LightList& CallBase_getLights(void) const
        {
            return SimpleRenderable::getLights();
        }
        //########## 
    };
}

//extern "C" SWIGEXPORT void set_SRD_FP_setMaterial
//extern "C" SWIGEXPORT void set_SRD_FP_setWorldTransform
//extern "C" SWIGEXPORT void set_SRD_FP_setBoundingBox

extern "C" SWIGEXPORT void set_SRD_FP_getMaterial(void * srd, void * _fn)
{
    ((Ogre::SimpleRenderableDirector*)srd)->mFP_getMaterial = (SRD_FP_getMaterial)_fn;
}

extern "C" SWIGEXPORT void set_SRD_FP_getWorldTransforms(void * srd, void * _fn)
{
    ((Ogre::SimpleRenderableDirector*)srd)->mFP_getWorldTransforms = (SRD_FP_getWorldTransforms)_fn;
}

extern "C" SWIGEXPORT void set_SRD_FP_getWorldOrientation(void * srd, void * _fn)
{
    ((Ogre::SimpleRenderableDirector*)srd)->mFP_getWorldOrientation = (SRD_FP_getWorldOrientation)_fn;
}

extern "C" SWIGEXPORT void set_SRD_FP_getWorldPosition(void * srd, void * _fn)
{
    ((Ogre::SimpleRenderableDirector*)srd)->mFP_getWorldPosition = (SRD_FP_getWorldPosition)_fn;
}

extern "C" SWIGEXPORT void set_SRD_FP_notifyCurrentCamera(void * srd, void * _fn)
{
    ((Ogre::SimpleRenderableDirector*)srd)->mFP_notifyCurrentCamera = (SRD_FP_notifyCurrentCamera)_fn;
}

extern "C" SWIGEXPORT void set_SRD_FP_getBoundingBox(void * srd, void * _fn)
{
    ((Ogre::SimpleRenderableDirector*)srd)->mFP_getBoundingBox = (SRD_FP_getBoundingBox)_fn;
}

extern "C" SWIGEXPORT void set_SRD_FP_updateRenderQueue(void * srd, void * _fn)
{
    ((Ogre::SimpleRenderableDirector*)srd)->mFP_updateRenderQueue = (SRD_FP_updateRenderQueue)_fn;
}

extern "C" SWIGEXPORT void set_SRD_FP_getName(void * srd, void * _fn)
{
    ((Ogre::SimpleRenderableDirector*)srd)->mFP_getName = (SRD_FP_getName)_fn;
}

extern "C" SWIGEXPORT void set_SRD_FP_getMovableType(void * srd, void * _fn)
{
    ((Ogre::SimpleRenderableDirector*)srd)->mFP_getMovableType = (SRD_FP_getMovableType)_fn;
}

extern "C" SWIGEXPORT void set_SRD_FP_getLights(void * srd, void * _fn)
{
    ((Ogre::SimpleRenderableDirector*)srd)->mFP_getLights = (SRD_FP_getLights)_fn;
}

extern "C" SWIGEXPORT void set_SRD_FP_getSquaredViewDepth(void * srd, void * _fn)
{
    ((Ogre::SimpleRenderableDirector*)srd)->mFP_getSquaredViewDepth = (SRD_FP_getSquaredViewDepth)_fn;
}

extern "C" SWIGEXPORT void set_SRD_FP_getBoundingRadius(void * srd, void * _fn)
{
    ((Ogre::SimpleRenderableDirector*)srd)->mFP_getBoundingRadius = (SRD_FP_getBoundingRadius)_fn;
}

#endif //_SimpleRenderableDirector_H_
