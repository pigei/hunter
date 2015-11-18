# This is a header-like file, so include guards needed
if(DEFINED HUNTER_CMAKE_PROJECTS_NIDAQ_HUNTER_CMAKE_)
  return()
else()
  set(HUNTER_CMAKE_PROJECTS_NIDAQ_HUNTER_CMAKE_ 1)
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

SET(_buildType ${HUNTER_MSVC_ARCH})

#list of sha being here 
#SHABEGIN
SET(NIDAQ-amd64_SHA  a35120c05b98b97bbb1e5d267fc19acee42c3831)
SET(NIDAQ-x86_SHA  8e0679d0ab924999497b9cbf555955a1bdcd277e)
#SHAEND
#list of sha ends here

SET(selected_sha ${NIDAQ-${_buildType}_SHA})

if ("${selected_sha}" STREQUAL "")
	hunter_fatal_error("No tarball available for NIDAQ ${_buildType}"   WIKI "error.external.build.missing")
endif()


# List of versions here...

hunter_add_version(
	PACKAGE_NAME NIDAQ
	VERSION     "15.1.1"
	URL			"${HUNTER_SERVER_URL}/NIDAQ/${HUNTER_MSVC_ARCH}/NIDAQ-15.1.1.tar.gz"
	SHA1	    ${selected_sha}
)




# Pick a download scheme
hunter_pick_scheme(DEFAULT url_sha1_unpack_install ) # use scheme for cmake projects


# Download package.
# Two versions of library will be build by default:
hunter_flat_download(PACKAGE_NAME NIDAQ PACKAGE_USR ${HUNTER_SERVER_USR} PACKAGE_PSW ${HUNTER_SERVER_PSW})
