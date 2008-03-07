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
//             return isInSceneGraph();
//         }
//     }

    public SceneManager Creator {
        get
        {
            return getCreator();
        }
    }

//     public virtual bool ShowBoundingBox {
//         get
//         {
//             return getShowBoundingBox();
//         }
//     }

    public SceneNode AutoTrackTarget {
        get
        {
            return getAutoTrackTarget();
        }
    }

    public Math3D.Vector3 AutoTrackOffset {
        get
        {
            return getAutoTrackOffset();
        }
    }

    public Math3D.Vector3 AutoTrackLocalDirection {
        get
        {
            return getAutoTrackLocalDirection();
        }
    }

    public SceneNode ParentSceneNode {
        get
        {
            return getParentSceneNode();
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
