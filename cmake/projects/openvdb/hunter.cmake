# This is a header-like file, so include guards needed
if(DEFINED HUNTER_CMAKE_PROJECTS_OPENVDB_HUNTER_CMAKE_)
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



#add dependency packages
hunter_add_package(zlib)
hunter_add_package(tbb)
hunter_add_package(openexr)
hunter_add_package(boost COMPONENTS system thread date_time chrono )

hunter_check_local_server() #verify that the local server has been set up

SET(_buildType ${HUNTER_MSVC_RUNTIME}-${HUNTER_MSVC_ARCH})

# List of versions here...
if ("${_buildType}" STREQUAL "msvc2013-amd64")

	hunter_add_version(
		PACKAGE_NAME openvdb
		VERSION     "3.0.1"
		URL			"${HUNTER_SERVER_URL}/openvdb/${HUNTER_MSVC_RUNTIME}-${HUNTER_MSVC_ARCH}/openvdb-3.0.1.tar.gz"
		SHA1	    96327540b04996eca4a94df2ca008885aef4b860
	)

else ()
	hunter_fatal_error("No tarball available for openvdb ${_buildType}"   WIKI "error.external.build.missing")
endif()
# Probably more versions for real packages...



# Pick a download scheme
hunter_pick_scheme(DEFAULT url_sha1_unpack ) # use scheme for cmake projects


# Download package.
# Two versions of library will be build by default:
hunter_flat_download(PACKAGE_NAME openvdb PACKAGE_USR ${HUNTER_SERVER_USR} PACKAGE_PSW ${HUNTER_SERVER_PSW})