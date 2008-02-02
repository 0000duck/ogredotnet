DEMO = ../../Bin/Debug/DemoCEGUI.Boo.exe

RESOURCES=
CSC_FLAGS= -debug

ASM_REFERENCES = \
	System \
	System.Xml \
	System.Drawing \
	../../Bin/Debug/Math3D.dll \
	../../Bin/Debug/OgreDotNet.dll \
	../../Bin/Debug/CeguiDotNet.dll \
	../../Bin/Debug/OgreDotNet.Cegui.dll

ASM_REFERENCES_BUILD = $(addprefix -r:, $(ASM_REFERENCES))

DEMO_FILES = \
	CEGUIApplication.boo

CLEANFILES = $(DEMO) $(DEMO).mdb


all: $(DEMO)


$(DEMO):
	booc $(CSC_FLAGS) -output:$@ -target:exe $(DEMO_FILES) $(RESOURCES) $(ASM_REFERENCES_BUILD)



clean:
	rm -f $(CLEANFILES)
