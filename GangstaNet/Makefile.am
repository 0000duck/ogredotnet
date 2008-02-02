GANGSTANET= $(top_builddir)/Bin/Debug/GangstaDotNet.dll

RESOURCES=
CSC_FLAGS= $(CSC_TOP_FLAGS)

ASM_REFERENCES= \
	System \
	System.Xml \
	System.Drawing \
	$(top_builddir)/Bin/Debug/Math3D.dll \
	$(top_builddir)/Bin/Debug/OgreDotNet.dll


ASM_REFERENCES_BUILD = $(addprefix -r:, $(ASM_REFERENCES))

include Makefile.include

GANGSTANET_FILES_CUSTOM= \
	Custom/AssemblyInfo.cs \
	Custom/GangstaExample.cs

GANGSTANET_FILES = $(GANGSTANET_SWIG_FILES) $(GANGSTANET_FILES_CUSTOM)

CLEANFILES = $(GANGSTANET) $(GANGSTANET).mdb $(top_builddir)/Bin/Debug/GangstaDotNet.dll.config
DISTCLEANFILES = $(GANGSTANET_SWIG_FILES) GangstaBindings_wrap.cxx GangstaDotNet.dll.config
EXTRA_DIST = Makefile.include buildCSList.sh GangstaDotNet.dll.config.in


all: libGangstaBindings.la $(GANGSTANET)


$(GANGSTANET):
	mkdir -p $(top_builddir)/Bin/Debug/
	$(MCS) $(CSC_FLAGS) -out:$@ -target:library $(GANGSTANET_FILES) $(RESOURCES) $(ASM_REFERENCES_BUILD)
	cp --reply=yes GangstaDotNet.dll.config $(top_builddir)/Bin/Debug/


lib_LTLIBRARIES = libGangstaBindings.la

libGangstaBindings_la_CXXFLAGS = \
	$(GANGSTA_OGRE_CFLAGS) \
	-D SWIG

libGangstaBindings_la_SOURCES = \
	GangstaBindings_wrap.cxx

libGangstaBindings_la_LIBADD = \
	$(GANGSTA_OGRE_LIBS)

libGangstaBindings_la_LDFLAGS = -version-info @GANGSTANET_VERSION_INFO@

