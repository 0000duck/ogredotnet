DEMO = $(top_builddir)/Bin/Debug/DemoWinForms.exe

RESOURCES= \
	Form1.resx

CSC_FLAGS= $(CSC_TOP_FLAGS)

ASM_REFERENCES = \
	System \
	System.Xml \
	System.Drawing \
	System.Windows.Forms \
	System.Data \
	$(top_builddir)/Bin/Debug/OgreDotNet.dll \
	$(top_builddir)/Bin/Debug/Math3D.dll

ASM_REFERENCES_BUILD = $(addprefix -r:, $(ASM_REFERENCES))

RESOURCES_BUILD = $(addprefix -resource:, $(RESOURCES))

DEMO_FILES = \
	AssemblyInfo.cs \
	App.cs \
	Form1.cs

CLEANFILES = $(DEMO) $(DEMO).mdb


all: $(DEMO)


$(DEMO):
	mkdir -p $(top_builddir)/Bin/Debug/
	$(MCS) $(CSC_FLAGS) -out:$@ -target:exe $(DEMO_FILES) $(RESOURCES_BUILD) $(ASM_REFERENCES_BUILD)

