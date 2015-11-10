
if(DEFINED HUNTER_CMAKE_PROJECTS_BOOST_MATH_C99L_HUNTER_CMAKE_)
  return()
else()
  set(HUNTER_CMAKE_PROJECTS_BOOST_MATH_C99L_HUNTER_CMAKE_ 1)
endif()

include(hunter_add_package)
include(hunter_flat_download)
include(hunter_pick_scheme)
include(hunter_status_debug)

hunter_pick_scheme(DEFAULT url_sha1_unpack_install)
hunter_flat_download(
    PACKAGE_NAME Boost
    PACKAGE_COMPONENT "math_c99l"
	PACKAGE_USR ${HUNTER_SERVER_USR} PACKAGE_PSW ${HUNTER_SERVER_PSW}
)
