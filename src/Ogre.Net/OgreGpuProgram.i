%{
#include "OgreGpuProgram.h"
#include "GpuProgramExt.h"
%}

%apply double *INPUTARRAY {double *val};
%apply float *INPUTARRAY {float *val};
%apply int *INPUTARRAY {int *val};


// Ignore typemaps may not work here Matrix is already typemapted 
%ignore Ogre::GpuProgramParameters::setConstant(size_t, const Matrix4 *, size_t);
%ignore Ogre::GpuProgramParameters::setNamedConstant(const String& name, const Matrix4* m, size_t numEntries);

//these are custom wrapped,  there is already apply for  xxx *val  
//%ignore Ogre::GpuProgramParameters::setConstant(size_t, const float *, size_t);
//%ignore Ogre::GpuProgramParameters::setConstant(size_t, const double *, size_t);
//%ignore Ogre::GpuProgramParameters::setConstant(size_t, const int *, size_t);
//%ignore Ogre::GpuProgramParameters::setNamedConstant(const String& name, const float *val, size_t count);
//%ignore Ogre::GpuProgramParameters::setNamedConstant(const String& name, const double *val, size_t count);
//%ignore Ogre::GpuProgramParameters::setNamedConstant(const String& name, const int *val, size_t count);




//Custom wrapped subclasses / structs of GpuProgramParameters
%ignore Ogre::GpuProgramParameters::getAutoConstantDefinition;
%ignore Ogre::GpuProgramParameters::RealConstantIterator;
%ignore Ogre::GpuProgramParameters::getRealConstantEntry;
%ignore Ogre::GpuProgramParameters::getNamedRealConstantEntry;
%ignore Ogre::GpuProgramParameters::getPassIterationEntry;
%ignore Ogre::GpuProgramParameters::getRealConstantIterator;
%ignore Ogre::GpuProgramParameters::getIntConstantIterator;
%ignore Ogre::GpuProgramParameters::IntConstantIterator;
%ignore Ogre::GpuProgramParameters::getIntConstantEntry;
%ignore Ogre::GpuProgramParameters::getNamedIntConstantEntry;
%ignore Ogre::GpuProgramParameters::AutoConstantIterator;
%ignore Ogre::GpuProgramParameters::getAutoConstantEntry;
%ignore Ogre::GpuProgramParameters::getAutoConstantIterator;
%ignore Ogre::GpuProgramParameters::getConstantDefinition;
%ignore Ogre::GpuProgramParameters::findMatchingConstantDefinition;


%newobject     Ogre::GpuProgramParameters::GetAutoConstantDefinition;
%newobject     Ogre::GpuProgramParameters::GetAutoConstantDefinition;
%newobject     Ogre::GpuProgramParameters::GetRealConstantEntry;
%newobject     Ogre::GpuProgramParameters::GetNamedRealConstantEntry;
%newobject     Ogre::GpuProgramParameters::GetPassIterationEntry;
%newobject     Ogre::GpuProgramParameters::GetRealConstantIterator;
%newobject     Ogre::GpuProgramParameters::GetIntConstantEntry;
%newobject     Ogre::GpuProgramParameters::GetNamedIntConstantEntry;
%newobject     Ogre::GpuProgramParameters::GetIntConstantIterator;
%newobject     Ogre::GpuProgramParameters::GetAutoConstantEntry;
%newobject     Ogre::GpuProgramParameters::GetAutoConstantIterator;
%newobject     Ogre::GpuProgramParameters::GetConstantDefinition;
%newobject     Ogre::GpuProgramParameters::GetConstantDefinition;
%newobject     Ogre::GpuProgramParameters::FindMatchingConstantDefinition;

%newobject Ogre::GPPRealConstantIterator::peekNext;
%newobject Ogre::GPPRealConstantIterator::getNext;
%newobject Ogre::GPPRealConstantIterator::next;

%newobject Ogre::GPPIntConstantIterator::peekNext;
%newobject Ogre::GPPIntConstantIterator::getNext;
%newobject Ogre::GPPIntConstantIterator::next;

