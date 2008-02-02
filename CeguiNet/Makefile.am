CEGUINET= $(top_builddir)/Bin/Debug/CeguiDotNet.dll

RESOURCES=
CSC_FLAGS= $(CSC_TOP_FLAGS)

ASM_REFERENCES= \
	System \
	System.Xml

ASM_REFERENCES_BUILD= $(addprefix -r:, $(ASM_REFERENCES))

include Makefile.include

CEGUINET_FILES_CUSTOM= \
	AssemblyInfo.cs \
	Custom/CeguiEventDelegate.cs

CEGUINET_FILES = $(CEGUINET_SWIG_FILES) $(CEGUINET_FILES_CUSTOM)

CLEANFILES = $(CEGUINET) $(CEGUINET).mdb $(top_builddir)/Bin/Debug/CeguiDotNet.dll.config
DISTCLEANFILES = $(CEGUINET_SWIG_FILES) CeguiBindings_wrap.cxx CeguiDotNet.dll.config
EXTRA_DIST = Makefile.include buildCSList.sh CeguiDotNet.dll.config.in


all: libCeguiBindings.la $(CEGUINET)


$(CEGUINET):
	mkdir -p $(top_builddir)/Bin/Debug/
	$(MCS) $(CSC_FLAGS) -out:$@ -target:library $(CEGUINET_FILES) $(RESOURCES) $(ASM_REFERENCES_BUILD)
	cp --reply=yes CeguiDotNet.dll.config $(top_builddir)/Bin/Debug/


lib_LTLIBRARIES= libCeguiBindings.la

libCeguiBindings_la_CXXFLAGS= \
	$(CEGUI_CFLAGS) \
	$(CEGUI_CFLAGS2)

libCeguiBindings_la_SOURCES= \
	CeguiBindings_wrap.cxx \
	ConvertUni.cpp

libCeguiBindings_la_LIBADD= \
	$(CEGUI_LIBS)

libCeguiBindings_la_LDFLAGS= -version-info @CEGUINET_VERSION_INFO@

