//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUIEditbox.h"
%}

%extend CEGUI::Editbox
{
	const char * GetEventReadOnlyModeChangedName()
	{
		return CEGUI::Editbox::EventReadOnlyModeChanged.c_str();
	}
	
	const char * GetEventMaskedRenderingModeChangedName()
	{
		return CEGUI::Editbox::EventMaskedRenderingModeChanged.c_str();
	}
	
	const char * GetEventMaskCodePointChangedName()
	{
		return CEGUI::Editbox::EventMaskCodePointChanged.c_str();
	}
	
	const char * GetEventValidationStringChangedName()
	{
		return CEGUI::Editbox::EventValidationStringChanged.c_str();
	}
	
	const char * GetEventMaximumTextLengthChangedName()
	{
		return CEGUI::Editbox::EventMaximumTextLengthChanged.c_str();
	}
	
	const char * GetEventTextInvalidatedName()
	{
		return CEGUI::Editbox::EventTextInvalidated.c_str();
	}
	
	const char * GetEventInvalidEntryAttemptedName()
	{
		return CEGUI::Editbox::EventInvalidEntryAttempted.c_str();
	}
	
	const char * GetEventCaratMovedName()
	{
		return CEGUI::Editbox::EventCaratMoved.c_str();
	}
	
	const char * GetEventTextSelectionChangedName()
	{
		return CEGUI::Editbox::EventTextSelectionChanged.c_str();
	}
	
	const char * GetEventEditboxFullName()
	{
		return CEGUI::Editbox::EventEditboxFull.c_str();
	}
	
	const char * GetEventTextAcceptedFullName()
	{
		return CEGUI::Editbox::EventTextAccepted.c_str();
	}
};

%typemap(cscode) CEGUI::Editbox
%{
	public override void SubscribeEvents()
	{
		base.SubscribeEvents();
		
		ReadOnlyModeChangedHandler = new EventHandler( this, this.GetEventReadOnlyModeChangedName() );
		ReadOnlyModeChangedHandler.SetCallback( new CeguiEventDelegate( ReadOnlyModeChangedFunction ));
		
		MaskedRenderingModeChangedHandler = new EventHandler( this, this.GetEventMaskedRenderingModeChangedName() );
		MaskedRenderingModeChangedHandler.SetCallback( new CeguiEventDelegate( MaskedRenderingModeChangedFunction ));
		
		MaskCodePointChangedHandler = new EventHandler( this, this.GetEventMaskCodePointChangedName() );
		MaskCodePointChangedHandler.SetCallback( new CeguiEventDelegate( MaskCodePointChangedFunction ));
		
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
		
		TextAcceptedHandler = new EventHandler( this, this.GetEventTextAcceptedFullName() );
		TextAcceptedHandler.SetCallback( new CeguiEventDelegate( TextAcceptedFunction ));
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
	//			MaskedRenderingModeChanged
	//
	protected EventHandler MaskedRenderingModeChangedHandler = null;
	public event WindowEventDelegate MaskedRenderingModeChanged = null;
	protected bool MaskedRenderingModeChangedFunction()
	{
		if( MaskedRenderingModeChanged != null )
			return MaskedRenderingModeChanged(MaskedRenderingModeChangedHandler.GetWindowEventArgs());
		return true;
	}
	
	//
	//			MaskCodePointChanged
	//
	protected EventHandler MaskCodePointChangedHandler = null;
	public event WindowEventDelegate MaskCodePointChanged = null;
	protected bool MaskCodePointChangedFunction()
	{
		if( MaskCodePointChanged != null )
			return MaskCodePointChanged(MaskCodePointChangedHandler.GetWindowEventArgs());
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
%}

%include CEGUIEditbox.h