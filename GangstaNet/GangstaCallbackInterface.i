%{
#include "GaCallbackInterface.h"
%}

namespace Ga
{
	class CallbackInterface
	{
	public:
		CallbackInterface();
		virtual ~CallbackInterface();

		void resetToDefaults();
	};
}

PTR_REF_TYPEMAPS(CallbackInterface, Ga::CallbackInterface)

%extend Ga::CallbackInterface {
	//Ga::GaPtr<>.release 
	void Release()
	{
		SwigValueWrapper< Ga::GaPtr<Ga::CallbackInterface> > vCallbackInterface;
		vCallbackInterface = Ga::GaPtr<Ga::CallbackInterface>( (Ga::CallbackInterface*)self );
		((Ga::GaPtr<Ga::CallbackInterface> &)vCallbackInterface).release();
	}
};
