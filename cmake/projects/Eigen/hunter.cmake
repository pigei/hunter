# Copyright (c) 2015, David Hirvonen
# All rights reserved.

if(DEFINED HUNTER_CMAKE_PROJECTS_EIGEN_HUNTER_CMAKE_)
  return()
else()
  set(HUNTER_CMAKE_PROJECTS_EIGEN_HUNTER_CMAKE_ 1)
endif()

# Load used modules
include(hunter_add_version)
include(hunter_cmake_args)
include(hunter_flat_download)
include(hunter_pick_scheme)
include(hunter_local_server)


hunter_check_local_server() #verify that the local server has been set up


# List of versions here...
hunter_add_version(
    PACKAGE_NAME Eigen
    VERSION 	 "3.2.4"
    URL  		 "${HUNTER_SERVER_URL}/eigen/eigen-3.2.4.tar.gz"
    SHA1 	 	 77c9e6b507bb875197368852a2708e78748d1f44
)

hunter_cmake_args(Eigen CMAKE_ARGS EIGEN_ENABLE_TESTING=OFF)

# Pick a download scheme
hunter_pick_scheme(DEFAULT url_sha1_unpack_install)

# Download package.
hunter_flat_download(PACKAGE_NAME Eigen PACKAGE_USR ${HUNTER_SERVER_USR} PACKAGE_PSW ${HUNTER_SERVER_PSW})
