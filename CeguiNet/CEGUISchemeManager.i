//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUISchemeManager.h"
%}

%rename loadScheme LoadScheme;

%typemap(cscode) CEGUI::SchemeManager
%{
	public static SchemeManager Instance
	{
		get
		{
			return new SchemeManager(CeguiBindingsPINVOKE.SchemeManager_getSingleton(), false);
		}
	}
%}

%include "CEGUISchemeManager.h"

//	typedef	std::map<String, Scheme*> SchemeRegistry;
//	typedef	ConstBaseIterator<SchemeRegistry>	SchemeIterator;
PTR_REF_TYPEMAPS(Scheme, CEGUI::Scheme*)
ConstBaseMapIteratorWRAP(SchemeIteratorWrap, std::map, String, CEGUI::Scheme*);
