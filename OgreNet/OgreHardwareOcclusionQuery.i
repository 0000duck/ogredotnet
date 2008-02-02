%{
#include "OgreHardwareOcclusionQuery.h"
%}


%apply unsigned int *INOUT {unsigned int* NumOfFragments };


%include OgreHardwareOcclusionQuery.h

