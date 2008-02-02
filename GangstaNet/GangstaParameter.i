%{
#include "GaParameter.h"
%}

%ignore Ga::Parameter::operator=;	// all of them
%ignore Ga::Parameter::STRING_BLANK;
%ignore Ga::Parameter::VEC3_ZERO;
%ignore Ga::Parameter::VEC3_ONE;
%ignore Ga::Parameter::VEC3_UNIT_X;
%ignore Ga::Parameter::VEC3_UNIT_Y;
%ignore Ga::Parameter::VEC3_UNIT_Z;
%ignore Ga::Parameter::QUAT_IDENTITY;
%ignore Ga::Parameter::QUAT_ZERO;
%ignore Ga::Parameter::PTR_NULL;

%ignore Ga::ParameterList::operator[];


//so that you do not need to patch GangstaWrapper for the "param" parameter name problem.
//we will just copy the class definition that swig needs to see here.
//TODO: since we copy the class struct, remeber to update it if gangsta ever changes.
//  %include "GaParameter.h"
namespace Ga
{
	class Parameter
	{
	public:
		enum Type
		{
			GPT_BOOL,
			GPT_INT,
			GPT_STRING,
			GPT_UINT,
			GPT_PTR,
			GPT_FLOAT,
			GPT_VEC3,
			GPT_QUAT
		};

	public:
		Parameter(const Parameter &param);

		Parameter(bool value,bool required = true);
		Parameter(int value,bool required = true);
		Parameter(const GaString &value,bool required = true);
		Parameter(GaUint value,bool required = true);
		Parameter(GaPtr<void> value,bool required = true);
		Parameter(GaFloat value,bool required = true);
		Parameter(const GaVec3 &value,bool required = true);
		Parameter(const GaQuat &value,bool required = true);

		~Parameter();

		Parameter &operator=(bool value);
		Parameter &operator=(int value);
		Parameter &operator=(const GaString &value);
		Parameter &operator=(GaUint value);
		Parameter &operator=(GaPtr<void> value);
		Parameter &operator=(GaFloat value);
		Parameter &operator=(const GaVec3 &value);
		Parameter &operator=(const GaQuat &value);

		bool operator==(const GaString &other) const;
		bool operator==(const char *other) const;
		bool asBool() const;
		int asInt() const;
		GaString asString() const;
		GaUint asUint() const;
		template<class _Ty> GaPtr<_Ty> asPtr() const;
		GaFloat asFloat() const;
		GaVec3 asVec3() const;
		GaQuat asQuat() const;
		Parameter::Type typeOf();
		
		//TODO: Link error becaus these do not have bodies
		//		bool isRequired();

		static GaString		STRING_BLANK;
		static GaVec3		VEC3_ZERO;
		static GaVec3		VEC3_ONE;
		static GaVec3		VEC3_UNIT_X;
		static GaVec3		VEC3_UNIT_Y;
		static GaVec3		VEC3_UNIT_Z;
		static GaQuat		QUAT_IDENTITY;
		static GaQuat		QUAT_ZERO;
		static GaPtr<void>	PTR_NULL;
	};

	class  ParameterList
	{
	public:
		ParameterList();
		~ParameterList();

		void clear(const GaString &type = ParameterList::DEFAULT_TYPE);
		void add(const GaString &name,const Parameter &param);
		void remove(const GaString &name);
		bool exists(const GaString &name) const;
		Parameter &operator[](const GaString &name) const;

		bool isType(const GaString &type) const;
		const GaString &getType() const;

		static GaString	DEFAULT_TYPE;
	};

	class Parameterized
	{
	public:
		Parameterized();
		virtual ~Parameterized();

		virtual void getSupportedTypes(GaStringList &types) = 0;
		virtual void getSupportedParameters(ParameterList &prmlist,const GaString &type = ParameterList::DEFAULT_TYPE) = 0;
		virtual void initialise(const ParameterList &prmlist) = 0;	
		void initialiseDefaults(const GaString &type = ParameterList::DEFAULT_TYPE);
	};

	class Named
	{
	public:
		Named(const GaString &name):_name(name);
		virtual ~Named();

		const GaString &getName() const;
	};
}




%extend Ga::Parameter
{
	void setBool( bool value )
	{	(*self).operator =( (bool)value );	}

	void setInt( int value )
	{	(*self).operator =( (int)value );	}

	void setString( const GaString & value )
	{	(*self).operator =( (const GaString &)value );	}

	void setUint( GaUint value )
	{	(*self).operator =( (GaUint)value );	}

	void setGaPtr( GaPtr<void> value )
	{	(*self).operator =( (GaPtr<void>)value );	}

	void setFloat( GaFloat value )
	{	(*self).operator =( (GaFloat)value );	}

	void setVec3( const GaVec3 & value )
	{	(*self).operator =( (const GaVec3 &)value );	}

	void setVec3( GaFloat x, GaFloat y, GaFloat z )
	{
		GaVec3 v= GaVec3(x,y,z);
		(*self).operator =( v );
	}

	void setQuat( const GaQuat & value )
	{	(*self) =(const GaQuat &)value;	}

	void setQuat( GaFloat w, GaFloat x, GaFloat y, GaFloat z )
	{
		GaQuat q= GaQuat(w, x, y,z);
		(*self) =  q;
	}
}


%extend Ga::ParameterList
{
	const Parameter &Item( const GaString &name )
	{
		return (*self).operator [](name);
	}
}


//GaPtr<void>
//%template(SharedSkeletonPtr) Ogre::SharedPtr<Ogre::Skeleton>;
%template(GaPtrVoid) Ga::GaPtr<void>;

