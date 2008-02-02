//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUIRadioButton.h"
%}

%extend CEGUI::RadioButton
{
	const char * GetEventSelectStateChangedName()
	{
		return CEGUI::RadioButton::EventSelectStateChanged.c_str();
	}
};

%typemap(cscode) CEGUI::RadioButton
%{
	public override void SubscribeEvents()
	{
		base.SubscribeEvents();
		
		SelectStateChangedHandler = new EventHandler( this, this.GetEventSelectStateChangedName() );
		SelectStateChangedHandler.SetCallback( new CeguiEventDelegate( SelectStateChangedFunction ));
	}

	//
	//			SelectStateChanged
	//
	protected EventHandler SelectStateChangedHandler = null;
	public event WindowEventDelegate SelectStateChanged = null;
	protected bool SelectStateChangedFunction()
	{
		if( SelectStateChanged != null )
			return SelectStateChanged(SelectStateChangedHandler.GetWindowEventArgs());
		return true;
	}
%}

%include CEGUIRadioButton.h