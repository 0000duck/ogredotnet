//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUIScrollablePane.h"
%}

%extend CEGUI::ScrollablePane
{
	const char * GetEventContentPaneChangedName()
	{
		return CEGUI::ScrollablePane::EventContentPaneChanged.c_str();
	}
	
	const char * GetEventVertScrollbarModeChangedName()
	{
		return CEGUI::ScrollablePane::EventVertScrollbarModeChanged.c_str();
	}
	
	const char * GetEventHorzScrollbarModeChangedName()
	{
		return CEGUI::ScrollablePane::EventHorzScrollbarModeChanged.c_str();
	}
	
	const char * GetEventAutoSizeSettingChangedName()
	{
		return CEGUI::ScrollablePane::EventAutoSizeSettingChanged.c_str();
	}
	
	const char * GetEventContentPaneScrolledName()
	{
		return CEGUI::ScrollablePane::EventContentPaneScrolled.c_str();
	}
};

%typemap(cscode) CEGUI::ScrollablePane
%{
	public override void SubscribeEvents()
	{
		base.SubscribeEvents();
		
		ContentPaneChangedHandler = new EventHandler( this, this.GetEventContentPaneChangedName() );
		ContentPaneChangedHandler.SetCallback( new CeguiEventDelegate( ContentPaneChangedFunction ));
		
		VertScrollbarModeChangedHandler = new EventHandler( this, this.GetEventVertScrollbarModeChangedName() );
		VertScrollbarModeChangedHandler.SetCallback( new CeguiEventDelegate( VertScrollbarModeChangedFunction ));
		
		HorzScrollbarModeChangedHandler = new EventHandler( this, this.GetEventHorzScrollbarModeChangedName() );
		HorzScrollbarModeChangedHandler.SetCallback( new CeguiEventDelegate( HorzScrollbarModeChangedFunction ));
		
		AutoSizeSettingChangedHandler = new EventHandler( this, this.GetEventAutoSizeSettingChangedName() );
		AutoSizeSettingChangedHandler.SetCallback( new CeguiEventDelegate( AutoSizeSettingChangedFunction ));
		
		ContentPaneScrolledHandler = new EventHandler( this, this.GetEventContentPaneScrolledName() );
		ContentPaneScrolledHandler.SetCallback( new CeguiEventDelegate( ContentPaneScrolledFunction ));
	}

	//
	//			ContentPaneChanged
	//
	protected EventHandler ContentPaneChangedHandler = null;
	public event WindowEventDelegate ContentPaneChanged = null;
	protected bool ContentPaneChangedFunction()
	{
		if( ContentPaneChanged != null )
			return ContentPaneChanged(ContentPaneChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			VertScrollbarModeChanged
	//
	protected EventHandler VertScrollbarModeChangedHandler = null;
	public event WindowEventDelegate VertScrollbarModeChanged = null;
	protected bool VertScrollbarModeChangedFunction()
	{
		if( VertScrollbarModeChanged != null )
			return VertScrollbarModeChanged(VertScrollbarModeChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			HorzScrollbarModeChanged
	//
	protected EventHandler HorzScrollbarModeChangedHandler = null;
	public event WindowEventDelegate HorzScrollbarModeChanged = null;
	protected bool HorzScrollbarModeChangedFunction()
	{
		if( HorzScrollbarModeChanged != null )
			return HorzScrollbarModeChanged(HorzScrollbarModeChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			AutoSizeSettingChanged
	//
	protected EventHandler AutoSizeSettingChangedHandler = null;
	public event WindowEventDelegate AutoSizeSettingChanged = null;
	protected bool AutoSizeSettingChangedFunction()
	{
		if( AutoSizeSettingChanged != null )
			return AutoSizeSettingChanged(AutoSizeSettingChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			ContentPaneScrolled
	//
	protected EventHandler ContentPaneScrolledHandler = null;
	public event WindowEventDelegate ContentPaneScrolled = null;
	protected bool ContentPaneScrolledFunction()
	{
		if( ContentPaneScrolled != null )
			return ContentPaneScrolled(ContentPaneScrolledHandler.GetWindowEventArgs());
		return true;
	}
%}

%include CEGUIScrollablePane.h