%newobject Ogre::GPPAutoConstantIterator::peekNext;
%newobject Ogre::GPPAutoConstantIterator::getNext;
%newobject Ogre::GPPAutoConstantIterator::next;

%nodefault Ogre::GPPRealConstantIterator;
%nodefault Ogre::GPPIntConstantIterator;
%nodefault Ogre::GPPAutoConstantIterator;
%nodefault Ogre::GPPAutoConstantEntry;

//    typedef SharedPtr<GpuProgramParameters> GpuProgramParametersSharedPtr;
%template(GpuProgramParametersSharedPtr) Ogre::SharedPtr<Ogre::GpuProgramParameters>;


%include OgreGpuProgram.h


namespace Ogre
{
    class GPPAutoConstantDefinition
    {
    public:
        GPPAutoConstantDefinition(const String& _name);
        virtual ~GPPAutoConstantDefinition();

        GpuProgramParameters::AutoConstantType getAcType();
        void setAcType(GpuProgramParameters::AutoConstantType value);
        const String& getName();
        void setName(const String& value);
        size_t getElementCount();
        void setElementCount(size_t value);
        GpuProgramParameters::ElementType getElementType();
        void setElementType(GpuProgramParameters::ElementType value);
        GpuProgramParameters::ACDataType getDataType();
        void setDataType(GpuProgramParameters::ACDataType value);
    };

    class GPPRealConstantEntry
    {
    public:
        GPPRealConstantEntry();
        virtual ~GPPRealConstantEntry();
        float getVal(int index);
        void setVal(int index, float value);
        bool getIsSet();
        void setIsSet(bool value);
    };

    class  GPPRealConstantIterator
    {
    public:
        //GPPRealConstantIterator();
        //virtual ~GPPRealConstantIterator();
        bool hasMoreElements(void) const;
        void moveNext(void);
        GPPRealConstantEntry* peekNext(void);
        GPPRealConstantEntry* getNext(void);
        GPPRealConstantEntry* next();
    };

    class GPPIntConstantEntry
    {
    public:
        GPPIntConstantEntry();
        virtual ~GPPIntConstantEntry();
        float getVal(int index);
        void setVal(int index, float value);
        bool getIsSet();
        void setIsSet(bool value);
    };

    class  GPPIntConstantIterator
    {
    public:
        //GPPIntConstantIterator();
        //virtual ~GPPIntConstantIterator();
        bool hasMoreElements(void) const;
        void moveNext(void);
        GPPIntConstantEntry* peekNext(void);
        GPPIntConstantEntry* getNext(void);
        GPPIntConstantEntry* next();
    };



    class GPPConstantDefinition
    {
    public:
        GPPConstantDefinition();
        virtual ~GPPConstantDefinition();
        const String& getName();
        void setName(const String& value);
        size_t getEntryIndex();
        void setEntryIndex(size_t value);
        size_t getElementCount();
        void setElementCount(size_t value);
        size_t getArraySize();
        void setArraySize(size_t value);
        GpuProgramParameters::ElementType getElementType();
        void setElementType(GpuProgramParameters::ElementType value);
        size_t getAutoIndex();
        void setAutoIndex(size_t value);
        bool getIsAllocated();
        void setIsAllocated(bool value);
        bool getIsAuto();
        void setIsAuto(bool value);
    };

    //class _OgrePrivate AutoConstantEntry
    class GPPAutoConstantEntry
    {
    public:
        GpuProgramParameters::AutoConstantType getAcType();
        void setAcType(GpuProgramParameters::AutoConstantType value);
        size_t getIndex();
        void setIndex(size_t value);
        size_t getIntData()    ;
        void setIntData(size_t value);
        float getfloatData();
        void setfloatData(float value);
    };

    class  GPPAutoConstantIterator
    {
    public:
        //GPPAutoConstantIterator();
        //virtual ~GPPAutoConstantIterator();
        bool hasMoreElements(void) const;
        void moveNext(void);
        GPPAutoConstantEntry* peekNext(void);
        GPPAutoConstantEntry* getNext(void);
        GPPAutoConstantEntry* next();
    };
}





