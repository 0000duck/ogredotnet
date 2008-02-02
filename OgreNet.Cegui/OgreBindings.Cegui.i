 %module (directors="1") OgreBindings_Cegui

%{
#define NOMINMAX

#include "Ogre.h"
#include <OgreNoMemoryMacros.h>

#include "OgreCEGUIRenderer.h"
#include "OgreCEGUIResourceProvider.h"
#include "OgreCEGUITexture.h"
#include <OgreMemoryMacros.h>

using namespace CEGUI;
%}
//swiglabels.swg defines for SWIGSTDCALL and SWIGEXPORT
%include swiglabels.swg

%include std_string.i

%apply const std::string & {std::string &};
%apply std::string & {std::string *};
%apply const std::string & {const Ogre::String &};
%apply std::string & {Ogre::String &};
%apply std::string & {Ogre::String *};

%include CLSCompliancy.i

%include OgrePlatform.h
%ignore Ogre::KeyCode;

%include OgrePrerequisites.h 


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


namespace CEGUI
{
	typedef	unsigned long	ulong;
	typedef unsigned short	ushort;
	typedef unsigned int	uint;
	typedef unsigned char	uchar;

	typedef unsigned int    uint32;
	typedef unsigned short  uint16;
	typedef unsigned char   uint8;


	class Rect;
	class Size;
}




DLLNonePtrType(OgreDotNet.RenderQueueGroupID, Ogre::RenderQueueGroupID)
DLLNonePtrType(OgreDotNet.SceneType, Ogre::SceneType)
DLLNonePtrType(OgreDotNet.TexturePtr, Ogre::TexturePtr)
PTR_REF_TYPEMAPS(OgreDotNet.RenderWindow, Ogre::RenderWindow)
PTR_REF_TYPEMAPS(OgreDotNet.SceneManager, Ogre::SceneManager)
PTR_REF_TYPEMAPS(OgreDotNet.TexturePtr, Ogre::TexturePtr)




DLLNonePtrType( CeguiDotNet.String, CEGUI::String)
PTR_REF_TYPEMAPS(CeguiDotNet.String, CEGUI::String)
DLLNonePtrType( CeguiDotNet.String, String)
PTR_REF_TYPEMAPS(CeguiDotNet.String, String)

DLLNonePtrType( CeguiDotNet.QuadSplitMode, QuadSplitMode)
%typemap(ctype)    QuadSplitMode   "int";
%typemap(imtype)   QuadSplitMode   "CeguiDotNet.QuadSplitMode";
%typemap(csin)     QuadSplitMode   "(CeguiDotNet.QuadSplitMode)$csinput"

PTR_REF_TYPEMAPS(CeguiDotNet.ColourRect, ColourRect)
PTR_REF_TYPEMAPS(CeguiDotNet.ResourceProvider, ResourceProvider)
PTR_REF_TYPEMAPS(CeguiDotNet.Texture, Texture)
PTR_REF_TYPEMAPS(CeguiDotNet.RawDataContainer, RawDataContainer)





DLLNonePtrType( CeguiDotNet.Rect, CEGUI::Rect)
DLLNonePtrType( CeguiDotNet.Size, CEGUI::Size)
PTR_REF_TYPEMAPS(CeguiDotNet.Rect, CEGUI::Rect)
PTR_REF_TYPEMAPS(CeguiDotNet.Size, CEGUI::Size)



//DLLNonePtrType( CeguiDotNet.Rect, Rect)
//DLLNonePtrType( CeguiDotNet.Size, Size)
//PTR_REF_TYPEMAPS(CeguiDotNet.Rect, Rect)
//PTR_REF_TYPEMAPS(CeguiDotNet.Size, Size)

//CONST_PTR_REF_TYPEMAPS(CeguiDotNet.Rect, CEGUI::Rect)
//CONST_PTR_REF_TYPEMAPS(CeguiDotNet.Size, CEGUI::Size)






%ignore CEGUI::CEGUIRQListener;

%typemap(csbase) CEGUI::OgreCEGUIRenderer "CeguiDotNet.Renderer";
%typemap(cscode) CEGUI::OgreCEGUIRenderer
%{
   public void Initialise()
   {
      base.Initialise( swigCPtr, swigCMemOwn );
   }
%}
%include "OgreCEGUIRenderer.h"



%include OgreCEGUIResourceProvider.h


%include OgreCEGUITexture.h
