//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUIWindow.h"
%}


//%typemap(csbase) CEGUI::Window "Cegui.WrappedEventSet";

%rename addChildWindow AddChildWindow;
%rename show Show;
%rename setPosition SetPosition;
%rename setSize SetSize;
%rename getType GetWindowType;

%{
	typedef void (SWIGSTDCALL *GenericFunctionPointer)(void);
%}

%extend CEGUI::Window
{
	void SetPosition( float x, float y )
	{
		self->setPosition(CEGUI::Point( x, y ));
	}
	
	void SetSize( float width, float height )
	{
		self->setSize(CEGUI::Size(width,height));
	}
	
	const char * GetEventParentSizedName()
	{
		return CEGUI::Window::EventParentSized.c_str();
	}
	
	const char * GetEventSizedName()
	{
		return CEGUI::Window::EventSized.c_str();
	}
	
	const char * GetEventMovedName()
	{
		return CEGUI::Window::EventMoved.c_str();
	}
	
	const char * GetEventMovedName()
	{
		return CEGUI::Window::EventMoved.c_str();
	}
	
	const char * GetEventTextChangedName()
	{
		return CEGUI::Window::EventTextChanged.c_str();
	}
	
	const char * GetEventFontChangedName()
	{
		return CEGUI::Window::EventFontChanged.c_str();
	}
	
	const char * GetEventAlphaChangedName()
	{
		return CEGUI::Window::EventAlphaChanged.c_str();
	}
	
	const char * GetEventIDChangedName()
	{
		return CEGUI::Window::EventIDChanged.c_str();
	}
	
	const char * GetEventActivatedName()
	{
		return CEGUI::Window::EventActivated.c_str();
	}
	
	const char * GetEventDeactivatedName()
	{
		return CEGUI::Window::EventDeactivated.c_str();
	}
	
	const char * GetEventShownName()
	{
		return CEGUI::Window::EventShown.c_str();
	}
	
	const char * GetEventHiddenName()
	{
		return CEGUI::Window::EventHidden.c_str();
	}
	
	const char * GetEventEnabledName()
	{
		return CEGUI::Window::EventEnabled.c_str();
	}
	
	const char * GetEventDisabledName()
	{
		return CEGUI::Window::EventDisabled.c_str();
	}
	
	const char * GetEventMetricsModeChangedName()
	{
		return CEGUI::Window::EventMetricsModeChanged.c_str();
	}
	
	const char * GetEventClippedByParentChangedName()
	{
		return CEGUI::Window::EventClippedByParentChanged.c_str();
	}
	
	const char * GetEventDestroyedByParentChangedName()
	{
		return CEGUI::Window::EventDestroyedByParentChanged.c_str();
	}
	
	const char * GetEventInheritsAlphaChangedName()
	{
		return CEGUI::Window::EventInheritsAlphaChanged.c_str();
	}
	
	const char * GetEventAlwaysOnTopChangedName()
	{
		return CEGUI::Window::EventAlwaysOnTopChanged.c_str();
	}
	
	const char * GetEventInputCaptureGainedName()
	{
		return CEGUI::Window::EventInputCaptureGained.c_str();
	}
	
	const char * GetEventInputCaptureLostName()
	{
		return CEGUI::Window::EventInputCaptureLost.c_str();
	}
	
	const char * GetEventRenderingStartedName()
	{
		return CEGUI::Window::EventRenderingStarted.c_str();
	}
	
	const char * GetEventRenderingEndedName()
	{
		return CEGUI::Window::EventRenderingEnded.c_str();
	}
	
	const char * GetEventChildAddedName()
	{
		return CEGUI::Window::EventChildAdded.c_str();
	}
	
	const char * GetEventChildRemovedName()
	{
		return CEGUI::Window::EventChildRemoved.c_str();
	}
	
	const char * GetEventDestructionStartedName()
	{
		return CEGUI::Window::EventDestructionStarted.c_str();
	}
	
	const char * GetEventZOrderChangedName()
	{
		return CEGUI::Window::EventZOrderChanged.c_str();
	}
	
	const char * GetEventDragDropItemEntersName()
	{
		return CEGUI::Window::EventDragDropItemEnters.c_str();
	}
	
	const char * GetEventDragDropItemLeavesName()
	{
		return CEGUI::Window::EventDragDropItemLeaves.c_str();
	}
	
	const char * GetEventDragDropItemDroppedName()
	{
		return CEGUI::Window::EventDragDropItemDropped.c_str();
	}
	
	const char * GetEventMouseEntersName()
	{
		return CEGUI::Window::EventMouseEnters.c_str();
	}
	
	const char * GetEventMouseLeavesName()
	{
		return CEGUI::Window::EventMouseLeaves.c_str();
	}
	
	const char * GetEventMouseMoveName()
	{
		return CEGUI::Window::EventMouseMove.c_str();
	}
	
	const char * GetEventMouseWheelName()
	{
		return CEGUI::Window::EventMouseWheel.c_str();
	}
	
	const char * GetEventMouseButtonDownName()
	{
		return CEGUI::Window::EventMouseButtonDown.c_str();
	}
	
	const char * GetEventMouseButtonUpName()
	{
		return CEGUI::Window::EventMouseButtonUp.c_str();
	}
	
	const char * GetEventMouseClickName()
	{
		return CEGUI::Window::EventMouseClick.c_str();
	}
	
	const char * GetEventMouseDoubleClickName()
	{
		return CEGUI::Window::EventMouseDoubleClick.c_str();
	}
	
	const char * GetEventMouseTripleClickName()
	{
		return CEGUI::Window::EventMouseTripleClick.c_str();
	}
	
	const char * GetEventKeyDownName()
	{
		return CEGUI::Window::EventKeyDown.c_str();
	}
	
	const char * GetEventKeyUpName()
	{
		return CEGUI::Window::EventKeyUp.c_str();
	}
	
	const char * GetEventCharacterKeyName()
	{
		return CEGUI::Window::EventCharacterKey.c_str();
	}
};

