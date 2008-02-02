//The best opensource license is no license at all - The OgreDotNet team

%{
	#include "EventHandler.h"
%}

%ignore EventHandler::EventHandlerSetCallback;
%ignore EventHandler::mEventFunctionPointer;

%typemap(cscode) EventHandler
%{
	[DllImport("CeguiBindings", EntryPoint="EventHandlerSetCallback")]
	public static extern void _SetCallback( HandleRef eventhandler, CeguiEventDelegate fn );
	protected CeguiEventDelegate mDelegate = null;
	public void SetCallback(CeguiEventDelegate del)
	{

		mDelegate = del;
		_SetCallback(swigCPtr, mDelegate);

	}
%}

%include EventHandler.h