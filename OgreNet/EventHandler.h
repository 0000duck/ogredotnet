#ifndef __EventHandler_H__
#define __EventHandler_H__


#include "OgreKeyEvent.h"
#include "OgreEventListeners.h"

namespace Ogre
{
	typedef bool (SWIGSTDCALL *FrameFunctionPointer)( float, float );
	typedef void (SWIGSTDCALL *KeyFunctionPointer)( int, char, bool, bool, bool );
	typedef void (SWIGSTDCALL *MouseMotionFunctionPointer)( float, float, float );
	typedef void (SWIGSTDCALL *MouseFunctionPointer)( float x, float y, float z, int button );

	class EventHandler : public FrameListener, public KeyListener, public MouseMotionListener, public MouseListener
	{
		EventProcessor * mEventProcessor;

		bool frameStarted( const Ogre::FrameEvent& evt )
		{
			if( mFrameStartFunction )
				return mFrameStartFunction( evt.timeSinceLastFrame, evt.timeSinceLastEvent );
			else
				return true;
		}

		bool frameEnded(const Ogre::FrameEvent& evt)
		{
			if( mFrameEndFunction )
				return mFrameEndFunction( evt.timeSinceLastFrame, evt.timeSinceLastEvent );
			else
				return true;
		}

		void keyClicked(KeyEvent* e) 
		{
			if( mKeyClickedFunction )
				mKeyClickedFunction( e->getKey(), e->getKeyChar(), e->isShiftDown(), e->isAltDown(), e->isControlDown() );
		}
		void keyPressed(KeyEvent* e)
		{
			if( mKeyPressedFunction )
				mKeyPressedFunction( e->getKey(), e->getKeyChar(), e->isShiftDown(), e->isAltDown(), e->isControlDown() );

		}
		void keyReleased(KeyEvent* e) 
		{
			if( mKeyReleasedFunction )
				mKeyReleasedFunction( e->getKey(), e->getKeyChar(), e->isShiftDown(), e->isAltDown(), e->isControlDown() );

		}

		void mouseMoved (MouseEvent *e)
		{
			if( mMouseMotionFunction )
				mMouseMotionFunction( (float)e->getRelX(), (float)e->getRelY(), (float)e->getRelZ() );
		}

		void mouseDragged (MouseEvent *e)
		{
			if( this->mMouseDraggedFunction )
				mMouseDraggedFunction( (float)e->getRelX(), (float)e->getRelY(), (float)e->getRelZ() );
		}

		void mouseDragMoved (MouseEvent *e)
		{

		}

		void 	mouseClicked (MouseEvent *e)
		{
			
			if( mMouseClickFunction )
				mMouseClickFunction( e->getX(), e->getY(), e->getZ(), e->getButtonID() );
		}

		void 	mouseEntered (MouseEvent *e)
		{
		}

		void 	mouseExited (MouseEvent *e)
		{
		}
	 	
		void 	mousePressed (MouseEvent *e)
		{
			if( mMousePressedFunction )
			{
				mMousePressedFunction( e->getX(), e->getY(), e->getZ(), e->getButtonID() );
			}
		}

		void 	mouseReleased (MouseEvent *e)
		{
			if( mMouseReleasedFunction )
			{
				mMouseReleasedFunction( e->getX(), e->getY(), e->getZ(), e->getButtonID() );
			}
		}

	public:

		FrameFunctionPointer mFrameStartFunction;
		FrameFunctionPointer mFrameEndFunction;

		KeyFunctionPointer mKeyClickedFunction;
		KeyFunctionPointer mKeyPressedFunction;
		KeyFunctionPointer mKeyReleasedFunction;

		MouseMotionFunctionPointer mMouseMotionFunction;
		MouseMotionFunctionPointer mMouseDraggedFunction;

		MouseFunctionPointer mMouseClickFunction;
		MouseFunctionPointer mMousePressedFunction;
		MouseFunctionPointer mMouseReleasedFunction;

		EventHandler( Root * root, RenderWindow * renderwindow, bool bHandleInput = true )
		{
			this->mFrameStartFunction = NULL;
			this->mFrameEndFunction = NULL;
			this->mKeyClickedFunction = NULL;
			this->mKeyPressedFunction = NULL;
			this->mKeyReleasedFunction = NULL;
			this->mMouseMotionFunction = NULL;
			this->mMouseClickFunction = NULL;
			this->mMousePressedFunction = NULL;
			this->mMouseReleasedFunction = NULL;
			this->mMouseDraggedFunction = NULL;

			root->addFrameListener( this );

			this->mEventProcessor=0;

			if (bHandleInput)	{
				this->mEventProcessor = new EventProcessor();
				this->mEventProcessor->initialise( renderwindow );
				this->mEventProcessor->startProcessingEvents();
				this->mEventProcessor->addKeyListener( this );
				this->mEventProcessor->addMouseMotionListener( this );
				this->mEventProcessor->addMouseListener( this );
			}
		}

		InputReader * GetInputReader()
		{
			if (this->mEventProcessor)
				return this->mEventProcessor->getInputReader();

			return 0;
		}
	};
}


extern "C" SWIGEXPORT void EventHandlerSetFrameFunctionStarted( void * eh, void * fn )
{
	((Ogre::EventHandler*)eh)->mFrameStartFunction = (Ogre::FrameFunctionPointer)fn;
}

extern "C" SWIGEXPORT void EventHandlerSetFrameEndFunction( void * eh, void * fn )
{
	((Ogre::EventHandler*)eh)->mFrameEndFunction = (FrameFunctionPointer)fn;
}

extern "C" SWIGEXPORT void EventHandlerSetKeyClickedFunction( void * eh, void * fn )
{
	((Ogre::EventHandler*)eh)->mKeyClickedFunction = (KeyFunctionPointer)fn;
}

extern "C" SWIGEXPORT void EventHandlerSetKeyPressedFunction( void * eh, void * fn )
{
	((Ogre::EventHandler*)eh)->mKeyPressedFunction = (KeyFunctionPointer)fn;
}

extern "C" SWIGEXPORT void EventHandlerSetKeyReleasedFunction( void * eh, void * fn )
{
	((Ogre::EventHandler*)eh)->mKeyReleasedFunction = (KeyFunctionPointer)fn;
}

extern "C" SWIGEXPORT void EventHandlerSetMouseMotionFunction( void * eh, void * fn )
{
	((Ogre::EventHandler*)eh)->mMouseMotionFunction = (MouseMotionFunctionPointer)fn;
}

extern "C" SWIGEXPORT void EventHandlerSetMouseDraggedFunction( void * eh, void * fn )
{
	((Ogre::EventHandler*)eh)->mMouseDraggedFunction = (MouseMotionFunctionPointer)fn;
}

extern "C" SWIGEXPORT void EventHandlerSetMouseClickFunction( void * eh, void * fn )
{
	((Ogre::EventHandler*)eh)->mMouseClickFunction = (MouseFunctionPointer)fn;
}

extern "C" SWIGEXPORT void EventHandlerSetMousePressedFunction( void * eh, void * fn )
{
	((Ogre::EventHandler*)eh)->mMousePressedFunction = (MouseFunctionPointer)fn;
}

extern "C" SWIGEXPORT void EventHandlerSetMouseReleasedFunction( void * eh, void * fn )
{
	((Ogre::EventHandler*)eh)->mMouseReleasedFunction = (MouseFunctionPointer)fn;
}

#endif //__EventHandler_H__