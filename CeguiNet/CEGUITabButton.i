//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUITabButton.h"
%}

%extend CEGUI::TabButton
{
	const char * GetEventClickedName()
	{
		return CEGUI::TabButton::EventClicked.c_str();
	}
};

%typemap(cscode) CEGUI::TabButton
%{
	public override void SubscribeEvents()
	{
		base.SubscribeEvents();
		
		ClickedHandler = new EventHandler( this, this.GetEventClickedName() );
		ClickedHandler.SetCallback( new CeguiEventDelegate( ClickedFunction ));
	}

	//
	//			Clicked
	//
	protected EventHandler ClickedHandler = null;
	public event WindowEventDelegate Clicked = null;
	protected bool ClickedFunction()
	{
		if( Clicked != null )
			return Clicked(ClickedHandler.GetWindowEventArgs());
		return true;
	}
%}

%include CEGUITabButton.h