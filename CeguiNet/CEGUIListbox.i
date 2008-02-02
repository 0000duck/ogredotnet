//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUIListbox.h"
%}

%ignore CEGUI::Listbox::operator<;
%ignore CEGUI::Listbox::operator>;

%extend CEGUI::Listbox
{
	const char * GetEventListContentsChangedName()
	{
		return CEGUI::Listbox::EventListContentsChanged.c_str();
	}
	
	const char * GetEventSelectionChangedName()
	{
		return CEGUI::Listbox::EventSelectionChanged.c_str();
	}
	
	const char * GetEventSortModeChangedName()
	{
		return CEGUI::Listbox::EventSortModeChanged.c_str();
	}
	
	const char * GetEventMultiselectModeChangedName()
	{
		return CEGUI::Listbox::EventMultiselectModeChanged.c_str();
	}
	
	const char * GetEventVertScrollbarModeChangedName()
	{
		return CEGUI::Listbox::EventVertScrollbarModeChanged.c_str();
	}
	
	const char * GetEventHorzScrollbarModeChangedName()
	{
		return CEGUI::Listbox::EventHorzScrollbarModeChanged.c_str();
	}
};

%typemap(cscode) CEGUI::Listbox
%{
	public override void SubscribeEvents()
	{
		base.SubscribeEvents();
		
		ListContentsChangedHandler = new EventHandler( this, this.GetEventListContentsChangedName() );
		ListContentsChangedHandler.SetCallback( new CeguiEventDelegate( ListContentsChangedFunction ));
		
		SelectionChangedHandler = new EventHandler( this, this.GetEventSelectionChangedName() );
		SelectionChangedHandler.SetCallback( new CeguiEventDelegate( SelectionChangedFunction ));
		
		SortModeChangedHandler = new EventHandler( this, this.GetEventSortModeChangedName() );
		SortModeChangedHandler.SetCallback( new CeguiEventDelegate( SortModeChangedFunction ));
		
		MultiselectModeChangedHandler = new EventHandler( this, this.GetEventMultiselectModeChangedName() );
		MultiselectModeChangedHandler.SetCallback( new CeguiEventDelegate( MultiselectModeChangedFunction ));
		
		VertScrollbarModeChangedHandler = new EventHandler( this, this.GetEventVertScrollbarModeChangedName() );
		VertScrollbarModeChangedHandler.SetCallback( new CeguiEventDelegate( VertScrollbarModeChangedFunction ));
		
		HorzScrollbarModeChangedHandler = new EventHandler( this, this.GetEventHorzScrollbarModeChangedName() );
		HorzScrollbarModeChangedHandler.SetCallback( new CeguiEventDelegate( HorzScrollbarModeChangedFunction ));
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
	
	//
	//			SortModeChanged
	//
	protected EventHandler SortModeChangedHandler = null;
	public event WindowEventDelegate SortModeChanged = null;
	protected bool SortModeChangedFunction()
	{
		if( SortModeChanged != null )
			return SortModeChanged(SortModeChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			MultiselectModeChanged
	//
	protected EventHandler MultiselectModeChangedHandler = null;
	public event WindowEventDelegate MultiselectModeChanged = null;
	protected bool MultiselectModeChangedFunction()
	{
		if( MultiselectModeChanged != null )
			return MultiselectModeChanged(MultiselectModeChangedHandler.GetWindowEventArgs());
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
%}

%include CEGUIListbox.h