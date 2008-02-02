//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUIProgressBar.h"
%}

%extend CEGUI::ProgressBar
{
	const char * GetEventProgressChangedName()
	{
		return CEGUI::ProgressBar::EventProgressChanged.c_str();
	}
	
	const char * GetEventProgressDoneName()
	{
		return CEGUI::ProgressBar::EventProgressDone.c_str();
	}
};

%typemap(cscode) CEGUI::ProgressBar
%{
	public override void SubscribeEvents()
	{
		base.SubscribeEvents();
		
		ProgressChangedHandler = new EventHandler( this, this.GetEventProgressChangedName() );
		ProgressChangedHandler.SetCallback( new CeguiEventDelegate( ProgressChangedFunction ));
		
		ProgressDoneHandler = new EventHandler( this, this.GetEventProgressDoneName() );
		ProgressDoneHandler.SetCallback( new CeguiEventDelegate( ProgressDoneFunction ));
	}

	//
	//			ProgressChanged
	//
	protected EventHandler ProgressChangedHandler = null;
	public event WindowEventDelegate ProgressChanged = null;
	protected bool ProgressChangedFunction()
	{
		if( ProgressChanged != null )
			return ProgressChanged(ProgressChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			ProgressDone
	//
	protected EventHandler ProgressDoneHandler = null;
	public event WindowEventDelegate ProgressDone = null;
	protected bool ProgressDoneFunction()
	{
		if( ProgressDone != null )
			return ProgressDone(ProgressDoneHandler.GetWindowEventArgs());
		return true;
	}
%}

%include CEGUIProgressBar.h