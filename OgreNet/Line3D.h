#ifndef __LINE3D_H__
#define __LINE3D_H__

#include "OgreRenderOperation.h"
namespace Ogre
{
	#define POSITION_BINDING 0
	#define TEXCOORD_BINDING 1

	class Line3D : public Ogre::SimpleRenderable
	{
	protected:
		typedef std::vector<Vector3> vecVector;
		typedef std::vector<Vector3>::iterator vecVectorIterator;
		vecVector mPoints;
		bool mDrawn;
		size_t mVertexBufferCapacity;
		RenderOperation::OperationType mopType;
	public:
		Line3D(void)
		{
			mRenderOp.vertexData = new VertexData();
			mDrawn = false;
			mVertexBufferCapacity=0;
			mopType = RenderOperation::OT_LINE_STRIP;
			this->setMaterial("BaseWhiteNoLighting");
		}
		Line3D(RenderOperation::OperationType opType)
			: Ogre::SimpleRenderable()
		{
			mRenderOp.vertexData = new VertexData();
			mDrawn = false;
			mVertexBufferCapacity=0;
			this->setMaterial("BaseWhiteNoLighting");
			mopType= opType;
		}
		
		~Line3D(void)
		{
			delete mRenderOp.vertexData;
		}
		
		void addPoint(const Vector3 &p)
		{
			mPoints.push_back(p);
		}

		const Vector3 &getPoint(size_t index) const
		{
			assert(index < mPoints.size() && "Point index is out of bounds!!");
			
			return mPoints[index];
		}

		size_t getNumPoints(void) const
		{
			return (size_t)mPoints.size();
		}


		void updatePoint(size_t index, const Vector3 &value)
		{
			assert(index < mPoints.size() && "Point index is out of bounds!!");
			
			mPoints[index] = value;
		}

		void deletePoint(size_t index)
		{
			assert(index < mPoints.size() && "Point index is out of bounds!!");
			vecVectorIterator it = mPoints.begin();
			std::advance(it,index);
			mPoints.erase(it);
		}

		void insertPoint(size_t index, const Vector3 &p)
		{
			assert(index < mPoints.size() && "Point index is out of bounds!!");
			vecVectorIterator it = mPoints.begin();
			std::advance(it,index);
			mPoints.insert(it, p);
		}


		void drawLine(Vector3 &start, Vector3 &end)
		{
			if(mPoints.size())
				mPoints.clear();
			
			mPoints.push_back(start);
			mPoints.push_back(end);
			
			drawLines();
		}

