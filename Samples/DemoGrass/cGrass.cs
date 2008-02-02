using System;
using System.Drawing;

using Math3D;
using OgreDotNet;


namespace DemoGrass
{

	public class cGrass : OgreDotNet.ExampleApplication
	{
		protected static float GRASS_HEIGHT = 300.0f;
		protected static float GRASS_WIDTH = 250.0f;
		protected static string GRASS_MESH_NAME = "grassblades";
		protected static string GRASS_MATERIAL = "Examples/GrassBlades";
		protected static uint OFFSET_PARAM =999;

		protected Light mLight = null;
		protected SceneNode mLightNode = null;
		protected AnimationState mAnimState;
		protected Color mMinLightColour = Converter.GetColor( 0.5f, 0.1f, 0.0f );
		protected Color mMaxLightColour = Converter.GetColor( 1.0f, 0.6f, 0.0f );
		protected float mMinFlareSize = 40.0f;
		protected float mMaxFlareSize = 80.0f;

		protected WaveformControllerFunction	mWFCF =null;
		protected ControllerFunctionFloatPtr	mCFFPtr =null;
		protected LightWibbler					mLightWibbler =null;
		protected ControllerValueFloatPtr		mCVFPtr =null;
		protected ControllerFloat				mLightCtlFlt;

		protected StaticGeometry mStaticGeom = null;
		protected SceneNode mpObjsNode =  null; // the node wich will hold our entities
		protected float xinc, zinc, xpos, zpos;
		protected Math3D.Vector4 xxoffset;

		protected OgreDotNet.Log	mLog;
		protected float timeDelay = 0.0f;
		protected bool mShowBBs=false;

		/// <summary>
		/// createGrassMesh2
		/// This demonstrates how to use MeshBuilderHelper class.
		/// 
		/// </summary>
		void createGrassMesh2()
		{
			mLog.LogMessage("createGrassMesh start");
			OgreDotNet.MeshBuilderHelper mbh = new MeshBuilderHelper( 
					GRASS_MESH_NAME,"General", false, 0, 12 );

			UInt32 offPos = mbh.addElement( VertexElementType.VET_FLOAT3 , VertexElementSemantic.VES_POSITION ).getOffset();
			mLog.LogMessage(string.Format("createGrassMesh offPos={0}", offPos ));

			UInt32 offNorm = mbh.addElement( VertexElementType.VET_FLOAT3 , VertexElementSemantic.VES_NORMAL ).getOffset();
			mLog.LogMessage(string.Format("createGrassMesh offNorm={0}", offNorm) );

			UInt32 offUV = mbh.addElement( VertexElementType.VET_FLOAT2 , VertexElementSemantic.VES_TEXTURE_COORDINATES ).getOffset();
			mLog.LogMessage(string.Format("createGrassMesh offUV={0}", offUV ));

			mbh.createVertexBuffer ( 12 , HardwareBuffer.Usage.HBU_STATIC_WRITE_ONLY );


			Vector3 baseVec = new Vector3(GRASS_WIDTH/2.0f, 0.0f, 0.0f);
			Vector3 vec = new Vector3(baseVec.x, baseVec.y, baseVec.z);
			Quaternion rot= Quaternion.FromAngleAxis( 60 , Vector3.UnitY);
			uint i;
			for (i = 0; i < 3; ++i)
			{
				mbh.setVertFloat( (i *4) +0, offPos, -vec.x, GRASS_HEIGHT, -vec.z );		//position
				mbh.setVertFloat( (i *4) +0, offNorm, 0.0f, 1.0f, 0.0f );					//normal
				mbh.setVertFloat( (i *4) +0, offUV, 0.0f, 0.0f );							//uv


				mbh.setVertFloat( (i *4) +1, offPos, vec.x, GRASS_HEIGHT, vec.z );			//position
				mbh.setVertFloat( (i *4) +1, offNorm, 0.0f, 1.0f, 0.0f );					//normal
				mbh.setVertFloat( (i *4) +1, offUV, 1.0f, 0.0f );							//uv


				mbh.setVertFloat( (i *4) +2, offPos, -vec.x, 0.0f, -vec.z );				//position
				mbh.setVertFloat( (i *4) +2, offNorm, 0.0f, 1.0f, 0.0f );					//normal
				mbh.setVertFloat( (i *4) +2, offUV, 0.0f, 1.0f );								//uv


				mbh.setVertFloat( (i *4) +3, offPos, vec.x, 0.0f, vec.z );					//position
				mbh.setVertFloat( (i *4) +3, offNorm, 0.0f, 1.0f, 0.0f );					//normal
				mbh.setVertFloat( (i *4) +3, offUV, 1.0f, 1.0f );							//uv

				vec = rot * vec;
			}

			mbh.createIndexBuffer (  6, HardwareIndexBuffer.IndexType.IT_16BIT, HardwareBuffer.Usage.HBU_STATIC_WRITE_ONLY);
			for (i = 0; i < 3; ++i)
			{
				UInt16 off = (UInt16)(i*4);
				mbh.setIndex16bit( (i*2) + 0,  (UInt16)(0 + off),  (UInt16)(3 + off),  (UInt16)(1 + off) );
				mbh.setIndex16bit( (i*2) + 1,  (UInt16)(0 + off),  (UInt16)(2 + off),  (UInt16)(3 + off) );
			}
			mbh.Load( GRASS_MATERIAL );
			mLog.LogMessage("createGrassMesh end");
		}

