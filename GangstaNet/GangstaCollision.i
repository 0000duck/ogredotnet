%{
#include "GaCollision.h"
%}

%include "GaCollision.h"

%extend Ga::Collision {
	//Ga::GaPtr<>.release 
	void Release()
	{
		SwigValueWrapper< Ga::GaPtr<Ga::Collision> > vCollision;
		vCollision = Ga::GaPtr<Ga::Collision>( (Ga::Collision*)self );
		((Ga::GaPtr<Ga::Collision> &)vCollision).release();
	}
};
