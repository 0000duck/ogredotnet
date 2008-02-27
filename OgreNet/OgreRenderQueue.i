%{
#include "OgreRenderQueue.h"
%}

//TODO wrap subclass RenderableListener
%ignore Ogre::RenderQueue::setRenderableListener;
%ignore Ogre::RenderQueue::getRenderableListener;


%include OgreRenderQueue.h


//        typedef std::map< uint8, RenderQueueGroup* > RenderQueueGroupMap;
//        typedef MapIterator<RenderQueueGroupMap> QueueGroupIterator;
PTR_REF_TYPEMAPS(RenderQueueGroup, Ogre::RenderQueueGroup*)
//%template(RenderQueueGroupMap) std::map<unsigned char, Ogre::RenderQueueGroup*>;
MapIteratorWRAP(QueueGroupIteratorWrap, std::map, unsigned char, Ogre::RenderQueueGroup*);


