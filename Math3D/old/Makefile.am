DEMO = $(top_builddir)/Bin/Debug/Math3D.dll

RESOURCES=
CSC_FLAGS= $(CSC_TOP_FLAGS) -unsafe

ASM_REFERENCES = \
	System \
	System.Xml

ASM_REFERENCES_BUILD = $(addprefix -r:, $(ASM_REFERENCES))

DEMO_FILES = \
	AssemblyInfo.cs \
	Matrix3.cs \
	Matrix4.cs \
	Quaternion.cs \
	Vector2.cs \
	Vector3.cs \
	Vector4.cs


CLEANFILES = $(DEMO) $(DEMO).mdb


all: $(DEMO)


$(DEMO):
	mkdir -p $(top_builddir)/Bin/Debug/
	$(MCS) $(CSC_FLAGS) -out:$@ -target:library $(DEMO_FILES) $(RESOURCES) $(ASM_REFERENCES_BUILD)

