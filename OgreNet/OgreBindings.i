%module (directors="1") OgreBindings

%{
#include "Ogre.h"
#include "OgrePrerequisites.h"
#include "OgreIteratorWrappers.h"
#include "OgreString.h"

#ifdef __APPLE__
#include "Carbon/Carbon.h"
#endif

using namespace Ogre;
%}

//swiglabels.swg defines for SWIGSTDCALL and SWIGEXPORT
%include swiglabels.swg

#define _OgreExport
#define OGRE_AUTO_SHARED_MUTE

// we know that "Nested union not currently supported (ignored)."
#pragma SWIG nowarn=312
#pragma SWIG nowarn=503
#pragma SWIG nowarn=402

//if classes do not have expected functions uncomment next line and see if another class needs to be defined.
#pragma SWIG nowarn=401        //: Nothing known about base class '.....'. Ignored.

%warnfilter(844) Ogre::Vector2;        //Warning(844): C# exception may not be thrown - no $excode or excode attribute in 'csout' typemap.
%warnfilter(844) Ogre::Vector3;
%warnfilter(844) Ogre::Vector4;
%warnfilter(844) Ogre::Matrix3;
%warnfilter(844) Ogre::Matrix4;
%warnfilter(844) Ogre::Quaternion;
%warnfilter(844) std::map;

%rename params parameters;

%include std_string.i
%include std_pair.i
%include std_vector.i
%include std_map.i

// %include new_std_map.i        //modified SWIG's version to add functions getitemValue, getitemKey
%include new_std_list.i        //modified SWIG's std_vector to use with list
%include new_std_multimap.i    //modified SWIG's std_map to use with multimap
%include new_std_set.i        //modified SWIG's std_vector to use with set

%apply const std::string & {std::string &};
%apply std::string & {std::string *};
%apply const std::string & {const Ogre::string &};
%apply std::string & {Ogre::string &};
%apply std::string & {Ogre::string *};

%include CLSCompliancy.i

%include OgrePlatform.h
%ignore Ogre::KeyCode;

%include OgrePrerequisites.h

%include OgreSharedPtr.i
%include OgreIteratorWrappers.i

// %include OgreString.i
// %include OgreStringVector.i
//%include OgreStringConverter.i
//%include OgreStringInterface.i
// %include Initialiser.i
// %include OgreColourValue.i    //so all colourvalues are the same
%include OgreCommon.i

%include OgreVector2.i
%include OgreVector3.i
%include OgreVector4.i
%include OgreMatrix3.i
%include OgreMatrix4.i
%include OgreQuaternion.i

//std::pair< uint, uint > 
// OgreFont.h , OgreTextureUnitState.h
%template(PairUintUint) std::pair<Ogre::uint, Ogre::uint>;

//std::pair<bool, Real>
//OgreMath.h , OgrePlaneBoundedVolume.h , OgreRay.h
%template(PairBoolFloat) std::pair<bool, float>;


//        typedef std::map<size_t, Vector3> VertexOffsetMap;
//OgreMesh.h , OgrePose.h
%apply unsigned long &INPUT { size_t& key };
%template(MapUInt32Vector3) std::map<size_t, Ogre::Vector3>;

%typemap(ctype)   const std::map<size_t, Ogre::Vector3> *&       "void *"
%typemap(imtype)  const std::map<size_t, Ogre::Vector3> *&       "IntPtr"
%typemap(cstype)  const std::map<size_t, Ogre::Vector3> *&       "MapUInt32Vector3"
%typemap(csin)    const std::map<size_t, Ogre::Vector3> *&       "MapUInt32Vector3.getCPtr($csinput).Handle"
%typemap(csout)   const std::map<size_t, Ogre::Vector3> *&
{
    IntPtr cPtr = $imcall;
    return (cPtr == IntPtr.Zero) ? null : new MapUInt32Vector3(cPtr, $owner);
}
%typemap(in)      const std::map<size_t, Ogre::Vector3> *& (std::map<size_t, Ogre::Vector3> *temp = 0)
%{
    temp = (std::map<size_t, Ogre::Vector3> *)$input;
    $1 = &temp;
%}
%typemap(out)     const std::map<size_t, Ogre::Vector3> *&       %{ $result = (void *)$1; %}

//        typedef std::vector<Real> LodDistanceList;
//OgreMaterial.h , OgreMesh.h
%template(VecFloats) std::vector<Ogre::Real>;

