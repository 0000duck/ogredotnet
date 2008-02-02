%{
#include "GaShape.h"
%}


//so that you do not need to patch GangstaWrapper for the "param" parameter name problem.
//we will just copy the class definition that swig needs to see here.
//TODO: since we copy the class struct, remeber to update it if gangsta ever changes.
//  %include "GaShape.h"
namespace Ga
{
	class Shape : public Parameterized, public Named
	{
	public:
		Shape(const GaString &name,GaPtr<World> world,GaPtr<Body> body);
		virtual ~Shape();

		virtual void getSupportedTypes(GaStringList &types);
		virtual void getSupportedParameters(ParameterList &prmlist,const GaString &type = ParameterList::DEFAULT_TYPE);

		virtual void initialise(const ParameterList &prmlist) = 0;

		virtual void setPosition(const GaVec3 &position) = 0;
		virtual void setOrientation(const GaQuat &orientation) = 0;
		virtual void setGroup(GaByte group) = 0;

		virtual GaVec3 getPosition() = 0;
		virtual GaQuat getOrientation() = 0;
		virtual GaByte getGroup() = 0;

		GaPtr<Body> getBody() const;
		GaPtr<World> getWorld() const;

		void setUserData(GaPtr<void> data);
		GaPtr<void> getUserData() const;

		virtual void setMaterial(const GaPtr<Material> &material);
		GaPtr<Material> getMaterial();
	};
}

%extend Ga::Shape {
	//Ga::GaPtr<>.release 
	void Release()
	{
		SwigValueWrapper< Ga::GaPtr<Ga::Shape> > vShape;
		vShape = Ga::GaPtr<Ga::Shape>( (Ga::Shape*)self );
		((Ga::GaPtr<Ga::Shape> &)vShape).release();
	}
};


