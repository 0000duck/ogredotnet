//MeshBuilderHelper.h
//rastaman 11/16/2005
// helper class for manual mesh

#ifndef _MeshBuilderHelper_H_
#define _MeshBuilderHelper_H_

namespace Ogre
{
	class  MeshBuilderHelper
	{
	public:
		MeshBuilderHelper(const String& name, const String& resourcegroup,
			bool usesharedvertices, uint vertexstart, uint vertexcount)
		{
			mName = name;
			mResourceGroup = resourcegroup;
			mVertextStart = vertexstart;
			mVertexCount = vertexcount;

			mMeshPtr = MeshManager::getSingleton().createManual( mName, mResourceGroup);
			mSubMesh = mMeshPtr->createSubMesh();
			mSubMesh->useSharedVertices = usesharedvertices;
			mSubMesh->vertexData = new VertexData();
			mSubMesh->vertexData->vertexStart = mVertextStart;
			mSubMesh->vertexData->vertexCount = mVertexCount;
			offset = 0;
			pVBuffStart=0;
			mIndexType = HardwareIndexBuffer::IT_16BIT;
		}
		virtual ~MeshBuilderHelper()
		{
		}


		virtual const VertexElement& addElement(VertexElementType theType, VertexElementSemantic semantic)
		{
			
			const VertexElement& ve = mSubMesh->vertexData->vertexDeclaration->addElement( 0 , offset, theType, semantic );
			offset += VertexElement::getTypeSize(theType);
			return ve;
		}


		virtual void createVertexBuffer(size_t numVerts, HardwareBuffer::Usage usage, bool useShadowBuffer = false)
		{
			mVertexSize = offset;
			mNumVerts = numVerts;
			mvbuf = HardwareBufferManager::getSingleton().createVertexBuffer(
					mVertexSize, mNumVerts, usage, useShadowBuffer);
			pVBuffStart = (void*)static_cast<float*>(mvbuf->lock(HardwareBuffer::HBL_DISCARD));
		}

		virtual void setVertFloat( uint vertexindex, size_t byteoffset, float val1)
		{
			if (vertexindex > mNumVerts)
				return;
			char *pp = (char *)pVBuffStart;
			pp += (mVertexSize * vertexindex) + byteoffset;
			float *p = (float *)pp;
			*p++ = val1;
		}

		virtual void setVertFloat( uint vertexindex, size_t byteoffset, float val1, float val2)
		{
			if (vertexindex > mNumVerts)
				return;
			char *pp = (char *)pVBuffStart;
			pp += (mVertexSize * vertexindex) + byteoffset;
			float *p = (float *)pp;
			*p++ = val1;
			*p++ = val2;
		}

		virtual void setVertFloat( uint vertexindex, size_t byteoffset, float val1, float val2, float val3)
		{
			if (vertexindex > mNumVerts)
				return;
			char *pp = (char *)pVBuffStart;
			pp += (mVertexSize * vertexindex) + byteoffset;
			float *p = (float *)pp;
			*p++ = val1;
			*p++ = val2;
			*p++ = val3;
		}

		virtual void setVertFloat( uint vertexindex, size_t byteoffset, float val1, float val2, float val3, float val4)
		{
			if (vertexindex > mNumVerts)
				return;
			char *pp = (char *)pVBuffStart;
			pp += (mVertexSize * vertexindex) + byteoffset;
			float *p = (float *)pp;
			*p++ = val1;
			*p++ = val2;
			*p++ = val3;
			*p++ = val4;
		}


		virtual void createIndexBuffer( size_t triaglecount, HardwareIndexBuffer::IndexType itype,
			HardwareBuffer::Usage usage, bool useShadowBuffer = false )
		{
			mvbuf->unlock();
			mTriagleCount = triaglecount;
			mIndexType = itype;
			mSubMesh->vertexData->vertexBufferBinding->setBinding(0, mvbuf);
			mSubMesh->indexData->indexCount = mTriagleCount * 3;
			mSubMesh->indexData->indexBuffer = HardwareBufferManager::getSingleton()
				.createIndexBuffer(mIndexType, mTriagleCount * 3,usage, useShadowBuffer);
			pIBuffStart = (void*)static_cast<uint16*>(
				mSubMesh->indexData->indexBuffer->lock(HardwareBuffer::HBL_DISCARD));
		}

		virtual void setIndex16bit( size_t triagleIdx, uint16 vidx1, uint16 vidx2, uint16 vidx3)
		{
			if (triagleIdx > mTriagleCount)
				return;
			if (mIndexType != HardwareIndexBuffer::IT_16BIT)
				return;
			uint16 *p = (uint16*)pIBuffStart;
			p += (triagleIdx * 3);
			*p++ = vidx1;
			*p++ = vidx2;
			*p++ = vidx3;
		}

