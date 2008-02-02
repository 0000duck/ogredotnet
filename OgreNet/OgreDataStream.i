// from Sinjaph in forums post
%{
#include "OgreDataStream.h"
#include "DataStreamExt.h"
%}

//rastaman C# has file streams.
%ignore Ogre::FileHandleDataStream;
%ignore Ogre::FileStreamDataStream;

//we may want these some day even thow buff is converted to an IntPtr 
//TODO need to create an exteded function to get chunks for binarry data
// (must be fixed size in param list, byte[256] )
//virtual size_t read(void* buf, size_t count) = 0;
//%ignore Ogre::DataStream::read;
//%ignore Ogre::MemoryDataStream::read;

//custom wrapped because out/ref type string parameters will need to use StringBuilder
//there is an extend below with a function that returns a string.
%ignore Ogre::DataStream::readLine;
%ignore Ogre::MemoryDataStream::readLine;

%ignore Ogre::DataStream::operator>>;


//   typedef SharedPtr<DataStream> DataStreamPtr;
%template(DataStreamPtr) Ogre::SharedPtr<Ogre::DataStream>;

//	typedef std::list<DataStreamPtr> DataStreamList;
SWIG_STD_LIST_SPECIALIZE_MINIMUM(DataStreamPtr  , Ogre::SharedPtr<Ogre::DataStream>)
%template(DataStreamList)  std::list<Ogre::SharedPtr<Ogre::DataStream> >;


//custom wrapped  functions that use it need to be ignored and an exteded function created to use DataStreamListSharedPtr
//   typedef SharedPtr<DataStreamList> DataStreamListPtr;
//DLLNonePtrType(DataStreamList,  std::list<Ogre::SharedPtr<Ogre::DataStream> >)
//%template(DataStreamListPtr) Ogre::SharedPtr<std::list<Ogre::SharedPtr<Ogre::DataStream> > >;



//custom wrapped  functions that use it need to be ignored and an exteded function created to use MemoryDataStreamSharedPtr
//causes error in OgreDotNet "no suitable method found to override"
//I have tried everthing under the sun, the only way is to custom warp the class 
//    typedef SharedPtr<MemoryDataStream> MemoryDataStreamPtr;
//%csmethodmodifiers Ogre::MemoryDataStreamPtr::read	"public ";
//%csmethodmodifiers Ogre::SharedPtr<Ogre::MemoryDataStream>::read	"public ";
//%csmethodmodifiers Ogre::SharedPtr<Ogre::MemoryDataStream>::read(void* buf, size_t count)	"public ";
//%ignore Ogre::SharedPtr<Ogre::MemoryDataStream>::read;
//%ignore Ogre::MemoryDataStreamPtr::read;
//%typemap(csinterfaces) Ogre::SharedPtr<Ogre::MemoryDataStream> "IDisposable, MemoryDataStream";
//%template(MemoryDataStreamPtr) Ogre::SharedPtr<Ogre::MemoryDataStream>;


%apply unsigned char *INPUTARRAY {void *newmembuff};

%newobject Ogre::MemoryDataStream::MakeTestBuffFloats;
%newobject Ogre::MemoryDataStream::MakeTestBuffDoubles;
%newobject Ogre::MemoryDataStream::MakeTestBuffInt32;


%include "OgreDataStream.h"

namespace Ogre
{
	//    typedef SharedPtr<MemoryDataStream> MemoryDataStreamPtr;
	class MemoryDataStreamSharedPtr
	{
	public:
		MemoryDataStreamSharedPtr();
		MemoryDataStreamSharedPtr(MemoryDataStream *p);
		MemoryDataStreamSharedPtr(MemoryDataStreamSharedPtr *p);
		virtual ~MemoryDataStreamSharedPtr();
		
		Ogre::MemoryDataStream* Get();
		bool IsUnique();
		unsigned int UseCount();
		bool IsNull();
		void SetNull();
	};
	//   typedef SharedPtr<DataStreamList> DataStreamListPtr;
	class DataStreamListSharedPtr
	{
	public:
		DataStreamListSharedPtr();
		DataStreamListSharedPtr(DataStreamList *p);
		DataStreamListSharedPtr(DataStreamListSharedPtr *p);
		virtual ~DataStreamListSharedPtr();
		
		Ogre::DataStreamList* Get();
		bool IsUnique();
		unsigned int UseCount();
		bool IsNull();
		void SetNull();
	};
}








%extend Ogre::DataStream {
	//virtual size_t readLine(char* buf, size_t maxCount, const String& delim = "\n");
	const Ogre::String& ReadLine(const Ogre::String& delim = "\n")
	{
		static Ogre::String s;
		char buff[1024];
		int cc= self->readLine( buff, 1024, delim);
		s = Ogre::String( buff );
		return s;
	}
	
	
};

