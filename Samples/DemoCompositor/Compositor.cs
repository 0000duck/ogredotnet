using System;
using System.Collections;
using System.Drawing;

using Math3D;
using OgreDotNet;
using CeguiDotNet;
using OgreDotNet.Cegui;


namespace DemoCompositor
{
	class cDemoCompositor : OgreDotNet.ExampleApplication
	{
		#region class members 

		protected float MINSPEED =0.150f;
		protected float MOVESPEED =30.0f;
		protected float MAXSPEED =1.800f;

		protected OgreDotNet.Log	mLog;
		protected OgreCEGUIRenderer mGuiRenderer = null;
		protected GuiSystem mGuiSystem = null;

		protected SceneNode                 mMainNode;
		protected SceneNode                 mSpinny;
		protected HeatVisionListener        mhvListener;
		protected HDRListener               mhdrListener;
		protected ItemSelectorViewManager   mCompositorSelectorViewManager;

		protected CeguiDotNet.Window    mGuiAvg;
		protected CeguiDotNet.Window    mGuiCurr;
		protected CeguiDotNet.Window    mGuiBest;
		protected CeguiDotNet.Window    mGuiWorst;
		protected CeguiDotNet.Window    mGuiTris;
		protected CeguiDotNet.Window    mGuiDbg;
		protected CeguiDotNet.Window    mGuiRoot;
		protected CeguiDotNet.Listbox        mDebugRTTListbox;
		protected CeguiDotNet.StaticImage    mDebugRTTStaticImage;
		protected ArrayList                  mDebugRTTImageSets;
		protected CeguiDotNet.PushButton mGuiBtnQuit=null;

		#endregion

		#region class init and dispose

		public cDemoCompositor()
		{
			mDebugRTTImageSets = new ArrayList();
		}

		public override void Dispose()
		{
			foreach (CeguiDotNet.Imageset imgset in mDebugRTTImageSets)
			{
				CeguiDotNet.ImagesetManager.getSingleton().destroyImageset( imgset );
			}
			mDebugRTTImageSets.Clear();
			mDebugRTTImageSets = null;


			mMainNode =null;
			mSpinny =null;
			mhvListener.Dispose();
			mhvListener=null;
			mhdrListener.Dispose();
			mhdrListener = null;
			mCompositorSelectorViewManager = null;


			mGuiAvg   = null;
			mGuiCurr  = null;
			mGuiBest  = null;
			mGuiWorst = null;
			mGuiTris  = null;
			mGuiDbg   = null;
			mGuiRoot  = null;
			mDebugRTTListbox = null;
			mDebugRTTImageSets =null;



			if (WindowManager.Instance !=null)
				WindowManager.Instance.destroyAllWindows();
			if (mGuiSystem !=null)
				mGuiSystem.Dispose();
			mGuiSystem = null;
			if (mGuiRenderer !=null)
				mGuiRenderer.Dispose();
			mGuiRenderer = null;

			if (mLog !=null)
				mLog.Dispose();
			mLog=null;

			base.Dispose();
		}

		#endregion

		#region OverRidden ExampleApp Init stuff

		protected override void CreateCamera()
		{
			mCamera = this.mSceneManager.CreateCamera("MainCamera");
			mCamera.SetPosition( 0, 0, 0 );
			mCamera.LookAt = new Vector3(0,0,-300);
			mCamera.NearClipDistance = 1;
		}

