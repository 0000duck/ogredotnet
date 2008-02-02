//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUITabControl.h"
%}

%extend CEGUI::TabControl
{
	const char * GetEventSelectionChangedName()
	{
		return CEGUI::TabControl::EventSelectionChanged.c_str();
	}
};

%typemap(cscode) CEGUI::TabControl
%{
	public override void SubscribeEvents()
	{
		base.SubscribeEvents();
		
		SelectionChangedHandler = new EventHandler( this, this.GetEventSelectionChangedName() );
		SelectionChangedHandler.SetCallback( new CeguiEventDelegate( SelectionChangedFunction ));
	}

	//
	//			SelectionChanged
	//
	protected EventHandler SelectionChangedHandler = null;
	public event WindowEventDelegate SelectionChanged = null;
	protected bool SelectionChangedFunction()
	{
		if( SelectionChanged != null )
			return SelectionChanged(SelectionChangedHandler.GetWindowEventArgs());
		return true;
	}
%}

%include CEGUITabControl.h