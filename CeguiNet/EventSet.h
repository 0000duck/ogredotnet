//The best opensource license is no license at all - The OgreDotNet team

#pragma once

#include "CEGUIEventSet.h"

typedef bool (SWIGSTDCALL *ClickedFunctionPointer)(void);

class WrappedEventSet : public CEGUI::EventSet
{
protected:
		
public:
	ClickedFunctionPointer mOnClick;

	WrappedEventSet() : EventSet()
	{
		mOnClick = NULL;
	}

	bool CEGUIClicked(const CEGUI::EventArgs& e)
	{
		if( mOnClick ) return mOnClick();
		else return false;
	}
};

extern "C" SWIGEXPORT void EventSetSetOnClicked( WrappedEventSet * el, void * fn )
{
	el->mOnClick = (ClickedFunctionPointer)fn;
}