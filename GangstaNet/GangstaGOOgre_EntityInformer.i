%{
#include "Ogre_EntityInformer.h"
%}

//these return arrays but how do we tell swig to do that ? 
// need to custom wrap i think, typemaping will at most
// just give you the first element in the array
%ignore Ga::Ogre_EntityInformer::getIndices;
%ignore Ga::Ogre_EntityInformer::getSubIndices;
%ignore Ga::Ogre_EntityInformer::getVertices;
%ignore Ga::Ogre_EntityInformer::getSubVertices;




%typemap(cstype) const Ogre::Vector3 & "Math3D.Vector3"
%typemap(csin) const Ogre::Vector3 & "OgreDotNet.OgreVector3.getCPtr(OgreDotNet.OgreVector3.FromVector3($csinput))"
%typemap(csout) const Ogre::Vector3 &
{
	return OgreDotNet.OgreVector3.ToVector3(new OgreDotNet.OgreVector3($imcall, false));
}
%typemap(csvarout) const Ogre::Vector3 &
%{
get
{
	return OgreDotNet.OgreVector3.ToVector3(new OgreDotNet.OgreVector3($imcall, false));
}
%}

%typemap(cstype) const Ogre::Vector3 * "Math3D.Vector3"
%typemap(csin) const Ogre::Vector3 * "OgreDotNet.OgreVector3.getCPtr(OgreDotNet.OgreVector3.FromVector3($csinput))"
%typemap(csout) const Ogre::Vector3 *
{
	return OgreDotNet.OgreVector3.ToVector3(new OgreDotNet.OgreVector3($imcall, false));
}
%typemap(csvarout) const Ogre::Vector3 *
%{
get
{
	return OgreDotNet.OgreVector3.ToVector3(new OgreDotNet.OgreVector3($imcall, false));
}
%}


%typemap(cstype) Ogre::Vector3 "Math3D.Vector3"
%typemap(csin) Ogre::Vector3 "OgreDotNet.OgreVector3.getCPtr(OgreDotNet.OgreVector3.FromVector3($csinput))"
%typemap(csout) Ogre::Vector3
{
	return OgreDotNet.OgreVector3.ToVector3(new OgreDotNet.OgreVector3($imcall, false));
}
%typemap(csvarout) Ogre::Vector3
%{
get
{
	return OgreDotNet.OgreVector3.ToVector3(new OgreDotNet.OgreVector3($imcall, false));
}
%}


%include "Ogre_EntityInformer.h"


