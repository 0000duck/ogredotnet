//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUISpinner.h"
%}

%extend CEGUI::Spinner
{
	const char * GetEventValueChangedName()
	{
		return CEGUI::Spinner::EventValueChanged.c_str();
	}
	
	const char * GetEventStepChangedName()
	{
		return CEGUI::Spinner::EventStepChanged.c_str();
	}
	
	const char * GetEventMaximumValueChangedName()
	{
		return CEGUI::Spinner::EventMaximumValueChanged.c_str();
	}
	
	const char * GetEventMinimumValueChangedName()
	{
		return CEGUI::Spinner::EventMinimumValueChanged.c_str();
	}
	
	const char * GetEventTextInputModeChangedName()
	{
		return CEGUI::Spinner::EventTextInputModeChanged.c_str();
	}
};

%typemap(cscode) CEGUI::Spinner
%{
	public override void SubscribeEvents()
	{
		base.SubscribeEvents();
		
		ValueChangedHandler = new EventHandler( this, this.GetEventValueChangedName() );
		ValueChangedHandler.SetCallback( new CeguiEventDelegate( ValueChangedFunction ));
		
		StepChangedHandler = new EventHandler( this, this.GetEventStepChangedName() );
		StepChangedHandler.SetCallback( new CeguiEventDelegate( StepChangedFunction ));
		
		MaximumValueChangedHandler = new EventHandler( this, this.GetEventMaximumValueChangedName() );
		MaximumValueChangedHandler.SetCallback( new CeguiEventDelegate( MaximumValueChangedFunction ));
		
		MinimumValueChangedHandler = new EventHandler( this, this.GetEventMinimumValueChangedName() );
		MinimumValueChangedHandler.SetCallback( new CeguiEventDelegate( MinimumValueChangedFunction ));
		
		TextInputModeChangedHandler = new EventHandler( this, this.GetEventTextInputModeChangedName() );
		TextInputModeChangedHandler.SetCallback( new CeguiEventDelegate( TextInputModeChangedFunction ));
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
	//			StepChanged
	//
	protected EventHandler StepChangedHandler = null;
	public event WindowEventDelegate StepChanged = null;
	protected bool StepChangedFunction()
	{
		if( StepChanged != null )
			return StepChanged(StepChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			MaximumValueChanged
	//
	protected EventHandler MaximumValueChangedHandler = null;
	public event WindowEventDelegate MaximumValueChanged = null;
	protected bool MaximumValueChangedFunction()
	{
		if( MaximumValueChanged != null )
			return MaximumValueChanged(MaximumValueChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			MinimumValueChanged
	//
	protected EventHandler MinimumValueChangedHandler = null;
	public event WindowEventDelegate MinimumValueChanged = null;
	protected bool MinimumValueChangedFunction()
	{
		if( MinimumValueChanged != null )
			return MinimumValueChanged(MinimumValueChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			TextInputModeChanged
	//
	protected EventHandler TextInputModeChangedHandler = null;
	public event WindowEventDelegate TextInputModeChanged = null;
	protected bool TextInputModeChangedFunction()
	{
		if( TextInputModeChanged != null )
			return TextInputModeChanged(TextInputModeChangedHandler.GetWindowEventArgs());
		return true;
	}
%}

%include CEGUISpinner.h