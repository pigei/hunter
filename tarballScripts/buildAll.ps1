cd ../zlib-1.2.8
..\tarballScripts\buildPackage.ps1 zlib 1.2.8 msvc2013-amd64 ..\tarballScripts\hunter.cmake.in *.cmake msvc2013-x64
 
cd ../glew-1.10.0
..\tarballScripts\buildPackage.ps1 glew 1.10.0 msvc2013-amd64 ..\tarballScripts\hunter.cmake.in *.cmake build/include build/bin/Release/x64 build/lib/Release/x64
..\tarballScripts\buildPackage.ps1 glew 1.10.0 msvc2013-x86 ..\tarballScripts\hunter.cmake.in *.cmake build/include build/bin/Release/Win32 build/lib/Release/Win32

cd ../WpdPack-4.1.0
..\tarballScripts\buildPackage.ps1 wpdpack 4.1.0 msvc2013-amd64 ..\tarballScripts\hunter.cmake.in *.cmake Include Lib/x64 bin/x64

cd ../qt-solutions-2015.02.19
..\tarballScripts\buildPackage.ps1 qt-solutions 2015.02.19 msvc2013-amd64 ..\tarballScripts\hunter.cmake.in *.cmake msvc2013-x64/qtpropertybrowser/lib msvc2013-x64/qtpropertybrowser/src
..\tarballScripts\buildPackage.ps1 qt-solutions 2015.02.19 msvc2013-x86 ..\tarballScripts\hunter.cmake.in *.cmake msvc2013-x32/qtpropertybrowser/lib msvc2013-x32/qtpropertybrowser/src

cd ../nuverLicense-1.1.0
..\tarballScripts\buildPackage.ps1 nuverlicense 1.1.0 msvc2013-amd64 ..\tarballScripts\hunter.cmake.in *.cmake msvc2013-x64


echo "TODO remove this file and use make_tarball.ps1 in each single lib folder"




