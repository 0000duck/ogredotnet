%{
#include "GaBody.h"
%}


//so that you do not need to patch GangstaWrapper for the "param" parameter name problem.
//we will just copy the class definition that swig needs to see here.
//TODO: since we copy the class struct, remeber to update it if gangsta ever changes.
//  %include "GaBody.h"
namespace Ga
{
	class Body : public Parameterized, public Named
	{
	public:
		Body(const GaString &name,GaPtr<World> world,const GaString &description);
		virtual ~Body();

		virtual void getSupportedTypes(GaStringList &types);
		virtual void getSupportedParameters(ParameterList &prmlist,const GaString &type = ParameterList::DEFAULT_TYPE);

		virtual void initialise(const ParameterList &prmlist) = 0;

		virtual void setPosition(const GaVec3 &position) = 0;
		virtual void setOrientation(const GaQuat &orientation) = 0;
		virtual void setLinearVelocity(const GaVec3 &velocity) = 0;
		virtual void setAngularVelocity(const GaVec3 &velocity) = 0;

		virtual GaVec3 getPosition() = 0;
		virtual GaQuat getOrientation() = 0;
		virtual GaVec3 getLinearVelocity() = 0;
		virtual GaVec3 getAngularVelocity() = 0;
		virtual GaVec3 getRelativeLinearVelocity() = 0;
		virtual GaVec3 getRelativeAngularVelocity() = 0;

		virtual void setLinearDamping(GaFloat damp) = 0;
		virtual void setAngularDamping(GaFloat damp) = 0;
		virtual GaFloat getLinearDamping() = 0;
		virtual GaFloat getAngularDamping() = 0;
		virtual void setMaximumAngularVelocity(GaFloat velocity) = 0;
		virtual GaFloat getMaximumAngularVelocity() = 0;

		virtual GaVec3 worldToLocal(const GaVec3 &world) = 0;
		virtual GaVec3 localToWorld(const GaVec3 &local) = 0;

		virtual void applyForce(const GaVec3 &force,const GaVec3 &position = Parameter::VEC3_ZERO) = 0;
		virtual void applyRelativeForce(const GaVec3 &force,const GaVec3 &position = Parameter::VEC3_ZERO) = 0;
		virtual void applyTorque(const GaVec3 &torque) = 0;
		virtual void applyRelativeTorque(const GaVec3 &torque) = 0;

		void setUserData(GaPtr<void> data);
		void setUserObject(const GaPtr<void> &user_object);

		inline GaPtr<void> getUserObject() const;
		inline GaPtr<World> getWorld() const;
		inline GaPtr<void> getUserData();
	};
}


%extend Ga::Body
{
	Ogre::Entity* getEntity()
	{
		return (Ogre::Entity*)static_cast<Ogre::Entity*>(self->getUserObject().cast<Ogre::SceneNode>()->getAttachedObject(0));
	}
	
	Ogre::SceneNode* getSceneNode()
	{
		return (Ogre::SceneNode*)self->getUserObject().cast<Ogre::SceneNode>().get();
	}

	static Ga::GaPtr<Ga::Body> getNullBodyPtr()
	{
		static Ga::GaPtr<Ga::Body> bodyNullPtr = Ga::GaPtr<Ga::Body>();
		return bodyNullPtr;
	}

	//Ga::GaPtr<>.release 
	void Release()
	{
		SwigValueWrapper< Ga::GaPtr<Ga::Body> > vBody;
		vBody = Ga::GaPtr<Ga::Body>( (Ga::Body*)self );
		((Ga::GaPtr<Ga::Body> &)vBody).release();
	}

}
