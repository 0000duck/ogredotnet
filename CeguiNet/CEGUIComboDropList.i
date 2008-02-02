//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUIComboDropList.h"
%}

%nodefault

%extend CEGUI::ComboDropList
{
	const char * GetEventListSelectionAcceptedName()
	{
		return CEGUI::ComboDropList::EventListSelectionAccepted.c_str();
	}
};

%typemap(cscode) CEGUI::ComboDropList
%{
	protected EventHandler ListSelectionAcceptedHandler = null;
	public event WindowEventDelegate ListSelectionAccepted = null;
	protected bool ListSelectionAcceptedFunction()
	{
		if( ListSelectionAccepted != null )
			return ListSelectionAccepted(ListSelectionAcceptedHandler.GetWindowEventArgs());
		return true;
	}

	public void SubscribeEvents()
	{
		base.SubscribeEvents();
		ListSelectionAcceptedHandler = new EventHandler( this, this.GetEventListSelectionAcceptedName() );
		ListSelectionAcceptedHandler.SetCallback( new CeguiEventDelegate( ListSelectionAcceptedFunction ));
	}
%}

%include CEGUIComboDropList.h

%makedefault