		protected override void CreateScene()
		{
			mLog = LogManager.Singleton.createLog("DemoCompositor.log", false, true );
			mLog.LogMessage(string.Format("DemoCompositor log {0}" , System.DateTime.Now ) );
			this.DebugOverlayVisible = false;

			mSceneManager.SetShadowTechnique( ShadowTechnique.ShadowTypeTextureModulative );
			mSceneManager.SetShadowFarDistance(1000.0f);
			
			// setup GUI system
			mGuiRenderer = new OgreCEGUIRenderer( mRenderWindow ,
				(byte)RenderQueueGroupID.RENDER_QUEUE_OVERLAY,
				false, 3000, mSceneManager );
			mGuiRenderer.Initialise();	//tell the CeguiNet proxy class the IntPtr to the CPP object

			// load scheme and set up defaults
			mGuiSystem = new GuiSystem(  mGuiRenderer ,  (CeguiDotNet.ScriptModule)null,
				(CeguiDotNet.ResourceProvider)null, "CompositorDemoCegui.config" );

			mGuiSystem.SetDefaultMouseCursor( "TaharezLook", "MouseArrow" );

			OgreDotNet.MovableObject.setDefaultVisibilityFlags( 0x00000001 );



			// Set ambient light
			mSceneManager.SetAmbientLight( Converter.GetColor( 0.3f, 0.3f, 0.2f) );

			Light l = mSceneManager.CreateLight("Light2");
			Vector3 dir = new Vector3(-1.0f,-1.0f,0.0f);
			dir.Normalize();
			l.Type = Light.LightTypes.Directional;
			l.Direction = dir;
			l.SetDiffuseColour( 1.0f, 1.0f, 0.8f);
			l.SetSpecularColour(1.0f, 1.0f, 1.0f);


			Entity pEnt;

			// House
			pEnt = mSceneManager.CreateEntity( "1", "tudorhouse.mesh" );
			SceneNode n1 = mSceneManager.GetRootSceneNode().CreateChildSceneNode( new Vector3(350.0f, 450.0f, -200.0f));
			n1.AttachObject( pEnt );

			pEnt = mSceneManager.CreateEntity( "2", "tudorhouse.mesh" );
			SceneNode n2 = mSceneManager.GetRootSceneNode().CreateChildSceneNode( new Vector3(-350.0f, 450.0f, -200.0f));
			n2.AttachObject( pEnt );

			pEnt = mSceneManager.CreateEntity( "3", "knot.mesh" );
			mSpinny = mSceneManager.GetRootSceneNode().CreateChildSceneNode( new Vector3(0.0f, 0.0f, 300.0f));
			mSpinny.AttachObject( pEnt );
			pEnt.SetMaterialName("Examples/MorningCubeMap");

			mSceneManager.SetSkyBox(true, "Examples/MorningSkyBox");


			Plane plane=new Plane();
			plane.Normal = OgreVector3.FromVector3(Math3D.Vector3.UnitY );
			plane.D = 100.0f;
			MeshPtr m = MeshManager.Instance.CreatePlane( "Myplane",
				ResourceGroupManager.DEFAULT_RESOURCE_GROUP_NAME, plane,
				1500.0f, 1500.0f, 10, 10, true, 1, 5.0f, 5.0f, Vector3.UnitZ );
			Entity pPlaneEnt = mSceneManager.CreateEntity( "plane", "Myplane" );
			pPlaneEnt.SetMaterialName("Examples/Rockwall");
			pPlaneEnt.SetCastShadows(false);
			mSceneManager.GetRootSceneNode().CreateChildSceneNode().AttachObject(pPlaneEnt);
			m.SetNull();
			m=null;

			mCamera.SetPosition( -400.0f, 50.0f, 900.0f);
			mCamera.LookAt = new Vector3(0.0f,80.0f,0.0f);

			connectMainEventHandlers();

			/// Create a couple of hard coded postfilter effects as an example of how to do it
			/// but the preferred method is to use compositor scripts.
			createEffects();

		}
		
		protected override void CreateEventHandler()
		{
			//this function can be used as an equivalent to C++ FrameListener constructor or the App.CreateFrameListener
			base.CreateEventHandler();
			
			mGuiAvg   = WindowManager.Instance.getWindow("OPAverageFPS");
			mGuiCurr  = WindowManager.Instance.getWindow("OPCurrentFPS");
			mGuiBest  = WindowManager.Instance.getWindow("OPBestFPS");
			mGuiWorst = WindowManager.Instance.getWindow("OPWorstFPS");
			mGuiTris  = WindowManager.Instance.getWindow("OPTriCount");
			mGuiDbg   = WindowManager.Instance.getWindow("OPDebugMsg");
			mGuiRoot  = WindowManager.Instance.getWindow("root");

			registerCompositors();
			initDebugRTTWindow();
			connectEventHandlers();
		}
		
