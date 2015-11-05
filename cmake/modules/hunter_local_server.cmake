include(CMakeParseArguments) # cmake_parse_arguments

include(hunter_status_debug)
include(hunter_status_print)
include(hunter_authentication)

#Setup local repository information to direct download of packages using authentication if AUTH is provided. Projects may use HUNTER_SERVER_URL as storage location.
#It will set HUNTER_SERVER_URL accordingly. If AUTH is enabled it will also setup  HUNTER_SERVER_USR and HUNTER_SERVER_PSW to be injected into the server url during donwload
#e.g. hunter_local_server(PROTOCOL ftp ADDRESS my.library.server FOLDER libs AUTH)
function(hunter_local_server)
  set(options AUTH)
  set(one PROTOCOL ADDRESS FOLDER)
  cmake_parse_arguments(HUNTER_SERVER "${options}" "${one}" "" ${ARGV})
  
  hunter_status_print("Hunter will serve library from  ${HUNTER_SERVER_PROTOCOL}://${HUNTER_SERVER_ADDRESS}/${HUNTER_SERVER_FOLDER} with authentication")

  if (HUNTER_SERVER_AUTH)

	#prepare parameter for server authentication if required
	hunter_authentication(HUNTER_SERVER)
	
	SET(HUNTER_SERVER_URL ${HUNTER_SERVER_PROTOCOL}://@user@:@password@@${HUNTER_SERVER_ADDRESS}/${HUNTER_SERVER_FOLDER} CACHE STRING "Library URL" FORCE)

	
	hunter_status_print("Remember to set HUNTER_SERVER_USR and HUNTER_SERVER_PSW")
  else()
 
	SET(HUNTER_SERVER_URL "${HUNTER_SERVER_PROTOCOL}://${HUNTER_SERVER_ADDRESS}/${HUNTER_SERVER_FOLDER}" CACHE STRING  "Library URL" FORCE)

  endif()  
  MARK_AS_ADVANCED(HUNTER_SERVER_URL)
 endfunction()
 
 
 #Verify that the hunter server was set
function(hunter_check_local_server)
	STRING(COMPARE EQUAL "${HUNTER_SERVER_URL}" "" local_server_not_set)
	IF(local_server_not_set)
		hunter_fatal_error("${HUNTER_SERVER_URL} You forgot to call hunter_local_server to setup the local library server provider")
	endif()
endfunction()