%extend Ogre::GpuProgramParameters {

    const Ogre::GPPAutoConstantDefinition* GetAutoConstantDefinition(const String& name)
    {
        return new Ogre::GPPAutoConstantDefinition((GpuProgramParameters::AutoConstantDefinition*)GpuProgramParameters::getAutoConstantDefinition(name));
    }
    const Ogre::GPPAutoConstantDefinition* GetAutoConstantDefinition(const size_t idx)
    {
        return new Ogre::GPPAutoConstantDefinition((GpuProgramParameters::AutoConstantDefinition*)GpuProgramParameters::getAutoConstantDefinition(idx));
    }


    const Ogre::GPPRealConstantEntry* GetRealConstantEntry(const size_t index)
    {
        return new Ogre::GPPRealConstantEntry((GpuProgramParameters::RealConstantEntry*)self->getRealConstantEntry(index));
    }
    const Ogre::GPPRealConstantEntry* GetNamedRealConstantEntry(const String& name)
    {
        return new Ogre::GPPRealConstantEntry((GpuProgramParameters::RealConstantEntry*)self->getNamedRealConstantEntry(name));
    }
    const Ogre::GPPRealConstantEntry* GetPassIterationEntry(void)
    {
        return new Ogre::GPPRealConstantEntry((GpuProgramParameters::RealConstantEntry*)self->getPassIterationEntry());
    }
    const Ogre::GPPRealConstantIterator* GetRealConstantIterator(void)
    {
        return new Ogre::GPPRealConstantIterator((GpuProgramParameters::RealConstantIterator*)&self->getRealConstantIterator());
    }


    const Ogre::GPPIntConstantEntry* GetIntConstantEntry(const size_t index)
    {
        return new Ogre::GPPIntConstantEntry((GpuProgramParameters::IntConstantEntry*)self->getIntConstantEntry(index));
    }
    const Ogre::GPPIntConstantEntry* GetNamedIntConstantEntry(const String& name)
    {
        return new Ogre::GPPIntConstantEntry((GpuProgramParameters::IntConstantEntry*)self->getNamedIntConstantEntry(name));
    }
    const Ogre::GPPIntConstantIterator* GetIntConstantIterator(void)
    {
        return new Ogre::GPPIntConstantIterator((GpuProgramParameters::IntConstantIterator*)&self->getIntConstantIterator());
    }


    const Ogre::GPPAutoConstantEntry* GetAutoConstantEntry(const size_t index)
    {
        return new Ogre::GPPAutoConstantEntry((GpuProgramParameters::AutoConstantEntry*)self->getAutoConstantEntry(index));
    }
    const Ogre::GPPAutoConstantIterator* GetAutoConstantIterator(void)
    {
        return new Ogre::GPPAutoConstantIterator((GpuProgramParameters::AutoConstantIterator*)&self->getAutoConstantIterator());
    }


    const Ogre::GPPConstantDefinition* GetConstantDefinition(const String& name)
    {
        return new Ogre::GPPConstantDefinition((GpuProgramParameters::ConstantDefinition*)self->getConstantDefinition(name));
    }
    const Ogre::GPPConstantDefinition* GetConstantDefinition(const size_t idx)
    {
        return new Ogre::GPPConstantDefinition((GpuProgramParameters::ConstantDefinition*)self->getConstantDefinition(idx));
    }
    const Ogre::GPPConstantDefinition* FindMatchingConstantDefinition(const String& name, const size_t entryIndex, const ElementType elementType)
    {
        return new Ogre::GPPConstantDefinition(
            (GpuProgramParameters::ConstantDefinition*)self->findMatchingConstantDefinition(name, entryIndex, elementType));
    }

};


//lot of trouble with templating the SharedPtr + we dont need 2 of them.
// so just the autocreated one some functions
%extend Ogre::GpuProgramPtr
{
    Ogre::GpuProgram* Get()
    {
        return (Ogre::GpuProgram*)self->get();
    }
    bool IsUnique()
    {
        return self->unique();
    }
    unsigned int UseCount()
    {
        return self->useCount();
    }
    bool IsNull()
    {
        return self->isNull();
    }
    void SetNull()
    {
        return self->setNull();
    }
};
