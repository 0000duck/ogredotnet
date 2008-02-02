//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUIListHeaderSegment.h"
%}

%extend CEGUI::ListHeaderSegment
{
	const char * GetEventSegmentClickedName()
	{
		return CEGUI::ListHeaderSegment::EventSegmentClicked.c_str();
	}
	
	const char * GetEventSplitterDoubleClickedName()
	{
		return CEGUI::ListHeaderSegment::EventSplitterDoubleClicked.c_str();
	}
	
	const char * GetEventSizingSettingChangedName()
	{
		return CEGUI::ListHeaderSegment::EventSizingSettingChanged.c_str();
	}
	
	const char * GetEventSortDirectionChangedName()
	{
		return CEGUI::ListHeaderSegment::EventSizingSettingChanged.c_str();
	}
	
	const char * GetEventMovableSettingChangedName()
	{
		return CEGUI::ListHeaderSegment::EventMovableSettingChanged.c_str();
	}
	
	const char * GetEventSegmentDragStartName()
	{
		return CEGUI::ListHeaderSegment::EventSegmentDragStart.c_str();
	}
	
	const char * GetEventSegmentDragStopName()
	{
		return CEGUI::ListHeaderSegment::EventSegmentDragStop.c_str();
	}
	
	const char * GetEventSegmentDragPositionChangedName()
	{
		return CEGUI::ListHeaderSegment::EventSegmentDragPositionChanged.c_str();
	}
	
	const char * GetEventSegmentSizedName()
	{
		return CEGUI::ListHeaderSegment::EventSegmentSized.c_str();
	}
	
	const char * GetEventClickableSettingChangedName()
	{
		return CEGUI::ListHeaderSegment::EventClickableSettingChanged.c_str();
	}
};

%typemap(cscode) CEGUI::ListHeaderSegment
%{
	public override void SubscribeEvents()
	{
		base.SubscribeEvents();
		
		SegmentClickedHandler = new EventHandler( this, this.GetEventSegmentClickedName() );
		SegmentClickedHandler.SetCallback( new CeguiEventDelegate( SegmentClickedFunction ));
		
		SplitterDoubleClickedHandler = new EventHandler( this, this.GetEventSplitterDoubleClickedName() );
		SplitterDoubleClickedHandler.SetCallback( new CeguiEventDelegate( SplitterDoubleClickedFunction ));
		
		SizingSettingChangedHandler = new EventHandler( this, this.GetEventSizingSettingChangedName() );
		SizingSettingChangedHandler.SetCallback( new CeguiEventDelegate( SizingSettingChangedFunction ));
		
		SortDirectionChangedHandler = new EventHandler( this, this.GetEventSortDirectionChangedName() );
		SortDirectionChangedHandler.SetCallback( new CeguiEventDelegate(SortDirectionChangedFunction ));
		
		MovableSettingChangedHandler = new EventHandler( this, this.GetEventMovableSettingChangedName() );
		MovableSettingChangedHandler.SetCallback( new CeguiEventDelegate(MovableSettingChangedFunction ));
		
		SegmentDragStartHandler = new EventHandler( this, this.GetEventSegmentDragStartName() );
		SegmentDragStartHandler.SetCallback( new CeguiEventDelegate(SegmentDragStartFunction ));
		
		SegmentDragStopHandler = new EventHandler( this, this.GetEventSegmentDragStopName() );
		SegmentDragStopHandler.SetCallback( new CeguiEventDelegate(SegmentDragStopFunction ));
		
		SegmentDragPositionChangedHandler = new EventHandler( this, this.GetEventSegmentDragPositionChangedName() );
		SegmentDragPositionChangedHandler.SetCallback( new CeguiEventDelegate(SegmentDragPositionChangedFunction ));
		
		SegmentSizedHandler = new EventHandler( this, this.GetEventSegmentSizedName() );
		SegmentSizedHandler.SetCallback( new CeguiEventDelegate(SegmentSizedFunction ));

		ClickableSettingChangedHandler = new EventHandler( this, this.GetEventClickableSettingChangedName() );
		ClickableSettingChangedHandler.SetCallback( new CeguiEventDelegate(ClickableSettingChangedFunction ));
	}

	//
	//			SegmentClicked
	//
	protected EventHandler SegmentClickedHandler = null;
	public event WindowEventDelegate SegmentClicked = null;
	protected bool SegmentClickedFunction()
	{
		if( SegmentClicked != null )
			return SegmentClicked(SegmentClickedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			SplitterDoubleClicked
	//
	protected EventHandler SplitterDoubleClickedHandler = null;
	public event WindowEventDelegate SplitterDoubleClicked = null;
	protected bool SplitterDoubleClickedFunction()
	{
		if( SplitterDoubleClicked != null )
			return SplitterDoubleClicked(SplitterDoubleClickedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			SizingSettingChanged
	//
	protected EventHandler SizingSettingChangedHandler = null;
	public event WindowEventDelegate SizingSettingChanged = null;
	protected bool SizingSettingChangedFunction()
	{
		if( SizingSettingChanged != null )
			return SizingSettingChanged(SizingSettingChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			SortDirectionChanged
	//
	protected EventHandler SortDirectionChangedHandler = null;
	public event WindowEventDelegate SortDirectionChanged = null;
	protected bool SortDirectionChangedFunction()
	{
		if( SortDirectionChanged != null )
			return SortDirectionChanged(SortDirectionChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			MovableSettingChanged
	//
	protected EventHandler MovableSettingChangedHandler = null;
	public event WindowEventDelegate MovableSettingChanged = null;
	protected bool MovableSettingChangedFunction()
	{
		if( MovableSettingChanged != null )
			return MovableSettingChanged(MovableSettingChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			SegmentDragStart
	//
	protected EventHandler SegmentDragStartHandler = null;
	public event WindowEventDelegate SegmentDragStart = null;
	protected bool SegmentDragStartFunction()
	{
		if( SegmentDragStart != null )
			return SegmentDragStart(SegmentDragStartHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			SegmentDragStop
	//
	protected EventHandler SegmentDragStopHandler = null;
	public event WindowEventDelegate SegmentDragStop = null;
	protected bool SegmentDragStopFunction()
	{
		if( SegmentDragStop != null )
			return SegmentDragStop(SegmentDragStopHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			SegmentDragPositionChanged
	//
	protected EventHandler SegmentDragPositionChangedHandler = null;
	public event WindowEventDelegate SegmentDragPositionChanged = null;
	protected bool SegmentDragPositionChangedFunction()
	{
		if( SegmentDragPositionChanged != null )
			return SegmentDragPositionChanged(SegmentDragPositionChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			SegmentSized
	//
	protected EventHandler SegmentSizedHandler = null;
	public event WindowEventDelegate SegmentSized = null;
	protected bool SegmentSizedFunction()
	{
		if( SegmentSized != null )
			return SegmentSized(SegmentSizedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			ClickableSettingChanged
	//
	protected EventHandler ClickableSettingChangedHandler = null;
	public event WindowEventDelegate ClickableSettingChanged = null;
	protected bool ClickableSettingChangedFunction()
	{
		if( ClickableSettingChanged != null )
			return ClickableSettingChanged(ClickableSettingChangedHandler.GetWindowEventArgs());
		return true;
	}
%}

%include CEGUIListHeaderSegment.h