//for pointers/reference use the default swig typemaping 
//use for each function in their *.i file like:
//%include typemaps.i
// %apply double *INPUT { double *theVarible, double *theVarible };
// %apply double *OUTPUT { double *theVarible };
// %apply double *INOUT { double *theVarible };



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
%typemap(ctype)    const CTYPE *, const CTYPE &   "void *"
%typemap(imtype)   const CTYPE *, const CTYPE &   "IntPtr"
%typemap(cstype)   const CTYPE *, const CTYPE &   "CSTYPE"
%typemap(csin)     const CTYPE *, const CTYPE &   "CSTYPE.getCPtr($csinput).Handle"
%typemap(csout)    const CTYPE *, const CTYPE &   {
    IntPtr cPtr = $imcall;
    return (cPtr == IntPtr.Zero) ? null : new CSTYPE(cPtr, $owner);
  }
%typemap(in)       const CTYPE *, const CTYPE &   (CTYPE *temp = 0) %{
temp = (CTYPE *)$input;
$1 = &temp;
%}
%typemap(out)      const CTYPE *, const CTYPE &   %{ $result = (void *)*$1; %}
#endif
%enddef



// ***************************************************************************************
// The following typemaps are required to be able to wrap another library that use GangstaDotNet.
// They make the constructors and the getCPtr() methods accessible, so the other wrapper
// can create GangstaDotNet objects.
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
