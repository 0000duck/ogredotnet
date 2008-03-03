SUBDIRS = Math3D OgreNet

if HAS_GANGSTA
SUBDIRS += GangstaNet
endif

if HAS_CEGUI
SUBDIRS += CeguiNet OgreNet.Cegui DemoCEGUI DemoCeguiMenus 
endif

SUBDIRS += Samples DemoSkyBox DemoParticleFX DemoWinForms DemoSkeletalAnimation


#pkgconfigdir = $(libdir)/pkgconfig
#pkgconfig_DATA = OgreNet.pc CeguiNet.pc

EXTRA_DIST = autogen.sh configure
#DISTCLEANFILES = OgreNet.pc CeguiNet.pc
 
