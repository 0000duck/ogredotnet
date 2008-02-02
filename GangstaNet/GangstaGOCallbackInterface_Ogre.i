%{
#include "GaCallbackInterface_Ogre.h"
%}

%ignore Ga::CallbackInterface_Ogre::GetHeightAt;
%ignore Ga::CallbackInterface_Ogre::queryResult;

%ignore Ga::CallbackInterface_Ogre::openFile;
%ignore Ga::CallbackInterface_Ogre::getFileSize;
%ignore Ga::CallbackInterface_Ogre::readFromFile;
%ignore Ga::CallbackInterface_Ogre::closeFile;




//input arrays seem to work in Ogre::MemoryDataStream need more testing
//so these typemaps and the function shapeFromRaw that uses them can stay untill someone testes it
//----- GaFloat *vertices
%typemap(ctype)    float *vertices    "float*"
%typemap(imtype)   float *vertices    "float[]"
%typemap(cstype)   float *vertices    "float[]"
%typemap(in)       float *vertices    %{ $1 = ($1_ltype)$input; %}
%typemap(csin)     float *vertices    "$csinput"

//----- int *indices
%typemap(ctype)    int *indices    "int*"
%typemap(imtype)   int *indices    "int[]"
%typemap(cstype)   int *indices    "int[]"
%typemap(in)       int *indices    %{ $1 = ($1_ltype)$input; %}
%typemap(csin)     int *indices    "$csinput"




%include GaCallbackInterface_Ogre.h



%extend Ga::CallbackInterface_Ogre
{
	void setupCallbackInterface(Ga::GaPtr<Ga::PhysicsDriver> driver)
	{
		driver->getCallbackInterface()->setWorldStepListener( self );
		driver->getCallbackInterface()->setBodyMovementListener( self );
		driver->getCallbackInterface()->setDebugVisualProvider( self );
		driver->getCallbackInterface()->setFileAccessProvider( self );
		driver->getCallbackInterface()->setMessageOutputProvider( self );
		driver->getCallbackInterface()->setShapeCollisionListener( self );
		driver->getCallbackInterface()->setUserObjectListener( self );
#ifdef USE_TERRAIN_COLLIDE
		driver->getCallbackInterface()->setTerrainGeometryHeightListener( self );
#endif
	}

	//Ga::GaPtr<>.release 
	void Release()
	{
		SwigValueWrapper< Ga::GaPtr<Ga::CallbackInterface_Ogre> > vCallbackInterface_Ogre;
		vCallbackInterface_Ogre = Ga::GaPtr<Ga::CallbackInterface_Ogre>( (Ga::CallbackInterface_Ogre*)self );
		((Ga::GaPtr<Ga::CallbackInterface_Ogre> &)vCallbackInterface_Ogre).release();
	}
	
	
	Ga::GaPtr<Ga::Shape> shapeFromRaw(Ga::GaPtr<Ga::World> world,
		GaFloat *vertices,
		GaUint v_count,
		int *indices,
		GaUint i_count,
		Ga::GaPtr<Ga::Body> body,
		const Ogre::Matrix4 &transform = Ogre::Matrix4::IDENTITY)
	{
		GaVec3 *vverts = new GaVec3[v_count];
		GaUint *vidxs = new GaUint[i_count];
		Ogre::Vector3 vert;
		GaUint i=0;
		
		for(Ga::GaUint v = 0; v < v_count; v++)
		{
			vert.x = vertices[i++];
			vert.y = vertices[i++];
			vert.z = vertices[i++];
			vert = transform * vert;
			
			vverts[v].x = vert.x;
			vverts[v].y = vert.y;
			vverts[v].z = vert.z;
		}

		for(i = 0; i < i_count; i++)
			vidxs[i] = (GaUint)(indices[i]);
		
		
		GaPtr<Shape> shape;
		ParameterList params;
		
		shape = world->createShape("mesh");
		shape->getSupportedParameters(params,"mesh");
		
		params["vertex_count"] = (GaUint)v_count;
		params["vertices"] = GaPtr<void>(vverts);
		params["index_count"] = (GaUint)i_count;
		params["indices"] = GaPtr<void>(vidxs);
		
		shape->initialise(params);
		
		delete[] vverts;
		delete[] vidxs;
		
		return shape;
	}
	
	Ga::GaPtr<Ga::Shape> shapeFromRaw(Ga::GaPtr<Ga::World> world,
		Ogre::MemoryDataStream *dsVertices,
		Ogre::MemoryDataStream *dsIndices,
		Ga::GaPtr<Ga::Body> body,
		const Ogre::Matrix4 &transform = Ogre::Matrix4::IDENTITY)
	{
		Ogre::Vector3 vert;
		GaUint i=0;

		float *vertices = (float *)dsVertices->getPtr();
		GaUint v_count = (GaUint)dsVertices->size() / sizeof(float);
		v_count /= 3;
		GaVec3 *vverts = new GaVec3[v_count];
		
		for(Ga::GaUint v = 0; v < v_count; v++)
		{
			vert.x = (GaFloat)vertices[i++];
			vert.y = (GaFloat)vertices[i++];
			vert.z = (GaFloat)vertices[i++];
			vert = transform * vert;
			
			vverts[v].x = vert.x;
			vverts[v].y = vert.y;
			vverts[v].z = vert.z;
		}

		int *indices = (int *)dsIndices->getPtr();
		GaUint i_count = (GaUint)dsIndices->size() / sizeof(int);
		GaUint *vidxs = new GaUint[i_count];

		for(i = 0; i < i_count; i++)
			vidxs[i] = (GaUint)(indices[i]);
		
		
		GaPtr<Shape> shape;
		ParameterList params;
		
		shape = world->createShape("mesh");
		shape->getSupportedParameters(params,"mesh");
		
		params["vertex_count"] = (GaUint)v_count;
		params["vertices"] = GaPtr<void>(vverts);
		params["index_count"] = (GaUint)i_count;
		params["indices"] = GaPtr<void>(vidxs);
		
		shape->initialise(params);
		
		delete[] vverts;
		delete[] vidxs;
		
		return shape;
	}
	
};

