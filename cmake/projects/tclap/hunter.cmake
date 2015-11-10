# This is a header-like file, so include guards needed
if(DEFINED HUNTER_CMAKE_PROJECTS_EXAMPLE_HUNTER_CMAKE_)
  return()
else()
  set(HUNTER_CMAKE_PROJECTS_EXAMPLE_HUNTER_CMAKE_ 1)
endif()

# Load used modules
include(hunter_add_version)
include(hunter_flat_download)
include(hunter_pick_scheme)
include(hunter_local_server)



hunter_check_local_server() #verify that the local server has been set up

# List of versions here...
hunter_add_version(
    PACKAGE_NAME tclap
    VERSION     "1.2.1"
    URL			"${HUNTER_SERVER_URL}/tclap-1.2.1/tclap-1.2.1.tar.gz"
    SHA1	    cb4d6e872bcd209927a5d306428b27890714d044
)

# Probably more versions for real packages...




# Pick a download scheme
hunter_pick_scheme(DEFAULT url_sha1_unpack ) # use scheme for cmake projects


# Download package.
# Two versions of library will be build by default:
hunter_flat_download(PACKAGE_NAME tclap PACKAGE_USR ${HUNTER_SERVER_USR} PACKAGE_PSW ${HUNTER_SERVER_PSW})