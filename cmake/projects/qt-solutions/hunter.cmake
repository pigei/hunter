# This is a header-like file, so include guards needed
if(DEFINED HUNTER_CMAKE_PROJECTS_QT-SOLUTIONS_HUNTER_CMAKE_)
  return()
else()
  set(HUNTER_CMAKE_PROJECTS_QT-SOLUTIONS_HUNTER_CMAKE_ 1)
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
SET(qt-solutions-msvc2013-amd64_SHA  9b3de2c20ac89e1dc877f05c73bf6117be291048)
SET(qt-solutions-msvc2013-x86_SHA  feba9973434dcef3f9dcf89cda714e7882d7c2a7)
SET(qt-solutions-msvc2010-x86_SHA  6eeee24b988cadd237abc3935e8252a9e8d63385)
#SHAEND
#list of sha ends here

SET(selected_sha ${qt-solutions-${_buildType}_SHA})

if ("${selected_sha}" STREQUAL "")
	hunter_fatal_error("No tarball available for qt-solutions ${_buildType}"   WIKI "error.external.build.missing")
endif()


# List of versions here...

hunter_add_version(
	PACKAGE_NAME qt-solutions
	VERSION     "2015.02.19"
	URL			"${HUNTER_SERVER_URL}/qt-solutions/${HUNTER_MSVC_RUNTIME}-${HUNTER_MSVC_ARCH}/qt-solutions-2015.02.19.tar.gz"
	SHA1	    ${selected_sha}
)




# Pick a download scheme
hunter_pick_scheme(DEFAULT url_sha1_unpack_install ) # use scheme for cmake projects


# Download package.
# Two versions of library will be build by default:
hunter_flat_download(PACKAGE_NAME qt-solutions PACKAGE_USR ${HUNTER_SERVER_USR} PACKAGE_PSW ${HUNTER_SERVER_PSW})
