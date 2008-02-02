//The best opensource license is no license at all - The OgreDotNet team

typedef	unsigned long	ulong;
typedef unsigned short	ushort;
typedef unsigned int	uint;
typedef unsigned char	uchar;

typedef unsigned int    uint32;
typedef unsigned short  uint16;
typedef unsigned char   uint8;

## utf32 and utf8 stuff
##
typedef		uint8	utf8;
typedef		uint32	utf32;


%include typemaps.i
//for pointer/reference parameters to simple types use the default swig typemaping 
//for each function in their *.i file like:
// %apply double *INPUT { double *theVarible, double *theVarible2 };
// %apply double *OUTPUT { double *theVarible };
// %apply double *INOUT { double *theVarible };
//
//TODO figure out,  for functions that return a pointer to a simple type




%define SIMPLE_TYPEMAP(TYPE, CTYPE, CSTYPE)
%typemap(ctype)  TYPE "CTYPE"
%typemap(imtype) TYPE "CSTYPE"
%typemap(cstype) TYPE "CSTYPE"
%typemap(csin)   TYPE "(CSTYPE)$csinput"
%typemap(csout, excode=SWIGEXCODE)  TYPE
{
	return (CSTYPE)($imcall);
}
%typemap(csvarout) TYPE
%{
	get	{
		return (CSTYPE)($imcall);
	}
%}
%typemap(out) TYPE  %{ $result = (CTYPE)$1; %}
%enddef

SIMPLE_TYPEMAP(unsigned long,  unsigned long,    UInt32)
SIMPLE_TYPEMAP(ulong,          unsigned long,    UInt32)
SIMPLE_TYPEMAP(size_t,         unsigned long,    UInt32)

SIMPLE_TYPEMAP(unsigned char,  unsigned char,    Byte)
SIMPLE_TYPEMAP(uchar,          unsigned char,    Byte)
SIMPLE_TYPEMAP(uint8,          unsigned char,    Byte)

SIMPLE_TYPEMAP(short,          short,            Int16)
SIMPLE_TYPEMAP(long,           long,             Int32)

SIMPLE_TYPEMAP(unsigned short, unsigned short,   UInt16)
SIMPLE_TYPEMAP(ushort,         unsigned short,   UInt16)
SIMPLE_TYPEMAP(uint16,         unsigned short,   UInt16)

SIMPLE_TYPEMAP(unsigned int,   unsigned int,     UInt32)
SIMPLE_TYPEMAP(uint,           unsigned int,     UInt32)
SIMPLE_TYPEMAP(uint32,         unsigned int,     UInt32)



%define VOID_PTR_TYPEMAP(TYPE, CTYPE)
%typemap(ctype)		TYPE	"CTYPE"
%typemap(imtype)	TYPE	"IntPtr"
%typemap(cstype)	TYPE	"IntPtr"
%typemap(in)		TYPE	%{ $1 = (CTYPE)$input; %}
%typemap(out)		TYPE	%{ $result = $1; %}
%typemap(csin)		TYPE	"$csinput"
%typemap(csout, excode=SWIGEXCODE)		TYPE
{
	return new IntPtr((int)$imcall);
}
%typemap(csvarin)	TYPE
%{
	set {
		$imcall;
	}
%}
%typemap(csvarout)	TYPE
%{
	get {
		return new IntPtr((int)$imcall);
	}
%}
%enddef
VOID_PTR_TYPEMAP( void *,              void * )
VOID_PTR_TYPEMAP( void[ANY],           void * )
VOID_PTR_TYPEMAP( void[],              void * )
VOID_PTR_TYPEMAP( uchar *,             unsigned char * )
VOID_PTR_TYPEMAP( unsigned char *,     unsigned char * )
VOID_PTR_TYPEMAP( unsigned char[ANY],  unsigned char * )
VOID_PTR_TYPEMAP( unsigned char[],     unsigned char * )
VOID_PTR_TYPEMAP( unsigned char **,    unsigned char ** )




