using System;
using System.Collections;
using System.Xml;
using System.Drawing;

using Math3D;
using OgreDotNet;

namespace DemoCustomObjects
{
	
	class myBillBoardChainElement : IDisposable
	{
		public Math3D.Vector3 position;
		public float width;
		public float uTexCoord;
		public System.Drawing.Color colour;
		
		public myBillBoardChainElement()
		{
			position = Math3D.Vector3.Zero;
			width = 0.0f;
			uTexCoord = 0.0f;
			colour = Converter.GetColor(1.0f,1.0f,1.0f);
		}
		
		public myBillBoardChainElement(Math3D.Vector3 pos, float w, float u, System.Drawing.Color c)
		{
			position = pos;
			width = w;
			uTexCoord = u;
			colour = c;
		}
		
		
		public virtual void Dispose()
		{
		}
		
	}
	
	
	class myBillBoardChain : SimpleRenderableDirector
	{
		protected const ushort POSITION_BINDING      = 0;
		protected const ushort DIFFUSE_COLOR_BINDING = 1;
		protected const ushort TEXCOORD_BINDING      = 2;

		protected float mRadius;
		protected int mMaxNbChainElements;

		protected Camera mCamera=null;
		protected ArrayList mChainElementList=null;
		protected VertexData mVD=null;

		//for pVertexBuffer
		protected UInt32 mVBPostOff=0, mVBVertexSize=0;

		//for pVertexColorBuffer
		protected UInt32 mVCBrgbaOff=0, mVCBVertexSize=0;

		//for pTexCoordBuffer
		protected UInt32 mTCBuvOff=0, mTCVertexSize=0;


		#region constructor / destructor
		public myBillBoardChain(Camera vCamera, int maxNbChainElements) : base() 
		{

			Init_Event_NotifyCurrentCamera();
			Init_Event_GetSquaredViewDepth();
			Init_Event_GetBoundingRadius();

			evtNotifyCurrentCamera += new SRD_Delegate_notifyCurrentCamera( event_notifyCurrentCamera );
			evtGetSquaredViewDepth += new SRD_Delegate_getSquaredViewDepth( event_getSquaredViewDepth );
			evtGetBoundingRadius += new SRD_Delegate_getBoundingRadius( event_getBoundingRadius );

			mCamera = vCamera;
			mChainElementList = new ArrayList();

			mRadius = 0.0f;
			mMaxNbChainElements = maxNbChainElements;
			
			mVD = new VertexData();
			this.RO_VertexData = mVD;
			this.RO_IndexData = null;
			
			mVD.vertexCount = (uint)0;
			mVD.vertexStart = 0;
			this.RO_OperationType = OperationType.OT_TRIANGLE_STRIP;
			this.RO_UseIndexes = false;

			mVBPostOff=0;   mVBVertexSize=0;
			mVCBrgbaOff=0;  mVCBVertexSize=0;
			mTCBuvOff=0;    mTCVertexSize=0;

			//----------
			// Add a description for the buffer of the positions of the vertices
			mVBPostOff = mVD.vertexDeclaration.addElement( POSITION_BINDING, 0, VertexElementType.VET_FLOAT3, VertexElementSemantic.VES_POSITION).getOffset();
			mVBVertexSize += VertexElement.getTypeSize(VertexElementType.VET_FLOAT3);
			// Create the buffer
			HardwareVertexBufferSharedPtr pVertexBuffer = HardwareBufferManager.getSingleton().createVertexBuffer(
						mVD.vertexDeclaration.getVertexSize(POSITION_BINDING),
						(uint)(mMaxNbChainElements * 2),
						HardwareBuffer.Usage.HBU_STATIC_WRITE_ONLY);
			// Bind the buffer
			mVD.vertexBufferBinding.setBinding(POSITION_BINDING, pVertexBuffer);

			//----------
			// Add a description for the buffer of the diffuse color of the vertices
			mVCBrgbaOff = mVD.vertexDeclaration.addElement(DIFFUSE_COLOR_BINDING, 0, VertexElementType.VET_FLOAT4, VertexElementSemantic.VES_DIFFUSE).getOffset();
			mVCBVertexSize += VertexElement.getTypeSize(VertexElementType.VET_FLOAT4);
			// Create the buffer
			HardwareVertexBufferSharedPtr pVertexColorBuffer = HardwareBufferManager.getSingleton().createVertexBuffer(
						mVD.vertexDeclaration.getVertexSize(DIFFUSE_COLOR_BINDING),
						(uint)(mMaxNbChainElements * 2),
						HardwareBuffer.Usage.HBU_STATIC_WRITE_ONLY);
			// Bind the buffer
			mVD.vertexBufferBinding.setBinding( DIFFUSE_COLOR_BINDING, pVertexColorBuffer);

			//----------
			// Add a description for the buffer of the texture coordinates of the vertices
			mTCBuvOff = mVD.vertexDeclaration.addElement( TEXCOORD_BINDING, 0, VertexElementType.VET_FLOAT2, VertexElementSemantic.VES_TEXTURE_COORDINATES).getOffset();
			mTCVertexSize += VertexElement.getTypeSize(VertexElementType.VET_FLOAT2);
			// Create the buffer
			HardwareVertexBufferSharedPtr pTexCoordBuffer =	HardwareBufferManager.getSingleton().createVertexBuffer(
						mVD.vertexDeclaration.getVertexSize(TEXCOORD_BINDING),
						(uint)(mMaxNbChainElements * 2),
						HardwareBuffer.Usage.HBU_STATIC_WRITE_ONLY);
			// Bind the buffer
			mVD.vertexBufferBinding.setBinding(TEXCOORD_BINDING, pTexCoordBuffer);


			// set basic white material
			this.setMaterial( "BaseWhiteNoLighting" );
		}
		~myBillBoardChain()
		{
			this.Dispose();
		}