%extend Ogre::MemoryDataStream {

	void SetBuffer(const Ogre::String& data)
	{
		Ogre::uchar *mybuff = self->getPtr();
		size_t mysize = self->size();
		size_t newdatasize = data.length();
		size_t sizeTocopy = ((newdatasize > mysize)? mysize : newdatasize);
		
		strcpy((char*)mybuff, data.substr(0, sizeTocopy).c_str() );
	}
	//.Net should se newmembuff as a byte[]
	void SetBuffer(void *newmembuff, Ogre::uint pos, Ogre::uint count)
	{
		Ogre::uchar *mybuff = self->getPtr();
		size_t mysize = self->size();
		size_t sizeTocopy = ((count > mysize)? mysize : count);
		
		memcpy(mybuff, newmembuff, sizeTocopy);
	}

	void Test_FillBufferFloatCount( void )
	{
		size_t sizediff = self->size() % sizeof(float);
		size_t numfloats = (self->size()- sizediff) / sizeof(float);
		float *p = (float*)self->getPtr();
		float v = 0.0f;
		for (size_t i=0; i<numfloats; i++)
		{
			*p = v;
			v += 1.0f;
			p++;
		}
	}
	void Test_FillBufferInt32Count( void )
	{
		size_t sizediff = self->size() % sizeof(int);
		size_t numints = (self->size()- sizediff) / sizeof(int);
		int *p = (int*)self->getPtr();
		int v = 0;
		for (size_t i=0; i<numints; i++)
		{
			*p = v;
			v += 1;
			p++;
		}
	}
	
	
	Ogre::uint8 ReadByte()
	{
		size_t pos =self->tell();
		Ogre::uint8 *p =(Ogre::uint8*)self->getCurrentPtr();
		Ogre::uint8 v = *p;
		if ( (pos + sizeof(Ogre::uint8)) <= self->size() )
			self->seek( pos + sizeof(Ogre::uint8) );
		else
			self->seek( self->size() );
		return v;
	}
	Ogre::uint16 ReadUInt16()
	{
		size_t pos =self->tell();
		Ogre::uint16 *p =(Ogre::uint16*)self->getCurrentPtr();
		Ogre::uint16 v = *p;
		if ( (pos + sizeof(Ogre::uint16)) <= self->size() )
			self->seek( pos + sizeof(Ogre::uint16) );
		else
			self->seek( self->size() );
		return v;
	}
	short ReadInt16()
	{
		size_t pos =self->tell();
		short *p =(short*)self->getCurrentPtr();
		short v = *p;
		if ( (pos + sizeof(short)) <= self->size() )
			self->seek( pos + sizeof(short) );
		else
			self->seek( self->size() );
		return v;
	}
	Ogre::uint32 ReadUInt32()
	{
		size_t pos =self->tell();
		Ogre::uint32 *p =(Ogre::uint32*)self->getCurrentPtr();
		Ogre::uint32 v = *p;
		if ( (pos + sizeof(Ogre::uint32)) <= self->size() )
			self->seek( pos + sizeof(Ogre::uint32) );
		else
			self->seek( self->size() );
		return v;
	}
	int ReadInt32()
	{
		size_t pos =self->tell();
		int *p =(int*)self->getCurrentPtr();
		int v = *p;
		if ( (pos + sizeof(int)) <= self->size() )
			self->seek( pos + sizeof(int) );
		else
			self->seek( self->size() );
		return v;
	}
	float ReadFloat()
	{
		size_t pos =self->tell();
		float *p =(float*)self->getCurrentPtr();
		float v = *p;
		if ( (pos + sizeof(float)) <= self->size() )
			self->seek( pos + sizeof(float) );
		else
			self->seek( self->size() );
		return v;
	}
	double ReadDouble()
	{
		size_t pos =self->tell();
		double *p =(double*)self->getCurrentPtr();
		double v = *p;
		if ( (pos + sizeof(double)) <= self->size() )
			self->seek( pos + sizeof(double) );
		else
			self->seek( self->size() );
		return v;
	}
	
	
	size_t SeekByte( size_t index )
	{
		self->seek( sizeof(Ogre::uint8) * index );
		return self->tell();
	}
	size_t SeekUInt16( size_t index )
	{
		self->seek( sizeof(Ogre::uint16) * index );
		return self->tell();
	}
	size_t SeekInt16( size_t index )
	{
		self->seek( sizeof(short) * index );
		return self->tell();
	}
	size_t SeekUInt32( size_t index )
	{
		self->seek( sizeof(Ogre::uint32) * index );
		return self->tell();
	}
	size_t SeekInt32( size_t index )
	{
		self->seek( sizeof(int) * index );
		return self->tell();
	}
	size_t SeekFloat( size_t index )
	{
		self->seek( sizeof(float) * index );
		return self->tell();
	}
	size_t SeekDouble( size_t index )
	{
		self->seek( sizeof(double) * index );
		return self->tell();
	}
	
};

