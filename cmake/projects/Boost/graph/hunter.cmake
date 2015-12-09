# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED HUNTER_CMAKE_PROJECTS_BOOST_GRAPH_HUNTER_CMAKE)
  return()
else()
  set(HUNTER_CMAKE_PROJECTS_BOOST_GRAPH_HUNTER_CMAKE 1)
endif()

include(hunter_download)
include(hunter_pick_scheme)

hunter_pick_scheme(
    DEFAULT
    url_sha1_boost_library
    IPHONEOS
    url_sha1_boost_ios_library
)

hunter_download(
    PACKAGE_NAME
    Boost
    PACKAGE_COMPONENT
    graph
    PACKAGE_INTERNAL_DEPS_ID "1"
)
