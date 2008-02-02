%{
#include "GaWorld.h"
%}


//so that you do not need to patch GangstaWrapper for the "param" parameter name problem.
//we will just copy the class definition that swig needs to see here.
//TODO: since we copy the class struct, remeber to update it if gangsta ever changes.
//  %include "GaWorld.h"
namespace Ga
{
	class World : public Parameterized, public Named
	{
	public:
		World(const GaString &name,GaPtr<PhysicsDriver> driver);
		virtual ~World();

		virtual void getSupportedTypes(GaStringList &types);
		virtual void getSupportedParameters(ParameterList &prmlist,const GaString &type = ParameterList::DEFAULT_TYPE);
		
		virtual void initialise(const ParameterList &prmlist) = 0;

		virtual GaPtr<Body> createBody(const GaString &name,const GaString &visual_description) = 0;
		virtual GaPtr<Shape> createShape(const GaString &name,GaPtr<Body> body = GaPtr<Body>()) = 0;
		virtual GaPtr<Ray> createRay(const GaVec3 &origin,const GaVec3 &direction,GaFloat length) = 0;
		virtual GaPtr<Joint> createJoint(const GaString &name,GaPtr<Body> body,GaPtr<Body> other_body = GaPtr<Body>()) = 0;
		virtual GaPtr<Material> createMaterial(const GaString &name) = 0;

		virtual void destroyBody(GaPtr<Body> body) = 0;
		virtual void destroyShape(GaPtr<Shape> shape) = 0;
		virtual void destroyRay(GaPtr<Ray> ray) = 0;
		virtual void destroyJoint(GaPtr<Joint> joint) = 0;

		virtual void advanceTime(GaFloat time) = 0;

		virtual GaPtr<Body> findBody(const GaString &name) = 0;

		virtual void setCollisionNotify(GaPtr<Shape> shape,GaPtr<Shape> other_shape,bool enabled) = 0;

		GaPtr<PhysicsDriver> getDriver() const;

		virtual void setGroupCollision(GaByte group_a,GaByte group_b,bool enable) = 0;
		
		virtual void setDebugVisualMode(GaUint mode);
		GaUint getDebugVisualMode();

		GaPtr<Material> getDefaultMaterial();
	};
}


%extend Ga::World {
	//Ga::GaPtr<>.release 
	void Release()
	{
		SwigValueWrapper< Ga::GaPtr<Ga::World> > vWorld;
		vWorld = Ga::GaPtr<Ga::World>( (Ga::World*)self );
		((Ga::GaPtr<Ga::World> &)vWorld).release();
	}
};
