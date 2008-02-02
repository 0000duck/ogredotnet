//KeyFrameExt.h
#ifndef __KeyFrameExt_H_
#define __KeyFrameExt_H_

namespace Ogre
{
	//VertexPoseKeyFrame
	class VPKFPoseRef
	{
	protected:
		VertexPoseKeyFrame::PoseRef *myOBJ;
		bool mICreated;
		bool mShouldRelease;
	public:
		VPKFPoseRef(ushort p, Real i) {
			myOBJ = new VertexPoseKeyFrame::PoseRef(p, i);
			mICreated=true;
			mShouldRelease=true;
		}
		VPKFPoseRef(VertexPoseKeyFrame::PoseRef *p) {
			myOBJ = p;
			mICreated=false;
			mShouldRelease=false;
		}
		virtual ~VPKFPoseRef()	{
			if ( (mICreated) && (mShouldRelease) )
				delete myOBJ;
		}
		//## these functions Not for swig
		VertexPoseKeyFrame::PoseRef * get_myOBJ()	{	return myOBJ; }
		bool getICreated() { return mICreated; }
		bool getShouldRelease() { return mShouldRelease; }
		void setShouldRelease(bool value) { mShouldRelease = value; }
		//##

		//ushort poseIndex;
		ushort getPoseIndex()	{
			if (myOBJ!=0) return myOBJ->poseIndex; else return 0;
		}
		void setPoseIndex(ushort value) {
			if (myOBJ!=0) myOBJ->poseIndex = value;
		}

		//Real influence;
		Real getInfluence()	{
			if (myOBJ!=0) return myOBJ->influence; else return 0;
		}
		void setInfluence(Real value) {
			if (myOBJ!=0) myOBJ->influence = value;
		}
	};


	//typedef std::vector<PoseRef> PoseRefList;
	class  VPKFPoseRefList
	{
	protected:
		VertexPoseKeyFrame::PoseRefList  *myOBJ;
	public:
		VPKFPoseRefList()	{ myOBJ= 0; }
		VPKFPoseRefList(VertexPoseKeyFrame::PoseRefList *p)	{ myOBJ=p; }
		//## these functions Not for swig
		VertexPoseKeyFrame::PoseRefList * get_myOBJ()	{ return myOBJ; }
		//##

		size_t size()
		{	if (myOBJ==0)	return 0;
			return myOBJ->size();
		}
		void addItem(VPKFPoseRef *pnewItem)
		{	if (myOBJ==0) return;
			// a vector of non ptr types creates a new copy of the object
			myOBJ->push_back( *pnewItem->get_myOBJ() );
		}
		VPKFPoseRef *getFirst()
		{	if (myOBJ==0)	return 0;
			VertexPoseKeyFrame::PoseRefList::iterator it =myOBJ->begin();
			if (it == myOBJ->end())		return 0;
			else						return new VPKFPoseRef( (VertexPoseKeyFrame::PoseRef*)&(*it) );
		}
		VPKFPoseRef *getLast()
		{	if (myOBJ==0)	return 0;
			VertexPoseKeyFrame::PoseRefList::reverse_iterator rit =myOBJ->rbegin();
			if (rit == myOBJ->rend())	return 0;
			else						return new VPKFPoseRef( (VertexPoseKeyFrame::PoseRef*)&(*rit) );
		}
		VPKFPoseRef *getByIndex(int index)
		{	if (myOBJ==0)	return 0;
			VertexPoseKeyFrame::PoseRefList::iterator it =myOBJ->begin();
			if (it == myOBJ->end())		return 0;
			std::advance(it, index);
			if (it == myOBJ->end())		return 0;
			else						return new VPKFPoseRef( (VertexPoseKeyFrame::PoseRef*)&(*it) );
		}
	};


	//typedef VectorIterator<PoseRefList> PoseRefIterator;
	//typedef ConstVectorIterator<PoseRefList> ConstPoseRefIterator;
	/***
	* a custom VectorIterator proxy for VertexPoseKeyFrame::PoseRefIterator
	* typedef std::vector<PoseRef> PoseRefList;
	* typedef VectorIterator<PoseRefList> PoseRefIterator;
	***/
	class  VPKFPoseRefIterator
	{
	private:
		VertexPoseKeyFrame::PoseRefIterator *myOBJ;
	public:
		VPKFPoseRefIterator()	{ myOBJ = 0; }
		VPKFPoseRefIterator(VertexPoseKeyFrame::PoseRefIterator *p)	{ myOBJ = p; }
		virtual ~VPKFPoseRefIterator()	{
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
		VPKFPoseRef* peekNext(void)	{
			if (myOBJ==0) return 0;
			return new VPKFPoseRef( (VertexPoseKeyFrame::PoseRef*)&myOBJ->peekNext() );
		}
		VPKFPoseRef* getNext(void)		{
			if (myOBJ==0) return 0;
			return new VPKFPoseRef( (VertexPoseKeyFrame::PoseRef*)&myOBJ->getNext() );
		}
		VPKFPoseRef* next() {
			if (myOBJ==0) return 0;
			if (myOBJ->hasMoreElements())
				return new VPKFPoseRef( (VertexPoseKeyFrame::PoseRef*)&myOBJ->getNext() );
			else
				throw( Ogre::Exception( Exception::ERR_ITEM_NOT_FOUND, "StopIteration at end", "VPKFPoseRefIterator", __FILE__, __LINE__ ) );
		}
	};
}

#endif //__KeyFrameExt_H_

