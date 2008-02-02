using System;
using System.Collections;
using System.Xml;
using System.Drawing;

using Math3D;
using OgreDotNet;

namespace DemoCustomObjects
{
	/// <summary>
	/// Summary description for myLine3D.
	/// </summary>
	public class myLine3D : SimpleRenderableDirector
	{
		protected const ushort POSITION_BINDING      = 0;

		protected ArrayList mPoints=null;
		protected bool mDrawn;
		protected uint mVertexBufferCapacity;

		protected UInt32 offPos=0, mVertexSize=0;
		protected VertexData mVD=null;

		#region constructor / destructor
		public myLine3D()
		{
			Init_Event_GetSquaredViewDepth();
			Init_Event_GetBoundingRadius();
			Init_Event_GetWorldOrientation();
			Init_Event_GetWorldPosition();

			evtGetSquaredViewDepth += new SRD_Delegate_getSquaredViewDepth( event_getSquaredViewDepth );
			evtGetBoundingRadius += new SRD_Delegate_getBoundingRadius( event_getBoundingRadius );
			evtGetWorldOrientation += new SRD_Delegate_getWorldOrientation( event_getWorldOrientation );
			evtGetWorldPosition += new SRD_Delegate_getWorldPosition( event_getWorldPosition );
			
			mPoints = new ArrayList();
			mVD = new VertexData();
			this.RO_VertexData = mVD;

			mDrawn = false;
			mVertexBufferCapacity=0;

			this.setMaterial("BaseWhiteNoLighting");
		}

		~myLine3D()
		{
			this.Dispose();
		}

		public override void Dispose()
		{
			if (mPoints !=null) 
				mPoints.Clear();
            mPoints=null;

			if (mVD !=null)
			{
				{// in a new scope so the GC will collect befor we call mVD.Dispose
					mVD.vertexBufferBinding.unsetBinding( POSITION_BINDING );
				}
				mVD.Dispose();
			}
			mVD = null;

			base.Dispose();
		}
		#endregion


		public void addPoint(Math3D.Vector3 p)
		{
			mPoints.Add(p);
		}

		public Math3D.Vector3 getPoint(int index)
		{
			return (Math3D.Vector3)mPoints[index];
		}

		public int getNumPoints() 
		{
			return mPoints.Count;
		}

		public void updatePoint(int index, Math3D.Vector3 v)
		{
			mPoints[index] = v;
		}

		public void deletePoint(int index)
		{
			mPoints.RemoveAt( index );
		}

		public void insertPoint(int index,  Math3D.Vector3 p)
		{
			mPoints.Insert( index , p);
		}


		public void drawLine(Math3D.Vector3 start, Math3D.Vector3 end)
		{
			if( mPoints.Count > 0)
				mPoints.Clear();
			
			mPoints.Add( start );
			mPoints.Add( end );
			
			drawLines();
		}

