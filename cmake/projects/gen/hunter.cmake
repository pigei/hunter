# This is a header-like file, so include guards needed
if(DEFINED HUNTER_CMAKE_PROJECTS_GEN_HUNTER_CMAKE_)
  return()
else()
  set(HUNTER_CMAKE_PROJECTS_GEN_HUNTER_CMAKE_ 1)
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
SET(gen-msvc2013-amd64_SHA  285adebbf2da789e7f6491373f27d29c16def87f)
SET(gen-msvc2013-x86_SHA  cf2727f82e23f869d92579de6d28f9c346bd5d53)
#SHAEND
#list of sha ends here

SET(selected_sha ${gen-${_buildType}_SHA})

if ("${selected_sha}" STREQUAL "")
	hunter_fatal_error("No tarball available for gen ${_buildType}"   WIKI "error.external.build.missing")
endif()


# List of versions here...

hunter_add_version(
	PACKAGE_NAME gen
	VERSION     "1.1.0"
	URL			"${HUNTER_SERVER_URL}/gen/${HUNTER_MSVC_RUNTIME}-${HUNTER_MSVC_ARCH}/gen-1.1.0.tar.gz"
	SHA1	    ${selected_sha}
)




# Pick a download scheme
hunter_pick_scheme(DEFAULT url_sha1_unpack_install ) # use scheme for cmake projects


# Download package.
# Two versions of library will be build by default:
hunter_flat_download(PACKAGE_NAME gen PACKAGE_USR ${HUNTER_SERVER_USR} PACKAGE_PSW ${HUNTER_SERVER_PSW})
hunter_add_package(openvdb)
hunter_add_package(Eigen)
hunter_add_package(glew)
