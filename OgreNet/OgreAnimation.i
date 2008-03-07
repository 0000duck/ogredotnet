%{
#include "OgreAnimation.h"
%}

// enum InterpolationMode
#define IM_LINEAR        Linear
#define IM_SPLINE        Spline
// enum RotationInterpolationMode
#define RIM_LINEAR       RLinear
#define RIM_SPHERICAL    Spherical

// internal functions
%ignore Ogre::Animation::_getTimeIndex;
%ignore Ogre::Animation::_getNodeTrackList;
%ignore Ogre::Animation::_getNumericTrackList;
%ignore Ogre::Animation::_collectIdentityNodeTracks;
%ignore Ogre::Animation::_destroyNodeTracks;
%ignore Ogre::Animation::_keyFrameListChanged;
%ignore Ogre::Animation::_getVertexTrackList;

//typedef SharedPtr<AnimableValue> AnimableValuePtr;
%template(AnimableValuePtr) Ogre::SharedPtr<Ogre::AnimableValue>;

%typemap(cscode) Ogre::Animation
%{
    public InterpolationMode mInterpolationMode    {
        get    {
            return (InterpolationMode)GetInterpolationMode();
        }
        set     {
            SetInterpolationMode(value);
        }
    }
    
    public RotationInterpolationMode mRotationInterpolationMode     {
        get    {
            return (RotationInterpolationMode)GetRotationInterpolationMode();
        }
        set    {
            SetRotationInterpolationMode(value);
        }
    }
    
    public InterpolationMode DefaultInterpolationMode    {
        get    {
            return (InterpolationMode)GetDefaultInterpolationMode();
        }
        set    {
            SetDefaultInterpolationMode(value);
        }
    }
    
    public RotationInterpolationMode DefaultRotationInterpolationMode    {
        get    {
            return (RotationInterpolationMode)GetDefaultRotationInterpolationMode();
        }
        set    {
            SetDefaultRotationInterpolationMode(value);
        }
    }
    
    public string Name {
        get        {
            return GetName();
        }
    }
    
    public float Length {
        get        {
            return GetLength();
        }
    }
    
    public int NumNodeTracks {
        get { return GetNumNodeTracks(); }
    }

    public int NumNumericTracks {
        get { return GetNumNumericTracks(); }
    }

    public int NumVertexTracks {
        get { return GetNumVertexTracks(); }
    }
%}

%include OgreAnimation.h 

//typedef std::map<unsigned short, NodeAnimationTrack*> NodeTrackList;
//typedef std::map<unsigned short, NumericAnimationTrack*> NumericTrackList;
//typedef std::map<unsigned short, VertexAnimationTrack*> VertexTrackList;

PTR_REF_TYPEMAPS(NodeAnimationTrack, Ogre::NodeAnimationTrack*)
PTR_REF_TYPEMAPS(NumericAnimationTrack, Ogre::NumericAnimationTrack*)
PTR_REF_TYPEMAPS(VertexAnimationTrack, Ogre::VertexAnimationTrack*)

%template(NodeTrackList) std::map<unsigned short, Ogre::NodeAnimationTrack*>;
%template(NumericTrackList) std::map<unsigned short, Ogre::NumericAnimationTrack*>;
%template(VertexTrackList) std::map<unsigned short, Ogre::VertexAnimationTrack*>;

//typedef ConstMapIterator<NodeTrackList> NodeTrackIterator;
//typedef ConstMapIterator<NumericTrackList> NumericTrackIterator;
//typedef ConstMapIterator<VertexTrackList> VertexTrackIterator;

ConstMapIteratorWRAP(NodeTrackIteratorWrap, std::map, unsigned short, Ogre::NodeAnimationTrack*);
ConstMapIteratorWRAP(NumericTrackIteratorWrap, std::map, unsigned short, Ogre::NumericAnimationTrack*);
ConstMapIteratorWRAP(VertexTrackIteratorWrap, std::map, unsigned short, Ogre::VertexAnimationTrack*);
