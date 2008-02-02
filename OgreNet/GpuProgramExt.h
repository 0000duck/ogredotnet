//GpuProgramExt.h
#ifndef __GpuProgramExt_H_
#define __GpuProgramExt_H_

namespace Ogre
{
	class GPPAutoConstantDefinition
	{
	protected:
		Ogre::GpuProgramParameters::AutoConstantDefinition *myOBJ;
		bool mICreated;
		bool mShouldRelease;
	public:
		GPPAutoConstantDefinition(const String& _name)	{
			myOBJ = new GpuProgramParameters::AutoConstantDefinition(GpuProgramParameters::ACT_WORLD_MATRIX
				, _name, 0, GpuProgramParameters::ET_INT, GpuProgramParameters::ACDT_NONE);
			mICreated=true;
			mShouldRelease=true;
		}
	/*	GPPAutoConstantDefinition( Ogre::GpuProgramParameters::AutoConstantType _acType,
			const String& _name,
			size_t _elementCount,
			ElementType _elementType,
			Ogre::GpuProgramParameters::ACDataType _dataType)
		{
			myOBJ = new GpuProgramParameters::AutoConstantDefinition(_acType, _name, _elementCount, _elementType, _dataType);
			mICreated=true;
			mShouldRelease=true;
		}*/
		GPPAutoConstantDefinition(GpuProgramParameters::AutoConstantDefinition *p) {
			myOBJ = p;
			mICreated=false;
			mShouldRelease=false;
		}
		virtual ~GPPAutoConstantDefinition()	{
			if ( (mICreated) && (mShouldRelease) )
				delete myOBJ;
		}
		//## these functions Not for swig
		GpuProgramParameters::AutoConstantDefinition * get_myOBJ()	{	return myOBJ; }
		bool getICreated() { return mICreated; }
		bool getShouldRelease() { return mShouldRelease; }
		void setShouldRelease(bool value) { mShouldRelease = value; }
		//##

		//AutoConstantType acType;
		GpuProgramParameters::AutoConstantType getAcType()	{
			if (myOBJ!=0) return myOBJ->acType; else return GpuProgramParameters::ACT_WORLD_MATRIX;
		}
		void setAcType(GpuProgramParameters::AutoConstantType value) {
			if (myOBJ!=0) myOBJ->acType = value;
		}

		//String name;
		const String& getName()	{
			if (myOBJ!=0) return myOBJ->name; else return String("");
		}
		void setName(const String& value) {
			if (myOBJ!=0) myOBJ->name = value;
		}

		//size_t elementCount;
		size_t getElementCount()	{
			if (myOBJ!=0) return myOBJ->elementCount; else return 0;
		}
		void setElementCount(size_t value) {
			if (myOBJ!=0) myOBJ->elementCount = value;
		}

		///// The type of the constant in the program
		//ElementType elementType;
		GpuProgramParameters::ElementType getElementType()	{
			if (myOBJ!=0) return myOBJ->elementType; else return GpuProgramParameters::ET_INT;
		}
		void setElementType(GpuProgramParameters::ElementType value) {
			if (myOBJ!=0) myOBJ->elementType = value;
		}

		///// The type of any extra data
		//ACDataType dataType;
		GpuProgramParameters::ACDataType getDataType()	{
			if (myOBJ!=0) return myOBJ->dataType; else return GpuProgramParameters::ACDT_NONE;
		}
		void setDataType(GpuProgramParameters::ACDataType value) {
			if (myOBJ!=0) myOBJ->dataType = value;
		}
	};




