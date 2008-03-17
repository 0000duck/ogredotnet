%{
#include "OgreAnimationTrack.h"
%}

//in all (AnimationTrack, NumericAnimationTrack, NodeAnimationTrack, VertexAnimationTrack)
%rename getNumKeyFrames            GetNumKeyFrames;
%rename getKeyFrame                GetKeyFrame;
%rename createKeyFrame             CreateKeyFrame;
%rename removeKeyFrame             RemoveKeyFrame;
%rename removeAllKeyFrames         RemoveAllKeyFrames;
%rename getInterpolatedKeyFrame    GetInterpolatedKeyFrame;
%rename apply                      Apply;
%rename hasNonZeroKeyFrames        HasNonZeroKeyFrames;
%rename optimise                   Optimise;

//in NodeAnimationTrack
%rename getAssociatedNode          GetAssociatedNode;
%rename setAssociatedNode          SetAssociatedNode;
%rename applyToNode                ApplyToNode;
%rename setUseShortestRotationPath SetUseShortestRotationPath;
%rename getUseShortestRotationPath GetUseShortestRotationPath;

// TODO how do we deal with pointer2pointer? KeyFrame**
%ignore Ogre::AnimationTrack::getKeyFramesAtTime;    
%ignore Ogre::NumericAnimationTrack::getKeyFramesAtTime;    
%ignore Ogre::NodeAnimationTrack::getKeyFramesAtTime;    
%ignore Ogre::VertexAnimationTrack::getKeyFramesAtTime;    

%typemap(cscode) Ogre::NodeAnimationTrack
%{
    public Node AssociatedNode    {
        get    { return GetAssociatedNode(); }
        set    { SetAssociatedNode((Node)value); }
    }
%}

%include OgreAnimationTrack.h
