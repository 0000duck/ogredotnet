//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUIScrolledContainer.h"
%}

%extend CEGUI::ScrolledContainer
{
	const char * GetEventContentChangedName()
	{
		return CEGUI::ScrolledContainer::EventContentChanged.c_str();
	}
	
	const char * GetEventAutoSizeSettingChangedName()
	{
		return CEGUI::ScrolledContainer::EventAutoSizeSettingChanged.c_str();
	}
};

%typemap(cscode) CEGUI::ScrolledContainer
%{
	public override void SubscribeEvents()
	{
		base.SubscribeEvents();
		
		ContentChangedHandler = new EventHandler( this, this.GetEventContentChangedName() );
		ContentChangedHandler.SetCallback( new CeguiEventDelegate( ContentChangedFunction ));
		
		AutoSizeSettingChangedHandler = new EventHandler( this, this.GetEventAutoSizeSettingChangedName() );
		AutoSizeSettingChangedHandler.SetCallback( new CeguiEventDelegate( AutoSizeSettingChangedFunction ));
	}

	//
	//			ContentChanged
	//
	protected EventHandler ContentChangedHandler = null;
	public event WindowEventDelegate ContentChanged = null;
	protected bool ContentChangedFunction()
	{
		if( ContentChanged != null )
			return ContentChanged(ContentChangedHandler.GetWindowEventArgs());
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
%}

%include CEGUIScrolledContainer.h