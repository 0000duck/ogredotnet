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
    get    {
        return (CSTYPE)($imcall);
    }
%}
%typemap(out) TYPE  %{ $result = (CTYPE)$1; %}
%enddef

SIMPLE_TYPEMAP(ResourceHandle, unsigned long,    UInt32)
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


//there are a few std::map templates that need this for their key values
%define SIMPLE_RETRUN_PTR_TYPEMAP(TYPE, CTYPE, CSTYPE)
%typemap(ctype)  TYPE & "CTYPE"
%typemap(imtype) TYPE & "CSTYPE"
%typemap(cstype) TYPE & "CSTYPE"
%typemap(csout, excode=SWIGEXCODE)  TYPE & 
{
    return (CSTYPE)($imcall);
}
%typemap(out) TYPE & %{ $result = (CTYPE)*$1; %}
%typemap(ctype)  TYPE * "CTYPE"
%typemap(imtype) TYPE * "CSTYPE"
%typemap(cstype) TYPE * "CSTYPE"
%typemap(csout, excode=SWIGEXCODE)  TYPE * 
{
    return (CSTYPE)($imcall);
}
%typemap(out) TYPE * %{ $result = (CTYPE)*$1; %}
%enddef
SIMPLE_RETRUN_PTR_TYPEMAP(unsigned long,  unsigned long,    UInt32)
SIMPLE_RETRUN_PTR_TYPEMAP(size_t,         unsigned long,    UInt32)
SIMPLE_RETRUN_PTR_TYPEMAP(unsigned short, unsigned short,   UInt16)


%define SIMPLE_ARRAY_TYPE_IN(CTYPE, CSTYPE)
%typemap(ctype)  CTYPE *INPUTARRAY   "void *"
%typemap(imtype) CTYPE *INPUTARRAY   "CSTYPE[]"
%typemap(cstype) CTYPE *INPUTARRAY   "CSTYPE[]"
%typemap(in)     CTYPE *INPUTARRAY   %{ $1 = ($1_ltype)$input; %}
%typemap(csin)   CTYPE *INPUTARRAY   "$csinput"
%enddef
SIMPLE_ARRAY_TYPE_IN(unsigned char,  byte)
SIMPLE_ARRAY_TYPE_IN(double,  double)
SIMPLE_ARRAY_TYPE_IN(float,  float)
SIMPLE_ARRAY_TYPE_IN(int,  int)


%define VOID_PTR_TYPEMAP(TYPE, CTYPE)
%typemap(ctype)        TYPE    "CTYPE"
%typemap(imtype)    TYPE    "IntPtr"
%typemap(cstype)    TYPE    "IntPtr"
%typemap(in)        TYPE    %{ $1 = (CTYPE)$input; %}
%typemap(out)        TYPE    %{ $result = $1; %}
%typemap(csin)        TYPE    "$csinput"
%typemap(csout, excode=SWIGEXCODE)        TYPE
{
    return new IntPtr((int)$imcall);
}
%typemap(csvarin)    TYPE
%{
    set {
        $imcall;
    }
%}
%typemap(csvarout)    TYPE
%{
    get {
        return new IntPtr((int)$imcall);
    }
%}
%enddef
VOID_PTR_TYPEMAP(void *,              void *)
VOID_PTR_TYPEMAP(void[ANY],           void *)
VOID_PTR_TYPEMAP(void[],              void *)
VOID_PTR_TYPEMAP(uchar *,             unsigned char *)
VOID_PTR_TYPEMAP(unsigned char *,     unsigned char *)
VOID_PTR_TYPEMAP(unsigned char[ANY],  unsigned char *)
VOID_PTR_TYPEMAP(unsigned char[],     unsigned char *)
VOID_PTR_TYPEMAP(unsigned char **,    unsigned char **)


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
%typemap(in)       const CTYPE *, const CTYPE & 
%{
    $1 = (CTYPE *)$input;
%}
%typemap(out)      const CTYPE *, const CTYPE &   %{ $result = (void *)*$1; %}
#endif
%enddef


%define DLLEnumType(CSTYPE, CTYPE)
#if defined(SWIGCSHARP)
%typemap(ctype)    CTYPE   "int";
%typemap(imtype)   CTYPE   "CSTYPE";
%typemap(cstype)   CTYPE   "CSTYPE";
%typemap(csin)     CTYPE   "(CSTYPE)$csinput"
%typemap(csout)    CTYPE 
{
    return (CSTYPE)$imcall;
}
%typemap(out)      CTYPE   %{ $result = (int)$1; %}
%typemap(in)       CTYPE   %{ $1 = (CTYPE)$input; %}
#endif
%enddef


%define DLLNonePtrType(CSTYPE, CTYPE)
#if defined(SWIGCSHARP)
%typemap(ctype)    CTYPE   "void *";
%typemap(imtype)   CTYPE   "IntPtr";
%typemap(cstype)   CTYPE   "CSTYPE";
%typemap(csbase)   CTYPE   "CSTYPE";
%typemap(csin)     CTYPE   "CSTYPE.getCPtr($csinput).Handle"
%typemap(csout, excode=SWIGEXCODE)    CTYPE   {
    IntPtr cPtr = $imcall;
    return (cPtr == IntPtr.Zero) ? null : new CSTYPE(cPtr, $owner);
}
%typemap(out)      CTYPE   %{ $result = (void *)new CTYPE($1); %}
#endif
%enddef


// ***************************************************************************************
// The following typemaps are required to be able to wrap another library that uses
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
