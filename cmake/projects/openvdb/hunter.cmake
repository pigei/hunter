# This is a header-like file, so include guards needed
if(DEFINED HUNTER_CMAKE_PROJECTS_ZLIB_HUNTER_CMAKE_)
  return()
else()
  set(HUNTER_CMAKE_PROJECTS_OPENVDB_HUNTER_CMAKE_ 1)
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
SET(_package_name "zlib")

# List of versions here...
if (_buildType STREQUAL "msvc2013-amd64")

	hunter_add_version(
		PACKAGE_NAME ${_package_name}
		VERSION     "1.2.8"
		URL			"${HUNTER_SERVER_URL}/${_package_name}/${HUNTER_MSVC_RUNTIME}-${HUNTER_MSVC_ARCH}/${_package_name}-1.2.8.tar.gz"
		SHA1	    b50c941c2d13668649a6cbb9418e92e2f0452b9a
	)

else ()
	hunter_fatal_error("No tarball available for ${_package_name} ${_buildType}"   WIKI "error.external.build.missing")
endif()
# Probably more versions for real packages...



# Pick a download scheme
hunter_pick_scheme(DEFAULT url_sha1_unpack ) # use scheme for cmake projects


# Download package.
# Two versions of library will be build by default:
hunter_flat_download(PACKAGE_NAME ${_package_name} PACKAGE_USR ${HUNTER_SERVER_USR} PACKAGE_PSW ${HUNTER_SERVER_PSW})

UNSET(_package_name)
