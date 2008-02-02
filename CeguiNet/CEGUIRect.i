//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUIRect.h"
%}

%ignore CEGUI::Rect::operator==;
%ignore CEGUI::Rect::operator!=;
%ignore CEGUI::Rect::operator=;
%ignore CEGUI::Rect::operator*;
%ignore CEGUI::Rect::operator*=;

%include CEGUIRect.h

%extend CEGUI::Rect
{
	void Scale(float scalar)
	{
		self->d_top *= scalar;
		self->d_bottom *= scalar;
		self->d_left *= scalar;
		self->d_right *= scalar;
	}
	bool IsEqual(const CEGUI::Rect& other)
	{
		return ((*self) == other);
	}
	void  SetEqualTo(const CEGUI::Rect& other)
	{
		self->d_top = other.d_top; 
		self->d_bottom = other.d_bottom; 
		self->d_left = other.d_left; 
		self->d_right = other.d_right; 
	}
};

