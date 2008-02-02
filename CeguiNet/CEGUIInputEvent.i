//The best opensource license is no license at all - The OgreDotNet team

%{
#include "CEGUIInputEvent.h"
%}

//%rename MouseEventArgs MouseEvent;

%rename LeftButton Left;
%rename RightButton Right;
%rename MiddleButton Middle;
%rename X1Button X1;
%rename X2Button X2;
%rename MouseButtonCount Count;

%include CEGUIInputEvent.h