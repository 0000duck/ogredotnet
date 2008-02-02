#pragma once

#include "CEGUIString.h"

class Convert
{
public:
	static const char * ToNetString( CEGUI::String * s )
	{
		CEGUI::String * s2 = (CEGUI::String *)s;
		return s2->c_str();
	}

	static CEGUI::String * ToCeguiString( char * s )
	{
		return new CEGUI::String( s );
	}
};