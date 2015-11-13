# This is a header-like file, so include guards needed
if(DEFINED HUNTER_CMAKE_PROJECTS_GLEW_HUNTER_CMAKE_)
  return()
else()
  set(HUNTER_CMAKE_PROJECTS_GLEW_HUNTER_CMAKE_ 1)
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

# List of versions here...
if (_buildType STREQUAL "msvc2013-amd64")

	hunter_add_version(
		PACKAGE_NAME glew
		VERSION     "1.10.0"
		URL			"${HUNTER_SERVER_URL}/glew/${HUNTER_MSVC_RUNTIME}-${HUNTER_MSVC_ARCH}/glew-1.10.0.tar.gz"
		SHA1	    d2b28fabb383bba283617deb51d20ab316ae02a4
	)

elseif (_buildType STREQUAL "msvc2013-x86")

	hunter_add_version(
		PACKAGE_NAME glew
		VERSION     "1.10.0"
		URL			"${HUNTER_SERVER_URL}/glew/${HUNTER_MSVC_RUNTIME}-${HUNTER_MSVC_ARCH}/glew-1.10.0.tar.gz"
		SHA1	    81206df73fbfc0f0aa0d9e85aa2b6886f46c264e
	)
else()
	hunter_fatal_error("No tarball available for glew ${_buildType}"   WIKI "error.external.build.missing")
endif()
# Probably more versions for real packages...



# Pick a download scheme
hunter_pick_scheme(DEFAULT url_sha1_unpack_install ) # use scheme for cmake projects


# Download package.
# Two versions of library will be build by default:
hunter_flat_download(PACKAGE_NAME glew PACKAGE_USR ${HUNTER_SERVER_USR} PACKAGE_PSW ${HUNTER_SERVER_PSW})