		/// <summary>
		/// createGrassMesh
		/// This demonstrates how to create a manual mesh 
		///  only use static members of MeshBuilderHelper to help set vertex and index data.
		/// </summary>
		void createGrassMesh()
		{
			OgreDotNet.MeshPtr mp = MeshManager.Instance.CreateManual( GRASS_MESH_NAME,"General" );
			SubMesh sm =  mp.Get().CreateSubMesh();
			sm.useSharedVertices = false;
			sm.vertexData = new VertexData();
			sm.vertexData.vertexStart = 0;
			sm.vertexData.vertexCount = 12;
			//mIndexType = HardwareIndexBuffer::IT_16BIT;
			
			VertexDeclaration dcl = sm.vertexData.vertexDeclaration;
			UInt32 offset = 0;

			UInt32 offPos = dcl.addElement(0, offset, VertexElementType.VET_FLOAT3, VertexElementSemantic.VES_POSITION).getOffset();
			offset = VertexElement.getTypeSize(VertexElementType.VET_FLOAT3);

			UInt32 offNorm = dcl.addElement(0, offset, VertexElementType.VET_FLOAT3, VertexElementSemantic.VES_NORMAL).getOffset();
			offset += VertexElement.getTypeSize(VertexElementType.VET_FLOAT3);
			
			UInt32 offUV = dcl.addElement(0, offset, VertexElementType.VET_FLOAT2, VertexElementSemantic.VES_TEXTURE_COORDINATES).getOffset();
			offset += VertexElement.getTypeSize(VertexElementType.VET_FLOAT2);
			
			UInt32 vertexsize = offset;
			mLog.LogMessage(string.Format("createGrassMesh vertexsize={0}", vertexsize ));
			
			HardwareVertexBufferSharedPtr vbuf = HardwareBufferManager.getSingleton().createVertexBuffer(
					vertexsize, 12, HardwareBuffer.Usage.HBU_STATIC_WRITE_ONLY);
			
			IntPtr pV = vbuf.Get().Lock(HardwareBuffer.LockOptions.HBL_DISCARD);
			
			Vector3 vec = new Vector3(GRASS_WIDTH/2.0f, 0.0f, 0.0f);
			Quaternion rot= Quaternion.FromAngleAxis( 60 , Vector3.UnitY);
			uint i;
			for (i = 0; i < 3; ++i)
			{
				OgreDotNet.MeshBuilderHelper.SetVertexFloat(pV, vertexsize, (i *4) +0, offPos, -vec.x, GRASS_HEIGHT, -vec.z );		//position
				OgreDotNet.MeshBuilderHelper.SetVertexFloat(pV, vertexsize, (i *4) +0, offNorm, 0.0f, 1.0f, 0.0f );					//normal
				OgreDotNet.MeshBuilderHelper.SetVertexFloat(pV, vertexsize, (i *4) +0, offUV, 0.0f, 0.0f );							//uv
			
				OgreDotNet.MeshBuilderHelper.SetVertexFloat(pV, vertexsize, (i *4) +1, offPos, vec.x, GRASS_HEIGHT, vec.z );		//position
				OgreDotNet.MeshBuilderHelper.SetVertexFloat(pV, vertexsize, (i *4) +1, offNorm, 0.0f, 1.0f, 0.0f );					//normal
				OgreDotNet.MeshBuilderHelper.SetVertexFloat(pV, vertexsize, (i *4) +1, offUV, 1.0f, 0.0f );							//uv
			
				OgreDotNet.MeshBuilderHelper.SetVertexFloat(pV, vertexsize, (i *4) +2, offPos, -vec.x, 0.0f, -vec.z );				//position
				OgreDotNet.MeshBuilderHelper.SetVertexFloat(pV, vertexsize, (i *4) +2, offNorm, 0.0f, 1.0f, 0.0f );					//normal
				OgreDotNet.MeshBuilderHelper.SetVertexFloat(pV, vertexsize, (i *4) +2, offUV, 0.0f, 1.0f );							//uv
			
				OgreDotNet.MeshBuilderHelper.SetVertexFloat(pV, vertexsize, (i *4) +3, offPos, vec.x, 0.0f, vec.z );				//position
				OgreDotNet.MeshBuilderHelper.SetVertexFloat(pV, vertexsize, (i *4) +3, offNorm, 0.0f, 1.0f, 0.0f );					//normal
				OgreDotNet.MeshBuilderHelper.SetVertexFloat(pV, vertexsize, (i *4) +3, offUV, 1.0f, 1.0f );							//uv
			
				vec = rot * vec;
			}
			
			vbuf.Get().Unlock();
			sm.vertexData.vertexBufferBinding.setBinding(0, vbuf);
			sm.indexData.indexCount = 6*3;
			sm.indexData.indexBuffer = HardwareBufferManager.getSingleton().createIndexBuffer(
				HardwareIndexBuffer.IndexType.IT_16BIT, 6*3, HardwareBuffer.Usage.HBU_STATIC_WRITE_ONLY );
			
			IntPtr pI = sm.indexData.indexBuffer.Get().Lock( HardwareBuffer.LockOptions.HBL_DISCARD );
			
			for (i = 0; i < 3; ++i)
			{
				UInt16 off = (UInt16)(i*4);
				OgreDotNet.MeshBuilderHelper.SetIndex16bit(pI, (i*2) + 0,  (UInt16)(0 + off),  (UInt16)(3 + off),  (UInt16)(1 + off) );
				OgreDotNet.MeshBuilderHelper.SetIndex16bit(pI, (i*2) + 1,  (UInt16)(0 + off),  (UInt16)(2 + off),  (UInt16)(3 + off) );
			}
			
			sm.indexData.indexBuffer.Get().Unlock();
			sm.SetMaterialName(GRASS_MATERIAL);
			mp.Get().Load();
		}