		void drawLines(void)
		{
			//resizeing code adapted from 
			//http://www.ogre3d.org/wiki/index.php/DynamicGrowingBuffers
			HardwareVertexBufferSharedPtr vbuf;
			size_t newVertCapacity = mVertexBufferCapacity;
			if(!mDrawn)
			{
				mDrawn = true;
				mVertexBufferCapacity = 0;
				newVertCapacity = 1;

				// Make capacity the next power of two
				while (newVertCapacity < mPoints.size())
					newVertCapacity <<= 1;
				mVertexBufferCapacity = newVertCapacity;

				// Initialization stuff
				mRenderOp.indexData = 0;
				mRenderOp.useIndexes = false;

				mRenderOp.vertexData->vertexCount = mPoints.size();
				mRenderOp.vertexData->vertexStart = 0;
				mRenderOp.operationType = (RenderOperation::OperationType)mopType; //RenderOperation::OT_LINE_STRIP; // OT_LINE_LIST, OT_LINE_STRIP

				mRenderOp.vertexData->vertexDeclaration->addElement(POSITION_BINDING, 0, VET_FLOAT3, VES_POSITION);
				
				vbuf = HardwareBufferManager::getSingleton().createVertexBuffer(
						mRenderOp.vertexData->vertexDeclaration->getVertexSize(POSITION_BINDING),
						mVertexBufferCapacity,
						HardwareBuffer::HBU_STATIC_WRITE_ONLY);

				mRenderOp.vertexData->vertexBufferBinding->setBinding(0, vbuf);
			}


			if ((mPoints.size() > mVertexBufferCapacity) ||
				(!mVertexBufferCapacity))
			{
				// vertexCount exceeds current capacity!
				// It is necessary to reallocate the buffer.

				// Check if this is the first call... should never happen(we have mDrawn flag check)
				if (!newVertCapacity)
					newVertCapacity = 1;

				// Make capacity the next power of two
				while (newVertCapacity < mPoints.size())
					newVertCapacity <<= 1;
			}
			else if (mPoints.size() < mVertexBufferCapacity>>1) {
				// Make capacity the previous power of two
				while (mPoints.size() < newVertCapacity>>1)
					newVertCapacity >>= 1;
			}
			if (newVertCapacity != mVertexBufferCapacity) 
			{
				mVertexBufferCapacity = newVertCapacity;
				mRenderOp.vertexData->vertexCount = mVertexBufferCapacity;

				// Create new vertex buffer
				vbuf = HardwareBufferManager::getSingleton().createVertexBuffer(
						mRenderOp.vertexData->vertexDeclaration->getVertexSize(POSITION_BINDING),
						mVertexBufferCapacity,
						HardwareBuffer::HBU_STATIC_WRITE_ONLY);
				
				//the old buffer will automatically be deleted once no more references to it exist
				//http://www.ogre3d.org/phpBB2/viewtopic.php?t=13058&highlight=vertexbuffer+update
				
				// Bind buffer
				mRenderOp.vertexData->vertexBufferBinding->setBinding(0, vbuf);
			}
			else
			{	//we need to set vbuf
				vbuf = mRenderOp.vertexData->vertexBufferBinding->getBuffer(0);
			}
			// Update vertex count in the render operation
			mRenderOp.vertexData->vertexCount = mPoints.size();


			// Drawing stuff
			size_t size = mPoints.size();
			Vector3 vaabMin = mPoints[0];
			Vector3 vaabMax = mPoints[0];
			
			Real *prPos = static_cast<Real*>(vbuf->lock(HardwareBuffer::HBL_DISCARD));
			
			for(size_t i = 0; i < size; i++)
			{
				*prPos++ = mPoints[i].x;
				*prPos++ = mPoints[i].y;
				*prPos++ = mPoints[i].z;
			
				if(mPoints[i].x < vaabMin.x)
					vaabMin.x = mPoints[i].x;
				if(mPoints[i].y < vaabMin.y)
					vaabMin.y = mPoints[i].y;
				if(mPoints[i].z < vaabMin.z)
					vaabMin.z = mPoints[i].z;
			
				if(mPoints[i].x > vaabMax.x)
					vaabMax.x = mPoints[i].x;
				if(mPoints[i].y > vaabMax.y)
					vaabMax.y = mPoints[i].y;
				if(mPoints[i].z > vaabMax.z)
					vaabMax.z = mPoints[i].z;
			}
			
			vbuf->unlock();
			
			mBox.setExtents(vaabMin, vaabMax);
		}
		
		Real getSquaredViewDepth(const Camera *cam) const
		{
			Vector3 vMin, vMax, vMid, vDist;
			vMin = mBox.getMinimum();
			vMax = mBox.getMaximum();
			vMid = ((vMin - vMax) * 0.5) + vMin;
			vDist = cam->getDerivedPosition() - vMid;
			
			return vDist.squaredLength();
		}

		Real getBoundingRadius(void) const
		{
			return Math::Sqrt(std::max(mBox.getMaximum().squaredLength(), mBox.getMinimum().squaredLength()));
			//return mRadius;
		}

	protected:
	/*
		void getWorldTransforms(Matrix4 *xform) const
		{
			// return identity matrix to prevent parent transforms
			*xform = Matrix4::IDENTITY;
		}
	*/
		const Quaternion &getWorldOrientation(void) const
		{
			return Quaternion::IDENTITY;
		}
		const Vector3 &getWorldPosition(void) const
		{
			return Vector3::ZERO;
		}
	};
}
#endif /* __LINE3D_H__ */
