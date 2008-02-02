//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUIImageset.h"
%}

%include CEGUIImageset.h

//	typedef	std::map<String, Image>	ImageRegistry;
//	typedef	ConstBaseIterator<ImageRegistry>	ImageIterator;	//!< Iterator type for this collection
ConstBaseMapIteratorWRAP(ImageIteratorWrap, std::map, String, CEGUI::Image);

