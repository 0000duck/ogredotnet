//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUIMenuBase.h"
%}

%ignore getPopupMenuItem;
%ignore changePopupMenuItem;

%extend CEGUI::MenuBase
{
	const char * GetEventPopupOpenedName()
	{
		return CEGUI::MenuBase::EventPopupOpened.c_str();
	}
	
	const char * GetEventPopupClosedName()
	{
		return CEGUI::MenuBase::EventPopupClosed.c_str();
	}
};

%typemap(cscode) CEGUI::MenuBase
%{
	public override void SubscribeEvents()
	{
		base.SubscribeEvents();
		
		PopupOpenedHandler = new EventHandler( this, this.GetEventPopupOpenedName() );
		PopupOpenedHandler.SetCallback( new CeguiEventDelegate( PopupOpenedFunction ));
		
		PopupClosedHandler = new EventHandler( this, this.GetEventPopupClosedName() );
		PopupClosedHandler.SetCallback( new CeguiEventDelegate( PopupClosedFunction ));
	}

	//
	//			PopupOpened
	//
	protected EventHandler PopupOpenedHandler = null;
	public event WindowEventDelegate PopupOpened = null;
	protected bool PopupOpenedFunction()
	{
		if( PopupOpened != null )
			return PopupOpened(PopupOpenedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			PopupClosed
	//
	protected EventHandler PopupClosedHandler = null;
	public event WindowEventDelegate PopupClosed = null;
	protected bool PopupClosedFunction()
	{
		if( PopupClosed != null )
			return PopupClosed(PopupClosedHandler.GetWindowEventArgs());
		return true;
	}
%}

%include "CEGUIMenuBase.h"