//pointer typemaps:
%define PTR_REF_TYPEMAPS(CSTYPE, CTYPE)
#if defined(SWIGCSHARP)
%typemap(ctype)    CTYPE *, CTYPE &    "void *"
%typemap(imtype)   CTYPE *, CTYPE &    "IntPtr"
%typemap(cstype)   CTYPE *, CTYPE &    "CSTYPE"
%typemap(csin)     CTYPE *, CTYPE &    "CSTYPE.getCPtr($csinput).Handle"
%typemap(csout, excode=SWIGEXCODE)    CTYPE *, CTYPE &    {
    IntPtr cPtr = $imcall;
    return (cPtr == IntPtr.Zero) ? null : new CSTYPE(cPtr, $owner);
}
%typemap(in)       CTYPE *, CTYPE &    %{ $1 = (CTYPE *)$input; %}
%typemap(out)      CTYPE *, CTYPE &    %{ $result = (void *)$1; %}
#endif
%enddef




%define CONST_PTR_REF_TYPEMAPS(CSTYPE, CTYPE)
#if defined(SWIGCSHARP)
%typemap(ctype) const CTYPE *& "void *"
%typemap(imtype) const CTYPE *& "IntPtr"
%typemap(cstype) const CTYPE *& "CSTYPE"
%typemap(csin) const CTYPE *& "CSTYPE.getCPtr($csinput).Handle"
%typemap(csout) const CTYPE *& {
    IntPtr cPtr = $imcall;
    return (cPtr == IntPtr.Zero) ? null : new CSTYPE(cPtr, $owner);
  }
%typemap(in) const CTYPE *& (CTYPE *temp = 0) %{
temp = (CTYPE *)$input;
$1 = &temp;
%}
%typemap(out) const CTYPE *& %{ $result = (void *)*$1; %}
#endif
%enddef




//#######  unicode string stuff 
%{
typedef CEGUI::uint32 UTF32;
typedef CEGUI::uint16 UTF16;
typedef CEGUI::utf8 UTF8;
extern size_t findSizeUTF8( const UTF8** sourceStart, UTF8** outptrEnd );
extern const CEGUI::utf8 *work_UTF16_UTF8( const UTF16* inUTF16);
extern int ConvertUTF8toUTF16 (const UTF8** sourceStart, const UTF8* sourceEnd, 
	UTF16** targetStart, UTF16* targetEnd, bool strictConversion);
static UTF16 *_tmpStringBuffer=0;
static void _KillTmpStringBuffer()
{
	if (_tmpStringBuffer)
		delete [] _tmpStringBuffer;
	_tmpStringBuffer=0;
}
%}
static void _KillTmpStringBuffer();

//mono uses UTF8 all the time
//We have to return as IntPtr and use the Marshal.PtrToString,
// when just a string I get glibc error about double free
//
//Will it return unicode string?. how do we test
//return Marshal.PtrToStringUni( $imcall );   //got weird results, like the text is not unicode
//return Marshal.PtrToStringAnsi( $imcall );  //use this with mono default UTF8
//return Marshal.PtrToStringAuto( $imcall );  
//return Marshal.PtrToStringBSTR( $imcall );  //not implemented in Mono 1.1.15
//

%typemap(ctype)  utf8 *  "void *"
#if defined(_SWIG_VS2003) || defined(_SWIG_VS2005)
//### windows ###
%typemap(imtype, out="IntPtr") utf8 *  "[MarshalAs(UnmanagedType.LPWStr)] string"
#else
//### mono ###
%typemap(imtype, out="IntPtr") utf8 *  "[MarshalAs(UnmanagedType.LPTStr)] string"
#endif

%typemap(cstype) utf8 *  "string"
%typemap(csin)   utf8 *  "$csinput"

#if defined(_SWIG_VS2003) || defined(_SWIG_VS2005)
//### windows ###
%typemap(csout, excode=SWIGEXCODE)  utf8 * {
    string ret = Marshal.PtrToStringUni( $imcall );
    CeguiBindings._KillTmpStringBuffer();
    return ret;
}
#else
//### mono ###
%typemap(csout, excode=SWIGEXCODE)  utf8 * {
    string ret = Marshal.PtrToStringAnsi( $imcall );
    return ret;
}
#endif

