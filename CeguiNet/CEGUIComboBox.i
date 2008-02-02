//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUICombobox.h"
%}

%extend CEGUI::Combobox
{
	const char * GetEventReadOnlyModeChangedName()
	{
		return CEGUI::Combobox::EventReadOnlyModeChanged.c_str();
	}
	
	const char * GetEventValidationStringChangedName()
	{
		return CEGUI::Combobox::EventValidationStringChanged.c_str();
	}
	
	const char * GetEventMaximumTextLengthChangedName()
	{
		return CEGUI::Combobox::EventMaximumTextLengthChanged.c_str();
	}
	
	const char * GetEventTextInvalidatedName()
	{
		return CEGUI::Combobox::EventTextInvalidated.c_str();
	}
	
	const char * GetEventInvalidEntryAttemptedName()
	{
		return CEGUI::Combobox::EventInvalidEntryAttempted.c_str();
	}
	
	const char * GetEventCaratMovedName()
	{
		return CEGUI::Combobox::EventCaratMoved.c_str();
	}
	
	const char * GetEventTextSelectionChangedName()
	{
		return CEGUI::Combobox::EventTextSelectionChanged.c_str();
	}
	
	const char * GetEventEditboxFullName()
	{
		return CEGUI::Combobox::EventEditboxFull.c_str();
	}
	
	const char * GetEventTextAcceptedName()
	{
		return CEGUI::Combobox::EventTextAccepted.c_str();
	}
	
	const char * GetEventListContentsChangedName()
	{
		return CEGUI::Combobox::EventListContentsChanged.c_str();
	}
	
	const char * GetEventListSelectionChangedName()
	{
		return CEGUI::Combobox::EventListSelectionChanged.c_str();
	}
	
	const char * GetEventSortModeChangedName()
	{
		return CEGUI::Combobox::EventSortModeChanged.c_str();
	}
};