		void setupLighting()
		{
			/****/
			// Set ambient light
			mSceneManager.SetAmbientLight( Converter.GetColor( 0.2f, 0.2f, 0.2f ) );
			// Point light, movable, reddish
			mLight = mSceneManager.CreateLight("Light2");
			mLight.SetDiffuseColour(mMinLightColour);
			mLight.SetSpecularColour(1.0f, 1.0f, 1.0f);
			mLight.SetAttenuation(8000.0f, 1.0f, 0.0005f, 0.0f);
	
			// Create light node
			mLightNode = mSceneManager.GetRootSceneNode().CreateChildSceneNode("MovingLightNode");
			mLightNode.AttachObject(mLight);
			// create billboard set
			BillboardSet bbs = mSceneManager.CreateBillboardSet("lightbbs", 1);
			bbs.SetMaterialName("Examples/Flare");
			Billboard bb = bbs.CreateBillboard(0, 0, 0, mMinLightColour);
			// attach
			mLightNode.AttachObject(bbs);
	


			// create controller, after this is will get updated on its own
			mWFCF = new WaveformControllerFunction(WaveformType.Sine, 0.0f, 0.5f  );
			mCFFPtr = new ControllerFunctionFloatPtr( mWFCF );

			mLightWibbler = new LightWibbler( mLight, bb, mMinLightColour, mMaxLightColour, mMinFlareSize, mMaxFlareSize);
			mCVFPtr = new ControllerValueFloatPtr( mLightWibbler.mCVFH );
			
			ControllerManager contMgr = ControllerManager.GetSingleton();
			mLightCtlFlt = contMgr.CreateController( contMgr.GetFrameTimeSource(), mCVFPtr, mCFFPtr);

			mLightNode.SetPosition( new Vector3(300,250,-300));

			
			// Create a track for the light
			Animation anim = mSceneManager.CreateAnimation( "LightTrack", 20.0f);
			// Spline it for nice curves
			anim.SetInterpolationMode( Animation.InterpolationMode.Spline );
			// Create a track to animate the camera's node
			NodeAnimationTrack track = anim.CreateNodeTrack( 0, mLightNode);
			// Setup keyframes
			TransformKeyFrame key = new TransformKeyFrame(KeyFrame.getCPtr( track.CreateKeyFrame(0.0f) ).Handle,false); // A startposition
			key.SetTranslate( new Vector3(300.0f,550.0f,-300.0f));
			
			key = new TransformKeyFrame(KeyFrame.getCPtr( track.CreateKeyFrame(2.0f) ).Handle,false);//B
			key.SetTranslate( new Vector3(150.0f,600.0f,-250.0f));
			key = new TransformKeyFrame(KeyFrame.getCPtr( track.CreateKeyFrame(4.0f) ).Handle,false);//C
			key.SetTranslate( new Vector3(-150.0f,650.0f,-100.0f));
			key = new TransformKeyFrame(KeyFrame.getCPtr( track.CreateKeyFrame(6.0f) ).Handle,false);//D
			key.SetTranslate( new Vector3(-400.0f,500.0f,-200.0f));
			key = new TransformKeyFrame(KeyFrame.getCPtr( track.CreateKeyFrame(8.0f) ).Handle,false);//E
			key.SetTranslate( new Vector3(-200.0f,500.0f,-400.0f));
			key = new TransformKeyFrame(KeyFrame.getCPtr( track.CreateKeyFrame(10.0f) ).Handle,false);//F
			key.SetTranslate( new Vector3(-100.0f,450.0f,-200.0f));
			key = new TransformKeyFrame(KeyFrame.getCPtr( track.CreateKeyFrame(12.0f) ).Handle,false);//G
			key.SetTranslate( new Vector3(-100.0f,400.0f,180.0f));
			key = new TransformKeyFrame(KeyFrame.getCPtr( track.CreateKeyFrame(14.0f) ).Handle,false);//H
			key.SetTranslate( new Vector3(0.0f,250.0f,600.0f));
			key = new TransformKeyFrame(KeyFrame.getCPtr( track.CreateKeyFrame(16.0f) ).Handle,false);//I
			key.SetTranslate( new Vector3(100.0f,650.0f,100.0f));
			key = new TransformKeyFrame(KeyFrame.getCPtr( track.CreateKeyFrame(18.0f) ).Handle,false);//J
			key.SetTranslate( new Vector3(250.0f,600.0f,0.0f));
			key = new TransformKeyFrame(KeyFrame.getCPtr( track.CreateKeyFrame(20.0f) ).Handle,false);//K == A
			key.SetTranslate( new Vector3(300.0f,550.0f,-300.0f));
			// Create a new animation state to track this
			mAnimState = mSceneManager.CreateAnimationState("LightTrack");
			mAnimState.SetEnabled(true);
			/****/
		}