#if defined(_SWIG_VS2003) || defined(_SWIG_VS2005)
//### windows ###
%typemap(in)     utf8 *  %{
  CEGUI::String sHold_$1 = (CEGUI::utf8*)work_UTF16_UTF8((const UTF16*)$input);
  $1 = (CEGUI::utf8 *)(sHold_$1).c_str();
%}
#else
//### mono ###
%typemap(in)     utf8 *  %{ $1 = (CEGUI::utf8 *)$input; %}
#endif

#if defined(_SWIG_VS2003) || defined(_SWIG_VS2005)
//### windows ###
%typemap(out)    utf8 *  %{
  if (_tmpStringBuffer)
    _KillTmpStringBuffer();
    
  UTF8 *sv_sourceStart=(UTF8 *)$1;
  UTF8 *sourceStart =sv_sourceStart, *sourceEnd=0;
  UTF16 *targetStart=0, *targetEnd=0;
  size_t newBufferSize = findSizeUTF8( (const UTF8**)&sourceStart, &sourceEnd );
  
  _tmpStringBuffer = new UTF16[newBufferSize +1];
  targetStart = (UTF16 *)_tmpStringBuffer;
  targetEnd = targetStart + newBufferSize;
  *targetEnd = (UTF16)0;
  
  int OK = ConvertUTF8toUTF16( (const UTF8**)&sourceStart, sourceEnd, &targetStart, targetEnd, false);
  if (OK !=0)
	$result = (void *)sv_sourceStart;
  else
    $result = (void *)_tmpStringBuffer;
%}
#else
//### mono ###
%typemap(out)    utf8 *  %{ $result = (void *)$1; %}
#endif
//#######  end unicode string stuff




// ***************************************************************************************
// The following typemaps are required to be able to wrap another library that use
// OgreDotNet.
// They make the constructors and the getCPtr() methods accessible, so the other wrapper
// can create OgreDotNet objects.
// ***************************************************************************************

// Proxy classes (base classes, ie, not derived classes)
%typemap(csbody) SWIGTYPE %{
  private HandleRef swigCPtr;
  protected bool swigCMemOwn;

  public $csclassname(IntPtr cPtr, bool cMemoryOwn) {
    swigCMemOwn = cMemoryOwn;
    swigCPtr = new HandleRef(this, cPtr);
  }

  static public HandleRef getCPtr($csclassname obj) {
    return (obj == null) ? new HandleRef(null, IntPtr.Zero) : obj.swigCPtr;
  }

  static public void RemoveOwnership($csclassname obj) {
    if (obj!=null)
		obj.swigCMemOwn=false;
  }

%}


// Derived proxy classes
%typemap(csbody_derived) SWIGTYPE %{
  private HandleRef swigCPtr;

  public $csclassname(IntPtr cPtr, bool cMemoryOwn) : base($modulePINVOKE.$csclassnameUpcast(cPtr), cMemoryOwn) {
    swigCPtr = new HandleRef(this, cPtr);
  }

  static public HandleRef getCPtr($csclassname obj) {
    return (obj == null) ? new HandleRef(null, IntPtr.Zero) : obj.swigCPtr;
  }

  static public void RemoveOwnership($csclassname obj) {
    if (obj!=null)
		obj.swigCMemOwn=false;
  }
%}

// Typewrapper classes
%typemap(csbody) SWIGTYPE *, SWIGTYPE &, SWIGTYPE [], SWIGTYPE (CLASS::*) %{
  private HandleRef swigCPtr;

  public $csclassname(IntPtr cPtr, bool futureUse) {
    swigCPtr = new HandleRef(this, cPtr);
  }

  protected $csclassname() {
    swigCPtr = new HandleRef(null, IntPtr.Zero);
  }

  static public HandleRef getCPtr($csclassname obj) {
    return (obj == null) ? new HandleRef(null, IntPtr.Zero) : obj.swigCPtr;
  }
%}
