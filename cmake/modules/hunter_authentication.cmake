# Copyright (c) 2015, Pierluigi Taddei
# All rights reserved.

#request authentication detail to access a given server. User and password are stored in the output variables
#${serverPrefix}_USR and ${serverPrefix}_PSW
#${serverPrefix}_AUTH is true if the details are provided
function(hunter_authentication serverPrefix)
  MESSAGE(STATUS "Good day. This is hunter_authentication.cmake %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
  #if not set check in the environemt?
  #
  #

  set(${serverPrefix}_USR "" CACHE STRING "${serverPrefix} user")
  set(${serverPrefix}_PSW "" CACHE STRING "${serverPrefix} password")

  
  #if not set shall we complain?
  #
  #
  #
  
  string(COMPARE EQUAL "${${serverPrefix}_USR}" "" hunter_no_auth)
  MESSAGE(STATUS "${serverPrefix}_USR = ${${serverPrefix}_USR} :${hunter_no_auth}" )
  if (hunter_no_auth)
	MESSAGE(FATAL_ERROR "No authentication set for ${serverPrefix}. Either set it in cmake cache or set it as environment variables")

 endif()
  
  set(${serverPrefix}_AUTH ${hunter_no_auth} PARENT_SCOPE)
  
endfunction()
