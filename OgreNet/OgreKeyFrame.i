%{
#include "OgreKeyFrame.h"
#include "KeyFrameExt.h"
%}

%rename Ogre::KeyFrame::getTime                GetTime;
%rename Ogre::TransformKeyFrame::setTranslate            SetTranslate;
%rename Ogre::TransformKeyFrame::getTranslate            GetTranslate;
%rename Ogre::TransformKeyFrame::setScale            SetScale;
%rename Ogre::TransformKeyFrame::getScale            GetScale;
%rename Ogre::TransformKeyFrame::setRotation            SetRotation;
%rename Ogre::TransformKeyFrame::getRotation            GetRotation;

%ignore Ogre::VertexPoseKeyFrame::PoseRefList;
%ignore Ogre::VertexPoseKeyFrame::PoseRefIterator;
%ignore Ogre::VertexPoseKeyFrame::getPoseReferenceIterator;
%ignore Ogre::VertexPoseKeyFrame::getPoseReferences;



%newobject Ogre::VPKFPoseRefList::getFirst;
%newobject Ogre::VPKFPoseRefList::getLast;
%newobject Ogre::VPKFPoseRefList::getByIndex;
%newobject Ogre::VPKFPoseRefIterator::peekNext;
%newobject Ogre::VPKFPoseRefIterator::getNext;
%newobject Ogre::VPKFPoseRefIterator::next;

%nodefault Ogre::VPKFPoseRefList;
%nodefault Ogre::VPKFPoseRefIterator;


%typemap(cscode) Ogre::KeyFrame
%{
    public float Time    {
        get { return GetTime(); }
    }
%}
%typemap(cscode) Ogre::TransformKeyFrame
%{
    public Math3D.Vector3 Translation {
        get { return GetTranslate(); }
        set { SetTranslate(value); }
    }
    public Math3D.Vector3 Scale {
        get { return GetScale(); }
        set { SetScale(value); }
    }
    public Math3D.Quaternion Rotation {
        get { return GetRotation(); }
        set { SetRotation(value); }
    }
%}


%include OgreKeyFrame.h

namespace Ogre
{
    class VPKFPoseRef
    {
    public:
        VPKFPoseRef(ushort p, Real i);
        virtual ~VPKFPoseRef();
        ushort getPoseIndex();
        void setPoseIndex(ushort value);
        Real getInfluence();
        void setInfluence(Real value);
    };

    class  VPKFPoseRefList
    {
    public:
        //VPKFPoseRefList();
        size_t size();
        void addItem(VPKFPoseRef *pnewItem);
        VPKFPoseRef *getFirst();
        VPKFPoseRef *getLast();
        VPKFPoseRef *getByIndex(int index);
    };

    class  VPKFPoseRefIterator
    {
    public:
        //VPKFPoseRefIterator();
        //virtual ~VPKFPoseRefIterator();
        bool hasMoreElements(void) const;
        void moveNext(void);
        VPKFPoseRef* peekNext(void);
        VPKFPoseRef* getNext(void);
        VPKFPoseRef* next();
    };
}

%extend Ogre::VertexPoseKeyFrame {
    Ogre::VPKFPoseRefIterator* GetPoseReferenceIterator(void)
    {
        return new Ogre::VPKFPoseRefIterator((VertexPoseKeyFrame::PoseRefIterator*)&self->getPoseReferenceIterator());
    }
    
    Ogre::VPKFPoseRefList* GetPoseReferences(void)
    {
        return new Ogre::VPKFPoseRefList((VertexPoseKeyFrame::PoseRefList*)&self->getPoseReferences());
    }
};

