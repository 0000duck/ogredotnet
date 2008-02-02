//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUIListboxItem.h"
%}

%ignore CEGUI::ListboxItem::operator<;
%ignore CEGUI::ListboxItem::operator>;

%include CEGUIListboxItem.h