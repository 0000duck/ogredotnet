DEMO = $(top_builddir)/Bin/Debug/DemoCompositor.exe

RESOURCES=
CSC_FLAGS= $(CSC_TOP_FLAGS)

ASM_REFERENCES = \
	System \
	System.Xml \
	System.Drawing \
	$(top_builddir)/Bin/Debug/Math3D.dll \
	$(top_builddir)/Bin/Debug/OgreDotNet.dll \
	$(top_builddir)/Bin/Debug/CeguiDotNet.dll \
	$(top_builddir)/Bin/Debug/OgreDotNet.Cegui.dll

ASM_REFERENCES_BUILD = $(addprefix -r:, $(ASM_REFERENCES))

DEMO_FILES = \
	AssemblyInfo.cs \
	Compositor.cs \
	CpIsListener.cs \
	ItemSelector.cs

CLEANFILES = $(DEMO) $(DEMO).mdb


all: $(DEMO)


$(DEMO):
	mkdir -p $(top_builddir)/Bin/Debug/
	$(MCS) $(CSC_FLAGS) -out:$@ -target:exe $(DEMO_FILES) $(RESOURCES) $(ASM_REFERENCES_BUILD)