		#endregion
		
		#region Other Scene Init stuff

		protected void connectEventHandlers()
		{
			//multi Inheritor problem 
			CeguiDotNet.Window w = WindowManager.Instance.getWindow("ExitDemoBtn");
			mGuiBtnQuit = new PushButton( Window.getCPtr(w).Handle, false );
			mGuiBtnQuit.SubscribeEvents();
			mGuiBtnQuit.Clicked += new WindowEventDelegate( handelQuit);
		}
		
		
		protected void createEffects()
		{
			//Separated for more clarity.
			createEffectMotionBlur();
			createEffectHeatVision();
		}
		
		
		protected void createEffectMotionBlur()
		{
			/// Motion blur effect
			CompositorPtr comp3 = new CompositorPtr( ResourcePtr.getCPtr(CompositorManager.Instance.GetAsResourceManager().Create( 
				"Motion Blur", ResourceGroupManager.DEFAULT_RESOURCE_GROUP_NAME )).Handle, false);
            CompositionTechnique t = comp3.Get().createTechnique();
			{
				CTTextureDefinition def = t.CreateTextureDefinition("scene");
				def.setWidth( 0);
				def.setHeight( 0);
				def.setFormat( PixelFormat.PF_R8G8B8 );
			}
			{
				CTTextureDefinition def = t.CreateTextureDefinition("sum");
				def.setWidth( 0);
				def.setHeight( 0);
				def.setFormat( PixelFormat.PF_R8G8B8 );
			}
			{
				CTTextureDefinition def = t.CreateTextureDefinition("temp");
				def.setWidth( 0);
				def.setHeight( 0);
				def.setFormat( PixelFormat.PF_R8G8B8 );
			}
			/// Render scene
			{
				CompositionTargetPass tp = t.createTargetPass();
				tp.setInputMode( CompositionTargetPass.InputMode.IM_PREVIOUS );
				tp.SetOutputName("scene");
			}
			/// Initialisation pass for sum texture
			{
				CompositionTargetPass tp = t.createTargetPass();
				tp.setInputMode( CompositionTargetPass.InputMode.IM_PREVIOUS );
				tp.SetOutputName("sum");
				tp.setOnlyInitial(true);
			}
			/// Do the motion blur
			{
				CompositionTargetPass tp = t.createTargetPass();
				tp.setInputMode( CompositionTargetPass.InputMode.IM_NONE );
				tp.SetOutputName("temp");
				{
					CompositionPass pass = tp.createPass();
					pass.setType( CompositionPass.PassType.PT_RENDERQUAD);
					pass.setMaterialName("Ogre/Compositor/Combine");
					pass.setInput(0, "scene");
					pass.setInput(1, "sum");
				}
			}
			/// Copy back sum texture
			{
				CompositionTargetPass tp = t.createTargetPass();
				tp.setInputMode( CompositionTargetPass.InputMode.IM_NONE);
				tp.SetOutputName("sum");
				{
					CompositionPass pass = tp.createPass();
					pass.setType(CompositionPass.PassType.PT_RENDERQUAD);
					pass.setMaterialName("Ogre/Compositor/Copyback");
					pass.setInput(0, "temp");
				}
			}
			/// Display result
			{
				CompositionTargetPass tp = t.getOutputTargetPass();
				tp.setInputMode(CompositionTargetPass.InputMode.IM_NONE);
				{
					CompositionPass pass = tp.createPass();
					pass.setType(CompositionPass.PassType.PT_RENDERQUAD);
					pass.setMaterialName("Ogre/Compositor/MotionBlur");
					pass.setInput(0, "sum");
				}
			}
		}


