%{
#include "OgreRenderQueueListener.h"
%}

%apply bool &INOUT { bool& skipThisInvocation , bool& repeatThisInvocation };

%include OgreRenderQueueListener.h

