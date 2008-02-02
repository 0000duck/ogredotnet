%{
#include "GaDebugVisual.h"
%}

%include "GaDebugVisual.h"


%extend Ga::DebugVisual {
	//Ga::GaPtr<>.release 
	void Release()
	{
		SwigValueWrapper< Ga::GaPtr<Ga::DebugVisual> > vDebugVisual;
		vDebugVisual = Ga::GaPtr<Ga::DebugVisual>( (Ga::DebugVisual*)self );
		((Ga::GaPtr<Ga::DebugVisual> &)vDebugVisual).release();
	}
};
