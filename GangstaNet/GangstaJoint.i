%{
#include "GaJoint.h"
%}

//so that you do not need to patch GangstaWrapper for the "param" parameter name problem.
//we will just copy the class definition that swig needs to see here.
//TODO: since we copy the class struct, remeber to update it if gangsta ever changes.
//  %include "GaJoint.h"
namespace Ga
{
	class Joint : public Parameterized, public Named
	{
	public:
		Joint(const GaString &name,GaPtr<World> world,GaPtr<Body> body,GaPtr<Body> other_body = GaPtr<Body>());
		virtual ~Joint();

		virtual void getSupportedTypes(GaStringList &types);
		virtual void getSupportedParameters(ParameterList &prmlist,const GaString &type = ParameterList::DEFAULT_TYPE);

		virtual void initialise(const ParameterList &prmlist) = 0;

		virtual void setAngularLimits(const GaRadian &low,const GaRadian &high,GaUint axis = 0) = 0;
		virtual void setLinearLimits(GaFloat low,GaFloat high,GaUint axis = 0) = 0;
		virtual void setMotorParameters(GaFloat velocity,GaFloat force) = 0;

		virtual GaRadian getAngle(GaUint axis = 0) = 0;
		virtual GaFloat getPosition(GaUint axis = 0) = 0;
		virtual GaFloat getAngularVelocity(GaUint axis = 0) = 0;
		virtual GaFloat getLinearVelocity(GaUint axis = 0) = 0;

		virtual void applyForce(GaFloat force,GaUint axis = 0) = 0;
		virtual void applyTorque(GaFloat torque,GaUint axis = 0) = 0;
		
		GaPtr<Body> getBody() const;
		GaPtr<Body> getOtherBody() const;
		GaPtr<World> getWorld() const;

		//TODO: Link error becaus these do not have bodies
		//	void setUserData(GaPtr<void> data);
		//	GaPtr<void> getUserData() const;
	};
}


%extend Ga::Joint {
	//Ga::GaPtr<>.release 
	void Release()
	{
		SwigValueWrapper< Ga::GaPtr<Ga::Joint> > vJoint;
		vJoint = Ga::GaPtr<Ga::Joint>( (Ga::Joint*)self );
		((Ga::GaPtr<Ga::Joint> &)vJoint).release();
	}
};
