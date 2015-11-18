# This is a header-like file, so include guards needed
if(DEFINED HUNTER_CMAKE_PROJECTS_QWT_HUNTER_CMAKE_)
  return()
else()
  set(HUNTER_CMAKE_PROJECTS_QWT_HUNTER_CMAKE_ 1)
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
SET(qwt-msvc2013-amd64_SHA  e0408b64da52242f1bb612f9473dfc692438ec9a)
SET(qwt-msvc2013-x86_SHA  8eeb52858b81c421f51a8146ecdfb91d0ec6a33b)
SET(qwt-msvc2010-amd64_SHA  6287ef7bcae52a3f71717c7d4d6dcc006340e89b)
SET(qwt-msvc2010-x86_SHA  68ab6fb2452ffcf91f07f89dd34654924389432f)
#SHAEND
#list of sha ends here

SET(selected_sha ${qwt-${_buildType}_SHA})

if ("${selected_sha}" STREQUAL "")
	hunter_fatal_error("No tarball available for qwt ${_buildType}"   WIKI "error.external.build.missing")
endif()


# List of versions here...

hunter_add_version(
	PACKAGE_NAME qwt
	VERSION     "6.1.2"
	URL			"${HUNTER_SERVER_URL}/qwt/${HUNTER_MSVC_RUNTIME}-${HUNTER_MSVC_ARCH}/qwt-6.1.2.tar.gz"
	SHA1	    ${selected_sha}
)




# Pick a download scheme
hunter_pick_scheme(DEFAULT url_sha1_unpack_install ) # use scheme for cmake projects


# Download package.
# Two versions of library will be build by default:
hunter_flat_download(PACKAGE_NAME qwt PACKAGE_USR ${HUNTER_SERVER_USR} PACKAGE_PSW ${HUNTER_SERVER_PSW})
