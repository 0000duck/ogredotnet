//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUICheckbox.h"
%}

%extend CEGUI::Checkbox
{
	const char * GetEventCheckStateChangedName()
	{
		return CEGUI::Checkbox::EventCheckStateChanged.c_str();
	}
};

%typemap(cscode) CEGUI::Checkbox
%{
	protected EventHandler CheckStateChangedHandler = null;
	public event WindowEventDelegate CheckStateChanged = null;
	protected bool CheckStateChangedFunction()
	{
		if( CheckStateChanged != null )
			return CheckStateChanged(CheckStateChangedHandler.GetWindowEventArgs());
		return true;
	}

	public override void SubscribeEvents()
	{
		base.SubscribeEvents();
		CheckStateChangedHandler = new EventHandler( this, this.GetEventCheckStateChangedName() );
		CheckStateChangedHandler.SetCallback( new CeguiEventDelegate( CheckStateChangedFunction ));
	}
%}

%include CEGUICheckbox.h