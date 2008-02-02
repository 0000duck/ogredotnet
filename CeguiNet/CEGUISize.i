//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUISize.h"
%}

%ignore CEGUI::Size::operator==;
%ignore CEGUI::Size::operator!=;

%include CEGUISize.h

%extend CEGUI::Size
{
	bool IsEqual(const CEGUI::Size& other)					{ return ((*self) == other); }
};

