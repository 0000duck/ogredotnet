//DotSceneOctreeHelper.h
#ifndef _DSOM_H
#define _DSOM_H

#include "OgreSceneManager.h"

namespace Ogre
{
	class DotSceneOctreeHelper
	{
	public:
		DotSceneOctreeHelper(SceneManager *ScnMgr)
		{
			mSceneMgr=ScnMgr;
		}
		virtual ~DotSceneOctreeHelper()	{}

		// Loads the XML and Binary data files to Memory //
		virtual void addWorldGeometry( const String& filename, const String& groupname )
		{
			if (mSceneMgr==0)
				return;
			StringVector s;
			s.push_back( filename );
			s.push_back( groupname );
			mSceneMgr->setOption("addWorldGeometry", &s);
		}

		virtual void addWorldGeometry( const String& filename , const String& name, float xOffset, float zOffset, const String& groupname )
		{
			if (mSceneMgr==0)
				return;
			StringVector s;
			s.push_back( filename );
			s.push_back( name );
			s.push_back( StringConverter::toString(xOffset) );
			s.push_back( StringConverter::toString(zOffset) );
			s.push_back( groupname );
			mSceneMgr->setOption("addWorldGeometry", &s);
		}


		virtual void removeWorldGeometry( const String& name )
		{
			if (mSceneMgr==0)
				return;
			mSceneMgr->setOption("removeWorldGeometry", &name);
		}

		virtual void removeAllWorldGeometry( void )
		{
			if (mSceneMgr==0)
				return;
			mSceneMgr->setOption("removeAllWorldGeometry", 0);
		}


		virtual void setOctreeVisible( bool Visible )
		{
			if (mSceneMgr==0)
				return;
			mSceneMgr->setOption("ShowOctree", &Visible);
		}

		virtual bool getOctreeVisible( void )
		{
			bool b=false;
			if (mSceneMgr!=0)
				mSceneMgr->getOption("ShowOctree", &b);
			return b;
		}


		// Return the Geometry Data For Collision //
		virtual int   getNumMeshes( char* name )
		{
			int ret=0;
			if (mSceneMgr!=0)
				mSceneMgr->getOption("NumMeshes", &ret);
			return ret;
		}

		virtual Ogre::MemoryDataStream* getVerticesPtr( char* name, int MeshIndex  )
		{
			Ogre::MemoryDataStream *ret=0;
			if (mSceneMgr!=0)
			{
				int count=0;
				if (mSceneMgr->getOption( String("NumVertices") + StringConverter::toString(MeshIndex), &count) == true)
				{
					if (count > 0)
					{
						float *buff=0;
						if (mSceneMgr->getOption( String("VerticesPtr") + StringConverter::toString(MeshIndex), &buff) == true)
						{
							ret = new Ogre::MemoryDataStream( sizeof(float)*(count*3), true );
							memcpy( ret->getPtr(), buff, sizeof(float)*(count*3) );
						}
					}
				}
			}
			return ret;
		}

		virtual  Ogre::MemoryDataStream* getIndexPtr( char* name, int MeshIndex )
		{
			Ogre::MemoryDataStream *ret=0;
			if (mSceneMgr!=0)
			{
				int count=0;
				if (mSceneMgr->getOption( String("NumIndex") + StringConverter::toString(MeshIndex), &count) == true)
				{
					if (count > 0)
					{
						int *buff=0;
						if (mSceneMgr->getOption( String("IndexPtr") + StringConverter::toString(MeshIndex), &buff) == true)
						{
							ret = new Ogre::MemoryDataStream( sizeof(int)*count, true );
							memcpy( ret->getPtr(), buff, sizeof(int)*count );
						}
					}
				}
			}
			return ret;
		}

		virtual int getNumVertices( char* name, int MeshIndex  )
		{
			int ret=0;
			if (mSceneMgr!=0)
				mSceneMgr->getOption( String("NumVertices") + StringConverter::toString(MeshIndex), &ret);
			return ret;
		}

		virtual int getNumIndex( char* name, int MeshIndex )
		{
			int ret=0;
			if (mSceneMgr!=0)
				mSceneMgr->getOption( String("NumIndex") + StringConverter::toString(MeshIndex), &ret);
			return ret;
		}

		virtual const AxisAlignedBox& getBoundingBox( char* name, int MeshIndex )
		{
			lastAABox = AxisAlignedBox(0,0,0,0,0,0);
			if (mSceneMgr!=0)
				mSceneMgr->getOption( String("BoundingBox") + StringConverter::toString(MeshIndex), &lastAABox);
			return lastAABox;
		}

	protected:
		SceneManager *mSceneMgr;
		AxisAlignedBox lastAABox;

	};
} //End namespace
#endif
