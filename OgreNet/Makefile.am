OGRENET= $(top_builddir)/Bin/Debug/OgreDotNet.dll

RESOURCES=
CSC_FLAGS= $(CSC_TOP_FLAGS)

ASM_REFERENCES= \
	System \
	System.Xml \
	System.Drawing \
	System.Windows.Forms \
	$(top_builddir)/Bin/Debug/Math3D.dll

ASM_REFERENCES_BUILD = $(addprefix -r:, $(ASM_REFERENCES))

include Makefile.include

OGRENET_FILES_CUSTOM= \
	AssemblyInfo.cs \
	Custom/ControllerFloatDelegates.cs \
	Custom/Converter.cs \
	Custom/ExampleApplication.cs \
	Custom/FrameEvent.cs \
	Custom/KeyEvent.cs \
	Custom/MouseEvent.cs \
	Custom/MouseMotionEvent.cs

OGRENET_FILES = $(OGRENET_SWIG_FILES) $(OGRENET_FILES_CUSTOM)

CLEANFILES = $(OGRENET) $(OGRENET).mdb $(top_builddir)/Bin/Debug/OgreDotNet.dll.config
DISTCLEANFILES = \
 $(OGRENET_SWIG_FILES) \
 OgreBindings_wrap.cxx \
 OgreBindings_Compositor_wrap.cxx \
 OgreBindings_DotSceneOctreeHelper_wrap.cxx \
 OgreDotNet.dll.config
EXTRA_DIST = Makefile.include buildCSList.sh OgreDotNet.dll.config.in


all: libOgreBindings.la $(OGRENET)


$(OGRENET):
	mkdir -p $(top_builddir)/Bin/Debug/
	$(MCS) $(CSC_FLAGS) -out:$@ -target:library $(OGRENET_FILES) $(RESOURCES) $(ASM_REFERENCES_BUILD)
	cp --reply=yes OgreDotNet.dll.config $(top_builddir)/Bin/Debug/


lib_LTLIBRARIES = libOgreBindings.la

libOgreBindings_la_CXXFLAGS = \
	$(OGRE_CFLAGS)

libOgreBindings_la_SOURCES = \
	OgreBindings_wrap.cxx \
	OgreBindings_Compositor_wrap.cxx \
	OgreBindings_DotSceneOctreeHelper_wrap.cxx

libOgreBindings_la_LIBADD = \
	$(OGRE_LIBS)

libOgreBindings_la_LDFLAGS = -version-info @OGRENET_VERSION_INFO@