%typemap(cscode) CEGUI::Combobox
%{
	public override void SubscribeEvents()
	{
		base.SubscribeEvents();
		
		ReadOnlyModeChangedHandler = new EventHandler( this, this.GetEventReadOnlyModeChangedName() );
		ReadOnlyModeChangedHandler.SetCallback( new CeguiEventDelegate( ReadOnlyModeChangedFunction ));
		
		ValidationStringChangedHandler = new EventHandler( this, this.GetEventValidationStringChangedName() );
		ValidationStringChangedHandler.SetCallback( new CeguiEventDelegate( ValidationStringChangedFunction ));
		
		MaximumTextLengthChangedHandler = new EventHandler( this, this.GetEventMaximumTextLengthChangedName() );
		MaximumTextLengthChangedHandler.SetCallback( new CeguiEventDelegate( MaximumTextLengthChangedFunction ));
		
		TextInvalidatedHandler = new EventHandler( this, this.GetEventTextInvalidatedName() );
		TextInvalidatedHandler.SetCallback( new CeguiEventDelegate( TextInvalidatedFunction ));
		
		InvalidEntryAttemptedHandler = new EventHandler( this, this.GetEventInvalidEntryAttemptedName() );
		InvalidEntryAttemptedHandler.SetCallback( new CeguiEventDelegate( InvalidEntryAttemptedFunction ));
		
		CaratMovedHandler = new EventHandler( this, this.GetEventCaratMovedName() );
		CaratMovedHandler.SetCallback( new CeguiEventDelegate( CaratMovedFunction ));
		
		TextSelectionChangedHandler = new EventHandler( this, this.GetEventTextSelectionChangedName() );
		TextSelectionChangedHandler.SetCallback( new CeguiEventDelegate( TextSelectionChangedFunction ));
		
		EditboxFullHandler = new EventHandler( this, this.GetEventEditboxFullName() );
		EditboxFullHandler.SetCallback( new CeguiEventDelegate( EditboxFullFunction ));
		
		TextAcceptedHandler = new EventHandler( this, this.GetEventTextAcceptedName() );
		TextAcceptedHandler.SetCallback( new CeguiEventDelegate( TextAcceptedFunction ));
		
		ListContentsChangedHandler = new EventHandler( this, this.GetEventListContentsChangedName() );
		ListContentsChangedHandler.SetCallback( new CeguiEventDelegate( ListContentsChangedFunction ));
		
		ListSelectionChangedHandler = new EventHandler( this, this.GetEventListSelectionChangedName() );
		ListSelectionChangedHandler.SetCallback( new CeguiEventDelegate( ListSelectionChangedFunction ));
		
		SortModeChangedHandler = new EventHandler( this, this.GetEventSortModeChangedName() );
		SortModeChangedHandler.SetCallback( new CeguiEventDelegate( SortModeChangedFunction ));
	}

	//
	//			ReadOnlyModeChanged
	//
	protected EventHandler ReadOnlyModeChangedHandler = null;
	public event WindowEventDelegate ReadOnlyModeChanged = null;
	protected bool ReadOnlyModeChangedFunction()
	{
		if( ReadOnlyModeChanged != null )
			return ReadOnlyModeChanged(ReadOnlyModeChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			ValidationStringChanged
	//
	protected EventHandler ValidationStringChangedHandler = null;
	public event WindowEventDelegate ValidationStringChanged = null;
	protected bool ValidationStringChangedFunction()
	{
		if( ValidationStringChanged != null )
			return ValidationStringChanged(ValidationStringChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			MaximumTextLengthChanged
	//
	protected EventHandler MaximumTextLengthChangedHandler = null;
	public event WindowEventDelegate MaximumTextLengthChanged = null;
	protected bool MaximumTextLengthChangedFunction()
	{
		if( MaximumTextLengthChanged != null )
			return MaximumTextLengthChanged(MaximumTextLengthChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			TextInvalidated
	//
	protected EventHandler TextInvalidatedHandler = null;
	public event WindowEventDelegate TextInvalidated = null;
	protected bool TextInvalidatedFunction()
	{
		if( TextInvalidated != null )
			return TextInvalidated(TextInvalidatedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			InvalidEntryAttempted
	//
	protected EventHandler InvalidEntryAttemptedHandler = null;
	public event WindowEventDelegate InvalidEntryAttempted = null;
	protected bool InvalidEntryAttemptedFunction()
	{
		if( InvalidEntryAttempted != null )
			return InvalidEntryAttempted(InvalidEntryAttemptedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			CaratMoved
	//
	protected EventHandler CaratMovedHandler = null;
	public event WindowEventDelegate CaratMoved = null;
	protected bool CaratMovedFunction()
	{
		if( CaratMoved != null )
			return CaratMoved(CaratMovedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			TextSelectionChanged
	//
	protected EventHandler TextSelectionChangedHandler = null;
	public event WindowEventDelegate TextSelectionChanged = null;
	protected bool TextSelectionChangedFunction()
	{
		if( TextSelectionChanged != null )
			return TextSelectionChanged(TextSelectionChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			EditboxFull
	//
	protected EventHandler EditboxFullHandler = null;
	public event WindowEventDelegate EditboxFull = null;
	protected bool EditboxFullFunction()
	{
		if( EditboxFull != null )
			return EditboxFull(EditboxFullHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			TextAccepted
	//
	protected EventHandler TextAcceptedHandler = null;
	public event WindowEventDelegate TextAccepted = null;
	protected bool TextAcceptedFunction()
	{
		if( TextAccepted != null )
			return TextAccepted(TextAcceptedHandler.GetWindowEventArgs());
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
	//			ListSelectionChanged
	//
	protected EventHandler ListSelectionChangedHandler = null;
	public event WindowEventDelegate ListSelectionChanged = null;
	protected bool ListSelectionChangedFunction()
	{
		if( ListSelectionChanged != null )
			return ListSelectionChanged(ListSelectionChangedHandler.GetWindowEventArgs());
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
%}

%include CEGUICombobox.h