//MovableObjectExt.h
#ifndef __MovableObjectExt_H_
#define __MovableObjectExt_H_

namespace Ogre
{

    typedef MovableObject*    (SWIGSTDCALL *MOFD_FP_createInstanceImpl)    (const String&, const NameValuePairList*);
    typedef const String&    (SWIGSTDCALL *MOFD_FP_getType)                (void);
    typedef MovableObject*    (SWIGSTDCALL *MOFD_FP_createInstance)        (const String&, SceneManager*, const NameValuePairList*);
    typedef void            (SWIGSTDCALL *MOFD_FP_destroyInstance)        (MovableObject*);
    typedef bool            (SWIGSTDCALL *MOFD_FP_requestTypeFlags)        (void);
    typedef void            (SWIGSTDCALL *MOFD_FP_notifyTypeFlags)        (unsigned long);
    typedef unsigned long    (SWIGSTDCALL *MOFD_FP_getTypeFlags)            (void);


    class MovableObjectFactoryDirector : public MovableObjectFactory 
    {
    public:
        MOFD_FP_createInstanceImpl    mFP_createInstanceImpl;
        MOFD_FP_getType                mFP_getType;
        MOFD_FP_createInstance        mFP_createInstance;
        MOFD_FP_destroyInstance        mFP_destroyInstance;
        MOFD_FP_requestTypeFlags    mFP_requestTypeFlags;
        MOFD_FP_notifyTypeFlags        mFP_notifyTypeFlags;
        MOFD_FP_getTypeFlags        mFP_getTypeFlags;


        MovableObjectFactoryDirector() : MovableObjectFactory()
        {
            mFP_createInstanceImpl = 0;
            mFP_getType = 0;
            mFP_createInstance = 0;
            mFP_destroyInstance = 0;
            mFP_requestTypeFlags = 0;
            mFP_notifyTypeFlags = 0;
            mFP_getTypeFlags = 0;
        }
        virtual ~MovableObjectFactoryDirector()
        {
        }


        /// Type flag, allocated if requested
        unsigned long get_TypeFlag()    {
            return mTypeFlag;
        }
        void set_TypeFlag(unsigned long value)    {
            mTypeFlag = value;
        }

        virtual MovableObject* CreateInstanceImpl(const String& name, const NameValuePairList* vParams = 0)
        {
            return createInstanceImpl(name, vParams);
        }


        //### overrides ###
    protected:
        /// Internal implementation of create method - must be overridden
        virtual MovableObject* createInstanceImpl(const String& name, const NameValuePairList* params = 0)
        {
            if(mFP_createInstanceImpl)
                return mFP_createInstanceImpl(name, params);
            else
                return 0;
        }
    public:
        /// Get the type of the object to be created
        virtual const String& getType(void) const
        {
            if(mFP_getType)
                return mFP_getType();
            else
                return String("");
        }

        /** Create a new instance of the object.
        @param name The name of the new object
        @param manager The SceneManager instance that will be holding the
            instance once created.
        @param params Name/value pair list of additional parameters required to 
            construct the object (defined per subtype). Optional.
        */
        virtual MovableObject* createInstance(const String& name, SceneManager* manager, const NameValuePairList* params = 0)
        {
            if(mFP_createInstance)
                return mFP_createInstance(name, manager, params);
            else
                return 0;
        }
        /** Destroy an instance of the object */
        virtual void destroyInstance(MovableObject* obj)
        {
            if(mFP_destroyInstance)
                mFP_destroyInstance(obj);
        }

        /** Does this factory require the allocation of a 'type flag', used to 
            selectively include / exclude this type from scene queries?
        @remarks
            The default implementation here is to return 'false', ie not to 
            request a unique type mask from Root. For objects that
            never need to be excluded in SceneQuery results, that's fine, since
            the default implementation of MovableObject::getTypeFlags is to return
            all ones, hence matching any query type mask. However, if you want the
            objects created by this factory to be filterable by queries using a 
            broad type, you have to give them a (preferably unique) type mask - 
            and given that you don't know what other MovableObject types are 
            registered, Root will allocate you one. 
        */
        virtual bool requestTypeFlags(void) const
        {
            if(mFP_requestTypeFlags)
                return mFP_requestTypeFlags();
            else
                return false;
        }
        /** Notify this factory of the type mask to apply. 
        @remarks
            This should normally only be called by Root in response to
            a 'true' result from requestTypeMask. However, you can actually use
            it yourself if you're careful; for example to assign the same mask
            to a number of different types of object, should you always wish them
            to be treated the same in queries.
        */
        void _notifyTypeFlags(unsigned long flag)
        {
            if(mFP_notifyTypeFlags)
                mFP_notifyTypeFlags(flag);
            else
                mTypeFlag = flag;
        }

        /** Gets the type flag for this factory.
        @remarks
            A type flag is like a query flag, except that it applies to all instances
            of a certain type of object.
        */
        unsigned long getTypeFlags(void) const
        {
            if(mFP_getTypeFlags)
                return mFP_getTypeFlags();
            else
                return mTypeFlag;
        }

    };
}

extern "C" SWIGEXPORT void set_MOFD_FP_createInstanceImpl(void * _obj, void * _fn)
{
    ((Ogre::MovableObjectFactoryDirector*)_obj)->mFP_createInstanceImpl = (MOFD_FP_createInstanceImpl)_fn;
}
extern "C" SWIGEXPORT void set_MOFD_FP_getType(void * _obj, void * _fn)
{
    ((Ogre::MovableObjectFactoryDirector*)_obj)->mFP_getType = (MOFD_FP_getType)_fn;
}
extern "C" SWIGEXPORT void set_MOFD_FP_createInstance(void * _obj, void * _fn)
{
    ((Ogre::MovableObjectFactoryDirector*)_obj)->mFP_createInstance = (MOFD_FP_createInstance)_fn;
}
extern "C" SWIGEXPORT void set_MOFD_FP_destroyInstance(void * _obj, void * _fn)
{
    ((Ogre::MovableObjectFactoryDirector*)_obj)->mFP_destroyInstance = (MOFD_FP_destroyInstance)_fn;
}
extern "C" SWIGEXPORT void set_MOFD_FP_requestTypeFlags(void * _obj, void * _fn)
{
    ((Ogre::MovableObjectFactoryDirector*)_obj)->mFP_requestTypeFlags = (MOFD_FP_requestTypeFlags)_fn;
}
extern "C" SWIGEXPORT void set_MOFD_FP_notifyTypeFlags(void * _obj, void * _fn)
{
    ((Ogre::MovableObjectFactoryDirector*)_obj)->mFP_notifyTypeFlags = (MOFD_FP_notifyTypeFlags)_fn;
}
extern "C" SWIGEXPORT void set_MOFD_FP_getTypeFlags(void * _obj, void * _fn)
{
    ((Ogre::MovableObjectFactoryDirector*)_obj)->mFP_getTypeFlags = (MOFD_FP_getTypeFlags)_fn;
}



#endif //__MovableObjectExt_H_
