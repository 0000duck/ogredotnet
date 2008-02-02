//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUITooltip.h"
%}

%extend CEGUI::Tooltip
{
	const char * GetEventHoverTimeChangedName()
	{
		return CEGUI::Tooltip::EventHoverTimeChanged.c_str();
	}
	
	const char * GetEventDisplayTimeChangedName()
	{
		return CEGUI::Tooltip::EventDisplayTimeChanged.c_str();
	}
	
	const char * GetEventFadeTimeChangedName()
	{
		return CEGUI::Tooltip::EventFadeTimeChanged.c_str();
	}
	
	const char * GetEventTooltipActiveName()
	{
		return CEGUI::Tooltip::EventTooltipActive.c_str();
	}
	
	const char * GetEventTooltipInactiveName()
	{
		return CEGUI::Tooltip::EventTooltipInactive.c_str();
	}
};

%typemap(cscode) CEGUI::Tooltip
%{
	public override void SubscribeEvents()
	{
		base.SubscribeEvents();
		
		HoverTimeChangedHandler = new EventHandler( this, this.GetEventHoverTimeChangedName() );
		HoverTimeChangedHandler.SetCallback( new CeguiEventDelegate( HoverTimeChangedFunction ));
		
		DisplayTimeChangedHandler = new EventHandler( this, this.GetEventDisplayTimeChangedName() );
		DisplayTimeChangedHandler.SetCallback( new CeguiEventDelegate( DisplayTimeChangedFunction ));
		
		FadeTimeChangedHandler = new EventHandler( this, this.GetEventFadeTimeChangedName() );
		FadeTimeChangedHandler.SetCallback( new CeguiEventDelegate( FadeTimeChangedFunction ));
		
		TooltipActiveHandler = new EventHandler( this, this.GetEventTooltipActiveName() );
		TooltipActiveHandler.SetCallback( new CeguiEventDelegate( TooltipActiveFunction ));
		
		TooltipInactiveHandler = new EventHandler( this, this.GetEventTooltipInactiveName() );
		TooltipInactiveHandler.SetCallback( new CeguiEventDelegate( TooltipInactiveFunction ));
	}

	//
	//			HoverTimeChanged
	//
	protected EventHandler HoverTimeChangedHandler = null;
	public event WindowEventDelegate HoverTimeChanged = null;
	protected bool HoverTimeChangedFunction()
	{
		if( HoverTimeChanged != null )
			return HoverTimeChanged(HoverTimeChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			DisplayTimeChanged
	//
	protected EventHandler DisplayTimeChangedHandler = null;
	public event WindowEventDelegate DisplayTimeChanged = null;
	protected bool DisplayTimeChangedFunction()
	{
		if( DisplayTimeChanged != null )
			return DisplayTimeChanged(DisplayTimeChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			FadeTimeChanged
	//
	protected EventHandler FadeTimeChangedHandler = null;
	public event WindowEventDelegate FadeTimeChanged = null;
	protected bool FadeTimeChangedFunction()
	{
		if( FadeTimeChanged != null )
			return FadeTimeChanged(FadeTimeChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			TooltipActive
	//
	protected EventHandler TooltipActiveHandler = null;
	public event WindowEventDelegate TooltipActive = null;
	protected bool TooltipActiveFunction()
	{
		if( TooltipActive != null )
			return TooltipActive(TooltipActiveHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			TooltipInactive
	//
	protected EventHandler TooltipInactiveHandler = null;
	public event WindowEventDelegate TooltipInactive = null;
	protected bool TooltipInactiveFunction()
	{
		if( TooltipInactive != null )
			return TooltipInactive(TooltipInactiveHandler.GetWindowEventArgs());
		return true;
	}
%}

%include CEGUITooltip.h