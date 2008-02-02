%{
#include "GaDynamicModule.h"
%}


%include "GaDynamicModule.h"


%extend Ga::DynamicModule {
	//Ga::GaPtr<>.release 
	void Release()
	{
		SwigValueWrapper< Ga::GaPtr<Ga::DynamicModule> > vDynamicModule;
		vDynamicModule = Ga::GaPtr<Ga::DynamicModule>( (Ga::DynamicModule*)self );
		((Ga::GaPtr<Ga::DynamicModule> &)vDynamicModule).release();
	}
};
