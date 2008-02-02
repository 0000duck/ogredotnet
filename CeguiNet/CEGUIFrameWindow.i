//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUIFrameWindow.h"
%}

%extend CEGUI::FrameWindow
{
	const char * GetEventRollupToggledName()
	{
		return CEGUI::FrameWindow::EventRollupToggled.c_str();
	}
	
	const char * GetEventCloseClickedName()
	{
		return CEGUI::FrameWindow::EventCloseClicked.c_str();
	}
};

%typemap(cscode) CEGUI::FrameWindow
%{
	public override void SubscribeEvents()
	{
		base.SubscribeEvents();
		
		RollupToggledHandler = new EventHandler( this, this.GetEventRollupToggledName() );
		RollupToggledHandler.SetCallback( new CeguiEventDelegate( RollupToggledFunction ));
		
		CloseClickedHandler = new EventHandler( this, this.GetEventCloseClickedName() );
		CloseClickedHandler.SetCallback( new CeguiEventDelegate( CloseClickedFunction ));
	}

	//
	//			RollupToggled
	//
	protected EventHandler RollupToggledHandler = null;
	public event WindowEventDelegate RollupToggled = null;
	protected bool RollupToggledFunction()
	{
		if( RollupToggled != null )
			return RollupToggled(RollupToggledHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			CloseClicked
	//
	protected EventHandler CloseClickedHandler = null;
	public event WindowEventDelegate CloseClicked = null;
	protected bool CloseClickedFunction()
	{
		if( CloseClicked != null )
			return CloseClicked(CloseClickedHandler.GetWindowEventArgs());
		return true;
	}
%}

%include CEGUIFrameWindow.h