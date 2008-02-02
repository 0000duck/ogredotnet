%{
#include "CEGUIEventSet.h"
%}

%{
typedef bool (SWIGSTDCALL *ClickedFunctionPointer)(void);
%}

%extend CEGUI::EventSet
{
		ClickedFunctionPointer mClicked;
		
		bool OnClicked(const CEGUI::EventArgs& e)
		{
		
		}
	
		void InitialiseEventHandlers()
		{
			mClicked = &this->OnClicked;
		}
};

%ignore subscribeEvent;

%include CEGUIEventSet.h
