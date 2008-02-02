//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUIUDim.h"
%}

%ignore CEGUI::UDim::operator+;
%ignore CEGUI::UDim::operator-;
%ignore CEGUI::UDim::operator/;
%ignore CEGUI::UDim::operator*;
%ignore CEGUI::UDim::operator+=;
%ignore CEGUI::UDim::operator-=;
%ignore CEGUI::UDim::operator/=;
%ignore CEGUI::UDim::operator*=;
%ignore CEGUI::UDim::operator==;
%ignore CEGUI::UDim::operator!=;

%ignore CEGUI::UVector2::operator+;
%ignore CEGUI::UVector2::operator-;
%ignore CEGUI::UVector2::operator/;
%ignore CEGUI::UVector2::operator*;
%ignore CEGUI::UVector2::operator+=;
%ignore CEGUI::UVector2::operator-=;
%ignore CEGUI::UVector2::operator/=;
%ignore CEGUI::UVector2::operator*=;
%ignore CEGUI::UVector2::operator==;
%ignore CEGUI::UVector2::operator!=;


%include CEGUIUDim.h

%extend CEGUI::UDim
{
	const CEGUI::UDim&  Add(const CEGUI::UDim& other)			{ return ((*self) + other); }
	const CEGUI::UDim&  Subtract(const CEGUI::UDim& other)		{ return ((*self) - other); }
	const CEGUI::UDim&  Divide(const CEGUI::UDim& other)		{ return ((*self) / other); }
	const CEGUI::UDim&  Multiply(const CEGUI::UDim& other)		{ return ((*self) * other); }
	bool IsEqual(const CEGUI::UDim& other)						{ return ((*self) == other); }
};
%extend CEGUI::UVector2
{
	const CEGUI::UVector2&  Add(const CEGUI::UVector2& other)			{ return ((*self) + other); }
	const CEGUI::UVector2&  Subtract(const CEGUI::UVector2& other)		{ return ((*self) - other); }
	const CEGUI::UVector2&  Divide(const CEGUI::UVector2& other)		{ return ((*self) / other); }
	const CEGUI::UVector2&  Multiply(const CEGUI::UVector2& other)		{ return ((*self) * other); }
	bool IsEqual(const CEGUI::UVector2& other)							{ return ((*self) == other); }
};