		public override void Dispose()
		{
			if (mChainElementList !=null)
				mChainElementList.Clear();
			mChainElementList=null;

			if (mVD !=null)
			{
				{// in a new scope so the GC will collect befor we call mVD.Dispose
					mVD.vertexBufferBinding.unsetBinding( POSITION_BINDING );
					mVD.vertexBufferBinding.unsetBinding( DIFFUSE_COLOR_BINDING );
					mVD.vertexBufferBinding.unsetBinding( TEXCOORD_BINDING );
				}
				mVD.Dispose();
			}
			mVD = null;

			base.Dispose();
		}
		#endregion
		
		public virtual void  event_notifyCurrentCamera(Camera cam)
		{
			this.CallBase_notifyCurrentCamera(cam);
			updateHardwareBuffers();
		}

		public virtual float event_getSquaredViewDepth(Camera cam)
		{
			Vector3 min, max, mid, dist;
			AxisAlignedBox box = this.CallBase_getBoundingBox();
			min = box.GetMinimum();
			max = box.GetMaximum();
			mid = ((max - min) * 0.5f) + min;
			dist = cam.GetDerivedPosition() - mid;
			
			return dist.LengthSquared;
		}

		public virtual float event_getBoundingRadius()
		{
			return mRadius;
		}



		public void addChainElement( myBillBoardChainElement e)
		{
			mChainElementList.Add( e );
		}
		
		public myBillBoardChainElement getChainElement(int index)
		{
			return (myBillBoardChainElement)mChainElementList[index];
		}
		
		public int getNumChainElement() 
		{
			return mChainElementList.Count;
		}
		
		public void updateChainElement(int index, myBillBoardChainElement e)
		{
			mChainElementList[index] = e;
		}
		
		public void deleteChainElement(int index)
		{
			mChainElementList.RemoveAt( index );
		}
		
		public void insertChainElement(int index, myBillBoardChainElement e)
		{
			mChainElementList.Insert( index , e);
		}



		public void updateBoundingBox()
		{
			if (mChainElementList.Count < 2)
				return;

			float width = ((myBillBoardChainElement)mChainElementList[0]).width;
			Vector3 widthVector = new Vector3( width, width, width);
			Vector3 position = ((myBillBoardChainElement)mChainElementList[0]).position;
			Vector3 minimum = position - widthVector;
			Vector3 maximum = position + widthVector;

			for (int i = 1; i < mChainElementList.Count; i++)
			{
				// Update the bounds of the bounding box
				width = ((myBillBoardChainElement)mChainElementList[i]).width;
				widthVector = new Vector3(width, width, width);
				position = ((myBillBoardChainElement)mChainElementList[i]).position;
				minimum.Floor( (position - widthVector) );
				maximum.Ceil( (position + widthVector) );
			}

			// Set the current bounding box
			//this.setBoundingBox( new AxisAlignedBox( minimum, maximum ) );
			AxisAlignedBox box = this.CallBase_getBoundingBox();
			box.SetMinimum( minimum.x, minimum.y, minimum.z );
			box.SetMaximum( maximum.x, maximum.y, maximum.z );

			// Set the current radius
			mRadius = (float)Math.Sqrt( Math.Max( (double)minimum.LengthSquared, (double)maximum.LengthSquared ) );
		}
		
