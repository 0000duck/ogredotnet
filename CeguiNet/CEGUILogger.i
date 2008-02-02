//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUILogger.h"
%}

%typemap(cscode) CEGUI::Logger
%{
	public static Logger Instance
	{
		get
		{
			return new Logger(CeguiBindingsPINVOKE.Logger_getSingleton(), false);
		}
	}
%}

%include "CEGUILogger.h"