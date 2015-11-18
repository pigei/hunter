
include(CMakeParseArguments) # cmake_parse_arguments
include(hunter_setup_msvc_arch)


macro(hunter_qt_prefix_path	)

	if (NOT DEFINED HUNTER_FLAT_DOWNLOAD_PATH)
		return()
	endif()

	hunter_setup_msvc_arch()

	if (NOT DEFINED HUNTER_MSVC_ARCH)
		return()
	endif()

	#build foldername
	if ("${HUNTER_MSVC_ARCH}" STREQUAL "x86")
		SET(QT_DIR "${HUNTER_FLAT_DOWNLOAD_PATH}/Qt-${HUNTER_Qt_VERSION}/${HUNTER_MSVC_RUNTIME}")
		
	elseif("${HUNTER_MSVC_ARCH}" STREQUAL "amd64")
		SET(QT_DIR "${HUNTER_FLAT_DOWNLOAD_PATH}/Qt-${HUNTER_Qt_VERSION}/${HUNTER_MSVC_RUNTIME}_64")
	endif()

	if (NOT "${HUNTER_Qt_CONFIGURATION_TYPES}" STREQUAL "")
		SET(QT_DIR ${QT_DIR}_${HUNTER_Qt_CONFIGURATION_TYPES})
	endif()
	list (FIND CMAKE_PREFIX_PATH "${QT_DIR}" _index)  #in cmake 3.3 you can use if ("${QT_DIR}" IN_LIST CMAKE_PREFIX_PATH)
	if (${_index} EQUAL -1)
	  list(APPEND CMAKE_PREFIX_PATH "${QT_DIR}")
	endif()

endmacro()