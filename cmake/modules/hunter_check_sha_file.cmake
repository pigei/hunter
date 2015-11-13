# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

cmake_minimum_required(VERSION 3.0)

include(hunter_internal_error)
include(hunter_lock_directory)
include(hunter_test_string_not_empty)

function(hunter_check_sha_file parent sha1 result)
  hunter_test_string_not_empty("${parent}")
  hunter_test_string_not_empty("${sha1}")
  hunter_test_string_not_empty("${result}")

  string(SUBSTRING "${sha1}" 0 7 dir_id)

  set(dir_path "${parent}/${dir_id}")
  set(sha1_path "${dir_path}/SHA1")

  if(EXISTS "${sha1_path}")
    file(READ "${sha1_path}" sha1_value)
    string(COMPARE EQUAL "${sha1_value}" "${sha1}" is_equal)
    set("${result}" ${is_equal} PARENT_SCOPE)
	MESSAGE("${is_equal} sha")
  else()
    set("${result}" false PARENT_SCOPE)
  endif()

endfunction()
