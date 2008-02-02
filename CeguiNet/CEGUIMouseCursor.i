//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUIMouseCursor.h"
%}

%typemap(cscode) CEGUI::MouseCursor
%{
	public static MouseCursor Instance	{
		get	{
			return new MouseCursor(CeguiBindingsPINVOKE.MouseCursor_getSingleton(), false);
		}
	}
%}

%include CEGUIMouseCursor.h
