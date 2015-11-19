# This is a header-like file, so include guards needed
if(DEFINED HUNTER_CMAKE_PROJECTS_ICON_HUNTER_CMAKE_)
  return()
else()
  set(HUNTER_CMAKE_PROJECTS_ICON_HUNTER_CMAKE_ 1)
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
SET(icon-msvc2013-amd64_SHA  aefdad79825b7646c7c8b1b1cd83cb2f3e071466)
SET(icon-msvc2013-x86_SHA  d4bd19814beb1dd06c336459e4dd43184090cb95)
SET(icon-msvc2010-amd64_SHA  09ceac6844a1292e53c129e06ff6b81675fc2d38)
SET(icon-msvc2010-x86_SHA  d7ee51f7ddcab74fdc9f5c9c37e0fae708c54695)
#SHAEND
#list of sha ends here

SET(selected_sha ${icon-${_buildType}_SHA})

if ("${selected_sha}" STREQUAL "")
	hunter_fatal_error("No tarball available for icon ${_buildType}"   WIKI "error.external.build.missing")
endif()


# List of versions here...

hunter_add_version(
	PACKAGE_NAME icon
	VERSION     "5.1.0.82"
	URL			"${HUNTER_SERVER_URL}/icon/${HUNTER_MSVC_RUNTIME}-${HUNTER_MSVC_ARCH}/icon-5.1.0.82.tar.gz"
	SHA1	    ${selected_sha}
)




# Pick a download scheme
hunter_pick_scheme(DEFAULT url_sha1_unpack_install ) # use scheme for cmake projects


# Download package.
# Two versions of library will be build by default:
hunter_flat_download(PACKAGE_NAME icon PACKAGE_USR ${HUNTER_SERVER_USR} PACKAGE_PSW ${HUNTER_SERVER_PSW})
