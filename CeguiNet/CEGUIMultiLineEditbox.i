//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUIMultiLineEditbox.h"
%}

%extend CEGUI::MultiLineEditbox
{
	const char * GetEventReadOnlyModeChangedName()
	{
		return CEGUI::MultiLineEditbox::EventReadOnlyModeChanged.c_str();
	}
	
	const char * GetEventWordWrapModeChangedName()
	{
		return CEGUI::MultiLineEditbox::EventWordWrapModeChanged.c_str();
	}
	
	const char * GetEventMaximumTextLengthChangedName()
	{
		return CEGUI::MultiLineEditbox::EventMaximumTextLengthChanged.c_str();
	}
	
	const char * GetEventCaratMovedName()
	{
		return CEGUI::MultiLineEditbox::EventCaratMoved.c_str();
	}
	
	const char * GetEventTextSelectionChangedName()
	{
		return CEGUI::MultiLineEditbox::EventTextSelectionChanged.c_str();
	}
	
	const char * GetEventEditboxFullName()
	{
		return CEGUI::MultiLineEditbox::EventEditboxFull.c_str();
	}
	
	const char * GetEventVertScrollbarModeChangedName()
	{
		return CEGUI::MultiLineEditbox::EventVertScrollbarModeChanged.c_str();
	}
	
	const char * GetEventHorzScrollbarModeChangedName()
	{
		return CEGUI::MultiLineEditbox::EventHorzScrollbarModeChanged.c_str();
	}
};

%typemap(cscode) CEGUI::MultiLineEditbox
%{
	public override void SubscribeEvents()
	{
		base.SubscribeEvents();
		
		ReadOnlyModeChangedHandler = new EventHandler( this, this.GetEventReadOnlyModeChangedName() );
		ReadOnlyModeChangedHandler.SetCallback( new CeguiEventDelegate( ReadOnlyModeChangedFunction ));
		
		WordWrapModeChangedHandler = new EventHandler( this, this.GetEventWordWrapModeChangedName() );
		WordWrapModeChangedHandler.SetCallback( new CeguiEventDelegate( WordWrapModeChangedFunction ));
		
		MaximumTextLengthChangedHandler = new EventHandler( this, this.GetEventMaximumTextLengthChangedName() );
		MaximumTextLengthChangedHandler.SetCallback( new CeguiEventDelegate( MaximumTextLengthChangedFunction ));
		
		CaratMovedHandler = new EventHandler( this, this.GetEventCaratMovedName() );
		CaratMovedHandler.SetCallback( new CeguiEventDelegate( CaratMovedFunction ));
		
		TextSelectionChangedHandler = new EventHandler( this, this.GetEventTextSelectionChangedName() );
		TextSelectionChangedHandler.SetCallback( new CeguiEventDelegate( TextSelectionChangedFunction ));
		
		EditboxFullHandler = new EventHandler( this, this.GetEventEditboxFullName() );
		EditboxFullHandler.SetCallback( new CeguiEventDelegate( EditboxFullFunction ));
		
		VertScrollbarModeChangedHandler = new EventHandler( this, this.GetEventVertScrollbarModeChangedName() );
		VertScrollbarModeChangedHandler.SetCallback( new CeguiEventDelegate( VertScrollbarModeChangedFunction ));
		
		HorzScrollbarModeChangedHandler = new EventHandler( this, this.GetEventHorzScrollbarModeChangedName() );
		HorzScrollbarModeChangedHandler.SetCallback( new CeguiEventDelegate( HorzScrollbarModeChangedFunction ));
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
	//			WordWrapModeChanged
	//
	protected EventHandler WordWrapModeChangedHandler = null;
	public event WindowEventDelegate WordWrapModeChanged = null;
	protected bool WordWrapModeChangedFunction()
	{
		if( WordWrapModeChanged != null )
			return WordWrapModeChanged(WordWrapModeChangedHandler.GetWindowEventArgs());
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

%include CEGUIMultiLineEditbox.h