	class GPPRealConstantEntry
	{
	protected:
		GpuProgramParameters::RealConstantEntry *myOBJ;
		bool mICreated;
		bool mShouldRelease;
	public:
		GPPRealConstantEntry() {
			myOBJ = new GpuProgramParameters::RealConstantEntry();
			mICreated=true;
			mShouldRelease=true;
		}
		GPPRealConstantEntry(GpuProgramParameters::RealConstantEntry *p) {
			myOBJ = p;
			mICreated=false;
			mShouldRelease=false;
		}
		virtual ~GPPRealConstantEntry()	{
			if ( (mICreated) && (mShouldRelease) )
				delete myOBJ;
		}
		//## these functions Not for swig
		GpuProgramParameters::RealConstantEntry * get_myOBJ()	{	return myOBJ; }
		bool getICreated() { return mICreated; }
		bool getShouldRelease() { return mShouldRelease; }
		void setShouldRelease(bool value) { mShouldRelease = value; }
		//##

		
		//float val[4];
		float getVal(int index)	{
			if ((myOBJ!=0) && (index>-1) && (index<4)) return myOBJ->val[index]; else return 0.0f;
		}
		void setVal(int index, float value) {
			if ((myOBJ!=0) && (index>-1) && (index<4)) myOBJ->val[index] = value;
		}

		//bool isSet;
		bool getIsSet()	{
			if (myOBJ!=0) return myOBJ->isSet; else return false;
		}
		void setIsSet(bool value) {
			if (myOBJ!=0) myOBJ->isSet = value;
		}
	};



	/***
	* a custom ConstVectorIterator proxy for GpuProgramParameters::RealConstantIterator
	* typedef std::vector<RealConstantEntry> RealConstantList;
	* typedef ConstVectorIterator<RealConstantList> RealConstantIterator;
	***/
	class  GPPRealConstantIterator
	{
	private:
		GpuProgramParameters::RealConstantIterator *myOBJ;
	public:
		GPPRealConstantIterator()	{ myOBJ = 0; }
		GPPRealConstantIterator(GpuProgramParameters::RealConstantIterator *p)	{ myOBJ = p; }
		virtual ~GPPRealConstantIterator()	{
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
		GPPRealConstantEntry* peekNext(void)	{
			if (myOBJ==0) return 0;
			return new GPPRealConstantEntry( (GpuProgramParameters::RealConstantEntry*)&myOBJ->peekNext() );
		}
		GPPRealConstantEntry* getNext(void)		{
			if (myOBJ==0) return 0;
			return new GPPRealConstantEntry( (GpuProgramParameters::RealConstantEntry*)&myOBJ->getNext() );
		}
		GPPRealConstantEntry* next() {
			if (myOBJ==0) return 0;
			if (myOBJ->hasMoreElements())
				return new GPPRealConstantEntry( (GpuProgramParameters::RealConstantEntry*)&myOBJ->getNext() );
			else
				throw( Ogre::Exception( Exception::ERR_ITEM_NOT_FOUND, "StopIteration at end", "GPPRealConstantIterator", __FILE__, __LINE__ ) );
		}
	};




	class GPPIntConstantEntry
	{
	protected:
		GpuProgramParameters::IntConstantEntry *myOBJ;
		bool mICreated;
		bool mShouldRelease;
	public:
		GPPIntConstantEntry() {
			myOBJ = new GpuProgramParameters::IntConstantEntry();
			mICreated=true;
			mShouldRelease=true;
		}
		GPPIntConstantEntry(GpuProgramParameters::IntConstantEntry *p) {
			myOBJ = p;
			mICreated=false;
			mShouldRelease=false;
		}
		virtual ~GPPIntConstantEntry()	{
			if ( (mICreated) && (mShouldRelease) )
				delete myOBJ;
		}
		//## these functions Not for swig
		GpuProgramParameters::IntConstantEntry * get_myOBJ()	{	return myOBJ; }
		bool getICreated() { return mICreated; }
		bool getShouldRelease() { return mShouldRelease; }
		void setShouldRelease(bool value) { mShouldRelease = value; }
		//##

		
		//float val[4];
		float getVal(int index)	{
			if ((myOBJ!=0) && (index>-1) && (index<4)) return myOBJ->val[index]; else return 0.0f;
		}
		void setVal(int index, float value) {
			if ((myOBJ!=0) && (index>-1) && (index<4)) myOBJ->val[index] = value;
		}

		//bool isSet;
		bool getIsSet()	{
			if (myOBJ!=0) return myOBJ->isSet; else return false;
		}
		void setIsSet(bool value) {
			if (myOBJ!=0) myOBJ->isSet = value;
		}
	};



