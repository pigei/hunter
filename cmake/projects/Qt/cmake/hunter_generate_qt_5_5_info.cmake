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
      3d
      activeqt
      androidextras
      core
	  concurrent
	  opengl
      canvas3d
      connectivity
      declarative
      doc
      enginio
      graphicaleffects
      imageformats
      location
      macextras
      multimedia
      quick1
      quickcontrols
      script
      sensors
      serialport
      svg
      tools
      translations
      wayland
      webchannel
      webengine
      webkit
      webkit-examples
      websockets
      winextras
      x11extras
      xmlpatterns
  )

  # This is modified copy/paste code from <qt-sources>/qt.pro

  if(is_android)
    set(ANDROID_EXTRAS androidextras)
  else()
    set(ANDROID_EXTRAS "")
  endif()

  if(is_win32)
    set(ACTIVE_QT activeqt)
  else()
    # Project MESSAGE: ActiveQt is a Windows Desktop-only module. Will just generate a docs target.
    set(ACTIVE_QT "")
  endif()

  # Order is important. Component of each section should not depends on entry
  # from section below.

  # Components are in list but not exists in fact:
  # * docgallery
  # * feedback
  # * pim
  # * systems

  # Depends on nothing
  hunter_qt_add_module(NAME core)
  # --

  # Depends only on core
  hunter_qt_add_module(NAME androidextras COMPONENTS core)
  hunter_qt_add_module(NAME macextras COMPONENTS core)
  hunter_qt_add_module(NAME x11extras COMPONENTS core)
  hunter_qt_add_module(NAME svg COMPONENTS core)
  hunter_qt_add_module(NAME xmlpatterns COMPONENTS core)
  hunter_qt_add_module(NAME ${ACTIVE_QT} COMPONENTS core)
  hunter_qt_add_module(NAME imageformats COMPONENTS core)
  hunter_qt_add_module(NAME serialport COMPONENTS core)
  hunter_qt_add_module(NAME gui COMPONENTS core)
  hunter_qt_add_module(NAME widget COMPONENTS core)
  hunter_qt_add_module(NAME concurrent COMPONENTS core)
  # --

  # --
  hunter_qt_add_module(NAME declarative COMPONENTS core svg xmlpatterns)
  # --

  
  
    hunter_qt_add_module(NAME opengl COMPONENTS core widget)
  
  
  # Depends only on core/declarative
  hunter_qt_add_module(NAME canvas3d COMPONENTS declarative)
  hunter_qt_add_module(NAME doc COMPONENTS declarative)
  hunter_qt_add_module(NAME enginio COMPONENTS declarative)
  hunter_qt_add_module(NAME graphicaleffects COMPONENTS declarative)
  hunter_qt_add_module(NAME multimedia COMPONENTS core declarative)
  hunter_qt_add_module(NAME sensors COMPONENTS core declarative)
  hunter_qt_add_module(NAME wayland COMPONENTS core declarative)
  hunter_qt_add_module(NAME websockets COMPONENTS core declarative)
  # --

  # --
  hunter_qt_add_module(NAME quickcontrols COMPONENTS declarative graphicaleffects)
  hunter_qt_add_module(NAME winextras COMPONENTS core declarative multimedia)
  hunter_qt_add_module(NAME location COMPONENTS core declarative)
  hunter_qt_add_module(NAME connectivity COMPONENTS core ${ANDROID_EXTRAS} declarative)
  hunter_qt_add_module(NAME webchannel COMPONENTS core declarative websockets)
  hunter_qt_add_module(NAME 3d COMPONENTS declarative imageformats)
  # --

  # --
  hunter_qt_add_module(NAME webkit COMPONENTS declarative location multimedia sensors webchannel)
  # --

  # --
  hunter_qt_add_module(NAME tools COMPONENTS core declarative ${ACTIVE_QT} webkit)
  hunter_qt_add_module(NAME webengine COMPONENTS quickcontrols webchannel webkit location)
  # --

  # --
  hunter_qt_add_module(NAME webkit-examples COMPONENTS webkit tools)
  hunter_qt_add_module(NAME script COMPONENTS core tools)
  hunter_qt_add_module(NAME translations COMPONENTS tools)
  # --

  # --
  hunter_qt_add_module(NAME quick1 COMPONENTS script svg xmlpatterns webkit)
  # --

  string(COMPARE EQUAL "${component_name}" "core" is_core)
  string(COMPARE EQUAL "${component_${component_name}_depends_on}" "" depends_on_nothing)
  if(is_core)
    if(NOT depends_on_nothing)
      hunter_internal_error("core should not depends on anything")
    endif()
  else()
    if(depends_on_nothing)
      hunter_internal_error(
          "component `${component_name}` should have at least one dependency:"
          " core"
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
