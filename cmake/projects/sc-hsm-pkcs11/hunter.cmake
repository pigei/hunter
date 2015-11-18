# This is a header-like file, so include guards needed
if(DEFINED HUNTER_CMAKE_PROJECTS_SC-HSM-PKCS11_HUNTER_CMAKE_)
  return()
else()
  set(HUNTER_CMAKE_PROJECTS_SC-HSM-PKCS11_HUNTER_CMAKE_ 1)
endif()

# Load used modules
include(hunter_add_package)
include(hunter_add_version)
include(hunter_fatal_error)
include(hunter_flat_download)
include(hunter_pick_scheme)
include(hunter_local_server)
include(hunter_setup_msvc_arch)

hunter_check_local_server() #verify that the local server has been set up




#add dependency packages
#...

SET(_buildType ${HUNTER_MSVC_ARCH})

#list of sha being here 
#SHABEGIN
SET(sc-hsm-pkcs11-amd64_SHA  24cc64d6203f8d72822f2fdd612eef79141dd802)
SET(sc-hsm-pkcs11-x86_SHA  6cb70c48a2b3cb386466e15a5fc7f4a0773206c8)
#SHAEND
#list of sha ends here

SET(selected_sha ${sc-hsm-pkcs11-${_buildType}_SHA})

if ("${selected_sha}" STREQUAL "")
	hunter_fatal_error("No tarball available for sc-hsm-pkcs11 ${_buildType}"   WIKI "error.external.build.missing")
endif()


# List of versions here...

hunter_add_version(
	PACKAGE_NAME sc-hsm-pkcs11
	VERSION     "1.0.0.1"
	URL			"${HUNTER_SERVER_URL}/sc-hsm-pkcs11/${HUNTER_MSVC_ARCH}/sc-hsm-pkcs11-1.0.0.1.tar.gz"
	SHA1	    ${selected_sha}
)




# Pick a download scheme
hunter_pick_scheme(DEFAULT url_sha1_unpack_install ) # use scheme for cmake projects


# Download package.
# Two versions of library will be build by default:
hunter_flat_download(PACKAGE_NAME sc-hsm-pkcs11 PACKAGE_USR ${HUNTER_SERVER_USR} PACKAGE_PSW ${HUNTER_SERVER_PSW})
