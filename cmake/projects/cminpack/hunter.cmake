# This is a header-like file, so include guards needed
if(DEFINED HUNTER_CMAKE_PROJECTS_CMINPACK_HUNTER_CMAKE_)
  return()
else()
  set(HUNTER_CMAKE_PROJECTS_CMINPACK_HUNTER_CMAKE_ 1)
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
SET(cminpack-msvc2013-amd64_SHA  c3f3796f6458e2f928c8d773edb29add8c634db4)
SET(cminpack-msvc2013-x86_SHA  73310b71fbefb0f8b075635139716eb660adbea1)
#SHAEND
#list of sha ends here

SET(selected_sha ${cminpack-${_buildType}_SHA})

if ("${selected_sha}" STREQUAL "")
	hunter_fatal_error("No tarball available for cminpack ${_buildType}"   WIKI "error.external.build.missing")
endif()


# List of versions here...

hunter_add_version(
	PACKAGE_NAME cminpack
	VERSION     "1.3.4"
	URL			"${HUNTER_SERVER_URL}/cminpack/${HUNTER_MSVC_RUNTIME}-${HUNTER_MSVC_ARCH}/cminpack-1.3.4.tar.gz"
	SHA1	    ${selected_sha}
)




# Pick a download scheme
hunter_pick_scheme(DEFAULT url_sha1_unpack_install ) # use scheme for cmake projects


# Download package.
# Two versions of library will be build by default:
hunter_flat_download(PACKAGE_NAME cminpack PACKAGE_USR ${HUNTER_SERVER_USR} PACKAGE_PSW ${HUNTER_SERVER_PSW})