	/***
	* a custom ConstVectorIterator proxy for GpuProgramParameters::RealConstantIterator
	* typedef std::vector<IntConstantEntry> IntConstantList;
	* typedef ConstVectorIterator<IntConstantList> IntConstantIterator;
	***/
	class  GPPIntConstantIterator
	{
	private:
		GpuProgramParameters::IntConstantIterator *myOBJ;
	public:
		GPPIntConstantIterator()	{ myOBJ = 0; }
		GPPIntConstantIterator(GpuProgramParameters::IntConstantIterator *p)	{ myOBJ = p; }
		virtual ~GPPIntConstantIterator()	{
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
		GPPIntConstantEntry* peekNext(void)	{
			if (myOBJ==0) return 0;
			return new GPPIntConstantEntry( (GpuProgramParameters::IntConstantEntry*)&myOBJ->peekNext() );
		}
		GPPIntConstantEntry* getNext(void)		{
			if (myOBJ==0) return 0;
			return new GPPIntConstantEntry( (GpuProgramParameters::IntConstantEntry*)&myOBJ->getNext() );
		}
		GPPIntConstantEntry* next() {
			if (myOBJ==0) return 0;
			if (myOBJ->hasMoreElements())
				return new GPPIntConstantEntry( (GpuProgramParameters::IntConstantEntry*)&myOBJ->getNext() );
			else
				throw( Ogre::Exception( Exception::ERR_ITEM_NOT_FOUND, "StopIteration at end", "GPPIntConstantIterator", __FILE__, __LINE__ ) );
		}
	};



	class GPPConstantDefinition
	{
	protected:
		GpuProgramParameters::ConstantDefinition *myOBJ;
		bool mICreated;
		bool mShouldRelease;
	public:
		GPPConstantDefinition() {
			myOBJ = new GpuProgramParameters::ConstantDefinition();
			mICreated=true;
			mShouldRelease=true;
		}
		GPPConstantDefinition(GpuProgramParameters::ConstantDefinition *p) {
			myOBJ = p;
			mICreated=false;
			mShouldRelease=false;
		}
		virtual ~GPPConstantDefinition()	{
			if ( (mICreated) && (mShouldRelease) )
				delete myOBJ;
		}
		//## these functions Not for swig
		GpuProgramParameters::ConstantDefinition * get_myOBJ()	{	return myOBJ; }
		bool getICreated() { return mICreated; }
		bool getShouldRelease() { return mShouldRelease; }
		void setShouldRelease(bool value) { mShouldRelease = value; }
		//##

		
		//String name;
		const String& getName()	{
			if (myOBJ!=0) return myOBJ->name; else return String("");
		}
		void setName(const String& value) {
			if (myOBJ!=0) myOBJ->name = value;
		}

		//size_t entryIndex;
		size_t getEntryIndex()	{
			if (myOBJ!=0) return myOBJ->entryIndex; else return 0;
		}
		void setEntryIndex(size_t value) {
			if (myOBJ!=0) myOBJ->entryIndex = value;
		}

		//size_t elementCount;
		size_t getElementCount()	{
			if (myOBJ!=0) return myOBJ->elementCount; else return 0;
		}
		void setElementCount(size_t value) {
			if (myOBJ!=0) myOBJ->elementCount = value;
		}

		//size_t arraySize;
		size_t getArraySize()	{
			if (myOBJ!=0) return myOBJ->arraySize; else return 0;
		}
		void setArraySize(size_t value) {
			if (myOBJ!=0) myOBJ->arraySize = value;
		}

		//ElementType elementType;
		GpuProgramParameters::ElementType getElementType()	{
			if (myOBJ!=0) return myOBJ->elementType; else return GpuProgramParameters::ET_INT;
		}
		void setElementType(GpuProgramParameters::ElementType value) {
			if (myOBJ!=0) myOBJ->elementType = value;
		}

		//size_t autoIndex;
		size_t getAutoIndex()	{
			if (myOBJ!=0) return myOBJ->autoIndex; else return 0;
		}
		void setAutoIndex(size_t value) {
			if (myOBJ!=0) myOBJ->autoIndex = value;
		}

