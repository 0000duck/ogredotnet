//The best opensource license is no license at all - The OgreDotNet team

#pragma once

#include <CEGUIWindow.h>

typedef bool (SWIGSTDCALL *EventFunctionPointer)(void);

class EventHandler
{
protected:
	CEGUI::EventArgs * mEventArgs;

	bool HandleCEGUIEvent(const CEGUI::EventArgs& e)
	{
		this->mEventArgs = (CEGUI::EventArgs*)&e;
		if(mEventFunctionPointer) 
			return mEventFunctionPointer();
		else
			return true;
	}
public:
	EventHandler( CEGUI::Window * window, const CEGUI::String & eventname )
	{
		//mEventArgs = new CEGUI::EventArgs();
		mEventFunctionPointer = NULL;
		window->subscribeEvent( eventname, Event::Subscriber(&EventHandler::HandleCEGUIEvent, this));
	}

	EventFunctionPointer mEventFunctionPointer;

	CEGUI::MouseEventArgs * GetMouseEventArgs()
	{
		return (CEGUI::MouseEventArgs *) this->mEventArgs;
	}

	CEGUI::WindowEventArgs * GetWindowEventArgs()
	{
		return (CEGUI::WindowEventArgs *) this->mEventArgs;
	}

	CEGUI::ActivationEventArgs * GetActivationEventArgs()
	{
		return (CEGUI::ActivationEventArgs *) this->mEventArgs;
	}

	CEGUI::DragDropEventArgs * GetDragDropEventArgs()
	{
		return (CEGUI::DragDropEventArgs *) this->mEventArgs;
	}

	CEGUI::KeyEventArgs * GetKeyEventArgs()
	{
		return (CEGUI::KeyEventArgs *) this->mEventArgs;
	}
};

extern "C" SWIGEXPORT void EventHandlerSetCallback( EventHandler * e, void * fn )
{
	e->mEventFunctionPointer = (EventFunctionPointer)fn;
}