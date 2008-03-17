%{
#include "OgreAnimationState.h"
#include "ControllerFloatHandler.h"

namespace Ogre
{
    class AnimationStateControllerValueDirector :
        public AnimationStateControllerValue,
        public ControllerValueFloatDirector
    {
    public:
        AnimationStateControllerValueDirector(AnimationState* targetAnimationState)    :
            ControllerValueFloatDirector(),
            AnimationStateControllerValue(targetAnimationState)
        {}
        virtual ~AnimationStateControllerValueDirector() {}
    };
}
%}

%rename Ogre::AnimationState::getAnimationName GetAnimationName;
%rename Ogre::AnimationState::getTimePosition GetTimePosition;
%rename Ogre::AnimationState::setTimePosition SetTimePosition;
%rename Ogre::AnimationState::getLength GetLength;
%rename Ogre::AnimationState::setLength SetLength;
%rename Ogre::AnimationState::getWeight GetWeight;
%rename Ogre::AnimationState::setWeight SetWeight;
%rename Ogre::AnimationState::addTime AddTime;
%rename Ogre::AnimationState::getEnabled GetEnabled;
%rename Ogre::AnimationState::setEnabled SetEnabled;
%rename Ogre::AnimationState::getLoop GetLoop;
%rename Ogre::AnimationState::setLoop SetLoop;
%rename Ogre::AnimationState::copyStateFrom CopyStateFrom;

%nodefault Ogre::AnimationStateControllerValueDirector;

%typemap(cscode) Ogre::AnimationState
%{
    public string AnimationName    {
        get { return GetAnimationName(); }
    }

    public float TimePosition    {
        get { return GetTimePosition(); }
        set { SetTimePosition((float)value); }
    }

    public float Length    {
        get { return GetLength(); }
        set { SetLength((float)value); }
    }

    public float Weight
    {
        get { return GetWeight(); }
        set { SetWeight((float)value); }
    }

    public bool Enabled
    {
        get { return GetEnabled(); }
        set { SetEnabled((bool)value); }
    }

    public bool Loop
    {
        get { return GetLoop(); }
        set { SetLoop((bool)value); }
    }
%}

// AnimationStateControllerValue Event Director
%typemap(cscode) Ogre::AnimationStateControllerValueDirector %{
    protected delegate float _CVFH_GetValue_Delegate();
    protected delegate void _CVFH_SetValue_Delegate(float newvalue);

    public void SubscribeEvents()
    {
        mGetValueDelegate = new _CVFH_GetValue_Delegate(GetValueHandler);
        SetGetValueFunction(swigCPtr, mGetValueDelegate);
        
        mSetValueDelegate = new _CVFH_SetValue_Delegate(SetValueHandler);
        SetSetValueFunction(swigCPtr, mSetValueDelegate);
    }

    //
    // CVFH_GetValue handling
    //
    public event CVFHGetValueDelegate GetValueFunction = null;
    [DllImport("OgreBindings", EntryPoint="CVFH_GetValue_Function")]
    protected static extern void SetGetValueFunction(HandleRef CVFloatDirector, _CVFH_GetValue_Delegate fn);
    protected _CVFH_GetValue_Delegate mGetValueDelegate = null;
    protected float GetValueHandler()
    {
        if(GetValueFunction != null)
            return GetValueFunction();
        return 0;
    }
    
    //
    // CVFH_SetValue handling
    //
    public event CVFHSetValueDelegate SetValueFunction = null;
    [DllImport("OgreBindings", EntryPoint="CVFH_SetValue_Function")]
    protected static extern void SetSetValueFunction(HandleRef CVFloatDirector, _CVFH_SetValue_Delegate fn);
    protected _CVFH_SetValue_Delegate mSetValueDelegate = null;
    protected void SetValueHandler(float newvalue)
    {
        if(SetValueFunction != null)
            SetValueFunction(newvalue);
    }
%}

%include OgreAnimationState.h

namespace Ogre
{
    class AnimationStateControllerValueDirector : public AnimationStateControllerValue, public ControllerValueFloatDirector
    {
    public:
        AnimationStateControllerValueDirector(AnimationState* targetAnimationState);
        virtual ~AnimationStateControllerValueDirector();
    };
}

//    typedef std::map<String, AnimationState*> AnimationStateMap;
PTR_REF_TYPEMAPS(AnimationState, Ogre::AnimationState*)
%template(AnimationStateMap) std::map<std::string, Ogre::AnimationState*>;

//    typedef MapIterator<AnimationStateMap> AnimationStateIterator;
MapIteratorWRAP(AnimationStateIteratorWrap, std::map, std::string, Ogre::AnimationState*);

//    typedef ConstMapIterator<AnimationStateMap> ConstAnimationStateIterator;
ConstMapIteratorWRAP(ConstAnimationStateIteratorWrap, std::map, std::string, Ogre::AnimationState*);

//    typedef std::list<AnimationState*> EnabledAnimationStateList;
SWIG_STD_LIST_SPECIALIZE(AnimationState, Ogre::AnimationState*)
%template(EnabledAnimationStateList) std::list<Ogre::AnimationState*>;

//    typedef ConstVectorIterator<EnabledAnimationStateList> ConstEnabledAnimationStateIterator;
ConstVectorIteratorWRAP(ConstEnabledAnimationStateIteratorWrap, std::list, Ogre::AnimationState*);
