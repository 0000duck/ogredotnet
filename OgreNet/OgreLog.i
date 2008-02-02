%{
#include "OgreLog.h"
%}

%rename Ogre::LoggingLevel             OgreLoggingLevel;

%rename Ogre::Log::logMessage               LogMessage;


%include OgreLog.h

