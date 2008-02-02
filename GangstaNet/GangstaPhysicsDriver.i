%{
#include "GaPhysicsDriver.h"
%}

%include "GaPhysicsDriver.h"


%extend Ga::PhysicsDriver {
	//Ga::GaPtr<>.release 
	void Release()
	{
		SwigValueWrapper< Ga::GaPtr<Ga::PhysicsDriver> > vPhysicsDriver;
		vPhysicsDriver = Ga::GaPtr<Ga::PhysicsDriver>( (Ga::PhysicsDriver*)self );
		((Ga::GaPtr<Ga::PhysicsDriver> &)vPhysicsDriver).release();
	}
};