		protected void createEffectHeatVision()
		{
			/// Heat vision effect
			CompositorPtr comp4 = new CompositorPtr( ResourcePtr.getCPtr(CompositorManager.Instance.GetAsResourceManager().Create(
					"Heat Vision", ResourceGroupManager.DEFAULT_RESOURCE_GROUP_NAME )).Handle, false);
				CompositionTechnique t = comp4.Get().createTechnique();
				{
					CTTextureDefinition def = t.CreateTextureDefinition("scene");
					def.setWidth( 256);
					def.setHeight( 256);
					def.setFormat( OgreDotNet.PixelFormat.PF_R8G8B8 );
				}
				{
					CTTextureDefinition def = t.CreateTextureDefinition("temp");
					def.setWidth( 256);
					def.setHeight( 256);
					def.setFormat( OgreDotNet.PixelFormat.PF_R8G8B8 );
				}
				/// Render scene
				{
					CompositionTargetPass tp = t.createTargetPass();
					tp.setInputMode( CompositionTargetPass.InputMode.IM_PREVIOUS);
					tp.SetOutputName("scene");
				}
				/// Light to heat pass
				{
					CompositionTargetPass tp = t.createTargetPass();
					tp.setInputMode( CompositionTargetPass.InputMode.IM_NONE);
					tp.SetOutputName("temp");
					{
						CompositionPass pass = tp.createPass();
						pass.setType( CompositionPass.PassType.PT_RENDERQUAD);
						pass.setIdentifier( 0xDEADBABE ); /// Identify pass for use in listener
						pass.setMaterialName( "Fury/HeatVision/LightToHeat");
						pass.setInput(0, "scene");
					}
				}
				/// Display result
				{
					CompositionTargetPass tp = t.getOutputTargetPass();
					tp.setInputMode( CompositionTargetPass.InputMode.IM_NONE);
					{
						CompositionPass pass = tp.createPass();
						pass.setType( CompositionPass.PassType.PT_RENDERQUAD);
						pass.setMaterialName("Fury/HeatVision/Blur");
						pass.setInput(0, "temp");
					}
				}
		}

		protected void registerCompositors()
		{
			Viewport vp = mRenderWindow.GetViewport(0);
			mhvListener = new HeatVisionListener();
			mhdrListener = new HDRListener();

			mCompositorSelectorViewManager = new ItemSelectorViewManager("CompositorSelectorWin");
			// tell view manager to notify us when an item changes selection state
			mCompositorSelectorViewManager.EventItemStateChanged += new ISVMItemStateChanged( ItemStateChanged );
			//iterate through Compositor Managers resources and add name keys ast Item selectors to Compositor selector view manager
			OgreDotNet.ResourceMapIteratorWrap resourceIterator =
				CompositorManager.Instance.GetAsResourceManager().getResourceIterator();

			// add all compositor resources to the view container
			while (resourceIterator.hasMoreElements())
			{
				ResourcePtr resource = resourceIterator.getNext();
				string compositorName = resource.GetName();
				// Don't add base Ogre/Scene compositor to view
				if (compositorName == "Ogre/Scene")
					continue;

				mCompositorSelectorViewManager.addItemSelector(compositorName);
				int addPosition = -1;
				if (compositorName == "HDR")
				{
					// HDR must be first in the chain
					addPosition = 0;
				}
				CompositorInstance instance = CompositorManager.Instance.addCompositor(vp, compositorName, addPosition);
				CompositorManager.Instance.setCompositorEnabled(vp, compositorName, false);
				// special handling for Heat Vision which uses a listener
				if((instance!=null) && (compositorName == "Heat Vision"))
					instance.AddListener(mhvListener);
				else if((instance!=null) && (compositorName == "HDR"))
				{
					instance.AddListener(mhdrListener);
					mhdrListener.notifyViewportSize( vp.GetActualWidth(), vp.GetActualHeight());
					mhdrListener.notifyCompositor(instance);
				}
			}
		}

