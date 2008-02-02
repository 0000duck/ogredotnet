OGRENETCEGUI= $(top_builddir)/Bin/Debug/OgreDotNet.Cegui.dll

RESOURCES=
CSC_FLAGS= $(CSC_TOP_FLAGS)

ASM_REFERENCES= \
	System \
	System.Xml \
	System.Drawing \
	System.Windows.Forms \
	$(top_builddir)/Bin/Debug/OgreDotNet.dll \
	$(top_builddir)/Bin/Debug/CeguiDotNet.dll

ASM_REFERENCES_BUILD= $(addprefix -r:, $(ASM_REFERENCES))

include Makefile.include

OGRENETCEGUI_FILES_CUSTOM= \
	AssemblyInfo.cs

OGRENETCEGUI_FILES = $(OGRENETCEGUI_SWIG_FILES) $(OGRENETCEGUI_FILES_CUSTOM)

CLEANFILES = $(OGRENETCEGUI) $(OGRENETCEGUI).mdb $(top_builddir)/Bin/Debug/OgreDotNet.Cegui.dll.config
DISTCLEANFILES = $(OGRENETCEGUI_SWIG_FILES) OgreBindings.Cegui_wrap.cxx OgreDotNet.Cegui.dll.config
EXTRA_DIST = Makefile.include buildCSList.sh OgreDotNet.Cegui.dll.config.in


all: libOgreDotNetCeguiBindings.la $(OGRENETCEGUI)


$(OGRENETCEGUI):
	mkdir -p $(top_builddir)/Bin/Debug/
	$(MCS) $(CSC_FLAGS) -out:$@ -target:library $(OGRENETCEGUI_FILES) $(RESOURCES) $(ASM_REFERENCES_BUILD)
	cp --reply=yes OgreDotNet.Cegui.dll.config $(top_builddir)/Bin/Debug/


lib_LTLIBRARIES=libOgreDotNetCeguiBindings.la

libOgreDotNetCeguiBindings_la_CXXFLAGS= \
	$(CEGUI_OGRE_CFLAGS) \
	$(CEGUI_CFLAGS)

libOgreDotNetCeguiBindings_la_SOURCES= \
	OgreBindings.Cegui_wrap.cxx

libOgreDotNetCeguiBindings_la_LIBADD= \
	$(CEGUI_OGRE_LIBS) \
	$(CEGUI_LIBS)

libOgreDotNetCeguiBindings_la_LDFLAGS= -version-info @CEGUINET_VERSION_INFO@


