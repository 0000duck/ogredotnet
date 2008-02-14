#!/bin/sh
#
# this will run swig in the needed directories and 
# setup ogredotnet auto make files for building.
#

answer=
BUILDCEGUINET=false
BUILDGANGSTANET=false
ASSUMEDEFAULTS=false

function bomb()
{
    echo "$0 failed: $*" >&2
    exit 1
}

function NeedToSWIG()
{
    local runswigOGRE="no"
    local runswigCEGUI="no"
    local runswigOGRENetCEGUI="no"
    local runswigGANGSTA="no"
    local OGRE_HEADERS1
    local CEGUI_HEADERS1
    local CEGUI_HEADERS2
    local GANGSTAWRAPP_HEADERS
    local GANGSTAOGRE_HEADERS

    ## /-- checks
    if ( ( [ ! -f "OgreNet/OgreBindings_wrap.cxx" ] ) ||
            ( [ ! -f "OgreNet/OgreBindings.cs" ] ) ||
            ( [ ! -f "OgreNet/OgreBindings_Compositor_wrap.cxx" ] ) ||
            ( [ ! -f "OgreNet/OgreBindings_Compositor.cs" ] ) ); then
        runswigOGRE='yes'
    else
        if ( [ x$ASSUMEDEFAULTS = xfalse ] ); then
            read -p "Do you want to run swig for Ogre again (y/n)? " answer
            if ( [ "$answer" = 'y' ] ) || ( [ "$answer" = 'Y' ] ); then
                runswigOGRE='yes'
            fi
        else
            runswigOGRE='no'
        fi
    fi

    if ( [ x$BUILDCEGUINET = xtrue ] ); then
        if ( ( [ ! -f "CeguiNet/CeguiBindings_wrap.cxx" ] ) || ( [ ! -f "CeguiNet/CeguiBindings.cs" ] ) ); then
            runswigCEGUI='yes'
        else
            if ( [ x$ASSUMEDEFAULTS = xfalse ] ); then
                read -p "Do you want to run swig for CEGUI again (y/n)? " answer
                if ( [ "$answer" = 'y' ] ) || ( [ "$answer" = 'Y' ] ); then
                    runswigCEGUI='yes'
                fi
            else
                runswigCEGUI='no'
            fi
        fi
        
        if ( ( [ ! -f "OgreNet.Cegui/OgreBindings.Cegui_wrap.cxx" ] ) || ( [ ! -f "OgreNet.Cegui/OgreBindings_Cegui.cs" ] ) ); then
            runswigOGRENetCEGUI='yes'
        else
            if ( [ x$ASSUMEDEFAULTS = xfalse ] ); then
                read -p "Do you want to run swig for OgreNet.Cegui renderer again (y/n)? " answer
                if ( [ "$answer" = 'y' ] ) || ( [ "$answer" = 'Y' ] ); then
                    runswigOGRENetCEGUI='yes'
                fi
            else
                runswigOGRENetCEGUI='no'
            fi
        fi
    fi

    if ( [ x$BUILDGANGSTANET = xtrue ] ); then
        if ( ( [ ! -f "GangstaNet/GangstaBindings_wrap.cxx" ] ) || ( [ ! -f "GangstaNet/GangstaBindings.cs" ] ) ); then
            runswigGANGSTA='yes'
        else
            if ( [ x$ASSUMEDEFAULTS = xfalse ] ); then
                read -p "Do you want to run swig for GangstaNet again (y/n)? " answer
                if ( [ "$answer" = 'y' ] ) || ( [ "$answer" = 'Y' ] ); then
                    runswigGANGSTA='yes'
                fi
            else
                runswigGANGSTA='no'
            fi
        fi
    fi

    ## --/ checks

    echo " "
    echo " will run swig for Ogre: $runswigOGRE"
    if ( [ x$BUILDCEGUINET = xtrue ] ); then
        echo " will run swig for CEGUI: $runswigCEGUI"
        echo " will run swig for OgreNet.Cegui renderer: $runswigOGRENetCEGUI"
    fi
    if ( [ x$BUILDGANGSTANET = xtrue ] ); then
        echo " will run swig for GangstaNet: $runswigGANGSTA"
    fi
    echo " "
    read -p "Continue (y/n)? " answer
    if ( [ "$answer" != 'y' ] ) && ( [ "$answer" != 'Y' ] ); then
        bomb "user canceled"
    fi

    ## OgreNet
    echo "/-- OgreNet"
    cd OgreNet
    if [ "$runswigOGRE" = 'yes' ]; then
        OGRE_HEADERS1="`pkg-config --cflags-only-I OGRE`"

        echo " ### running swig on OgreBindings ### "
        echo "swig -c++ -csharp -namespace OgreDotNet -D_MONO ${OGRE_HEADERS1} OgreBindings.i"
        if swig -c++ -csharp -namespace OgreDotNet -D_MONO ${OGRE_HEADERS1} OgreBindings.i; then
            echo " ### success, swigging OgreBindings ### "
        else
            bomb " ### ERROR, swigging OgreBindings ### "
        fi
        echo " ### running swig on OgreBindings_Compositor ### "
        echo "swig -c++ -csharp -dllimport OgreBindings -namespace OgreDotNet -D_MONO ${OGRE_HEADERS1} OgreBindings_Compositor.i"
        if swig -c++ -csharp -dllimport OgreBindings -namespace OgreDotNet -D_MONO ${OGRE_HEADERS1} OgreBindings_Compositor.i; then
            echo " ### success, swigging OgreBindings_Compositor ### "
        else
            bomb " ### ERROR, swigging OgreBindings_Compositor ### "
        fi
        echo " ### running swig on OgreBindings_DotSceneOctreeHelper ### "
        echo "swig -c++ -csharp -dllimport OgreBindings -namespace OgreDotNet -D_MONO ${OGRE_HEADERS1} OgreBindings_DotSceneOctreeHelper.i"
        if swig -c++ -csharp -dllimport OgreBindings -namespace OgreDotNet -D_MONO ${OGRE_HEADERS1} OgreBindings_DotSceneOctreeHelper.i; then
            echo " ### success, swigging OgreBindings_DotSceneOctreeHelper ### "
        else
            bomb " ### ERROR, swigging OgreBindings_DotSceneOctreeHelper ### "
        fi
    fi
    ## this should be done always 
    ## rebuild OgreNet/Makefile.include
    echo "running OgreNet/buildCSList.sh"
    chmod u+x buildCSList.sh
    ./buildCSList.sh
    cd ..
    echo "OgreNet --/"
    ## OgreNet

    if ( [ x$BUILDCEGUINET = xtrue ] ); then
        ## CeguiNet
        echo "/-- CeguiNet"
        cd CeguiNet
        if [ "$runswigCEGUI" = 'yes' ]; then
            echo " ### running swig on CeguiBindings ### "
            CEGUI_HEADERS1="`pkg-config --cflags-only-I CEGUI`"
            CEGUI_HEADERS2=${CEGUI_HEADERS1:0:${#CEGUI_HEADERS1}-2}'/elements'
            echo "swig -c++ -csharp -namespace CeguiDotNet -D_MONO ${CEGUI_HEADERS1} ${CEGUI_HEADERS2} CeguiBindings.i"
            if swig -c++ -csharp -namespace CeguiDotNet -D_MONO ${CEGUI_HEADERS1} ${CEGUI_HEADERS2} CeguiBindings.i; then
                echo " ### success, swigging CeguiBindings ### "
            else
                bomb " ### ERROR, swigging CeguiBindings ### "
            fi
        fi
        ## this should be don always 
        ##  rebuild CeguiNet/Makefile.include
        echo "running CeguiNet/buildCSList.sh"
        chmod u+x buildCSList.sh
        ./buildCSList.sh
        cd ..
        echo "CeguiNet --/"
        ## CeguiNet
        
        ## OgreNet.Cegui
        echo "/-- OgreNet.Cegui"
        cd OgreNet.Cegui
        if [ "$runswigOGRENetCEGUI" = 'yes' ]; then
            echo " ### running swig on OgreNet.Cegui renderer ### "
            OGRE_HEADERS1="`pkg-config --cflags-only-I OGRE`"
            CEGUI_HEADERS1="`pkg-config --cflags-only-I CEGUI`"
            CEGUI_HEADERS2=${CEGUI_HEADERS1:0:${#CEGUI_HEADERS1}-2}'/elements'
            echo "swig -c++ -csharp -namespace OgreDotNet.Cegui -D_MONO ${OGRE_HEADERS1} ${CEGUI_HEADERS1} ${CEGUI_HEADERS2} OgreBindings.Cegui.i"
            if swig -c++ -csharp -namespace OgreDotNet.Cegui -D_MONO ${OGRE_HEADERS1} ${CEGUI_HEADERS1} ${CEGUI_HEADERS2} OgreBindings.Cegui.i; then
                echo " ### success, swigging OgreNet.Cegui renderer ### "
            else
                bomb " ### ERROR, swigging OgreNet.Cegui renderer ### "
            fi
        fi
        ## this should be don always 
        ##  rebuild OgreNet.Cegui/Makefile.include
        echo "running OgreNet.Cegui/buildCSList.sh"
        chmod u+x buildCSList.sh
        ./buildCSList.sh
        cd ..
        echo "OgreNet.Cegui --/"
        ## OgreNet.Cegui
    fi

    if ( [ x$BUILDGANGSTANET = xtrue ] ); then
        ## GangstaNet
        echo "/-- GangstaNet"
        cd GangstaNet
        if [ "$runswigGANGSTA" = 'yes' ]; then
            echo " ### running swig on GangstaBindings ### "
            OGRE_HEADERS1="`pkg-config --cflags-only-I OGRE`"
            GANGSTAWRAPP_HEADERS="`pkg-config --cflags-only-I gangsta_ogre | cut -d' ' -f1`"
            GANGSTAOGRE_HEADERS="`pkg-config --cflags-only-I gangsta_ogre | cut -d' ' -f4`"
            echo "swig -c++ -csharp -namespace GangstaDotNet -D_MONO ${OGRE_HEADERS1} ${GANGSTAWRAPP_HEADERS} ${GANGSTAOGRE_HEADERS} GangstaBindings.i"
            if swig -c++ -csharp -namespace GangstaDotNet -D_MONO ${OGRE_HEADERS1} ${GANGSTAWRAPP_HEADERS} ${GANGSTAOGRE_HEADERS} GangstaBindings.i; then
                echo " ### success, swigging GangstaBindings ### "
            else
                bomb " ### ERROR, swigging GangstaBindings ### "
            fi
        fi
        ## this should be don always 
        ##  rebuild GangstaNet/Makefile.include
        echo "running GangstaNet/buildCSList.sh"
        chmod u+x buildCSList.sh
        ./buildCSList.sh
        cd ..
        echo "GangstaNet --/"
        ## GangstaNet
    fi
}

echo " "
read -p "Default build (OgreNet, CeguiNet, GangstaNet), and no re-swigging (y/n)? " answer
if ( [ "$answer" = 'y' ] ) || ( [ "$answer" = 'Y' ] ); then
    ASSUMEDEFAULTS=true
    BUILDCEGUINET=true
    BUILDGANGSTANET=true
fi

if ( [ x$ASSUMEDEFAULTS = xfalse ] ); then
    echo " "
    read -p "Do you want to compile CeguiNet (y/n)? " answer
    if ( [ "$answer" = 'y' ] ) || ( [ "$answer" = 'Y' ] ); then
        BUILDCEGUINET=true
    fi
    
    read -p "Do you want to compile GangstaNet (y/n)? " answer
    if ( [ "$answer" = 'y' ] ) || ( [ "$answer" = 'Y' ] ); then
        BUILDGANGSTANET=true
    fi
fi

echo " "
NeedToSWIG

cat >setup.Configure_in.sh <<EOF
#!/bin/sh
set -e
set -x

sed -e "s/@BUILDCEGUI@/$BUILDCEGUINET/" configure.in.in > configure.in.in.tmp

sed -e "s/@BUILDGANGSTANET@/$BUILDGANGSTANET/" configure.in.in.tmp > configure.in
rm -f configure.in.in.tmp
EOF

chmod u+x setup.Configure_in.sh
./setup.Configure_in.sh

echo "Running the autotools"
echo "rm -f config.cache"
rm -f config.cache

echo "libtoolize --force"
libtoolize --force

echo "aclocal"
aclocal

echo "autoheader"
autoheader

echo "automake --add-missing --foreign"
automake --add-missing --foreign

echo "autoconf"
autoconf

echo "Running configure"
echo "./configure $@"
./configure $@

echo "done."
