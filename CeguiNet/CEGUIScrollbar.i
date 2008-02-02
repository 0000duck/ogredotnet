//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUIScrollbar.h"
%}

%extend CEGUI::Scrollbar
{
	const char * GetEventScrollPositionChangedName()
	{
		return CEGUI::Scrollbar::EventScrollPositionChanged.c_str();
	}
	
	const char * GetEventThumbTrackStartedName()
	{
		return CEGUI::Scrollbar::EventThumbTrackStarted.c_str();
	}
	
	const char * GetEventThumbTrackEndedName()
	{
		return CEGUI::Scrollbar::EventThumbTrackEnded.c_str();
	}
	
	const char * GetEventScrollConfigChangedName()
	{
		return CEGUI::Scrollbar::EventScrollConfigChanged.c_str();
	}
};

%typemap(cscode) CEGUI::Scrollbar
%{
	public override void SubscribeEvents()
	{
		base.SubscribeEvents();
		
		ScrollPositionChangedHandler = new EventHandler( this, this.GetEventScrollPositionChangedName() );
		ScrollPositionChangedHandler.SetCallback( new CeguiEventDelegate( ScrollPositionChangedFunction ));
		
		ThumbTrackStartedHandler = new EventHandler( this, this.GetEventThumbTrackStartedName() );
		ThumbTrackStartedHandler.SetCallback( new CeguiEventDelegate( ThumbTrackStartedFunction ));
		
		ThumbTrackEndedHandler = new EventHandler( this, this.GetEventThumbTrackEndedName() );
		ThumbTrackEndedHandler.SetCallback( new CeguiEventDelegate( ThumbTrackEndedFunction ));
		
		ScrollConfigChangedHandler = new EventHandler( this, this.GetEventScrollConfigChangedName() );
		ScrollConfigChangedHandler.SetCallback( new CeguiEventDelegate( ScrollConfigChangedFunction ));
	}

	//
	//			ScrollPositionChanged
	//
	protected EventHandler ScrollPositionChangedHandler = null;
	public event WindowEventDelegate ScrollPositionChanged = null;
	protected bool ScrollPositionChangedFunction()
	{
		if( ScrollPositionChanged != null )
			return ScrollPositionChanged(ScrollPositionChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			ThumbTrackStarted
	//
	protected EventHandler ThumbTrackStartedHandler = null;
	public event WindowEventDelegate ThumbTrackStarted = null;
	protected bool ThumbTrackStartedFunction()
	{
		if( ThumbTrackStarted != null )
			return ThumbTrackStarted(ThumbTrackStartedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			ThumbTrackEnded
	//
	protected EventHandler ThumbTrackEndedHandler = null;
	public event WindowEventDelegate ThumbTrackEnded = null;
	protected bool ThumbTrackEndedFunction()
	{
		if( ThumbTrackEnded != null )
			return ThumbTrackEnded(ThumbTrackEndedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			ScrollConfigChanged
	//
	protected EventHandler ScrollConfigChangedHandler = null;
	public event WindowEventDelegate ScrollConfigChanged = null;
	protected bool ScrollConfigChangedFunction()
	{
		if( ScrollConfigChanged != null )
			return ScrollConfigChanged(ScrollConfigChangedHandler.GetWindowEventArgs());
		return true;
	}
%}

%include CEGUIScrollbar.h
