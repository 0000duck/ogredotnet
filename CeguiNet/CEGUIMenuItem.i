//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUIMenuItem.h"
%}

%extend CEGUI::MenuItem
{
	const char * GetEventClickedName()
	{
		return CEGUI::MenuItem::EventClicked.c_str();
	}
};

%typemap(cscode) CEGUI::MenuItem
%{
	protected EventHandler ClickedHandler = null;
	public event WindowEventDelegate Clicked;
	protected bool ClickedFunction()
	{
		Clicked(ClickedHandler.GetWindowEventArgs());
		return true;
	}

	public override void SubscribeEvents()
	{
		ClickedHandler = new EventHandler( this, this.GetEventClickedName() );
		ClickedHandler.SetCallback( new CeguiEventDelegate( ClickedFunction ));
	}
%}

%include "CEGUIMenuItem.h"