%typemap(cscode) CEGUI::Window
%{
	public string Text
	{
		get
		{
			return getText();
		}
		set
		{
			setText( value );
		}
	}
	
	public virtual void SubscribeEvents()
	{
		mParentSizedHandler = new EventHandler( this, this.GetEventParentSizedName() );
		mParentSizedHandler.SetCallback( new CeguiEventDelegate( ParentSizedFunction ));
		
		mSizedHandler = new EventHandler( this, this.GetEventSizedName() );
		mSizedHandler.SetCallback( new CeguiEventDelegate( SizedFunction ));
		
		mMovedHandler = new EventHandler( this, this.GetEventMovedName() );
		mMovedHandler.SetCallback( new CeguiEventDelegate( MovedFunction ));
		
		mTextChangedHandler = new EventHandler( this, this.GetEventTextChangedName() );
		mTextChangedHandler.SetCallback( new CeguiEventDelegate( TextChangedFunction ));
		
		mFontChangedHandler = new EventHandler( this, this.GetEventFontChangedName() );
		mFontChangedHandler.SetCallback( new CeguiEventDelegate( FontChangedFunction ));
		
		mAlphaChangedHandler = new EventHandler( this, this.GetEventAlphaChangedName() );
		mAlphaChangedHandler.SetCallback( new CeguiEventDelegate( AlphaChangedFunction ));
		
		mIDChangedHandler = new EventHandler( this, this.GetEventIDChangedName() );
		mIDChangedHandler.SetCallback( new CeguiEventDelegate( IDChangedFunction ));
		
		mActivatedHandler = new EventHandler( this, this.GetEventActivatedName() );
		mActivatedHandler.SetCallback( new CeguiEventDelegate( ActivatedFunction ));
		
		mDeactivatedHandler = new EventHandler( this, this.GetEventDeactivatedName() );
		mDeactivatedHandler.SetCallback( new CeguiEventDelegate( DeactivatedFunction ));
		
		mShownHandler = new EventHandler( this, this.GetEventShownName() );
		mShownHandler.SetCallback( new CeguiEventDelegate( ShownFunction ));
		
		mHiddenHandler = new EventHandler( this, this.GetEventHiddenName() );
		mHiddenHandler.SetCallback( new CeguiEventDelegate( HiddenFunction ));
		
		mEnabledHandler = new EventHandler( this, this.GetEventEnabledName() );
		mEnabledHandler.SetCallback( new CeguiEventDelegate( EnabledFunction ));
		
		mDisabledHandler = new EventHandler( this, this.GetEventDisabledName() );
		mDisabledHandler.SetCallback( new CeguiEventDelegate( DisabledFunction ));
		
		mMetricsModeChangedHandler = new EventHandler( this, this.GetEventMetricsModeChangedName() );
		mMetricsModeChangedHandler.SetCallback( new CeguiEventDelegate( MetricsModeChangedFunction ));
		
		mClippedByParentChangedHandler = new EventHandler( this, this.GetEventClippedByParentChangedName() );
		mClippedByParentChangedHandler.SetCallback( new CeguiEventDelegate( ClippedByParentChangedFunction ));
		
		mDestroyedByParentChangedHandler = new EventHandler( this, this.GetEventDestroyedByParentChangedName() );
		mDestroyedByParentChangedHandler.SetCallback( new CeguiEventDelegate( DestroyedByParentChangedFunction ));
		
		mInheritsAlphaChangedHandler = new EventHandler( this, this.GetEventInheritsAlphaChangedName() );
		mInheritsAlphaChangedHandler.SetCallback( new CeguiEventDelegate( InheritsAlphaChangedFunction ));
		
		mAlwaysOnTopChangedHandler = new EventHandler( this, this.GetEventAlwaysOnTopChangedName() );
		mAlwaysOnTopChangedHandler.SetCallback( new CeguiEventDelegate( AlwaysOnTopChangedFunction ));
		
		mInputCaptureGainedHandler = new EventHandler( this, this.GetEventInputCaptureGainedName() );
		mInputCaptureGainedHandler.SetCallback( new CeguiEventDelegate( InputCaptureGainedFunction ));
		
		mInputCaptureLostHandler = new EventHandler( this, this.GetEventInputCaptureLostName() );
		mInputCaptureLostHandler.SetCallback( new CeguiEventDelegate( InputCaptureLostFunction ));
		
		mRenderingStartedHandler = new EventHandler( this, this.GetEventRenderingStartedName() );
		mRenderingStartedHandler.SetCallback( new CeguiEventDelegate( RenderingStartedFunction ));
		
		mRenderingEndedHandler = new EventHandler( this, this.GetEventRenderingEndedName() );
		mRenderingEndedHandler.SetCallback( new CeguiEventDelegate( RenderingEndedFunction ));
		
		mChildAddedHandler = new EventHandler( this, this.GetEventChildAddedName() );
		mChildAddedHandler.SetCallback( new CeguiEventDelegate( ChildAddedFunction ));
		
		mChildRemovedHandler = new EventHandler( this, this.GetEventChildRemovedName() );
		mChildRemovedHandler.SetCallback( new CeguiEventDelegate( ChildRemovedFunction ));
		
		mDestructionStartedHandler = new EventHandler( this, this.GetEventDestructionStartedName() );
		mDestructionStartedHandler.SetCallback( new CeguiEventDelegate( DestructionStartedFunction ));
		
		mZOrderChangedHandler = new EventHandler( this, this.GetEventZOrderChangedName() );
		mZOrderChangedHandler.SetCallback( new CeguiEventDelegate( ZOrderChangedFunction ));
		
		mDragDropItemEntersHandler = new EventHandler( this, this.GetEventDragDropItemEntersName() );
		mDragDropItemEntersHandler.SetCallback( new CeguiEventDelegate( DragDropItemEntersFunction ));
		
		mDragDropItemLeavesHandler = new EventHandler( this, this.GetEventDragDropItemLeavesName() );
		mDragDropItemLeavesHandler.SetCallback( new CeguiEventDelegate( DragDropItemLeavesFunction ));
		
		mDragDropItemDroppedHandler = new EventHandler( this, this.GetEventDragDropItemDroppedName() );
		mDragDropItemDroppedHandler.SetCallback( new CeguiEventDelegate( DragDropItemDroppedFunction ));
		
		mMouseEntersHandler = new EventHandler( this, this.GetEventMouseEntersName() );
		mMouseEntersHandler.SetCallback( new CeguiEventDelegate( MouseEntersFunction ));
		
		mMouseLeavesHandler = new EventHandler( this, this.GetEventMouseLeavesName() );
		mMouseLeavesHandler.SetCallback( new CeguiEventDelegate( MouseLeavesFunction ));
		
		mMouseMoveHandler = new EventHandler( this, this.GetEventMouseMoveName() );
		mMouseMoveHandler.SetCallback( new CeguiEventDelegate( MouseMoveFunction ));
		
		mMouseWheelHandler = new EventHandler( this, this.GetEventMouseWheelName() );
		mMouseWheelHandler.SetCallback( new CeguiEventDelegate( MouseWheelFunction ));
		
		mMouseButtonDownHandler = new EventHandler( this, this.GetEventMouseButtonDownName() );
		mMouseButtonDownHandler.SetCallback( new CeguiEventDelegate( MouseButtonDownFunction ));
		
		mMouseButtonUpHandler = new EventHandler( this, this.GetEventMouseButtonUpName() );
		mMouseButtonUpHandler.SetCallback( new CeguiEventDelegate( MouseButtonUpFunction ));
		
		mMouseClickHandler = new EventHandler( this, this.GetEventMouseClickName() );
		mMouseClickHandler.SetCallback( new CeguiEventDelegate( MouseClickFunction ));
		
		mMouseDoubleClickHandler = new EventHandler( this, this.GetEventMouseDoubleClickName() );
		mMouseDoubleClickHandler.SetCallback( new CeguiEventDelegate( MouseDoubleClickFunction ));
		
		mMouseTripleClickHandler = new EventHandler( this, this.GetEventMouseTripleClickName() );
		mMouseTripleClickHandler.SetCallback( new CeguiEventDelegate( MouseTripleClickFunction ));
		
		mKeyDownHandler = new EventHandler( this, this.GetEventKeyDownName() );
		mKeyDownHandler.SetCallback( new CeguiEventDelegate( KeyDownFunction ));
		
		mKeyUpHandler = new EventHandler( this, this.GetEventKeyUpName() );
		mKeyUpHandler.SetCallback( new CeguiEventDelegate( KeyUpFunction ));
		
		mCharacterKeyHandler = new EventHandler( this, this.GetEventCharacterKeyName() );
		mCharacterKeyHandler.SetCallback( new CeguiEventDelegate( CharacterKeyFunction ));
	}
	
	//
	//			ParentSized
	//
	protected EventHandler mParentSizedHandler = null;
	public event WindowEventDelegate ParentSized = null;
	protected bool ParentSizedFunction()
	{
		if( ParentSized != null )
			return ParentSized(mParentSizedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			Sized
	//
	protected EventHandler mSizedHandler = null;
	public event WindowEventDelegate Sized = null;
	protected bool SizedFunction()
	{
		if( Sized != null )
			return Sized(mSizedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			Moved
	//
	protected EventHandler mMovedHandler = null;
	public event WindowEventDelegate Moved = null;
	protected bool MovedFunction()
	{
		if( Moved != null )
			return Moved(mMovedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			TextChanged
	//
	protected EventHandler mTextChangedHandler = null;
	public event WindowEventDelegate TextChanged = null;
	protected bool TextChangedFunction()
	{
		if( TextChanged != null )
			return TextChanged(mTextChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			FontChanged
	//
	protected EventHandler mFontChangedHandler = null;
	public event WindowEventDelegate FontChanged = null;
	protected bool FontChangedFunction()
	{
		if( FontChanged != null )
			return FontChanged(mFontChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			AlphaChanged
	//
	protected EventHandler mAlphaChangedHandler = null;
	public event WindowEventDelegate AlphaChanged = null;
	protected bool AlphaChangedFunction()
	{
		if( AlphaChanged != null )
			return AlphaChanged(mAlphaChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			IDChanged
	//
	protected EventHandler mIDChangedHandler = null;
	public event WindowEventDelegate IDChanged = null;
	protected bool IDChangedFunction()
	{
		if( IDChanged != null )
			return IDChanged(mIDChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			Activated
	//
	protected EventHandler mActivatedHandler = null;
	public event ActivationEventDelegate Activated = null;
	protected bool ActivatedFunction()
	{
		if( Activated != null )
			return Activated(mActivatedHandler.GetActivationEventArgs());
		return true;
	}
	
	//
	//			Deactivated
	//
	protected EventHandler mDeactivatedHandler = null;
	public event ActivationEventDelegate Deactivated = null;
	protected bool DeactivatedFunction()
	{
		if( Deactivated != null )
			return Deactivated(mDeactivatedHandler.GetActivationEventArgs());
		return true;
	}
	
	//
	//			Shown
	//
	protected EventHandler mShownHandler = null;
	public event WindowEventDelegate Shown = null;
	protected bool ShownFunction()
	{
		if( Shown != null )
			return Shown(mShownHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			Hidden
	//
	protected EventHandler mHiddenHandler = null;
	public event WindowEventDelegate Hidden = null;
	protected bool HiddenFunction()
	{
		if( Hidden != null )
			return Hidden(mHiddenHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			Enabled
	//
	protected EventHandler mEnabledHandler = null;
	public event WindowEventDelegate Enabled = null;
	protected bool EnabledFunction()
	{
		if( Enabled != null )
			return Enabled(mEnabledHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			Disabled
	//
	protected EventHandler mDisabledHandler = null;
	public event WindowEventDelegate Disabled = null;
	protected bool DisabledFunction()
	{
		if( Disabled != null )
			return Disabled(mDisabledHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			MetricsModeChanged
	//
	protected EventHandler mMetricsModeChangedHandler = null;
	public event WindowEventDelegate MetricsModeChanged = null;
	protected bool MetricsModeChangedFunction()
	{
		if( MetricsModeChanged != null )
			return MetricsModeChanged(mMetricsModeChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			ClippedByParentChanged
	//
	protected EventHandler mClippedByParentChangedHandler = null;
	public event WindowEventDelegate ClippedByParentChanged = null;
	protected bool ClippedByParentChangedFunction()
	{
		if( ClippedByParentChanged != null )
			return ClippedByParentChanged(mClippedByParentChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			DestroyedByParentChanged
	//
	protected EventHandler mDestroyedByParentChangedHandler = null;
	public event WindowEventDelegate DestroyedByParentChanged = null;
	protected bool DestroyedByParentChangedFunction()
	{
		if( DestroyedByParentChanged != null )
			return DestroyedByParentChanged(mDestroyedByParentChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			InheritsAlphaChanged
	//
	protected EventHandler mInheritsAlphaChangedHandler = null;
	public event WindowEventDelegate InheritsAlphaChanged = null;
	protected bool InheritsAlphaChangedFunction()
	{
		if( InheritsAlphaChanged != null )
			return InheritsAlphaChanged(mInheritsAlphaChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			AlwaysOnTopChanged
	//
	protected EventHandler mAlwaysOnTopChangedHandler = null;
	public event WindowEventDelegate AlwaysOnTopChanged = null;
	protected bool AlwaysOnTopChangedFunction()
	{
		if( AlwaysOnTopChanged != null )
			return AlwaysOnTopChanged(mAlwaysOnTopChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			InputCaptureGained
	//
	protected EventHandler mInputCaptureGainedHandler = null;
	public event WindowEventDelegate InputCaptureGained = null;
	protected bool InputCaptureGainedFunction()
	{
		if( InputCaptureGained != null )
			return InputCaptureGained(mInputCaptureGainedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			InputCaptureLost
	//
	protected EventHandler mInputCaptureLostHandler = null;
	public event WindowEventDelegate InputCaptureLost = null;
	protected bool InputCaptureLostFunction()
	{
		if( InputCaptureLost != null )
			return InputCaptureLost(mInputCaptureLostHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			RenderingStarted
	//
	protected EventHandler mRenderingStartedHandler = null;
	public event WindowEventDelegate RenderingStarted = null;
	protected bool RenderingStartedFunction()
	{
		if( RenderingStarted != null )
			return RenderingStarted(mRenderingStartedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			RenderingEnded
	//
	protected EventHandler mRenderingEndedHandler = null;
	public event WindowEventDelegate RenderingEnded = null;
	protected bool RenderingEndedFunction()
	{
		if( RenderingEnded != null )
			return RenderingEnded(mRenderingEndedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			ChildAdded
	//
	protected EventHandler mChildAddedHandler = null;
	public event WindowEventDelegate ChildAdded = null;
	protected bool ChildAddedFunction()
	{
		if( ChildAdded != null )
			return ChildAdded(mChildAddedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			ChildRemoved
	//
	protected EventHandler mChildRemovedHandler = null;
	public event WindowEventDelegate ChildRemoved = null;
	protected bool ChildRemovedFunction()
	{
		if( ChildRemoved != null )
			return ChildRemoved(mChildRemovedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			DestructionStarted
	//
	protected EventHandler mDestructionStartedHandler = null;
	public event WindowEventDelegate DestructionStarted = null;
	protected bool DestructionStartedFunction()
	{
		if( DestructionStarted != null )
			return DestructionStarted(mDestructionStartedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			ZOrderChanged
	//
	protected EventHandler mZOrderChangedHandler = null;
	public event WindowEventDelegate ZOrderChanged = null;
	protected bool ZOrderChangedFunction()
	{
		if( ZOrderChanged != null )
			return ZOrderChanged(mZOrderChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			DragDropItemEnters
	//
	protected EventHandler mDragDropItemEntersHandler = null;
	public event DragDropEventDelegate DragDropItemEnters = null;
	protected bool DragDropItemEntersFunction()
	{
		if( DragDropItemEnters != null )
			return DragDropItemEnters(mDragDropItemEntersHandler.GetDragDropEventArgs());
		return true;
	}
	
	//
	//			DragDropItemLeaves
	//
	protected EventHandler mDragDropItemLeavesHandler = null;
	public event DragDropEventDelegate DragDropItemLeaves = null;
	protected bool DragDropItemLeavesFunction()
	{
		if( DragDropItemLeaves != null )
			return DragDropItemLeaves(mDragDropItemLeavesHandler.GetDragDropEventArgs());
		return true;
	}
	
	//
	//			DragDropItemDropped
	//
	protected EventHandler mDragDropItemDroppedHandler = null;
	public event DragDropEventDelegate DragDropItemDropped = null;
	protected bool DragDropItemDroppedFunction()
	{
		if( DragDropItemDropped != null )
			return DragDropItemDropped(mDragDropItemDroppedHandler.GetDragDropEventArgs());
		return true;
	}
	
	//
	//			MouseEnters
	//
	protected EventHandler mMouseEntersHandler = null;
	public event MouseEventDelegate MouseEnters = null;
	protected bool MouseEntersFunction()
	{
		if( MouseEnters != null )
			return MouseEnters(mMouseEntersHandler.GetMouseEventArgs());
		return true;
	}
	
	//
	//			MouseLeaves
	//
	protected EventHandler mMouseLeavesHandler = null;
	public event MouseEventDelegate MouseLeaves = null;
	protected bool MouseLeavesFunction()
	{
		if( MouseLeaves != null )
			return MouseLeaves(mMouseLeavesHandler.GetMouseEventArgs());
		return true;
	}
	
	//
	//			MouseMove
	//
	protected EventHandler mMouseMoveHandler = null;
	public event MouseEventDelegate MouseMove = null;
	protected bool MouseMoveFunction()
	{
		if( MouseMove != null )
			return MouseMove(mMouseMoveHandler.GetMouseEventArgs());
		return true;
	}
	
	//
	//			MouseWheel
	//
	protected EventHandler mMouseWheelHandler = null;
	public event MouseEventDelegate MouseWheel = null;
	protected bool MouseWheelFunction()
	{
		if( MouseWheel != null )
			return MouseWheel(mMouseWheelHandler.GetMouseEventArgs());
		return true;
	}
	
	//
	//			MouseButtonDown
	//
	protected EventHandler mMouseButtonDownHandler = null;
	public event MouseEventDelegate MouseButtonDown = null;
	protected bool MouseButtonDownFunction()
	{
		if( MouseButtonDown != null )
			return MouseButtonDown(mMouseButtonDownHandler.GetMouseEventArgs());
		return true;
	}
	
	//
	//			MouseButtonUp
	//
	protected EventHandler mMouseButtonUpHandler = null;
	public event MouseEventDelegate MouseButtonUp = null;
	protected bool MouseButtonUpFunction()
	{
		if( MouseButtonUp != null )
			return MouseButtonUp(mMouseButtonUpHandler.GetMouseEventArgs());
		return true;
	}
	
	//
	//			MouseClick
	//
	protected EventHandler mMouseClickHandler = null;
	public event MouseEventDelegate MouseClick = null;
	protected bool MouseClickFunction()
	{
		if( MouseClick != null )
			return MouseClick(mMouseClickHandler.GetMouseEventArgs());
		return true;
	}
	
	//
	//			MouseDoubleClick
	//
	protected EventHandler mMouseDoubleClickHandler = null;
	public event MouseEventDelegate MouseDoubleClick = null;
	protected bool MouseDoubleClickFunction()
	{
		if( MouseDoubleClick != null )
			return MouseDoubleClick(mMouseDoubleClickHandler.GetMouseEventArgs());
		return true;
	}
	
	//
	//			MouseTripleClick
	//
	protected EventHandler mMouseTripleClickHandler = null;
	public event MouseEventDelegate MouseTripleClick = null;
	protected bool MouseTripleClickFunction()
	{
		if( MouseTripleClick != null )
			return MouseTripleClick(mMouseTripleClickHandler.GetMouseEventArgs());
		return true;
	}
	
	//
	//			KeyDown
	//
	protected EventHandler mKeyDownHandler = null;
	public event KeyEventDelegate KeyDown = null;
	protected bool KeyDownFunction()
	{
		if( KeyDown != null )
			return KeyDown(mKeyDownHandler.GetKeyEventArgs());
		return true;
	}
	
	//
	//			KeyUp
	//
	protected EventHandler mKeyUpHandler = null;
	public event KeyEventDelegate KeyUp = null;
	protected bool KeyUpFunction()
	{
		if( KeyUp != null )
			return KeyUp(mKeyUpHandler.GetKeyEventArgs());
		return true;
	}
	
	//
	//			CharacterKey
	//
	protected EventHandler mCharacterKeyHandler = null;
	public event KeyEventDelegate CharacterKey = null;
	protected bool CharacterKeyFunction()
	{
		if( CharacterKey != null )
			return CharacterKey(mCharacterKeyHandler.GetKeyEventArgs());
		return true;
	}
%}



%include "CEGUIWindow.h"