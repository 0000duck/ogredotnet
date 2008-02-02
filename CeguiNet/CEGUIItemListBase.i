//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUIItemListBase.h"
%}

%extend CEGUI::ItemListBase
{
	const char * GetEventListContentsChangedName()
	{
		return CEGUI::ItemListBase::EventListContentsChanged.c_str();
	}
};

%typemap(cscode) CEGUI::ItemListBase
%{
	public override void SubscribeEvents()
	{
		base.SubscribeEvents();
		
		ListContentsChangedHandler = new EventHandler( this, this.GetEventListContentsChangedName() );
		ListContentsChangedHandler.SetCallback( new CeguiEventDelegate( ListContentsChangedFunction ));
	}

	//
	//			ListContentsChanged
	//
	protected EventHandler ListContentsChangedHandler = null;
	public event WindowEventDelegate ListContentsChanged = null;
	protected bool ListContentsChangedFunction()
	{
		if( ListContentsChanged != null )
			return ListContentsChanged(ListContentsChangedHandler.GetWindowEventArgs());
		return true;
	}
%}

%include CEGUIItemListBase.h