%{
#include "OgreAnimationTrack.h"
%}

// TODO how do we deal with pointer2pointer? KeyFrame**
%ignore Ogre::AnimationTrack::getKeyFramesAtTime;    
%ignore Ogre::NumericAnimationTrack::getKeyFramesAtTime;    
%ignore Ogre::NodeAnimationTrack::getKeyFramesAtTime;    
%ignore Ogre::VertexAnimationTrack::getKeyFramesAtTime;    

%typemap(cscode) Ogre::NodeAnimationTrack
%{
    public Node AssociatedNode    {
        get    { return getAssociatedNode(); }
        set    { setAssociatedNode((Node)value); }
    }
%}

%include OgreAnimationTrack.h
