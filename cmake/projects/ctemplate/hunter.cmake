# This is a header-like file, so include guards needed
if(DEFINED HUNTER_CMAKE_PROJECTS_CTEMPLATE_HUNTER_CMAKE_)
  return()
else()
  set(HUNTER_CMAKE_PROJECTS_CTEMPLATE_HUNTER_CMAKE_ 1)
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
SET(ctemplate-msvc2013-amd64_SHA  e2d2042aca3e0a7625b897e1c61dccfaffc36a3f)
SET(ctemplate-msvc2013-x86_SHA  ef36d0b8626279e060d7e8ecb7e9280defcc13af)
SET(ctemplate-msvc2010-amd64_SHA  22fde38d4e059e4be6a06a5023942dfc38ee84af)
SET(ctemplate-msvc2010-x86_SHA  3071238af51c0181c64734f152aa384c2cba8fcb)
#SHAEND
#list of sha ends here

SET(selected_sha ${ctemplate-${_buildType}_SHA})

if ("${selected_sha}" STREQUAL "")
	hunter_fatal_error("No tarball available for ctemplate ${_buildType}"   WIKI "error.external.build.missing")
endif()


# List of versions here...

hunter_add_version(
	PACKAGE_NAME ctemplate
	VERSION     "2.3"
	URL			"${HUNTER_SERVER_URL}/ctemplate/${HUNTER_MSVC_RUNTIME}-${HUNTER_MSVC_ARCH}/ctemplate-2.3.tar.gz"
	SHA1	    ${selected_sha}
)




# Pick a download scheme
hunter_pick_scheme(DEFAULT url_sha1_unpack_install ) # use scheme for cmake projects


# Download package.
# Two versions of library will be build by default:
hunter_flat_download(PACKAGE_NAME ctemplate PACKAGE_USR ${HUNTER_SERVER_USR} PACKAGE_PSW ${HUNTER_SERVER_PSW})
