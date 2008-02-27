%{
#include "OgreAnimation.h"
%}

// enum InterpolationMode
#define IM_LINEAR        Linear
#define IM_SPLINE        Spline
// enum RotationInterpolationMode
#define RIM_LINEAR       RLinear
#define RIM_SPHERICAL    Spherical

%rename Ogre::Animation::createNodeTrack                CreateNodeTrack;
%rename Ogre::Animation::createNumericTrack                CreateNumericTrack;
%rename Ogre::Animation::createVertexTrack                CreateVertexTrack;
%rename Ogre::Animation::destroyNodeTrack                DestroyNodeTrack;
%rename Ogre::Animation::destroyNumericTrack            DestroyNumericTrack;
%rename Ogre::Animation::destroyVertexTrack                DestroyVertexTrack;
%rename Ogre::Animation::destroyAllTracks                DestroyAllTracks;
%rename Ogre::Animation::destroyAllNodeTracks            DestroyAllNodeTracks;
%rename Ogre::Animation::destroyAllNumericTracks        DestroyAllNumericTracks;
%rename Ogre::Animation::destroyAllVertexTracks            DestroyAllVertexTracks;
%rename Ogre::Animation::getNodeTrack                    GetNodeTrack;
%rename Ogre::Animation::getNumericTrack                GetNumericTrack;
%rename Ogre::Animation::getVertexTrack                    GetVertexTrack;
%rename Ogre::Animation::hasNodeTrack                    HasNodeTrack;
%rename Ogre::Animation::hasNumericTrack                HasNumericTrack;
%rename Ogre::Animation::hasVertexTrack                    HasVertexTrack;
%rename Ogre::Animation::getNumNodeTracks                GetNumNodeTracks;
%rename Ogre::Animation::getNumNumericTracks            GetNumNumericTracks;
%rename Ogre::Animation::getNumVertexTracks                GetNumVertexTracks;
%rename Ogre::Animation::getNodeTrackIterator            GetNodeTrackIterator;
%rename Ogre::Animation::getNumericTrackIterator        GetNumericTrackIterator;
%rename Ogre::Animation::getVertexTrackIterator            GetVertexTrackIterator;
%rename Ogre::Animation::_getNodeTrackList                GetNodeTrackList;
%rename Ogre::Animation::_getNumericTrackList            GetNumericTrackList;
%rename Ogre::Animation::apply Apply;
%rename Ogre::Animation::optimise Optimise;
%rename Ogre::Animation::getName GetName;
%rename Ogre::Animation::getLength GetLength;
%rename Ogre::Animation::setRotationInterpolationMode SetRotationInterpolationMode;
%rename Ogre::Animation::setDefaultInterpolationMode  SetDefaultInterpolationMode;
%rename Ogre::Animation::setInterpolationMode SetInterpolationMode;
%rename Ogre::Animation::getInterpolationMode GetInterpolationMode;
%rename Ogre::Animation::getRotationInterpolationMode  GetRotationInterpolationMode;
%rename Ogre::Animation::getDefaultInterpolationMode   GetDefaultInterpolationMode;
%rename Ogre::Animation::setDefaultRotationInterpolationMode  SetDefaultRotationInterpolationMode;
%rename Ogre::Animation::getDefaultRotationInterpolationMode  GetDefaultRotationInterpolationMode;


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



