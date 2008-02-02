//CompositorInstanceExt.h
#ifndef __CompositorInstanceExt_H_
#define __CompositorInstanceExt_H_

namespace Ogre
{
	typedef const void (SWIGSTDCALL *CILD_FunctionPointers) (uint32 pass_id, MaterialPtr &mat);
	
	class CompositorInstanceListenerDirector : public Ogre::CompositorInstance::Listener
	{
	public:
		CILD_FunctionPointers	mFP_notifyMaterialSetup;
		CILD_FunctionPointers	mFP_notifyMaterialRender;

		CompositorInstanceListenerDirector()
		{
			mFP_notifyMaterialSetup = 0;
			mFP_notifyMaterialRender = 0;
		}
		virtual ~CompositorInstanceListenerDirector() {}
		
		virtual void notifyMaterialSetup(uint32 pass_id, MaterialPtr &mat)
		{
			if (mFP_notifyMaterialSetup)
				mFP_notifyMaterialSetup(pass_id, mat);
		}
		virtual void notifyMaterialRender(uint32 pass_id, MaterialPtr &mat)
		{
			if (mFP_notifyMaterialRender)
				mFP_notifyMaterialRender(pass_id, mat);
		}
	};
}

extern "C" SWIGEXPORT void set_CILD_FP_notifyMaterialSetup( void * nld, void * _fn )
{
	((Ogre::CompositorInstanceListenerDirector*)nld)->mFP_notifyMaterialSetup = (CILD_FunctionPointers)_fn;
}
extern "C" SWIGEXPORT void set_CILD_FP_notifyMaterialRender( void * nld, void * _fn )
{
	((Ogre::CompositorInstanceListenerDirector*)nld)->mFP_notifyMaterialRender = (CILD_FunctionPointers)_fn;
}

#endif //__CompositorInstanceExt_H_
