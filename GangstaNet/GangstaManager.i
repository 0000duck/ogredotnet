%{
#include "GaManager.h"
%}

%rename Ga::Exception GaException;

%include "GaManager.h"


%extend Ga::Manager {
	//Ga::GaPtr<>.release 
	void Release()
	{
		SwigValueWrapper< Ga::GaPtr<Ga::Manager> > vManager;
		vManager = Ga::GaPtr<Ga::Manager>( (Ga::Manager*)self );
		((Ga::GaPtr<Ga::Manager> &)vManager).release();
	}
};
