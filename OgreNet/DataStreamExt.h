//DataStreamExt.h
#ifndef _DataStreamExt__H_
#define _DataStreamExt__H_

namespace Ogre
{
    //    typedef SharedPtr<MemoryDataStream> MemoryDataStreamPtr;
    class MemoryDataStreamSharedPtr
    {
    protected:
        MemoryDataStreamPtr mObj;
    public:
        MemoryDataStreamSharedPtr()        { mObj=MemoryDataStreamPtr(); }
        MemoryDataStreamSharedPtr(MemoryDataStream *p)        { mObj=MemoryDataStreamPtr(p); }
        MemoryDataStreamSharedPtr(MemoryDataStreamSharedPtr *p)        { mObj=p->get_myOBJ(); }
        virtual ~MemoryDataStreamSharedPtr()    { mObj.setNull(); }

        //## these functions Not for swig
        MemoryDataStreamSharedPtr(const Ogre::MemoryDataStreamPtr &other)    { mObj=MemoryDataStreamPtr(other.get()); }
        MemoryDataStreamPtr get_myOBJ() { return mObj; }
        //##

        Ogre::MemoryDataStream* Get()
        {
            return (Ogre::MemoryDataStream*)mObj.get();
        }
        bool IsUnique()
        {
            return mObj.unique();
        }
        unsigned int UseCount()
        {
            return mObj.useCount();
        }
        bool IsNull()
        {
            return mObj.isNull();
        }
        void SetNull()
        {
            return mObj.setNull();
        }
    };

    //   typedef SharedPtr<DataStreamList> DataStreamListPtr;
    class DataStreamListSharedPtr
    {
    protected:
        DataStreamListPtr mObj;
    public:
        DataStreamListSharedPtr()        { mObj=DataStreamListPtr(); }
        DataStreamListSharedPtr(DataStreamList *p)        { mObj=DataStreamListPtr(p); }
        DataStreamListSharedPtr(DataStreamListSharedPtr *p)        { mObj=p->get_myOBJ(); }
        virtual ~DataStreamListSharedPtr()    { mObj.setNull(); }

        //## these functions Not for swig
        DataStreamListSharedPtr(const Ogre::DataStreamListPtr &other)    { mObj=other; }
        DataStreamListPtr get_myOBJ() { return mObj; }
        //##

        Ogre::DataStreamList* Get()
        {
            return (Ogre::DataStreamList*)mObj.get();
        }
        bool IsUnique()
        {
            return mObj.unique();
        }
        unsigned int UseCount()
        {
            return mObj.useCount();
        }
        bool IsNull()
        {
            return mObj.isNull();
        }
        void SetNull()
        {
            return mObj.setNull();
        }
    };
}

#endif //_DataStreamExt__H_
