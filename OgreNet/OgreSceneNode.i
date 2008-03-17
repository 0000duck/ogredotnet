%{
#include "OgreSceneNode.h"
%}

%rename Ogre::SceneNode::attachObject                AttachObject;
%rename Ogre::SceneNode::numAttachedObjects          NumAttachedObjects;
%rename Ogre::SceneNode::getAttachedObject           GetAttachedObject;
%rename Ogre::SceneNode::detachObject                DetachObject;
%rename Ogre::SceneNode::detachAllObjects            DetachAllObjects;
%rename Ogre::SceneNode::isInSceneGraph              IsInSceneGraph;
%rename Ogre::SceneNode::getCreator                  GetCreator;
%rename Ogre::SceneNode::removeAndDestroyChild       RemoveAndDestroyChild;
%rename Ogre::SceneNode::removeAndDestroyAllChildren RemoveAndDestroyAllChildren;
%rename Ogre::SceneNode::showBoundingBox             ShowBoundingBox;
%rename Ogre::SceneNode::getShowBoundingBox          GetShowBoundingBox;
%rename Ogre::SceneNode::createChildSceneNode        CreateChildSceneNode;
%rename Ogre::SceneNode::findLights                  FindLights;
%rename Ogre::SceneNode::setFixedYawAxis             SetFixedYawAxis;
%rename Ogre::SceneNode::yaw                         Yaw;
%rename Ogre::SceneNode::setDirection                SetDirection;
%rename Ogre::SceneNode::lookAt                      LookAt;
%rename Ogre::SceneNode::setAutoTracking             SetAutoTracking;
%rename Ogre::SceneNode::getAutoTrackTarget          GetAutoTrackTarget;
%rename Ogre::SceneNode::getAutoTrackOffset          GetAutoTrackOffset;
%rename Ogre::SceneNode::getAutoTrackLocalDirection  GetAutoTrackLocalDirection;
%rename Ogre::SceneNode::getParentSceneNode          GetParentSceneNode;
%rename Ogre::SceneNode::setVisible                  SetVisible;
%rename Ogre::SceneNode::flipVisibility              FlipVisibility;

%typemap(csattributes) Ogre::SceneNode 
"/// <summary>
/// Class representing a node in the scene graph.
/// </summary>";

%typemap(cscode) Ogre::SceneNode
%{
//     public virtual bool IsInSceneGraph {
//         get
//         {
//             return IsInSceneGraph();
//         }
//     }

    public SceneManager Creator {
        get
        {
            return GetCreator();
        }
    }

//     public virtual bool ShowBoundingBox {
//         get
//         {
//             return GetShowBoundingBox();
//         }
//     }

    public SceneNode AutoTrackTarget {
        get
        {
            return GetAutoTrackTarget();
        }
    }

    public Math3D.Vector3 AutoTrackOffset {
        get
        {
            return GetAutoTrackOffset();
        }
    }

    public Math3D.Vector3 AutoTrackLocalDirection {
        get
        {
            return GetAutoTrackLocalDirection();
        }
    }

    public SceneNode ParentSceneNode {
        get
        {
            return GetParentSceneNode();
        }
    }

    static public SceneNode GetSceneNodeFrom(Node n)
    {
        SceneNode ret = new SceneNode(Node.getCPtr(n).Handle , false);
        return ret;
    }
%}

//TODO wrap Iterator, hash_map needs custom wrap
%ignore Ogre::SceneNode::getAttachedObjectIterator;
%ignore Ogre::SceneNode::ObjectMap;
%ignore Ogre::SceneNode::ObjectIterator;
%ignore Ogre::SceneNode::ConstObjectIterator;

%include "OgreSceneNode.h"

//        typedef HashMap<String, MovableObject*> ObjectMap;
//        typedef MapIterator<ObjectMap> ObjectIterator;
//        typedef ConstMapIterator<ObjectMap> ConstObjectIterator;
