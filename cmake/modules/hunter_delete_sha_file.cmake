# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

cmake_minimum_required(VERSION 3.0)

include(hunter_internal_error)
include(hunter_lock_directory)
include(hunter_test_string_not_empty)

function(hunter_delete_sha_file parent sha1)
  hunter_test_string_not_empty("${parent}")
  hunter_test_string_not_empty("${sha1}")

  string(SUBSTRING "${sha1}" 0 7 dir_id)

  set(dir_path "${parent}/${dir_id}")
  set(sha1_path "${dir_path}/SHA1")

  if(EXISTS "${sha1_path}")

	FILE(REMOVE  ${dir_path}/SHA1 )
	FILE(REMOVE  ${dir_path}/DONE )
	FILE(REMOVE  ${dir_path}/cmake.lock )
    FILE(REMOVE_RECURSE  ${dir_path} )
  endif()

endfunction()
