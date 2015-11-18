# This is a header-like file, so include guards needed
if(DEFINED HUNTER_CMAKE_PROJECTS_RAINSTORM_HUNTER_CMAKE_)
  return()
else()
  set(HUNTER_CMAKE_PROJECTS_RAINSTORM_HUNTER_CMAKE_ 1)
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
SET(Rainstorm-msvc2013-amd64_SHA  814646291d0215d8d2592d125d9854b347aa6d36)
SET(Rainstorm-msvc2013-x86_SHA  45e255e1f974cbaee5edd9a0fcc71e5a5f9df369)
SET(Rainstorm-msvc2010-amd64_SHA  6ed85100d373f2ab016561bf5d296dc1ab287ca9)
SET(Rainstorm-msvc2010-x86_SHA  9f06d444ad817ca1afb9a349571d95b894e3afc9)
#SHAEND
#list of sha ends here

SET(selected_sha ${Rainstorm-${_buildType}_SHA})

if ("${selected_sha}" STREQUAL "")
	hunter_fatal_error("No tarball available for Rainstorm ${_buildType}"   WIKI "error.external.build.missing")
endif()


# List of versions here...

hunter_add_version(
	PACKAGE_NAME Rainstorm
	VERSION     "1.0.0.5"
	URL			"${HUNTER_SERVER_URL}/Rainstorm/${HUNTER_MSVC_RUNTIME}-${HUNTER_MSVC_ARCH}/Rainstorm-1.0.0.5.tar.gz"
	SHA1	    ${selected_sha}
)




# Pick a download scheme
hunter_pick_scheme(DEFAULT url_sha1_unpack_install ) # use scheme for cmake projects


# Download package.
# Two versions of library will be build by default:
hunter_flat_download(PACKAGE_NAME Rainstorm PACKAGE_USR ${HUNTER_SERVER_USR} PACKAGE_PSW ${HUNTER_SERVER_PSW})
