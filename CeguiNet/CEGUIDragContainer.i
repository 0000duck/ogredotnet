//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUIDragContainer.h"
%}

%extend CEGUI::DragContainer
{
	const char * GetEventDragStartedName()
	{
		return CEGUI::DragContainer::EventDragStarted.c_str();
	}
	
	const char * GetEventDragEndedName()
	{
		return CEGUI::DragContainer::EventDragEnded.c_str();
	}
	
	const char * GetEventDragPositionChangedName()
	{
		return CEGUI::DragContainer::EventDragPositionChanged.c_str();
	}
	
	const char * GetEventDragEnabledChangedName()
	{
		return CEGUI::DragContainer::EventDragEnabledChanged.c_str();
	}
	
	const char * GetEventDragAlphaChangedName()
	{
		return CEGUI::DragContainer::EventDragAlphaChanged.c_str();
	}
	
	const char * GetEventDragMouseCursorChangedName()
	{
		return CEGUI::DragContainer::EventDragMouseCursorChanged.c_str();
	}
	
	const char * GetEventDragThresholdChangedName()
	{
		return CEGUI::DragContainer::EventDragThresholdChanged.c_str();
	}
	
	const char * GetEventDragDropTargetChangedName()
	{
		return CEGUI::DragContainer::EventDragDropTargetChanged.c_str();
	}
};

%typemap(cscode) CEGUI::DragContainer
%{
	public override void SubscribeEvents()
	{
		base.SubscribeEvents();
		
		DragStartedHandler = new EventHandler( this, this.GetEventDragStartedName() );
		DragStartedHandler.SetCallback( new CeguiEventDelegate( DragStartedFunction ));
		
		DragEndedHandler = new EventHandler( this, this.GetEventDragEndedName() );
		DragEndedHandler.SetCallback( new CeguiEventDelegate( DragEndedFunction ));
		
		DragPositionChangedHandler = new EventHandler( this, this.GetEventDragPositionChangedName() );
		DragPositionChangedHandler.SetCallback( new CeguiEventDelegate( DragPositionChangedFunction ));
		
		DragEnabledChangedHandler = new EventHandler( this, this.GetEventDragEnabledChangedName() );
		DragEnabledChangedHandler.SetCallback( new CeguiEventDelegate( DragEnabledChangedFunction ));
		
		DragAlphaChangedHandler = new EventHandler( this, this.GetEventDragAlphaChangedName() );
		DragAlphaChangedHandler.SetCallback( new CeguiEventDelegate( DragAlphaChangedFunction ));
		
		DragMouseCursorChangedHandler = new EventHandler( this, this.GetEventDragMouseCursorChangedName() );
		DragMouseCursorChangedHandler.SetCallback( new CeguiEventDelegate( DragMouseCursorChangedFunction ));
		
		DragThresholdChangedHandler = new EventHandler( this, this.GetEventDragThresholdChangedName() );
		DragThresholdChangedHandler.SetCallback( new CeguiEventDelegate( DragThresholdChangedFunction ));
		
		DragDropTargetChangedHandler = new EventHandler( this, this.GetEventDragDropTargetChangedName() );
		DragDropTargetChangedHandler.SetCallback( new CeguiEventDelegate( DragDropTargetChangedFunction ));
	}

	//
	//			DragStarted
	//
	protected EventHandler DragStartedHandler = null;
	public event WindowEventDelegate DragStarted = null;
	protected bool DragStartedFunction()
	{
		if( DragStarted != null )
			return DragStarted(DragStartedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			DragEnded
	//
	protected EventHandler DragEndedHandler = null;
	public event WindowEventDelegate DragEnded = null;
	protected bool DragEndedFunction()
	{
		if( DragEnded != null )
			return DragEnded(DragEndedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			DragPositionChanged
	//
	protected EventHandler DragPositionChangedHandler = null;
	public event WindowEventDelegate DragPositionChanged = null;
	protected bool DragPositionChangedFunction()
	{
		if( DragPositionChanged != null )
			return DragPositionChanged(DragPositionChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			DragEnabledChanged
	//
	protected EventHandler DragEnabledChangedHandler = null;
	public event WindowEventDelegate DragEnabledChanged = null;
	protected bool DragEnabledChangedFunction()
	{
		if( DragEnabledChanged != null )
			return DragEnabledChanged(DragEnabledChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			DragAlphaChanged
	//
	protected EventHandler DragAlphaChangedHandler = null;
	public event WindowEventDelegate DragAlphaChanged = null;
	protected bool DragAlphaChangedFunction()
	{
		if( DragAlphaChanged != null )
			return DragAlphaChanged(DragAlphaChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			DragMouseCursorChanged
	//
	protected EventHandler DragMouseCursorChangedHandler = null;
	public event WindowEventDelegate DragMouseCursorChanged = null;
	protected bool DragMouseCursorChangedFunction()
	{
		if( DragMouseCursorChanged != null )
			return DragMouseCursorChanged(DragMouseCursorChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			DragThresholdChanged
	//
	protected EventHandler DragThresholdChangedHandler = null;
	public event WindowEventDelegate DragThresholdChanged = null;
	protected bool DragThresholdChangedFunction()
	{
		if( DragThresholdChanged != null )
			return DragThresholdChanged(DragThresholdChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			DragDropTargetChanged
	//
	protected EventHandler DragDropTargetChangedHandler = null;
	public event DragDropEventDelegate DragDropTargetChanged = null;
	protected bool DragDropTargetChangedFunction()
	{
		if( DragDropTargetChanged != null )
			return DragDropTargetChanged(DragDropTargetChangedHandler.GetDragDropEventArgs());
		return true;
	}
%}

%include CEGUIDragContainer.h