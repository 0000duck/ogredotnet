//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUIMultiColumnList.h"
%}

%ignore CEGUI::MCLGridRef::operator=;
%ignore CEGUI::MCLGridRef::operator<;
%ignore CEGUI::MCLGridRef::operator>;
%ignore CEGUI::MCLGridRef::operator<=;
%ignore CEGUI::MCLGridRef::operator>=;
%ignore CEGUI::MCLGridRef::operator==;
%ignore CEGUI::MCLGridRef::operator!=;

%extend CEGUI::MultiColumnList
{
	const char * GetEventSelectionModeChangedName()
	{
		return CEGUI::MultiColumnList::EventSelectionModeChanged.c_str();
	}
	
	const char * GetEventNominatedSelectColumnChangedName()
	{
		return CEGUI::MultiColumnList::EventNominatedSelectColumnChanged.c_str();
	}
	
	const char * GetEventNominatedSelectRowChangedName()
	{
		return CEGUI::MultiColumnList::EventNominatedSelectRowChanged.c_str();
	}
	
	const char * GetEventVertScrollbarModeChangedName()
	{
		return CEGUI::MultiColumnList::EventVertScrollbarModeChanged.c_str();
	}
	
	const char * GetEventHorzScrollbarModeChangedName()
	{
		return CEGUI::MultiColumnList::EventHorzScrollbarModeChanged.c_str();
	}
	
	const char * GetEventSelectionChangedName()
	{
		return CEGUI::MultiColumnList::EventSelectionChanged.c_str();
	}
	
	const char * GetEventListContentsChangedName()
	{
		return CEGUI::MultiColumnList::EventListContentsChanged.c_str();
	}
	
	const char * GetEventSortColumnChangedName()
	{
		return CEGUI::MultiColumnList::EventSortColumnChanged.c_str();
	}
	
	const char * GetEventSortDirectionChangedName()
	{
		return CEGUI::MultiColumnList::EventSortDirectionChanged.c_str();
	}
	
	const char * GetEventListColumnSizedName()
	{
		return CEGUI::MultiColumnList::EventListColumnSized.c_str();
	}
	
	const char * GetEventListColumnMovedName()
	{
		return CEGUI::MultiColumnList::EventListColumnMoved.c_str();
	}
};

%typemap(cscode) CEGUI::MultiColumnList
%{
	public override void SubscribeEvents()
	{
		base.SubscribeEvents();
		
		SelectionModeChangedHandler = new EventHandler( this, this.GetEventSelectionModeChangedName() );
		SelectionModeChangedHandler.SetCallback( new CeguiEventDelegate( SelectionModeChangedFunction ));
		
		NominatedSelectColumnChangedHandler = new EventHandler( this, this.GetEventNominatedSelectColumnChangedName() );
		NominatedSelectColumnChangedHandler.SetCallback( new CeguiEventDelegate( NominatedSelectColumnChangedFunction ));

		NominatedSelectRowChangedHandler = new EventHandler( this, this.GetEventNominatedSelectRowChangedName() );
		NominatedSelectRowChangedHandler.SetCallback( new CeguiEventDelegate( NominatedSelectRowChangedFunction ));

		VertScrollbarModeChangedHandler = new EventHandler( this, this.GetEventVertScrollbarModeChangedName() );
		VertScrollbarModeChangedHandler.SetCallback( new CeguiEventDelegate( VertScrollbarModeChangedFunction ));

		HorzScrollbarModeChangedHandler = new EventHandler( this, this.GetEventHorzScrollbarModeChangedName() );
		HorzScrollbarModeChangedHandler.SetCallback( new CeguiEventDelegate( HorzScrollbarModeChangedFunction ));

		SelectionChangedHandler = new EventHandler( this, this.GetEventSelectionChangedName() );
		SelectionChangedHandler.SetCallback( new CeguiEventDelegate( SelectionChangedFunction ));
		
		ListContentsChangedHandler = new EventHandler( this, this.GetEventListContentsChangedName() );
		ListContentsChangedHandler.SetCallback( new CeguiEventDelegate( ListContentsChangedFunction ));
		
		SortColumnChangedHandler = new EventHandler( this, this.GetEventSortColumnChangedName() );
		SortColumnChangedHandler.SetCallback( new CeguiEventDelegate( SortColumnChangedFunction ));
		
		SortDirectionChangedHandler = new EventHandler( this, this.GetEventSortDirectionChangedName() );
		SortDirectionChangedHandler.SetCallback( new CeguiEventDelegate( SortDirectionChangedFunction ));
		
		ListColumnSizedHandler = new EventHandler( this, this.GetEventListColumnSizedName() );
		ListColumnSizedHandler.SetCallback( new CeguiEventDelegate( ListColumnSizedFunction ));
		
		ListColumnMovedHandler = new EventHandler( this, this.GetEventListColumnMovedName() );
		ListColumnMovedHandler.SetCallback( new CeguiEventDelegate( ListColumnMovedFunction ));
	}

	//
	//			SelectionModeChanged
	//
	protected EventHandler SelectionModeChangedHandler = null;
	public event WindowEventDelegate SelectionModeChanged = null;
	protected bool SelectionModeChangedFunction()
	{
		if( SelectionModeChanged != null )
			return SelectionModeChanged(SelectionModeChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			NominatedSelectColumnChanged
	//
	protected EventHandler NominatedSelectColumnChangedHandler = null;
	public event WindowEventDelegate NominatedSelectColumnChanged = null;
	protected bool NominatedSelectColumnChangedFunction()
	{
		if( NominatedSelectColumnChanged != null )
			return NominatedSelectColumnChanged(NominatedSelectColumnChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			NominatedSelectRowChanged
	//
	protected EventHandler NominatedSelectRowChangedHandler = null;
	public event WindowEventDelegate NominatedSelectRowChanged = null;
	protected bool NominatedSelectRowChangedFunction()
	{
		if( NominatedSelectRowChanged != null )
			return NominatedSelectRowChanged(NominatedSelectRowChangedHandler.GetWindowEventArgs());
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
	//			SortColumnChanged
	//
	protected EventHandler SortColumnChangedHandler = null;
	public event WindowEventDelegate SortColumnChanged = null;
	protected bool SortColumnChangedFunction()
	{
		if( SortColumnChanged != null )
			return SortColumnChanged(SortColumnChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			SortDirectionChanged
	//
	protected EventHandler SortDirectionChangedHandler = null;
	public event WindowEventDelegate SortDirectionChanged = null;
	protected bool SortDirectionChangedFunction()
	{
		if( SortDirectionChanged != null )
			return SortDirectionChanged(SortDirectionChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			ListColumnSized
	//
	protected EventHandler ListColumnSizedHandler = null;
	public event WindowEventDelegate ListColumnSized = null;
	protected bool ListColumnSizedFunction()
	{
		if( ListColumnSized != null )
			return ListColumnSized(ListColumnSizedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			ListColumnMoved
	//
	protected EventHandler ListColumnMovedHandler = null;
	public event WindowEventDelegate ListColumnMoved = null;
	protected bool ListColumnMovedFunction()
	{
		if( ListColumnMoved != null )
			return ListColumnMoved(ListColumnMovedHandler.GetWindowEventArgs());
		return true;
	}
%}

%include CEGUIMultiColumnList.h