%{
#include "GaDebugVisual_Ogre.h"
%}

%include "GaDebugVisual_Ogre.h"


%extend Ga::DebugVisual_Ogre {
	//Ga::GaPtr<>.release 
	void Release()
	{
		SwigValueWrapper< Ga::GaPtr<Ga::DebugVisual_Ogre> > vDebugVisual_Ogre;
		vDebugVisual_Ogre = Ga::GaPtr<Ga::DebugVisual_Ogre>( (Ga::DebugVisual_Ogre*)self );
		((Ga::GaPtr<Ga::DebugVisual_Ogre> &)vDebugVisual_Ogre).release();
	}
};
