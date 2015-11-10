# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

include(hunter_internal_error)
include(hunter_qt_add_module)
include(hunter_test_string_not_empty)

# See cmake/projects/Qt/generate.sh

# This function will be used in build scheme too so it's better to set
# regular CMake variables like WIN32 or ANDROID explicitly by is_{android,win32}

function(
    hunter_generate_qt_5_5_info
    component_name
    skip_components_varname
    component_depends_on_varname
    is_android
    is_win32
)
  hunter_test_string_not_empty("${component_name}")
  hunter_test_string_not_empty("${skip_components_varname}")
  hunter_test_string_not_empty("${component_depends_on_varname}")

  string(COMPARE NOTEQUAL "${ARGN}" "" has_unparsed)
  if(has_unparsed)
    hunter_internal_error("Unparsed argument: ${ARGN}")
  endif()

  set(
      all_components
      qt3d
      qtactiveqt
      qtandroidextras
      qtcore
      qtcanvas3d
      qtconnectivity
      qtdeclarative
      qtdoc
      qtenginio
      qtgraphicaleffects
      qtimageformats
      qtlocation
      qtmacextras
      qtmultimedia
      qtquick1
      qtquickcontrols
      qtscript
      qtsensors
      qtserialport
      qtsvg
      qttools
      qttranslations
      qtwayland
      qtwebchannel
      qtwebengine
      qtwebkit
      qtwebkit-examples
      qtwebsockets
      qtwinextras
      qtx11extras
      qtxmlpatterns
  )

  # This is modified copy/paste code from <qt-sources>/qt.pro

  if(is_android)
    set(ANDROID_EXTRAS qtandroidextras)
  else()
    set(ANDROID_EXTRAS "")
  endif()

  if(is_win32)
    set(ACTIVE_QT qtactiveqt)
  else()
    # Project MESSAGE: ActiveQt is a Windows Desktop-only module. Will just generate a docs target.
    set(ACTIVE_QT "")
  endif()

  # Order is important. Component of each section should not depends on entry
  # from section below.

  # Components are in list but not exists in fact:
  # * qtdocgallery
  # * qtfeedback
  # * qtpim
  # * qtsystems

  # Depends on nothing
  hunter_qt_add_module(NAME qtcore)
  # --

  # Depends only on qtcore
  hunter_qt_add_module(NAME qtandroidextras COMPONENTS qtcore)
  hunter_qt_add_module(NAME qtmacextras COMPONENTS qtcore)
  hunter_qt_add_module(NAME qtx11extras COMPONENTS qtcore)
  hunter_qt_add_module(NAME qtsvg COMPONENTS qtcore)
  hunter_qt_add_module(NAME qtxmlpatterns COMPONENTS qtcore)
  hunter_qt_add_module(NAME ${ACTIVE_QT} COMPONENTS qtcore)
  hunter_qt_add_module(NAME qtimageformats COMPONENTS qtcore)
  hunter_qt_add_module(NAME qtserialport COMPONENTS qtcore)
  hunter_qt_add_module(NAME qtgui COMPONENTS qtcore)
  # --

  # --
  hunter_qt_add_module(NAME qtdeclarative COMPONENTS qtcore qtsvg qtxmlpatterns)
  # --

  # Depends only on qtcore/qtdeclarative
  hunter_qt_add_module(NAME qtcanvas3d COMPONENTS qtdeclarative)
  hunter_qt_add_module(NAME qtdoc COMPONENTS qtdeclarative)
  hunter_qt_add_module(NAME qtenginio COMPONENTS qtdeclarative)
  hunter_qt_add_module(NAME qtgraphicaleffects COMPONENTS qtdeclarative)
  hunter_qt_add_module(NAME qtmultimedia COMPONENTS qtcore qtdeclarative)
  hunter_qt_add_module(NAME qtsensors COMPONENTS qtcore qtdeclarative)
  hunter_qt_add_module(NAME qtwayland COMPONENTS qtcore qtdeclarative)
  hunter_qt_add_module(NAME qtwebsockets COMPONENTS qtcore qtdeclarative)
  # --

  # --
  hunter_qt_add_module(NAME qtquickcontrols COMPONENTS qtdeclarative qtgraphicaleffects)
  hunter_qt_add_module(NAME qtwinextras COMPONENTS qtcore qtdeclarative qtmultimedia)
  hunter_qt_add_module(NAME qtlocation COMPONENTS qtcore qtdeclarative)
  hunter_qt_add_module(NAME qtconnectivity COMPONENTS qtcore ${ANDROID_EXTRAS} qtdeclarative)
  hunter_qt_add_module(NAME qtwebchannel COMPONENTS qtcore qtdeclarative qtwebsockets)
  hunter_qt_add_module(NAME qt3d COMPONENTS qtdeclarative qtimageformats)
  # --

  # --
  hunter_qt_add_module(NAME qtwebkit COMPONENTS qtdeclarative qtlocation qtmultimedia qtsensors qtwebchannel)
  # --

  # --
  hunter_qt_add_module(NAME qttools COMPONENTS qtcore qtdeclarative ${ACTIVE_QT} qtwebkit)
  hunter_qt_add_module(NAME qtwebengine COMPONENTS qtquickcontrols qtwebchannel qtwebkit qtlocation)
  # --

  # --
  hunter_qt_add_module(NAME qtwebkit-examples COMPONENTS qtwebkit qttools)
  hunter_qt_add_module(NAME qtscript COMPONENTS qtcore qttools)
  hunter_qt_add_module(NAME qttranslations COMPONENTS qttools)
  # --

  # --
  hunter_qt_add_module(NAME qtquick1 COMPONENTS qtscript qtsvg qtxmlpatterns qtwebkit)
  # --

  string(COMPARE EQUAL "${component_name}" "qtcore" is_qtcore)
  string(COMPARE EQUAL "${component_${component_name}_depends_on}" "" depends_on_nothing)
  if(is_qtcore)
    if(NOT depends_on_nothing)
      hunter_internal_error("qtcore should not depends on anything")
    endif()
  else()
    if(depends_on_nothing)
      hunter_internal_error(
          "component `${component_name}` should have at least one dependency:"
          " qtcore"
      )
    endif()
  endif()

  set(
      "${component_depends_on_varname}"
      "${component_${component_name}_depends_on}"
      PARENT_SCOPE
  )

  set(skip_list ${all_components})
  list(
      REMOVE_ITEM
      skip_list
      "${component_name}"
      ${component_${component_name}_depends_on}
  )
  set("${skip_components_varname}" "${skip_list}" PARENT_SCOPE)
endfunction()
