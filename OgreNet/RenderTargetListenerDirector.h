//RenderTargetListenerDirector.h
//
#ifndef _RenderTargetListenerDirector__H_
#define _RenderTargetListenerDirector__H_

namespace Ogre
{
	typedef void 	(SWIGSTDCALL *RTLD_FP_RenderTargetUpdate)	(const RenderTargetEvent& );
	typedef void 	(SWIGSTDCALL *RTLD_FP_ViewportUpdate)		(const RenderTargetViewportEvent& );

	class RenderTargetListenerDirector : public Ogre::RenderTargetListener
	{
	public:
		RTLD_FP_RenderTargetUpdate		mFP_preRenderTargetUpdate;
		RTLD_FP_RenderTargetUpdate		mFP_postRenderTargetUpdate;
		RTLD_FP_ViewportUpdate			mFP_preViewportUpdate;
		RTLD_FP_ViewportUpdate			mFP_postViewportUpdate;

		RenderTargetListenerDirector()
		{
			mFP_preRenderTargetUpdate = 0;
			mFP_postRenderTargetUpdate = 0;
			mFP_preViewportUpdate = 0;
			mFP_postViewportUpdate = 0;
		}

		virtual void preRenderTargetUpdate(const RenderTargetEvent& evt)
		{
			if( mFP_preRenderTargetUpdate )
				mFP_preRenderTargetUpdate( evt );
		}
		
		virtual void postRenderTargetUpdate(const RenderTargetEvent& evt)
		{
			if( mFP_postRenderTargetUpdate )
				mFP_postRenderTargetUpdate( evt );
		}
		
		virtual void preViewportUpdate(const RenderTargetViewportEvent& evt)
		{
			if( mFP_preViewportUpdate )
				mFP_preViewportUpdate( evt );
		}
		
		virtual void postViewportUpdate(const RenderTargetViewportEvent& evt)
		{
			if( mFP_postViewportUpdate )
				mFP_postViewportUpdate( evt );
		}
	};
}


extern "C" SWIGEXPORT void set_RTLD_FP_preRenderTargetUpdate( void * _obj, void * _fn )
{
	((Ogre::RenderTargetListenerDirector*)_obj)->mFP_preRenderTargetUpdate = (RTLD_FP_RenderTargetUpdate)_fn;
}

extern "C" SWIGEXPORT void set_RTLD_FP_postRenderTargetUpdate( void * _obj, void * _fn )
{
	((Ogre::RenderTargetListenerDirector*)_obj)->mFP_postRenderTargetUpdate = (RTLD_FP_RenderTargetUpdate)_fn;
}

extern "C" SWIGEXPORT void set_RTLD_FP_preViewportUpdate( void * _obj, void * _fn )
{
	((Ogre::RenderTargetListenerDirector*)_obj)->mFP_preViewportUpdate = (RTLD_FP_ViewportUpdate)_fn;
}

extern "C" SWIGEXPORT void set_RTLD_FP_postViewportUpdate( void * _obj, void * _fn )
{
	((Ogre::RenderTargetListenerDirector*)_obj)->mFP_postViewportUpdate = (RTLD_FP_ViewportUpdate)_fn;
}

#endif //_RenderTargetListenerDirector__H_
