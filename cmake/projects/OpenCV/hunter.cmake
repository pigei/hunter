
if(DEFINED HUNTER_CMAKE_PROJECTS_OPENCV_HUNTER_CMAKE)
  return()
else()
  set(HUNTER_CMAKE_PROJECTS_OPENCV_HUNTER_CMAKE 1)
endif()

LIST(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake") #library specific modules


include(hunter_add_version)
include(hunter_cacheable)
include(hunter_cmake_args)
include(hunter_flat_download)
include(hunter_pick_scheme)
include(hunter_setup_msvc_arch)
hunter_check_local_server() #verify that the local server has been set up


SET(_buildType "${HUNTER_MSVC_RUNTIME}-${HUNTER_MSVC_ARCH}")


if (DEFINED OPENCV_USE_STATIC_LIBS)
	SET(_buildType "${_buildType}-static")
endif()

SET(HUNTER_PACKAGE_URL "${HUNTER_SERVER_URL}/opencv/2.4.10/${HUNTER_MSVC_RUNTIME}-${HUNTER_MSVC_ARCH}")
hunter_add_version(
    PACKAGE_NAME opencv
    VERSION "2.4.10"
    URL  "${HUNTER_PACKAGE_URL}"
)

include(components_2_4_10_${_buildType}) #include all components detail for version and build type currently active

unset(${_buildType})


#include all submodule (unfortunately opencv requires all files to be present when cmake setup targets)
FILE(GLOB children "${CMAKE_CURRENT_LIST_DIR}/*")
FOREACH(child ${children})
 IF(EXISTS "${child}/hunter.cmake")
    include("${child}/hunter.cmake")
 ENDIF()
endforeach()

