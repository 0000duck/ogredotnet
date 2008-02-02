//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUIWindowManager.h"
%}

%typemap(cscode) CEGUI::WindowManager
%{
	public static WindowManager Instance
	{
		get
		{
			return new WindowManager(CeguiBindingsPINVOKE.WindowManager_getSingleton(), false);
		}
	}
%}

%extend CEGUI::WindowManager
{
	CEGUI::PushButton * CreatePushButton(const String &type, const String &name)
	{
		return (CEGUI::PushButton *)WindowManager::getSingleton().createWindow(type, name);
	}
	
	CEGUI::Titlebar * CreateTitlebar(const String &type, const String &name)
	{
		return (CEGUI::Titlebar *)WindowManager::getSingleton().createWindow(type, name);
	}
	
	CEGUI::Thumb * CreateThumb(const String &type, const String &name)
	{
		return (CEGUI::Thumb *)WindowManager::getSingleton().createWindow(type, name);
	}
	
	TabPane * CreateTabPane(const String &type, const String &name)
	{
		return (TabPane *)WindowManager::getSingleton().createWindow(type, name);
	}
	
	CEGUI::TabControl * CreateTabControl(const String &type, const String &name)
	{
		return (CEGUI::TabControl *)WindowManager::getSingleton().createWindow(type, name);
	}
	
	CEGUI::TabButton * CreateTabButton(const String &type, const String &name)
	{
		return (CEGUI::TabButton *)WindowManager::getSingleton().createWindow(type, name);
	}
	
	CEGUI::StaticText * CreateStaticText(const String &type, const String &name)
	{
		return (CEGUI::StaticText *)WindowManager::getSingleton().createWindow(type, name);
	}
	
	CEGUI::StaticImage * CreateStaticImage(const String &type, const String &name)
	{
		return (CEGUI::StaticImage *)WindowManager::getSingleton().createWindow(type, name);
	}
	
	CEGUI::Static * CreateStatic(const String &type, const String &name)
	{
		return (CEGUI::Static *)WindowManager::getSingleton().createWindow(type, name);
	}
	
	CEGUI::Spinner * CreateSpinner(const String &type, const String &name)
	{
		return (CEGUI::Spinner *)WindowManager::getSingleton().createWindow(type, name);
	}
	
	CEGUI::Slider * CreateSlider(const String &type, const String &name)
	{
		return (CEGUI::Slider *)WindowManager::getSingleton().createWindow(type, name);
	}
	
	CEGUI::ScrolledContainer * CreateScrolledContainer(const String &type, const String &name)
	{
		return (CEGUI::ScrolledContainer *)WindowManager::getSingleton().createWindow(type, name);
	}
	
	CEGUI::Scrollbar * CreateScrollbar(const String &type, const String &name)
	{
		return (CEGUI::Scrollbar *)WindowManager::getSingleton().createWindow(type, name);
	}
	
	CEGUI::ScrollablePane * CreateScrollablePane(const String &type, const String &name)
	{
		return (CEGUI::ScrollablePane *)WindowManager::getSingleton().createWindow(type, name);
	}
	
	CEGUI::RadioButton * CreateRadioButton(const String &type, const String &name)
	{
		return (CEGUI::RadioButton *)WindowManager::getSingleton().createWindow(type, name);
	}
	
	CEGUI::ProgressBar * CreateProgressBar(const String &type, const String &name)
	{
		return (CEGUI::ProgressBar *)WindowManager::getSingleton().createWindow(type, name);
	}
	
	CEGUI::MultiLineEditbox * CreateMultiLineEditbox(const String &type, const String &name)
	{
		return (CEGUI::MultiLineEditbox *)WindowManager::getSingleton().createWindow(type, name);
	}
	
	CEGUI::MultiColumnList * CreateMultiColumnList(const String &type, const String &name)
	{
		return (CEGUI::MultiColumnList *)WindowManager::getSingleton().createWindow(type, name);
	}
	
	CEGUI::FrameWindow * CreateFrameWindow(const String &type, const String &name)
	{
		return (CEGUI::FrameWindow *)WindowManager::getSingleton().createWindow(type, name);
	}
	
	CEGUI::Editbox * CreateEditbox(const String &type, const String &name)
	{
		return (CEGUI::Editbox *)WindowManager::getSingleton().createWindow(type, name);
	}
	
	CEGUI::GUISheet * CreateGUISheet(const String &type, const String &name)
	{
		return (CEGUI::GUISheet *)WindowManager::getSingleton().createWindow(type, name);
	}
	
	CEGUI::DragContainer * CreateDragContainer(const String &type, const String &name)
	{
		return (CEGUI::DragContainer *)WindowManager::getSingleton().createWindow(type, name);
	}
	
	CEGUI::Combobox * CreateCombobox(const String &type, const String &name)
	{
		return (CEGUI::Combobox *)WindowManager::getSingleton().createWindow(type, name);
	}
	
	CEGUI::Checkbox * CreateCheckbox(const String &type, const String &name)
	{
		return (CEGUI::Checkbox *)WindowManager::getSingleton().createWindow(type, name);
	}
	
	CEGUI::ButtonBase * CreateButtonBase(const String &type, const String &name)
	{
		return (CEGUI::ButtonBase *)WindowManager::getSingleton().createWindow(type, name);
	}
	
	CEGUI::Menubar * CreateMenubar(const String &type, const String &name)
	{
		return (CEGUI::Menubar *)WindowManager::getSingleton().createWindow(type, name);
	}
	
	CEGUI::MenuItem * CreateMenuItem(const String &type, const String &name)
	{
		return (CEGUI::MenuItem *)WindowManager::getSingleton().createWindow(type, name);
	}
	
	CEGUI::PopupMenu * CreatePopupMenu(const String &type, const String &name)
	{
		return (CEGUI::PopupMenu *)WindowManager::getSingleton().createWindow(type, name);
	}
	
	CEGUI::Window*	LoadWindowLayout(const CEGUI::String& filename, const CEGUI::String& name_prefix = "",
		const CEGUI::String& resourceGroup = "")
	{
		return self->loadWindowLayout( filename, name_prefix, resourceGroup);
	}
}

%rename createWindow CreateWindow;

%ignore CEGUI::WindowManager::PropertyCallback;
%ignore CEGUI::WindowManager::loadWindowLayout;

%include "CEGUIWindowManager.h"


//	typedef std::map<String, Window*>			WindowRegistry;				//!< Type used to implement registry of Window objects
//	typedef	ConstBaseIterator<WindowRegistry>	WindowIterator;
PTR_REF_TYPEMAPS(Window, CEGUI::Window*)
ConstBaseMapIteratorWRAP(WindowIteratorWrap, std::map, String, CEGUI::Window*);