		protected override void CreateScene()
		{
			mLog = LogManager.Singleton.createLog("DemoGrass.log", false, true );
			mLog.LogMessage(string.Format("DemoGrass log {0}" , System.DateTime.Now ) );

			//Init waveGrass varibles
			xinc = OgreMath.PI * 0.4f;
			zinc = OgreMath.PI * 0.55f;
			xpos = OgreMath.RangeRandom( -OgreDotNet.OgreMath.PI, OgreDotNet.OgreMath.PI );
			zpos = OgreMath.RangeRandom( -OgreDotNet.OgreMath.PI, OgreDotNet.OgreMath.PI );
			xxoffset = new Math3D.Vector4(0.0f, 0.0f, 0.0f, 0.0f );


			mSceneManager.SetSkyBox( true, "Examples/SpaceSkyBox");

			setupLighting();
			mSceneManager.AmbientLightColor = Color.FromArgb(125, 125, 125, 125);
			

			//create a ground plain
			mLog.LogMessage("Point 1");
			Plane plane = new Plane();
			plane.Normal.x=0;
			plane.Normal.y=1;
			plane.Normal.z=0;
			plane.D = 0;
			MeshManager.GetSingleton().CreatePlane( "Myplane", "General" , plane,
				14500,14500,10,10,true,1,50,50,Vector3.UnitZ );
			Entity pPlaneEnt = mSceneManager.CreateEntity( "plane", "Myplane" );
			pPlaneEnt.SetMaterialName("Examples/GrassFloor");
			pPlaneEnt.SetCastShadows(false);
			mSceneManager.GetRootSceneNode().CreateChildSceneNode().AttachObject(pPlaneEnt);


			//create the grass mesh 
			mLog.LogMessage("Point 2");
			createGrassMesh2();
			Entity e=null;
			e = mSceneManager.CreateEntity("1", GRASS_MESH_NAME);


			//close the the grass mesh in a region
			StaticGeometry s = mSceneManager.CreateStaticGeometry("bing");
			s.setRegionDimensions( new Vector3(1000,1000,1000) );
			// Set the region origin so the centre is at 0 world
			s.setOrigin( new Vector3(-500, 500, -500));
			mLog.LogMessage("Point 3");
			for (int x = -1950; x < 1950; x += 150)		//1950
			{
				for (int z = -1950; z < 1950; z += 150)
				{
					Vector3 pos;
					pos.x = x + OgreMath.RangeRandom(-25, 25);
					pos.y = 0;
					pos.z = z + OgreMath.RangeRandom(-25, 25);
					Quaternion  orientation = Quaternion.FromAngleAxis(
						new Degree(OgreMath.RangeRandom(0, 359)).ValueDegrees(), Vector3.UnitY );
					Vector3 scale = new Vector3( 1, OgreMath.RangeRandom( 0.85f, 1.15f), 1);
					s.addEntity(e, pos, orientation, scale);
				}
			}
			mLog.LogMessage("Point 4");
			s.build();
			mStaticGeom = s;
			//mStaticGeom.dump("Grass.SG.Dump.txt");

			
			
			//Put an Ogre head in the middle
			mLog.LogMessage("Point 5");
			OgreDotNet.MeshPtr m = MeshManager.GetSingleton().Load( "ogrehead.mesh", "General" );
			Mesh mm = m.Get();
			UInt16 src=0, dest=0;
			if (!mm.SuggestTangentVectorBuildParams(ref src, ref dest))
			{
				mLog.LogMessage("got from SuggestTangentVectorBuildParams src=" + src + " dest=" + dest);
				mm.BuildTangentVectors( src, dest );
			}
			e = mSceneManager.CreateEntity("head", "ogrehead.mesh");
			e.SetMaterialName("Examples/OffsetMapping/Specular");
			SceneNode headNode = mSceneManager.GetRootSceneNode().CreateChildSceneNode();
			headNode.AttachObject(e);
			headNode.SetScale(7,7,7);
			headNode.SetPosition(0,200,0);
			e.SetNormaliseNormals(true);


			mLog.LogMessage("Point 6");
			//setup camera position
			mCamera.Move( new Vector3(0,350, 800) );
			mCamera.LookAt = new Vector3( 0, 200, 0 );
			mLog.LogMessage("Point end");
		}