		protected void initDebugRTTWindow()
		{
			mDebugRTTStaticImage = new CeguiDotNet.StaticImage( CeguiDotNet.Window.getCPtr(
				WindowManager.Instance.getWindow("DebugRTTImage")).Handle, false );
			mDebugRTTStaticImage.SubscribeEvents();

			mDebugRTTListbox = new CeguiDotNet.Listbox( CeguiDotNet.Window.getCPtr(
				WindowManager.Instance.getWindow("DebugRTTListbox")).Handle, false );
			mDebugRTTListbox.SubscribeEvents();
			mDebugRTTListbox.SelectionChanged += new WindowEventDelegate( handleRttSelection );
		}

		protected void connectMainEventHandlers()
		{
			//The c++ demo only used the ogre events to inject input into cegui.
			//  Then used the cegui events to respond to movement.
			//We will use the ogre events to do both, so there is no need to register these handlers
			
			//still need to do this ?
			//CeguiDotNet.Window wndw = WindowManager.Instance.getWindow("root");
			//wndw.SubscribeEvents();

			//wndw.MouseMove += new CeguiDotNet.WindowEventDelegate( handleMouseMove );
			//wndw.MouseButtonUp  += new CeguiDotNet.WindowEventDelegate( handleMouseButtonUp );
			//wndw.MouseButtonDown += new CeguiDotNet.WindowEventDelegate( handleMouseButtonDown );
			//wndw.MouseWheel += new CeguiDotNet.WindowEventDelegate( handleMouseWheelEvent );
			//wndw.KeyDown += new CeguiDotNet.WindowEventDelegate( handleKeyDownEvent );
			//wndw.KeyUp += new CeguiDotNet.WindowEventDelegate( handleKeyUpEvent );
		}
		
		#endregion
		
		#region custom functions, cegui events handlers

		protected bool handelQuit(CeguiDotNet.WindowEventArgs args)
		{
			mRoot.QueueEndRendering();
			return true;
		}

		protected bool handleRttSelection(CeguiDotNet.WindowEventArgs args)
		{
			if (mDebugRTTListbox.getSelectedCount() > 0)
			{
				// image set is in user data
				CeguiDotNet.Imageset imgSet = new CeguiDotNet.Imageset( 
					mDebugRTTListbox.getFirstSelectedItem().getUserData(), false);
				mDebugRTTStaticImage.setImage( imgSet.getImage("RttImage") );
			}
			else
			{
				mDebugRTTStaticImage.setImage( null );
			}
			return true;
		}

		protected void ItemStateChanged(int index, bool state)
		{
			// get the item text and tell compositor manager to set enable state
			CompositorManager.Instance.setCompositorEnabled( mRenderWindow.GetViewport(0) ,
				mCompositorSelectorViewManager.getItemSelectorText(index), state);
			updateDebugRTTWindow();
		}