//        typedef std::vector<unsigned short> IndexMap;
// OgreMesh.h
%template(VecUShorts) std::vector<unsigned short>;

%include OgreTimer.i
// %include OgreConfigDialog.i
//%include OgreConfigFile.i
// %include OgreConfigOptionMap.i
%include OgrePlane.i
%include OgreSphere.i
%include OgreRay.i
%include OgreAxisAlignedBox.i
// %include OgrePlaneBoundedVolume.i
%include OgreMath.i
// %include OgreAutoParamDataSource.i
// %include OgreRectangle.i
// %include OgreException.i
// %include OgreDataStream.i
// %include OgreArchive.i
%include OgrePixelFormat.i
// %include OgreVertexBoneAssignment.i
// %include OgreProgressiveMesh.i
// %include Key.i
// %include EventHandler.i
// %include OgreLog.i
%include OgreNode.i
%include OgreViewport.i
// %include OgreSceneQuery.i
%include OgreSceneNode.i
%include OgreBlendMode.i
// %include OgreResource.i
%include OgreHardwareBuffer.i
// %include OgreHardwareIndexBuffer.i
// %include OgreHardwareOcclusionQuery.i
// %include OgreHardwarePixelBuffer.i
%include OgreHardwareVertexBuffer.i
// %include OgreGpuProgram.i
// %include OgreHighLevelGpuProgram.i

%include OgreAnimable.i
%include OgreShadowCaster.i
%include OgreMovableObject.i
// %include OgrePatchSurface.i

// %include OgreRenderOperation.i
%include OgreRenderQueue.i
// %include OgreRenderQueueSortingGrouping.i

// %include OgreKeyFrame.i
// %include OgrePose.i
%include OgreAnimationTrack.i    //enum VertexAnimationType befor submesh and animation
%include OgreAnimation.i
// %include OgreAnimationState.i
%include OgreSubMesh.i
// %include OgreStaticGeometry.i
// %include OgreBillboard.i
%include OgreBillboardSet.i
// %include OgreTagPoint.i
// %include OgreBone.i
// %include OgreSimpleRenderable.i
// %include OgreRectangle2D.i
%include OgreFrustum.i
%include OgreCamera.i
%include OgreLight.i
%include OgreEntity.i
%include OgreSubEntity.i
%include OgreMovablePlane.i
%include OgreMaterial.i
// %include OgreFont.i
// %include OgrePass.i
// %include OgreTechnique.i
// %include OgreTexture.i
%include OgreMesh.i
// %include OgrePatchMesh.i
// %include OgreSkeleton.i
// %include OgreSkeletonInstance.i
// %include OgreVertexIndexData.i
// %include OgreRibbonTrail.i
// %include OgreBillboardChain.i
// %include Line3D.i
%include OgreTextureUnitState.i

// %include OgreHardwareBufferManager.i
// %include OgreLogManager.i
// %include OgreScriptLoader.i
// %include OgreResourceManager.i
// %include OgreResourceGroupManager.i

// %include OgreFontManager.i
// %include OgreGpuProgramManager.i
// %include OgreHighLevelGpuProgramManager.i
// %include OgreMaterialManager.i
%include OgreMeshManager.i
// %include OgreSkeletonManager.i
%include OgreTextureManager.i

// %include OgreRenderQueueListener.i

// %include OgreController.i
// %include OgreControllerManager.i
// %include OgrePredefinedControllers.i
// %include ControllerFloatHandler.i

%include OgreRenderTarget.i
%include OgreRenderWindow.i
// %include OgreRenderTexture.i
// %include OgreRenderTargetListener.i
%include OgreRenderSystemCapabilities.i
%include OgreRenderSystem.i

// %include OgreOverlay.i
%include OgreOverlayElement.i
%include OgreOverlayContainer.i
// %include OgrePanelOverlayElement.i
// %include OgreTextAreaOverlayElement.i
// %include OgreOverlayElementFactory.i
// %include OgreOverlayManager.i

//%include OgreFactoryObj.i
// %include OgreParticle.i
// %include OgreParticleEmitter.i
// %include OgreParticleIterator.i
// %include OgreParticleSystem.i
// %include OgreParticleAffector.i
//%include OgreParticleAffectorFactory.i
//%include OgreParticleEmitterFactory.i
// %include OgreParticleSystemRenderer.i
// %include OgreParticleSystemManager.i

%include OgreSceneManager.i
%include OgreSceneManagerEnumerator.i
%include OgreRoot.i

%include OgreRenderable.i
// %include MeshBuilderHelper.i
