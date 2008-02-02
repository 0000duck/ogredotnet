//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUISystem.h"
%}

%typemap(cscode) CEGUI::System
%{
	public string DefaultFontName
	{
		set
		{
			setDefaultFont(value);
		}
	}
	
	public Window GUISheet
	{
		get
		{
			return getGUISheet();
		}
		set
		{
			setGUISheet( value );
		}
	}
	
	public static GuiSystem Instance
	{
		get
		{
			return new GuiSystem(CeguiBindingsPINVOKE.GuiSystem_getSingleton(), false);
		}
	}

	public static GuiSystem CreateGuiSystemSpecial(Renderer renderer)
	{
		return new GuiSystem( CeguiBindingsPINVOKE.new_GuiSystem__SWIG_1(Renderer.getCPtr(renderer)), false);
	}
%}

%rename System GuiSystem;
%rename setDefaultMouseCursor SetDefaultMouseCursor;
%rename injectMouseMove InjectMouseMove;
%rename injectMouseButtonDown InjectMouseButtonDown;
%rename injectMouseButtonUp InjectMouseButtonUp;

%include "CEGUISystem.h"
