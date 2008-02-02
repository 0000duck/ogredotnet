#ifndef _Initialiser__H_
#define _Initialiser__H_

namespace Ogre
{
	class Initialiser
	{
	public:
		static void SetupResources( char * resourceconfigfile )
		{
			Ogre::ConfigFile cf;
			cf.load(resourceconfigfile);
			
			// Go through all sections & settings in the file
			Ogre::ConfigFile::SectionIterator seci = cf.getSectionIterator();
			Ogre::String secName, typeName, archName;
			while (seci.hasMoreElements())
			{
				secName = seci.peekNextKey();
				Ogre::ConfigFile::SettingsMultiMap *settings = seci.getNext();
				Ogre::ConfigFile::SettingsMultiMap::iterator i;
				for (i = settings->begin(); i != settings->end(); ++i)
				{
					typeName = i->first;
					archName = i->second;
					Ogre::ResourceGroupManager::getSingleton().addResourceLocation(
						archName, typeName, secName);
				}
			}
		}
	};
}
#endif //_Initialiser__H_