		protected override bool FrameStarted( FrameEvent e )
		{
			if (!base.FrameStarted( e ))
				return false;
			
			if (mAnimState != null)
				mAnimState.AddTime ( e.TimeSinceLastFrame );
			
			//mShowBBs = !mShowBBs;
			//mSceneManager.ShowBoundingBoxes(mShowBBs);
			
			try 
			{
				waveGrass(e.TimeSinceLastFrame);
				//OgreDotNet.SGRegion.Test4DEMOGRASS_waveGrass( mStaticGeom, e.TimeSinceLastFrame );
			}
			catch ( Exception ex) 
			{
				Console.WriteLine( "###  Exception {0}\n{1}\n{2}", ex.Message ,ex.Source , ex.StackTrace );
			}

			return true;
		}

		protected virtual void waveGrass(float timeElapsed)
		{
			//Console.WriteLine("waveGrass:  01");
			xpos += xinc * timeElapsed;
			zpos += zinc * timeElapsed;

			// Update vertex program parameters by binding a value to each renderable

			SGRegionMapIterator rit =  mStaticGeom.GetRegionIterator();
			while (rit.hasMoreElements())
			{
				//Console.WriteLine("waveGrass:  02");
				OgreDotNet.SGRegion reg = rit.getNext();

				// a little randomness
				xpos += reg.getCentre().x * 0.001f;
				zpos += reg.getCentre().z * 0.001f;
				xxoffset.x = (float)Math.Sin( (float)xpos ) * 0.05f;
				xxoffset.z = (float)Math.Sin( (float)zpos ) * 0.05f;

				OgreDotNet.SGLODBucketVectorIterator lodit = reg.getLODIterator();
				while (lodit.hasMoreElements())
				{
					//Console.WriteLine("waveGrass:  03");
					OgreDotNet.SGLODBucket lod = lodit.getNext();
					OgreDotNet.SGMaterialBucketMapIterator matit = lod.getMaterialIterator();
					while (matit.hasMoreElements())
					{
						//Console.WriteLine("waveGrass:  04");
						OgreDotNet.SGMaterialBucket mat = matit.getNext();
						OgreDotNet.SGGeometryBucketVectorIterator geomit = mat.getGeometryIterator();
						while (geomit.hasMoreElements())
						{
							//Console.WriteLine("waveGrass:  05");
							OgreDotNet.SGGeometryBucket geom = geomit.getNext();
							geom.GetMeAsRenderable().setCustomParameter(OFFSET_PARAM, xxoffset);
						}
					}
				}
			}
			//Console.WriteLine("waveGrass:  --end--");
		}

