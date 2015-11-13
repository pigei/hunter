# This is a header-like file, so include guards needed
if(DEFINED HUNTER_CMAKE_PROJECTS_CRYPTLIB_HUNTER_CMAKE_)
  return()
else()
  set(HUNTER_CMAKE_PROJECTS_CRYPTLIB_HUNTER_CMAKE_ 1)
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
SET(cryptlib-msvc2013-amd64_SHA  5167bdcf8d7ae261c81e78ec2f234555de900487)
SET(cryptlib-msvc2013-x86_SHA  d3af05ab0c9b605cb3051efa31db42794c94def4)
SET(cryptlib-msvc2010-amd64_SHA  40985536e21567e5cdc3c2b979a157c86dbd327c)
SET(cryptlib-msvc2010-x86_SHA  33aca67cbb7cabdea1b0f5fdfb7921a603aa8c4b)
#SHAEND
#list of sha ends here

SET(selected_sha ${cryptlib-${_buildType}_SHA})

if ("${selected_sha}" STREQUAL "")
	hunter_fatal_error("No tarball available for cryptlib ${_buildType}"   WIKI "error.external.build.missing")
endif()


# List of versions here...

hunter_add_version(
	PACKAGE_NAME cryptlib
	VERSION     "3.4.3.1"
	URL			"${HUNTER_SERVER_URL}/cryptlib/${HUNTER_MSVC_RUNTIME}-${HUNTER_MSVC_ARCH}/cryptlib-3.4.3.1.tar.gz"
	SHA1	    ${selected_sha}
)




# Pick a download scheme
hunter_pick_scheme(DEFAULT url_sha1_unpack_install ) # use scheme for cmake projects


# Download package.
# Two versions of library will be build by default:
hunter_flat_download(PACKAGE_NAME cryptlib PACKAGE_USR ${HUNTER_SERVER_USR} PACKAGE_PSW ${HUNTER_SERVER_PSW})