		virtual void setIndex32bit( size_t triagleIdx, uint32 vidx1, uint32 vidx2, uint32 vidx3)
		{
			if (triagleIdx > mTriagleCount)
				return;
			if (mIndexType != HardwareIndexBuffer::IT_32BIT)
				return;
			uint32 *p = (uint32*)pIBuffStart;
			p += (triagleIdx * 3);
			*p++ = vidx1;
			*p++ = vidx2;
			*p++ = vidx3;
		}

		virtual MeshPtr Load(const String& materialname)
		{
			mSubMesh->indexData->indexBuffer->unlock();
			mSubMesh->setMaterialName(materialname);
			mMeshPtr->load();
			return mMeshPtr;
		}
	protected:
		MeshPtr			mMeshPtr;
		SubMesh*		mSubMesh;
		String			mName, mResourceGroup;
		uint			mVertextStart,mVertexCount;
		HardwareVertexBufferSharedPtr mvbuf;
		size_t			offset;
		size_t			mVertexSize;
		size_t			mNumVerts;
		void		 	*pVBuffStart;
		size_t			mTriagleCount;
		HardwareIndexBuffer::IndexType	mIndexType;
		void			*pIBuffStart;
		




	public:
		static void SetVertexFloat(void *vbStart, size_t VertexSize, uint vertexindex, size_t byteoffset, float val1)
		{
			char *pp = (char *)vbStart;
			pp += (VertexSize * vertexindex) + byteoffset;
			float *p = (float *)pp;
			*p++ = val1;
		}
		
		static void SetVertexFloat(void *vbStart, size_t VertexSize, uint vertexindex, size_t byteoffset, float val1, float val2)
		{
			char *pp = (char *)vbStart;
			pp += (VertexSize * vertexindex) + byteoffset;
			float *p = (float *)pp;
			*p++ = val1;
			*p++ = val2;
		}
		
		static void SetVertexFloat(void *vbStart, size_t VertexSize, uint vertexindex, size_t byteoffset, float val1, float val2, float val3)
		{
			char *pp = (char *)vbStart;
			pp += (VertexSize * vertexindex) + byteoffset;
			float *p = (float *)pp;
			*p++ = val1;
			*p++ = val2;
			*p++ = val3;
		}
		
		static void SetVertexFloat(void *vbStart, size_t VertexSize, uint vertexindex, size_t byteoffset, float val1, float val2, float val3, float val4)
		{
			char *pp = (char *)vbStart;
			pp += (VertexSize * vertexindex) + byteoffset;
			float *p = (float *)pp;
			*p++ = val1;
			*p++ = val2;
			*p++ = val3;
			*p++ = val4;
		}
		
		static void SetVertexRGBA(void *vbStart, size_t VertexSize, uint vertexindex, size_t byteoffset, uchar val1, uchar val2, uchar val3, uchar val4)
		{
			char *pp = (char *)vbStart;
			pp += (VertexSize * vertexindex) + byteoffset;
			uchar *p = (uchar *)pp;
			*p++ = val1;
			*p++ = val2;
			*p++ = val3;
			*p++ = val4;
		}
		
		static void SetVertexShort(void *vbStart, size_t VertexSize, uint vertexindex, size_t byteoffset, short val1)
		{
			char *pp = (char *)vbStart;
			pp += (VertexSize * vertexindex) + byteoffset;
			short *p = (short *)pp;
			*p++ = val1;
		}
		
		static void SetVertexShort(void *vbStart, size_t VertexSize, uint vertexindex, size_t byteoffset, short val1, short val2)
		{
			char *pp = (char *)vbStart;
			pp += (VertexSize * vertexindex) + byteoffset;
			short *p = (short *)pp;
			*p++ = val1;
			*p++ = val2;
		}
		
		static void SetVertexShort(void *vbStart, size_t VertexSize, uint vertexindex, size_t byteoffset, short val1, short val2, short val3)
		{
			char *pp = (char *)vbStart;
			pp += (VertexSize * vertexindex) + byteoffset;
			short *p = (short *)pp;
			*p++ = val1;
			*p++ = val2;
			*p++ = val3;
		}
		
		static void SetVertexShort(void *vbStart, size_t VertexSize, uint vertexindex, size_t byteoffset, short val1, short val2, short val3, short val4)
		{
			char *pp = (char *)vbStart;
			pp += (VertexSize * vertexindex) + byteoffset;
			short *p = (short *)pp;
			*p++ = val1;
			*p++ = val2;
			*p++ = val3;
			*p++ = val4;
		}


		static void SetIndex16bit(void *ibStart, size_t triagleIdx, uint16 vidx1, uint16 vidx2, uint16 vidx3)
		{
			uint16 *p = (uint16*)ibStart;
			p += (triagleIdx * 3);
			*p++ = vidx1;
			*p++ = vidx2;
			*p++ = vidx3;
		}

		static void SetIndex32bit(void *ibStart, size_t triagleIdx, uint32 vidx1, uint32 vidx2, uint32 vidx3)
		{
			uint32 *p = (uint32*)ibStart;
			p += (triagleIdx * 3);
			*p++ = vidx1;
			*p++ = vidx2;
			*p++ = vidx3;
		}
	};
}

#endif //_MeshBuilderHelper_H_

