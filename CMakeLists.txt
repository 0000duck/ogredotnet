PROJECT(OGREDOTNET)

## If you get errors about not finding swig, set this:
#SET(SWIG_DIR /usr/local/bin)

# Set this to the directory containing Ogre.h, etc.
#SET(OGRE_INCLUDE_DIR /Library/Frameworks/Ogre.framework/Headers)

SET(INTERFACE_FILES OgreNet/OgreBindings.i OgreNet/OgreBindings_Compositor.i OgreNet/OgreBindings_DotSceneOctreeHelper.i)
SET(SRC_FILES "")

FIND_PACKAGE(SWIG REQUIRED)
INCLUDE(${SWIG_USE_FILE})

SET_SOURCE_FILES_PROPERTIES(${INTERFACE_FILES} PROPERTIES CPLUSPLUS ON)
INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR}/OgreNet
  ${OGRE_INCLUDE_DIR})

IF(WINDOWS)
  SET(CMAKE_SWIG_FLAGS -c++ -csharp -namespace OgreDotNet)
ELSE(WINDOWS)
  SET(CMAKE_SWIG_FLAGS -c++ -csharp -namespace OgreDotNet -D_MONO)
ENDIF(WINDOWS)  

SET(CMAKE_SWIG_OUTDIR OgreNet/build)

SWIG_ADD_MODULE(OgreDotNet csharp
  ${INTERFACE_FILES} ${SRC_FILES})
SWIG_LINK_LIBRARIES(OgreDotNet)