		//bool   isAllocated;
		bool getIsAllocated()	{
			if (myOBJ!=0) return myOBJ->isAllocated; else return false;
		}
		void setIsAllocated(bool value) {
			if (myOBJ!=0) myOBJ->isAllocated = value;
		}

		//bool   isAuto;
		bool getIsAuto()	{
			if (myOBJ!=0) return myOBJ->isAuto; else return false;
		}
		void setIsAuto(bool value) {
			if (myOBJ!=0) myOBJ->isAuto = value;
		}
	};
	//typedef std::vector<ConstantDefinition> ConstantDefinitionContainer;





	//class _OgrePrivate AutoConstantEntry
	class GPPAutoConstantEntry
	{
	protected:
		GpuProgramParameters::AutoConstantEntry *myOBJ;
	public:
		//AutoConstantEntry(AutoConstantType theType, size_t theIndex, size_t theData)
		//    : paramType(theType), index(theIndex), data(theData) {}
		//AutoConstantEntry(AutoConstantType theType, size_t theIndex, Real theData)
		//	: paramType(theType), index(theIndex), fData(theData) {}
		GPPAutoConstantEntry(GpuProgramParameters::AutoConstantEntry *p) { myOBJ = p; }
		//## these functions Not for swig
		GpuProgramParameters::AutoConstantEntry * get_myOBJ()	{	return myOBJ; }
		//##

		///// The type of parameter
		//AutoConstantType paramType;
		GpuProgramParameters::AutoConstantType getAcType()	{
			if (myOBJ!=0) return myOBJ->paramType; else return GpuProgramParameters::ACT_WORLD_MATRIX;
		}
		void setAcType(GpuProgramParameters::AutoConstantType value) {
			if (myOBJ!=0) myOBJ->paramType = value;
		}

		///// The target constant index
		//size_t index;
		size_t getIndex()	{
			if (myOBJ!=0) return myOBJ->index; else return 0;
		}
		void setIndex(size_t value) {
			if (myOBJ!=0) myOBJ->index = value;
		}

		///// Additional information to go with the parameter
		//union{
		//	size_t data;
		size_t getIntData()	{
			if (myOBJ!=0) return myOBJ->data; else return 0;
		}
		void setIntData(size_t value) {
			if (myOBJ!=0) myOBJ->data = value;
		}
		//	Real fData;
		float getfloatData()	{
			if (myOBJ!=0) return myOBJ->fData; else return 0.0f;
		}
		void setfloatData(float value) {
			if (myOBJ!=0) myOBJ->fData = value;
		}
		//};
	};

	/***
	* a custom ConstVectorIterator proxy for GpuProgramParameters::RealConstantIterator
	* typedef std::vector<AutoConstantEntry> AutoConstantList;
	* typedef ConstVectorIterator<AutoConstantList> AutoConstantIterator;
	***/
	class  GPPAutoConstantIterator
	{
	private:
		GpuProgramParameters::AutoConstantIterator *myOBJ;
	public:
		GPPAutoConstantIterator()	{ myOBJ = 0; }
		GPPAutoConstantIterator(GpuProgramParameters::AutoConstantIterator *p)	{ myOBJ = p; }
		virtual ~GPPAutoConstantIterator()	{
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
		GPPAutoConstantEntry* peekNext(void)	{
			if (myOBJ==0) return 0;
			return new GPPAutoConstantEntry( (GpuProgramParameters::AutoConstantEntry*)&myOBJ->peekNext() );
		}
		GPPAutoConstantEntry* getNext(void)		{
			if (myOBJ==0) return 0;
			return new GPPAutoConstantEntry( (GpuProgramParameters::AutoConstantEntry*)&myOBJ->getNext() );
		}
		GPPAutoConstantEntry* next() {
			if (myOBJ==0) return 0;
			if (myOBJ->hasMoreElements())
				return new GPPAutoConstantEntry( (GpuProgramParameters::AutoConstantEntry*)&myOBJ->getNext() );
			else
				throw( Ogre::Exception( Exception::ERR_ITEM_NOT_FOUND, "StopIteration at end", "GPPAutoConstantIterator", __FILE__, __LINE__ ) );
		}
	};
}

#endif //__GpuProgramExt_H_
