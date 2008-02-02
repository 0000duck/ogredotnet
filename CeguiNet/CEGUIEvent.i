//The best opensource license is no license at all - The OgreDotNet team

%{
#include <CEGUIEvent.h>
%}

%ignore CEGUI::Event::subscribe;
%ignore CEGUI::Event::operator();

%include CEGUIEvent.h