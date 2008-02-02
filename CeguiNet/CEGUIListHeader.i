//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUIListHeader.h"
%}

%extend CEGUI::ListHeader
{
	const char * GetEventSortColumnChangedName()
	{
		return CEGUI::ListHeader::EventSortColumnChanged.c_str();
	}
	
	const char * GetEventSortDirectionChangedName()
	{
		return CEGUI::ListHeader::EventSortDirectionChanged.c_str();
	}
	
	const char * GetEventSegmentSizedName()
	{
		return CEGUI::ListHeader::EventSegmentSized.c_str();
	}
	
	const char * GetEventSegmentClickedName()
	{
		return CEGUI::ListHeader::EventSegmentClicked.c_str();
	}
	
	const char * GetEventSplitterDoubleClickedName()
	{
		return CEGUI::ListHeader::EventSplitterDoubleClicked.c_str();
	}
	
	const char * GetEventSegmentSequenceChangedName()
	{
		return CEGUI::ListHeader::EventSegmentSequenceChanged.c_str();
	}
	
	const char * GetEventSegmentAddedName()
	{
		return CEGUI::ListHeader::EventSegmentAdded.c_str();
	}
	
	const char * GetEventSegmentRemovedName()
	{
		return CEGUI::ListHeader::EventSegmentRemoved.c_str();
	}
	
	const char * GetEventSortSettingChangedName()
	{
		return CEGUI::ListHeader::EventSortSettingChanged.c_str();
	}
	
	const char * GetEventDragMoveSettingChangedName()
	{
		return CEGUI::ListHeader::EventDragMoveSettingChanged.c_str();
	}
	
	const char * GetEventDragSizeSettingChangedName()
	{
		return CEGUI::ListHeader::EventDragSizeSettingChanged.c_str();
	}
	
	const char * GetEventDragSizeSettingChangedName()
	{
		return CEGUI::ListHeader::EventDragSizeSettingChanged.c_str();
	}
};

%typemap(cscode) CEGUI::ListHeader
%{
	public override void SubscribeEvents()
	{
		base.SubscribeEvents();
		
		SortColumnChangedHandler = new EventHandler( this, this.GetEventSortColumnChangedName() );
		SortColumnChangedHandler.SetCallback( new CeguiEventDelegate( SortColumnChangedFunction ));
		
		SortDirectionChangedHandler = new EventHandler( this, this.GetEventSortDirectionChangedName() );
		SortDirectionChangedHandler.SetCallback( new CeguiEventDelegate( SortDirectionChangedFunction ));
		
		SegmentSizedHandler = new EventHandler( this, this.GetEventSegmentSizedName() );
		SegmentSizedHandler.SetCallback( new CeguiEventDelegate( SegmentSizedFunction ));
		
		SegmentClickedHandler = new EventHandler( this, this.GetEventSegmentClickedName() );
		SegmentClickedHandler.SetCallback( new CeguiEventDelegate( SegmentClickedFunction ));
		
		SplitterDoubleClickedHandler = new EventHandler( this, this.GetEventSplitterDoubleClickedName() );
		SplitterDoubleClickedHandler.SetCallback( new CeguiEventDelegate( SplitterDoubleClickedFunction ));
		
		SegmentSequenceChangedHandler = new EventHandler( this, this.GetEventSegmentSequenceChangedName() );
		SegmentSequenceChangedHandler.SetCallback( new CeguiEventDelegate( SegmentSequenceChangedFunction ));
		
		SegmentAddedHandler = new EventHandler( this, this.GetEventSegmentAddedName() );
		SegmentAddedHandler.SetCallback( new CeguiEventDelegate( SegmentAddedFunction ));

		SegmentRemovedHandler = new EventHandler( this, this.GetEventSegmentRemovedName() );
		SegmentRemovedHandler.SetCallback( new CeguiEventDelegate( SegmentRemovedFunction ));
		
		SortSettingChangedHandler = new EventHandler( this, this.GetEventSortSettingChangedName() );
		SortSettingChangedHandler.SetCallback( new CeguiEventDelegate( SortSettingChangedFunction ));
		
		DragMoveSettingChangedHandler = new EventHandler( this, this.GetEventDragMoveSettingChangedName() );
		DragMoveSettingChangedHandler.SetCallback( new CeguiEventDelegate( DragMoveSettingChangedFunction ));
		
		DragSizeSettingChangedHandler = new EventHandler( this, this.GetEventDragSizeSettingChangedName() );
		DragSizeSettingChangedHandler.SetCallback( new CeguiEventDelegate( DragSizeSettingChangedFunction ));
		
		SegmentRenderOffsetChangedHandler = new EventHandler( this, this.GetEventSegmentRenderOffsetChangedName() );
		SegmentRenderOffsetChangedHandler.SetCallback( new CeguiEventDelegate( SegmentRenderOffsetChangedFunction ));
	}

	//
	//			SortColumnChanged
	//
	protected EventHandler SortColumnChangedHandler = null;
	public event WindowEventDelegate SortColumnChanged = null;
	protected bool SortColumnChangedFunction()
	{
		if( SortColumnChanged != null )
			return SortColumnChanged(SortColumnChangedHandler.GetWindowEventArgs());
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
	//			SegmentSequenceChanged
	//
	protected EventHandler SegmentSequenceChangedHandler = null;
	public event WindowEventDelegate SegmentSequenceChanged = null;
	protected bool SegmentSequenceChangedFunction()
	{
		if( SegmentSequenceChanged != null )
			return SegmentSequenceChanged(SegmentSequenceChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			SegmentAdded
	//
	protected EventHandler SegmentAddedHandler = null;
	public event WindowEventDelegate SegmentAdded = null;
	protected bool SegmentAddedFunction()
	{
		if( SegmentAdded != null )
			return SegmentAdded(SegmentAddedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			SegmentRemoved
	//
	protected EventHandler SegmentRemovedHandler = null;
	public event WindowEventDelegate SegmentRemoved = null;
	protected bool SegmentRemovedFunction()
	{
		if( SegmentRemoved != null )
			return SegmentRemoved(SegmentRemovedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			SortSettingChanged
	//
	protected EventHandler SortSettingChangedHandler = null;
	public event WindowEventDelegate SortSettingChanged = null;
	protected bool SortSettingChangedFunction()
	{
		if( SortSettingChanged != null )
			return SortSettingChanged(SortSettingChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			DragMoveSettingChanged
	//
	protected EventHandler DragMoveSettingChangedHandler = null;
	public event WindowEventDelegate DragMoveSettingChanged = null;
	protected bool DragMoveSettingChangedFunction()
	{
		if( DragMoveSettingChanged != null )
			return DragMoveSettingChanged(DragMoveSettingChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			DragSizeSettingChanged
	//
	protected EventHandler DragSizeSettingChangedHandler = null;
	public event WindowEventDelegate DragSizeSettingChanged = null;
	protected bool DragSizeSettingChangedFunction()
	{
		if( DragSizeSettingChanged != null )
			return DragSizeSettingChanged(DragSizeSettingChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			SegmentRenderOffsetChanged
	//
	protected EventHandler SegmentRenderOffsetChangedHandler = null;
	public event WindowEventDelegate SegmentRenderOffsetChanged = null;
	protected bool SegmentRenderOffsetChangedFunction()
	{
		if( SegmentRenderOffsetChanged != null )
			return SegmentRenderOffsetChanged(SegmentRenderOffsetChangedHandler.GetWindowEventArgs());
		return true;
	}
%}

%include CEGUIListHeader.h