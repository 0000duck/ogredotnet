//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUIThumb.h"
%}

%extend CEGUI::Thumb
{
	const char * GetEventThumbPositionChangedName()
	{
		return CEGUI::Thumb::EventThumbPositionChanged.c_str();
	}
	
	const char * GetEventThumbTrackStartedName()
	{
		return CEGUI::Thumb::EventThumbTrackStarted.c_str();
	}
	
	const char * GetEventThumbTrackEndedName()
	{
		return CEGUI::Thumb::EventThumbTrackEnded.c_str();
	}
};

%typemap(cscode) CEGUI::Thumb
%{
	public override void SubscribeEvents()
	{
		base.SubscribeEvents();
		
		ThumbPositionChangedHandler = new EventHandler( this, this.GetEventThumbPositionChangedName() );
		ThumbPositionChangedHandler.SetCallback( new CeguiEventDelegate( ThumbPositionChangedFunction ));
		
		ThumbTrackStartedHandler = new EventHandler( this, this.GetEventThumbTrackStartedName() );
		ThumbTrackStartedHandler.SetCallback( new CeguiEventDelegate( ThumbTrackStartedFunction ));
		
		ThumbTrackEndedHandler = new EventHandler( this, this.GetEventThumbTrackEndedName() );
		ThumbTrackEndedHandler.SetCallback( new CeguiEventDelegate( ThumbTrackEndedFunction ));
	}

	//
	//			ThumbPositionChanged
	//
	protected EventHandler ThumbPositionChangedHandler = null;
	public event WindowEventDelegate ThumbPositionChanged = null;
	protected bool ThumbPositionChangedFunction()
	{
		if( ThumbPositionChanged != null )
			return ThumbPositionChanged(ThumbPositionChangedHandler.GetWindowEventArgs());
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
%}

%include CEGUIThumb.h