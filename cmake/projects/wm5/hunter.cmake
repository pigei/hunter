# This is a header-like file, so include guards needed
if(DEFINED HUNTER_CMAKE_PROJECTS_WM5_HUNTER_CMAKE_)
  return()
else()
  set(HUNTER_CMAKE_PROJECTS_WM5_HUNTER_CMAKE_ 1)
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
SET(wm5-msvc2013-amd64_SHA  68d9ea0b07009a246fe3608f2429052d93a3b90b)
SET(wm5-msvc2013-x86_SHA  746024035c6b9c23f4387b20e50a2b7ac92cf4e1)
SET(wm5-msvc2010-amd64_SHA  8ff8a753d7323488671c5ac135ae575499db5bae)
SET(wm5-msvc2010-x86_SHA  d0a852be50d4d71eb1f58536eb366caeac6928ed)
#SHAEND
#list of sha ends here

SET(selected_sha ${wm5-${_buildType}_SHA})

if ("${selected_sha}" STREQUAL "")
	hunter_fatal_error("No tarball available for wm5 ${_buildType}"   WIKI "error.external.build.missing")
endif()


# List of versions here...

hunter_add_version(
	PACKAGE_NAME wm5
	VERSION     "5.13"
	URL			"${HUNTER_SERVER_URL}/wm5/${HUNTER_MSVC_RUNTIME}-${HUNTER_MSVC_ARCH}/wm5-5.13.tar.gz"
	SHA1	    ${selected_sha}
)




# Pick a download scheme
hunter_pick_scheme(DEFAULT url_sha1_unpack_install ) # use scheme for cmake projects


# Download package.
# Two versions of library will be build by default:
hunter_flat_download(PACKAGE_NAME wm5 PACKAGE_USR ${HUNTER_SERVER_USR} PACKAGE_PSW ${HUNTER_SERVER_PSW})