		/// <summary>
		/// Disposes 
		/// </summary>
		public override void Dispose()
		{
			mLightNode =null;
			mLight =null;
			mpObjsNode =null;
			mStaticGeom =null;
			mAnimState =null;
			
			mSceneManager.ClearScene();
			
			mLightWibbler.Dispose();
			mLightWibbler =null;
			//ControllerManager contMgr = ControllerManager.GetSingleton();
			//contMgr.DestroyController( mLightCtlFlt );
			mLightCtlFlt =null;
			mWFCF =null;
			mCFFPtr =null;
			mCVFPtr =null;
			
			mLog.Dispose();
			mLog=null;
			
			//GC.Collect();
			base.Dispose();
		}


		[STAThread]
		static void Main(string[] args)
		{
			cGrass app = new cGrass();
			try 
			{
				app.Start();
			}
			catch ( Exception ex)
			{
				Console.WriteLine( "###  Exception {0}\n{1}\n{2}", ex.Message ,ex.Source , ex.StackTrace );
			}
			finally 
			{
				try 
				{
					app.Dispose();
				}
				catch ( Exception ex)
				{
					Console.WriteLine( "###  Exception {0}\n{1}\n{2}", ex.Message ,ex.Source , ex.StackTrace );
				}
			}
		}
	}
}