		protected void updateDebugRTTWindow()
		{
			// Clear listbox
			mDebugRTTListbox.resetList();
			// Clear imagesets
			mDebugRTTStaticImage.setImage( null );
			foreach (CeguiDotNet.Imageset imgset in mDebugRTTImageSets)
			{
				CeguiDotNet.ImagesetManager.getSingleton().destroyImageset( imgset );
			}
			mDebugRTTImageSets.Clear();
			// Add an entry for each render texture for all active compositors
			Viewport vp = mRenderWindow.GetViewport(0);
			CompositorChain chain = CompositorManager.Instance.getCompositorChain(vp);
			OgreDotNet.CompositorInstancesIteratorWrap it = chain.getCompositors();
			while (it.hasMoreElements())
			{
				CompositorInstance inst = it.getNext();
				if (inst.getEnabled())
				{
					CTTextureDefinitionsIterator texIt = 
						inst.getTechnique().GetTextureDefinitionIterator();
					while (texIt.hasMoreElements())
					{
						CTTextureDefinition texDef = texIt.getNext();

						// Get instance name of texture
						string instName = inst.getTextureInstanceName( texDef.getName() );
						// Create CEGUI texture from name of OGRE texture
						CeguiDotNet.Texture tex = mGuiRenderer.createTexture( new CeguiDotNet.String(instName) );
						// Create imageset
						CeguiDotNet.Imageset imgSet = 
							ImagesetManager.getSingleton().createImageset( instName, tex);
						mDebugRTTImageSets.Add(imgSet);
						imgSet.defineImage( "RttImage",
							new CEGUIVector2(0.0f, 0.0f),
							new CeguiDotNet.Size(tex.getWidth(), tex.getHeight()),
							new CEGUIVector2(0.0f,0.0f) );
						
						CeguiDotNet.ListboxTextItem item = new ListboxTextItem( texDef.getName(), 0, Imageset.getCPtr(imgSet).Handle );
						item.setSelectionBrushImage("TaharezLook", "ListboxSelectionBrush");
						item.setSelectionColours( new CeguiDotNet.colour( 0.0f ,0.0f,1.0f) );
						//the is so we dont have to keep track of the ListboxTextItem
						//if we loose the reference to the DotNet object CeguiDotNet.ListboxTextItem(leaving scope of the while statement), 
						//The swig generated code will delete the c++ object, we dont want this.
						//So calling the static function RemoveOwnership will stop the swig generated
						// code from deleteing the c++ object and the dotnet object can delete normaly.
						ListboxTextItem.RemoveOwnership( item );
						//make sure the c++ object will be deleted with its parent
						item.setAutoDeleted(true);
						mDebugRTTListbox.addItem(item);
					}
				}
			}
		}

		#endregion

		#region OverRidden ExampleApp event handlers

		protected override bool FrameStarted( FrameEvent e )
		{
			if (!base.FrameStarted( e ))
				return false;

			if (mSpinny != null)
				mSpinny.Yaw( 10 * e.TimeSinceLastFrame );

			return true;
		}

		protected override bool FrameEnded( FrameEvent e )
		{
			if (!base.FrameEnded( e ))
				return false;
			return true;
		}

		protected override void KeyPressed(KeyEvent e)
		{
			GuiSystem.Instance.injectKeyDown( (UInt32)e.KeyCode );
			GuiSystem.Instance.injectChar( (UInt32)e.KeyChar );
			base.KeyPressed (e);
		}

		protected override void KeyReleased( KeyEvent e )
		{
			GuiSystem.Instance.injectKeyUp( (uint)e.KeyCode );
			base.KeyReleased(e);
		}


		protected override void MousePressed(MouseEvent e)
		{
			switch( e.ButtonID )
			{
				case 16:
					GuiSystem.Instance.InjectMouseButtonDown( MouseButton.Left );
					break;
				case 32:
					GuiSystem.Instance.InjectMouseButtonDown( MouseButton.Right );
					break;
			}
		}

		protected override void MouseReleased(MouseEvent e)
		{
			switch( e.ButtonID )
			{
				case 16:
					GuiSystem.Instance.InjectMouseButtonUp( MouseButton.Left );
					break;
				case 32:
					GuiSystem.Instance.InjectMouseButtonUp( MouseButton.Right );
					break;
			}
		}


		protected override void MouseMotion(MouseMotionEvent e)
		{
			GuiSystem.Instance.InjectMouseMove(e.DeltaX*mRenderWindow.Width, e.DeltaY*mRenderWindow.Height);
		}

		protected override void MouseDragged(MouseMotionEvent e)
		{
			this.MouseMotion( e );
		}

		protected override void UpdateDebugOverlay()
		{
			mGuiAvg.setText( "Average FPS: " + mRenderWindow.AverageFPS );
			mGuiCurr.setText("Current FPS: " + mRenderWindow.LastFPS );
			mGuiBest.setText("Best FPS: " + mRenderWindow.BestFPS );
			mGuiWorst.setText("Worst FPS: " + mRenderWindow.WorstFPS );
			mGuiTris.setText("Triangle Count: " + mRenderWindow.TriangleCount );
		}

		#endregion

		#region Program Main

		[STAThread]
		static void Main(string[] args)
		{
			cDemoCompositor app = new cDemoCompositor();
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

		#endregion

	}
}
