
if(DEFINED HUNTER_CMAKE_PROJECTS_opencv_OCL_HUNTER_CMAKE_)
  return()
else()
  set(HUNTER_CMAKE_PROJECTS_opencv_OCL_HUNTER_CMAKE_ 1)
endif()

include(hunter_add_package)
include(hunter_flat_download)
include(hunter_pick_scheme)
include(hunter_status_debug)

hunter_pick_scheme(DEFAULT url_sha1_unpack_install)
hunter_flat_download(
    PACKAGE_NAME opencv
    PACKAGE_COMPONENT "ocl"
	PACKAGE_USR ${HUNTER_SERVER_USR} PACKAGE_PSW ${HUNTER_SERVER_PSW}
)
