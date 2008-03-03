//NodeExt.h
#ifndef __NodeExt_H_
#define __NodeExt_H_

namespace Ogre
{
    class ChildNodeIteratorWrap 
    {
    protected:
        Node::ChildNodeIterator *mObj;
    public:
        ChildNodeIteratorWrap() { mObj=0; }
        ChildNodeIteratorWrap(Ogre::Node::ChildNodeIterator *i)
        { mObj = i; }
        
        std::string peekNextKey(void)   { return mObj->peekNextKey(); }
        Ogre::Node * peekNextValue(void)   { return mObj->peekNextValue(); }
        Ogre::Node * getNext(void)    { return mObj->getNext(); }
        
        bool hasMoreElements(void) const    { return mObj->hasMoreElements(); }
        void moveNext(void) const    { mObj->moveNext(); }

        Ogre::Node * next()
        {
            if (mObj->hasMoreElements())
                return mObj->getNext();
            else
                throw new Ogre::Exception(500, "StopIteration" , __FILE__);
        }
    };

    typedef const void (SWIGSTDCALL *NLD_FunctionPointers) (const Node*);

    class NodeListenerDirector : public Ogre::Node::Listener
    {
    public:
        NLD_FunctionPointers    mFP_nodeUpdated;
        NLD_FunctionPointers    mFP_nodeDestroyed;
        NLD_FunctionPointers    mFP_nodeAttached;
        NLD_FunctionPointers    mFP_nodeDetached;

        NodeListenerDirector()
        {
            mFP_nodeUpdated = 0;
            mFP_nodeDestroyed = 0;
            mFP_nodeAttached = 0;
            mFP_nodeDetached = 0;
        }
        virtual ~NodeListenerDirector() {}
        /** Called when a node gets updated.
        @remarks
            Note that this happens when the node's derived update happens,
            not every time a method altering it's state occurs. There may 
            be several state-changing calls but only one of these calls, 
            when the node graph is fully updated.
        */
        virtual void nodeUpdated(const Node* node)
        {
            if (mFP_nodeUpdated)
                mFP_nodeUpdated(node);
        }
        /** Node is being destroyed */
        virtual void nodeDestroyed(const Node* node)
        {
            if (mFP_nodeDestroyed)
                mFP_nodeDestroyed(node);
        }
        /** Node has been attached to a parent */
        virtual void nodeAttached(const Node* node)
        {
            if (mFP_nodeAttached)
                mFP_nodeAttached(node);
        }
        /** Node has been detached from a parent */
        virtual void nodeDetached(const Node* node)
        {
            if (mFP_nodeDetached)
                mFP_nodeDetached(node);
        }
    };

}

extern "C" SWIGEXPORT void set_NLD_FP_nodeUpdated(void * nld, void * _fn)
{
    ((Ogre::NodeListenerDirector*)nld)->mFP_nodeUpdated = (NLD_FunctionPointers)_fn;
}
extern "C" SWIGEXPORT void set_NLD_FP_nodeDestroyed(void * nld, void * _fn)
{
    ((Ogre::NodeListenerDirector*)nld)->mFP_nodeDestroyed = (NLD_FunctionPointers)_fn;
}
extern "C" SWIGEXPORT void set_NLD_FP_nodeAttached(void * nld, void * _fn)
{
    ((Ogre::NodeListenerDirector*)nld)->mFP_nodeAttached = (NLD_FunctionPointers)_fn;
}
extern "C" SWIGEXPORT void set_NLD_FP_nodeDetached(void * nld, void * _fn)
{
    ((Ogre::NodeListenerDirector*)nld)->mFP_nodeDetached = (NLD_FunctionPointers)_fn;
}



#endif //__NodeExt_H_