		public void drawLines()
		{
			//resizeing code adapted from 
			//http://www.ogre3d.org/wiki/index.php/DynamicGrowingBuffers
			HardwareVertexBufferSharedPtr vbuf;
			uint newVertCapacity = mVertexBufferCapacity;

			if(!mDrawn)
			{
				mDrawn = true;
				mVertexBufferCapacity = 0;
				newVertCapacity = 1;

				// Make capacity the next power of two
				while (newVertCapacity < mPoints.Count)
					newVertCapacity <<= 1;
				mVertexBufferCapacity = newVertCapacity;

				// Initialization stuff
				this.RO_IndexData = null;
				this.RO_UseIndexes = false;

				mVD.vertexCount = (uint)mPoints.Count;
				mVD.vertexStart = 0;
				this.RO_OperationType = OperationType.OT_LINE_STRIP; // OT_LINE_LIST, OT_LINE_STRIP

				offPos =mVD.vertexDeclaration.addElement(
					POSITION_BINDING, 0, VertexElementType.VET_FLOAT3, VertexElementSemantic.VES_POSITION).getOffset();

				mVertexSize = VertexElement.getTypeSize(VertexElementType.VET_FLOAT3);
				
				vbuf = HardwareBufferManager.getSingleton().createVertexBuffer(
					mVD.vertexDeclaration.getVertexSize(POSITION_BINDING),
					mVertexBufferCapacity,
					HardwareBuffer.Usage.HBU_STATIC_WRITE_ONLY);

				mVD.vertexBufferBinding.setBinding(POSITION_BINDING, vbuf);
			}


			if ( (mPoints.Count > mVertexBufferCapacity) ||
				(mVertexBufferCapacity==0) )
			{
				// vertexCount exceeds current capacity!
				// It is necessary to reallocate the buffer.

				// Check if this is the first call... should never happen(we have mDrawn flag check)
				if (newVertCapacity ==0)
					newVertCapacity = 1;

				// Make capacity the next power of two
				while (newVertCapacity < mPoints.Count)
					newVertCapacity <<= 1;
			}
			else if (mPoints.Count < (mVertexBufferCapacity>>1) ) 
			{
				// Make capacity the previous power of two
				while (mPoints.Count < (newVertCapacity>>1))
					newVertCapacity >>= 1;
			}
			if (newVertCapacity != mVertexBufferCapacity) 
			{
				mVertexBufferCapacity = newVertCapacity;
				mVD.vertexCount = mVertexBufferCapacity;

				// Create new vertex buffer
				vbuf = HardwareBufferManager.getSingleton().createVertexBuffer(
					mVD.vertexDeclaration.getVertexSize(POSITION_BINDING),
					mVertexBufferCapacity,
					HardwareBuffer.Usage.HBU_STATIC_WRITE_ONLY);
				
				//the old buffer will automatically be deleted once no more references to it exist
				//http://www.ogre3d.org/phpBB2/viewtopic.php?t=13058&highlight=vertexbuffer+update
				
				// Bind buffer
				mVD.vertexBufferBinding.setBinding(POSITION_BINDING, vbuf);
			}
			else
			{	//we need to set vbuf
				vbuf = mVD.vertexBufferBinding.getBuffer(POSITION_BINDING);
			}
			// Update vertex count in the render operation
			mVD.vertexCount = (uint)mPoints.Count;


			// Drawing stuff
			int size = mPoints.Count;
			Vector3 vaabMin = (Math3D.Vector3)mPoints[0];
			Vector3 vaabMax = (Math3D.Vector3)mPoints[0];
			
			IntPtr ptrBuff = vbuf.Get().Lock( HardwareBuffer.LockOptions.HBL_DISCARD );
			
			for(int i = 0; i<size; i++)
			{
				MeshBuilderHelper.SetVertexFloat( ptrBuff, mVertexSize, (uint)i , offPos , 
					((Math3D.Vector3)mPoints[i]).x, 
					((Math3D.Vector3)mPoints[i]).y, 
					((Math3D.Vector3)mPoints[i]).z );

			
				if( ((Math3D.Vector3)mPoints[i]).x < vaabMin.x)
					vaabMin.x = ((Math3D.Vector3)mPoints[i]).x;
				if( ((Math3D.Vector3)mPoints[i]).y < vaabMin.y)
					vaabMin.y = ((Math3D.Vector3)mPoints[i]).y;
				if( ((Math3D.Vector3)mPoints[i]).z < vaabMin.z)
					vaabMin.z = ((Math3D.Vector3)mPoints[i]).z;
			
				if( ((Math3D.Vector3)mPoints[i]).x > vaabMax.x)
					vaabMax.x = ((Math3D.Vector3)mPoints[i]).x;
				if( ((Math3D.Vector3)mPoints[i]).y > vaabMax.y)
					vaabMax.y = ((Math3D.Vector3)mPoints[i]).y;
				if( ((Math3D.Vector3)mPoints[i]).z > vaabMax.z)
					vaabMax.z = ((Math3D.Vector3)mPoints[i]).z;
			}
			
			vbuf.Get().Unlock();

			AxisAlignedBox box = this.CallBase_getBoundingBox();
			box.SetExtents(vaabMin, vaabMax);
		}
		
		public virtual float event_getSquaredViewDepth( Camera cam) 
		{
			float ret=0.0f;
			Vector3 vMin, vMax, vMid, vDist;
			AxisAlignedBox box = this.CallBase_getBoundingBox();
			vMin = box.GetMinimum();
			vMax = box.GetMaximum();
			vMid = ((vMin - vMax) * 0.5f) + vMin;
			vDist = cam.GetDerivedPosition() - vMid;
			
			ret = vDist.LengthSquared;
			
			return ret;
		}

		public virtual float event_getBoundingRadius()
		{
			float ret=0.0f;
			AxisAlignedBox box = this.CallBase_getBoundingBox();
			ret = (float)Math.Sqrt( 
				Math.Max( (double)box.GetMaximum().LengthSquared, (double)box.GetMinimum().LengthSquared ) 
				);
			
			return ret;
		}

		public virtual Math3D.Quaternion event_getWorldOrientation() 
		{
			return Quaternion.Identity;
		}

		public virtual Math3D.Vector3 event_getWorldPosition() 
		{
			return Math3D.Vector3.Zero;
		}
	}
}
