//ResourceExt.h
#ifndef __ResourceExt_H_
#define __ResourceExt_H_

namespace Ogre
{
	typedef const void (SWIGSTDCALL *MRLD_FP_loadResource) ( Resource* );

	class ManualResourceLoaderDirector : public Ogre::ManualResourceLoader
	{
	public:
		MRLD_FP_loadResource	mFP_loadResource;

		ManualResourceLoaderDirector()
		{
			mFP_loadResource = 0;
		}
		virtual ~ManualResourceLoaderDirector() {}

		/** Called when a resource wishes to load.
		@param resource The resource which wishes to load
		*/
		virtual void loadResource(Resource* resource)
		{
			if (mFP_loadResource)
				mFP_loadResource(resource);
		}
	};
}

extern "C" SWIGEXPORT void set_MRLD_FP_loadResource( void * nld, void * _fn )
{
	((Ogre::ManualResourceLoaderDirector*)nld)->mFP_loadResource = (MRLD_FP_loadResource)_fn;
}

#endif //__ResourceExt_H_
