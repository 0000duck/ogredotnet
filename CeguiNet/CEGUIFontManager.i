%{
#include "CEGUIFontManager.h"
%}


%typemap(cscode) CEGUI::FontManager
%{
	public static FontManager Instance	{
		get	{
			return new FontManager(CeguiBindingsPINVOKE.FontManager_getSingleton(), false);
		}
	}
%}

%include CEGUIFontManager.h


//	typedef	std::map<String, Font*>		FontRegistry;
//	typedef	ConstBaseIterator<FontRegistry>	FontIterator;
PTR_REF_TYPEMAPS(Font, CEGUI::Font*)
ConstBaseMapIteratorWRAP(FontIteratorWrap, std::map, String, CEGUI::Font*);

