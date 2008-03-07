%{
#include "OgreSceneNode.h"
%}

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
