# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED HUNTER_CMAKE_PROJECTS_BOOST_HUNTER_CMAKE)
  return()
else()
  set(HUNTER_CMAKE_PROJECTS_BOOST_HUNTER_CMAKE 1)
endif()

include(hunter_add_version)
include(hunter_cacheable)
include(hunter_cmake_args)
include(hunter_download)
include(hunter_pick_scheme)
include(hunter_setup_msvc_arch)
hunter_check_local_server() #verify that the local server has been set up


SET(_buildType "${HUNTER_MSVC_RUNTIME}-${HUNTER_MSVC_ARCH}")

SET(HUNTER_PACKAGE_URL "${HUNTER_SERVER_URL}/Boost/lib-${HUNTER_MSVC_RUNTIME}-${HUNTER_MSVC_ARCH}")
hunter_add_version(
    PACKAGE_NAME Boost
    VERSION "1.57.0"
    URL  "${HUNTER_PACKAGE_URL}"
)

include(components_1_57_0_${_buildType}) #include all components detail for version and build type currently active

unset(${_buildType})

# Disable searching in locations not specified by these hint variables.
set(Boost_NO_SYSTEM_PATHS ON)


hunter_pick_scheme(DEFAULT url_sha1_boost)
hunter_cacheable(Boost)
hunter_download(PACKAGE_NAME Boost)
