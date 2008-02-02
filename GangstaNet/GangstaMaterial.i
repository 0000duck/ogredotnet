%{
#include "GaMaterial.h"
%}

//so that you do not need to patch GangstaWrapper for the "param" parameter name problem.
//we will just copy the class definition that swig needs to see here.
//TODO: since we copy the class struct, remeber to update it if gangsta ever changes.
//  %include "GaMaterial.h"
namespace Ga
{
	class Material : public Parameterized, public Named
	{
	public:
		Material(const GaString &name);
		virtual ~Material();

		virtual void getSupportedTypes(GaStringList &types);
		virtual void getSupportedParameters(ParameterList &prmlist,const GaString &type = ParameterList::DEFAULT_TYPE);

		virtual void initialise(const ParameterList &prmlist) = 0;
		virtual void setParameter(const GaString &name,const Parameter &value) = 0;
	};
}


%extend Ga::Material {
	//Ga::GaPtr<>.release 
	void Release()
	{
		SwigValueWrapper< Ga::GaPtr<Ga::Material> > vMaterial;
		vMaterial = Ga::GaPtr<Ga::Material>( (Ga::Material*)self );
		((Ga::GaPtr<Ga::Material> &)vMaterial).release();
	}
};
