#pragma once

#include <CEGUITexture.h>
#include <CEGUIRenderer.h>

typedef void (SWIGSTDCALL *void_voidFunctionPointer)(void);
typedef void (SWIGSTDCALL *void_boolFunctionPointer)(bool);

namespace CEGUI
{
	class DirectedRenderer : public CEGUI::Renderer
	{
	protected:
		void_voidFunctionPointer doRenderDirector;
		void_voidFunctionPointer clearRenderListDirector;
		void_boolFunctionPointer setQueueingEnabledDirector;
	public:
		DirectedRenderer()
		{
			this->doRenderDirector = NULL;
			this->clearRenderListDirector = NULL;
			this->setQueueingEnabledDirector = NULL;
		}

		//
		//			doRender
		//
		void SetdoRenderDirector( void * fn )
		{
			this->doRenderDirector = (void_voidFunctionPointer)fn;
		}
		void doRender( void )
		{
			if( this->doRenderDirector ) this->doRenderDirector();
		}

		//
		//			clearRenderList
		//
		void SetclearRenderListDirector( void * fn )
		{
			this->clearRenderListDirector = (void_voidFunctionPointer)fn;
		}
		void clearRenderList( void )
		{
			if( this->clearRenderListDirector ) this->clearRenderListDirector();
		}

		//
		//			setQueueingEnabled
		//
		void SetsetQueueingEnabledDirector( void * fn )
		{
			this->setQueueingEnabledDirector = (void_boolFunctionPointer)fn;
		}
		void setQueueingEnabled( bool setting )
		{
			if( this->setQueueingEnabledDirector ) this->setQueueingEnabledDirector(setting);
		}
	};
}