		protected void updateHardwareBuffers()
		{
			if (mChainElementList.Count < 2)
				return;

			// Here. we need to compute the position of the camera in the coordinate system of the billboard chain.
			Vector3 eyePos = this.ParentNode._getDerivedOrientation().Inverse() *
			(mCamera.GetDerivedPosition() - this.ParentNode._getDerivedPosition());

			IntPtr ptrBuff;
			uint buffIdx=0;
			int chainSize = mChainElementList.Count;
			mVD.vertexCount = (uint)chainSize * 2;

			// Setup the vertex coordinates
			HardwareVertexBufferSharedPtr pPosBuffer = mVD.vertexBufferBinding.getBuffer(POSITION_BINDING);
			ptrBuff = pPosBuffer.Get().Lock( HardwareBuffer.LockOptions.HBL_DISCARD );
			// Compute the position of the vertices in the chain
			for (int i = 0; i < chainSize; i++)
			{
				myBillBoardChainElement bbe = (myBillBoardChainElement)mChainElementList[i];
				Vector3 chainTangent;
				if (i == 0)
					chainTangent = bbe.position - ((myBillBoardChainElement)mChainElementList[0]).position;
				else if (i == chainSize - 1)
					chainTangent = ((myBillBoardChainElement)mChainElementList[chainSize - 1]).position -
						((myBillBoardChainElement)mChainElementList[chainSize - 2]).position;
				else
					chainTangent = ((myBillBoardChainElement)mChainElementList[i + 1]).position - 
						((myBillBoardChainElement)mChainElementList[i - 1]).position;

				Vector3 p1 = bbe.position;

				Vector3 vP1ToEye = eyePos - p1;
				Vector3 vPerpendicular = chainTangent.Cross(vP1ToEye);
				vPerpendicular.Normalize();
				vPerpendicular *=bbe.width;

				Vector3 pos0 = p1 - vPerpendicular;
				Vector3 pos1 = p1 + vPerpendicular;

				// Update the buffer with the 2 vertex positions
				MeshBuilderHelper.SetVertexFloat( ptrBuff, mVBVertexSize, buffIdx++, mVBPostOff, 
					pos0.x, pos0.y, pos0.z );
				MeshBuilderHelper.SetVertexFloat( ptrBuff, mVBVertexSize, buffIdx++, mVBPostOff, 
					pos1.x, pos1.y, pos1.z );
			}
			pPosBuffer.Get().Unlock ();
			

			// Setup the diffuse color of the vertex
			HardwareVertexBufferSharedPtr pVertexColorBuffer = mVD.vertexBufferBinding.getBuffer(DIFFUSE_COLOR_BINDING);
			ptrBuff = pVertexColorBuffer.Get().Lock( HardwareBuffer.LockOptions.HBL_DISCARD);
			buffIdx=0;
			for (int i = 0; i < chainSize; i++)
			{
				Color col = ((myBillBoardChainElement)mChainElementList[i]).colour;

				MeshBuilderHelper.SetVertexFloat( ptrBuff, mVCBVertexSize, buffIdx++, mVCBrgbaOff, 
					((float)col.R / 255.0f), ((float)col.G / 255.0f), ((float)col.B / 255.0f), ((float)col.A / 255.0f));
				MeshBuilderHelper.SetVertexFloat( ptrBuff, mVCBVertexSize, buffIdx++, mVCBrgbaOff, 
					((float)col.R / 255.0f), ((float)col.G / 255.0f), ((float)col.B / 255.0f), ((float)col.A / 255.0f));

			}
			pVertexColorBuffer.Get().Unlock ();
			

			// Setup the texture coordinates
			HardwareVertexBufferSharedPtr pTexCoordBuffer = mVD.vertexBufferBinding.getBuffer(TEXCOORD_BINDING);
			ptrBuff = pTexCoordBuffer.Get().Lock (HardwareBuffer.LockOptions.HBL_DISCARD );

			buffIdx=0;
			for (int i = 0; i < chainSize; i++)
			{
				myBillBoardChainElement bbe = (myBillBoardChainElement)mChainElementList[i];

				MeshBuilderHelper.SetVertexFloat( ptrBuff, mTCVertexSize, buffIdx++, mTCBuvOff, 
					bbe.uTexCoord, 0.0f );
				MeshBuilderHelper.SetVertexFloat( ptrBuff, mTCVertexSize, buffIdx++, mTCBuvOff, 
					bbe.uTexCoord, 1.0f );

			}
			pTexCoordBuffer.Get().Unlock ();
		}
	}
	
}