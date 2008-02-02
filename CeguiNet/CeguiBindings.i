//The best opensource license is no license at all - The OgreDotNet team

%module (directors="1") CeguiBindings

%{
#define NOMINMAX

#include "CEGUIString.h"

using namespace CEGUI;
	
#if defined( _MSC_VER )
// disable: "<type> needs to have dll-interface to be used by clients'
// Happens on STL member variables which are not public therefore is ok
#   pragma warning (disable : 4251)
#endif
#include <iostream>	//for std::cout testing

%}

//swiglabels.swg defines for SWIGSTDCALL and SWIGEXPORT
%include swiglabels.swg


#define CEGUIBASE_API
#define CEGUIEXPORT
%ignore CEGUI::lbi_greater;
%ignore CEGUI::lbi_less;

//if classes do not have expected functions uncomment next line and see if another class needs to be defined.
#pragma SWIG nowarn=401		//: Nothing known about base class '.....'. Ignored.
#pragma SWIG nowarn=402		//: Base class '...' is incomplete.

%warnfilter(503) CEGUI::colour;
%warnfilter(503) CEGUI::Vector2;
%warnfilter(844) CEGUI::Font;

%include std_string.i
%include std_vector.i
%include std_pair.i
%include std_map.i



%typemap(ctype)   const String &  "void *";
%typemap(cstype)  const String &  "string";
%typemap(csin)    const String &  "new CeguiDotNet.String($csinput).HandleRef";
%typemap(csout, excode=SWIGEXCODE)  const String & 
{
    CeguiDotNet.String ostring = new CeguiDotNet.String($imcall, false);
    string ret = ostring.c_str();
    ostring=null;
    return ret;
}



%typemap(ctype)   String * "void *";
%typemap(cstype)  String * "string";
%typemap(csin)    String * "new CeguiDotNet.String($csinput).HandleRef";
%typemap(csout, excode=SWIGEXCODE)  String *
{
    CeguiDotNet.String ostring = new CeguiDotNet.String($imcall, false);
    string ret = ostring.c_str();
    ostring=null;
    return ret;
}
%typemap(csvarout, excode=SWIGEXCODE)  String * %{
  get {
    CeguiDotNet.String ostring = new CeguiDotNet.String($imcall, false);
    string ret = ostring.c_str();
    ostring=null;
    return ret;
  }
%}


%typemap(cscode) String
%{
	public HandleRef HandleRef
	{
		get
		{
			return swigCPtr;
		}
	}
%}

%include CLSCompliancy.i

class String
{
public:
	String( const utf8 * s );
	utf8 * c_str();
};


%include CEGUIBase.h
%include CEGUIForwardRefs.i


%include CEGUIIteratorBase.i


%include CEGUIColour.i
%include CEGUIColourRect.i
%include CEGUISize.i
%include CEGUIVector.i
%include CEGUIRect.i
%include CEGUIUDim.i
%include CEGUIXMLAttributes.i
%include CEGUIXMLHandler.i
%include CEGUIXMLParser.i
%include CEGUIScriptModule.i
%include CEGUITexture.i
%include CEGUIRenderer.i
%include CEGUIFont.i
%include CEGUIFontManager.i
%include CEGUIRenderCache.i
%include DirectedRenderer.i
%include CEGUIImage.i
%include CEGUIImageSet.i
%include CEGUIImagesetManager.i
%include CEGUIMouseCursor.i
%include CEGUIEventArgs.i
%include CEGUIWindow.i
%include CEGUITooltip.i
%include CEGUIDragContainer.i
%include CEGUIInputEvent.i
%include CEGUIDataContainer.i
%include CEGUIResourceProvider.i
%include CEGUILogger.i
%include CEGUIScheme.i
%include CEGUISchemeManager.i
%include CEGUIEvent.i
%include EventSet.i
%include EventHandler.i
%include CEGUISystem.i
%include CEGUIButtonBase.i

%include CEGUIListboxItem.i
%include CEGUIListboxTextItem.i

%include CEGUIComboBox.i
//%include CEGUIComboDropList.i

%include CEGUIDragContainer.i
%include CEGUIEditbox.i
%include CEGUIFrameWindow.i
%include CEGUIGUISheet.i
%include CEGUIItemEntry.i
%include CEGUIItemListBase.i

%include CEGUIListbox.i
//%include CEGUIListHeader.i

%include CEGUIListHeaderSegment.i
%include CEGUIMultiColumnList.i
%include CEGUIMultiLineEditbox.i
%include CEGUIProgressBar.i
%include CEGUIScrollablePane.i
%include CEGUIScrollbar.i
%include CEGUIScrolledContainer.i
%include CEGUISlider.i
%include CEGUISpinner.i
%include CEGUIRenderableFrame.i
%include CEGUIStatic.i
%include CEGUITabControl.i
%include CEGUITitlebar.i
%include CEGUICheckbox.i
%include CEGUIRenderableImage.i
%include CEGUIPushButton.i
%include CEGUIThumb.i
%include CEGUIRadioButton.i
%include CEGUITabButton.i
%include CEGUIStaticImage.i
%include CEGUIStaticText.i
%include CEGUITabPane.i
%include CEGUIWindowManager.i
%include CEGUITextItem.i
%include CEGUIMenuBase.i
%include CEGUIPopupMenu.i
%include CEGUIMenuItem.i
%include CEGUIMenubar.i

