//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUIRenderer.h"
%}

%typemap(cscode) CEGUI::Renderer
%{
	public Renderer()
	{
	
	}

	public void Initialise( HandleRef cptr, bool memown )
	{
		swigCPtr = cptr;
		swigCMemOwn = memown;
	}
%}

%include "CEGUIRenderer.h"