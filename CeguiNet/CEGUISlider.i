//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUISlider.h"
%}

%extend CEGUI::Slider
{
	const char * GetEventValueChangedName()
	{
		return CEGUI::Slider::EventValueChanged.c_str();
	}
	
	const char * GetEventThumbTrackStartedName()
	{
		return CEGUI::Slider::EventThumbTrackStarted.c_str();
	}
	
	const char * GetEventThumbTrackEndedName()
	{
		return CEGUI::Slider::EventThumbTrackEnded.c_str();
	}
};

%typemap(cscode) CEGUI::Slider
%{
	public override void SubscribeEvents()
	{
		base.SubscribeEvents();
		
		ValueChangedHandler = new EventHandler( this, this.GetEventValueChangedName() );
		ValueChangedHandler.SetCallback( new CeguiEventDelegate( ValueChangedFunction ));
		
		ThumbTrackStartedHandler = new EventHandler( this, this.GetEventThumbTrackStartedName() );
		ThumbTrackStartedHandler.SetCallback( new CeguiEventDelegate( ThumbTrackStartedFunction ));
		
		ThumbTrackEndedHandler = new EventHandler( this, this.GetEventThumbTrackEndedName() );
		ThumbTrackEndedHandler.SetCallback( new CeguiEventDelegate( ThumbTrackEndedFunction ));
	}

	//
	//			ValueChanged
	//
	protected EventHandler ValueChangedHandler = null;
	public event WindowEventDelegate ValueChanged = null;
	protected bool ValueChangedFunction()
	{
		if( ValueChanged != null )
			return ValueChanged(ValueChangedHandler.GetWindowEventArgs());
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

%include CEGUISlider.h