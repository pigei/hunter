# This is a header-like file, so include guards needed
if(DEFINED HUNTER_CMAKE_PROJECTS_ZF_HUNTER_CMAKE_)
  return()
else()
  set(HUNTER_CMAKE_PROJECTS_ZF_HUNTER_CMAKE_ 1)
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




#add dependency packages
#...

SET(_buildType ${HUNTER_MSVC_RUNTIME}-${HUNTER_MSVC_ARCH})

#list of sha being here 
#SHABEGIN
SET(ZF-msvc2013-amd64_SHA  e184da915d71ef59f2d27456a70c9e34a6f5025b)
SET(ZF-msvc2013-x86_SHA  f40770384323076337984b337235c0f7cf979bc3)
SET(ZF-msvc2010-amd64_SHA  ea62a6d0e892180b02b2dcf6b0f9e80a4fe69f72)
SET(ZF-msvc2010-x86_SHA  24110c165f95347a963996c5ae045e210c6d1ef5)
#SHAEND
#list of sha ends here

SET(selected_sha ${ZF-${_buildType}_SHA})

if ("${selected_sha}" STREQUAL "")
	hunter_fatal_error("No tarball available for ZF ${_buildType}"   WIKI "error.external.build.missing")
endif()


# List of versions here...

hunter_add_version(
	PACKAGE_NAME ZF
	VERSION     "8.7.1"
	URL			"${HUNTER_SERVER_URL}/ZF/${HUNTER_MSVC_RUNTIME}-${HUNTER_MSVC_ARCH}/ZF-8.7.1.tar.gz"
	SHA1	    ${selected_sha}
)




# Pick a download scheme
hunter_pick_scheme(DEFAULT url_sha1_unpack_install ) # use scheme for cmake projects


# Download package.
# Two versions of library will be build by default:
hunter_flat_download(PACKAGE_NAME ZF PACKAGE_USR ${HUNTER_SERVER_USR} PACKAGE_PSW ${HUNTER_SERVER_PSW})
