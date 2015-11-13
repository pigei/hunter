# This is a header-like file, so include guards needed
if(DEFINED HUNTER_CMAKE_PROJECTS_ANN_HUNTER_CMAKE_)
  return()
else()
  set(HUNTER_CMAKE_PROJECTS_ANN_HUNTER_CMAKE_ 1)
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
SET(ANN-amd64_SHA  799fff368026a8517b55491b320ce017b75b6a89)
SET(ANN-x86_SHA  6a4de1d39118e522e2b319c8851e633561068d77)
#SHAEND
#list of sha ends here

SET(selected_sha ${ANN-${_buildType}_SHA})

if ("${selected_sha}" STREQUAL "")
	hunter_fatal_error("No tarball available for ANN ${_buildType}"   WIKI "error.external.build.missing")
endif()


# List of versions here...

hunter_add_version(
	PACKAGE_NAME ANN
	VERSION     "1.1.2"
	URL			"${HUNTER_SERVER_URL}/ANN/${HUNTER_MSVC_ARCH}/ANN-1.1.2.tar.gz"
	SHA1	    ${selected_sha}
)




# Pick a download scheme
hunter_pick_scheme(DEFAULT url_sha1_unpack_install ) # use scheme for cmake projects


# Download package.
# Two versions of library will be build by default:
hunter_flat_download(PACKAGE_NAME ANN PACKAGE_USR ${HUNTER_SERVER_USR} PACKAGE_PSW ${HUNTER_SERVER_PSW})
