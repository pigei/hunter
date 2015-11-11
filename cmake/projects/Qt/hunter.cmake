# Copyright (c) 2015, Ruslan Baratov, Alexandre Pretyman
# All rights reserved.

if(DEFINED HUNTER_CMAKE_PROJECTS_QT_HUNTER_CMAKE)
  return()
else()
  set(HUNTER_CMAKE_PROJECTS_QT_HUNTER_CMAKE 1)
endif()

LIST(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake") #QT specific modules

include(hunter_add_package)
include(hunter_add_version)
include(hunter_add_component_version)

include(hunter_cmake_args)
include(hunter_configuration_types)
include(hunter_report_broken_package)
include(hunter_flat_download)
include(hunter_local_server)
include(hunter_setup_msvc_arch)
include(hunter_qt_prefix_path) 

hunter_check_local_server() #verify that the local server has been set up

SET(HUNTER_PACKAGE_URL "${HUNTER_SERVER_URL}/Qt/5.5/${HUNTER_MSVC_RUNTIME}-${HUNTER_MSVC_ARCH}")
hunter_add_version(
    PACKAGE_NAME Qt
    VERSION "5.5"
    URL  "${HUNTER_PACKAGE_URL}"
)
include(components_5_5_${HUNTER_MSVC_RUNTIME}-${HUNTER_MSVC_ARCH}) #include all components detail for version 5.5.0


if(NOT APPLE AND NOT WIN32)
  hunter_configuration_types(Qt CONFIGURATION_TYPES Release)
endif()

if(ANDROID)
  # Static variant is not supported: https://bugreports.qt.io/browse/QTBUG-47455
  hunter_cmake_args(Qt CMAKE_ARGS BUILD_SHARED_LIBS=ON)
endif()

if(IOS)
  list(FIND IPHONEOS_ARCHS "armv7s" _armv7s_index)
  if(NOT _armv7s_index EQUAL -1)
    hunter_report_broken_package(
        "Some parts of Qt can't be built for armv7s."
        "For example Qt Multimedia: https://bugreports.qt.io/browse/QTBUG-48805"
    )
  endif()
endif()

#include at least core component
include("${CMAKE_CURRENT_LIST_DIR}/core/hunter.cmake")


hunter_qt_prefix_path()