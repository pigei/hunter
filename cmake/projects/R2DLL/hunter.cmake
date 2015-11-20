# This is a header-like file, so include guards needed
if(DEFINED HUNTER_CMAKE_PROJECTS_R2DLL_HUNTER_CMAKE_)
  return()
else()
  set(HUNTER_CMAKE_PROJECTS_R2DLL_HUNTER_CMAKE_ 1)
endif()

# Load used modules
include(hunter_add_package)
include(hunter_add_version)
include(hunter_fatal_error)
include(hunter_flat_download)
include(hunter_pick_scheme)
include(hunter_local_server)
include(hunter_setup_msvc_arch)

hunter_check_local_server() #verify that the local server has been set up



SET(_buildType ${HUNTER_MSVC_RUNTIME}-${HUNTER_MSVC_ARCH})


SET(R2DLL-msvc2013-amd64_SHA  abbafac73aa714aef54a6a77240ff20e1b6b719e)
SET(R2DLL-msvc2013-x86_SHA  6f55dcfb47641a914ba48f3d9751298b2a2ae486)


SET(selected_sha ${R2DLL-${_buildType}_SHA})

if ("${selected_sha}" STREQUAL "")
	hunter_fatal_error("No tarball available for R2DLL ${_buildType}"   WIKI "error.external.build.missing")
endif()


# List of versions here...

hunter_add_version(
	PACKAGE_NAME R2DLL
	VERSION     "1.5.1.0"
	URL			"${HUNTER_SERVER_URL}/R2DLL/${HUNTER_MSVC_RUNTIME}-${HUNTER_MSVC_ARCH}/R2DLL-1.5.1.0.tar.gz"
	SHA1	    ${selected_sha}
)



#list of sha being here 
#SHABEGIN
SET(R2DLL-msvc2013-amd64_SHA  661fb359d0038fa142596a913b3aeba31f2388b8)
SET(R2DLL-msvc2013-x86_SHA  cf8f1f1d3a4645c8f74d00bfee38635df28aa53a)
#SHAEND
#list of sha ends here

SET(selected_sha ${R2DLL-${_buildType}_SHA})

if ("${selected_sha}" STREQUAL "")
	hunter_fatal_error("No tarball available for R2DLL ${_buildType}"   WIKI "error.external.build.missing")
endif()


# List of versions here...

hunter_add_version(
	PACKAGE_NAME R2DLL
	VERSION     "1.5.0.202"
	URL			"${HUNTER_SERVER_URL}/R2DLL/${HUNTER_MSVC_RUNTIME}-${HUNTER_MSVC_ARCH}/R2DLL-1.5.0.202.tar.gz"
	SHA1	    ${selected_sha}
)




# Pick a download scheme
hunter_pick_scheme(DEFAULT url_sha1_unpack_install ) # use scheme for cmake projects


# Download package.
# Two versions of library will be build by default:
hunter_flat_download(PACKAGE_NAME R2DLL PACKAGE_USR ${HUNTER_SERVER_USR} PACKAGE_PSW ${HUNTER_SERVER_PSW})

hunter_add_package(cryptlib)
hunter_add_package(ANN)
hunter_add_package(zlib)
hunter_add_package(qt-solutions)
