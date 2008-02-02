DEMO = ../../Bin/Debug/DemoCEGUI.VB.exe

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
	AssemblyInfo.vb \
	DemoCEGUIVB.vb

CLEANFILES = $(DEMO) $(DEMO).mdb


all: $(DEMO)


$(DEMO):
	mbas $(CSC_FLAGS) -out:$@ -target:exe $(DEMO_FILES) $(RESOURCES) $(ASM_REFERENCES_BUILD)



clean:
	rm -f $(CLEANFILES)
