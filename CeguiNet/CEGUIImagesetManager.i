//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUIImagesetManager.h"
%}

%typemap(cscode) CEGUI::ImagesetManager
%{
	public static ImagesetManager Instance	{
		get	{
			return new ImagesetManager(CeguiBindingsPINVOKE.ImagesetManager_getSingleton(), false);
		}
	}
%}

%include CEGUIImagesetManager.h


//	typedef	std::map<String, Imageset*>		ImagesetRegistry;
//	typedef	ConstBaseIterator<ImagesetRegistry>	ImagesetIterator;
PTR_REF_TYPEMAPS(Imageset, CEGUI::Imageset*)
ConstBaseMapIteratorWRAP(ImagesetIteratorWrap, std::map, String, CEGUI::Imageset*);

