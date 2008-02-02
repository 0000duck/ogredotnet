%{
#include "GaRay.h"
%}

%include "GaRay.h"

%extend Ga::Ray {
	// when used from World.createRay
	//ray needs a way to release from a Ga::GaPtr<>
	void Release()
	{
		SwigValueWrapper< Ga::GaPtr<Ga::Ray> > vRay;
		vRay = Ga::GaPtr<Ga::Ray>( (Ga::Ray*)self );
		((Ga::GaPtr<Ga::Ray> &)vRay).release();
	}
};
