# This is a header-like file, so include guards needed
if(DEFINED HUNTER_CMAKE_PROJECTS_QT5FTP_HUNTER_CMAKE_)
  return()
else()
  set(HUNTER_CMAKE_PROJECTS_QT5FTP_HUNTER_CMAKE_ 1)
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
SET(Qt5Ftp-msvc2013-amd64_SHA  5f4040af0cf13880e78c1dbf7545158a67b635bc)
SET(Qt5Ftp-msvc2013-x86_SHA  04d6c1615d049ba5ff3dfdfe16f00f2b08e6559b)
SET(Qt5Ftp-msvc2010-x86_SHA  d64b7c68613e0e9e6dd2855b5eb863f592f16879)
#SHAEND
#list of sha ends here

SET(selected_sha ${Qt5Ftp-${_buildType}_SHA})

if ("${selected_sha}" STREQUAL "")
	hunter_fatal_error("No tarball available for Qt5Ftp ${_buildType}"   WIKI "error.external.build.missing")
endif()


# List of versions here...

hunter_add_version(
	PACKAGE_NAME Qt5Ftp
	VERSION     "5.1.0"
	URL			"${HUNTER_SERVER_URL}/Qt5Ftp/${HUNTER_MSVC_RUNTIME}-${HUNTER_MSVC_ARCH}/Qt5Ftp-5.1.0.tar.gz"
	SHA1	    ${selected_sha}
)




# Pick a download scheme
hunter_pick_scheme(DEFAULT url_sha1_unpack_install ) # use scheme for cmake projects


# Download package.
# Two versions of library will be build by default:
hunter_flat_download(PACKAGE_NAME Qt5Ftp PACKAGE_USR ${HUNTER_SERVER_USR} PACKAGE_PSW ${HUNTER_SERVER_PSW})
