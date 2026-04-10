#!/bin/sh
# Regression test for bug #2 in cmake submodule:
# cmake/derammo_main.cmake:1 calls `cmake_minimum_required(VERSION 3.13.0)`.
# `cmake_minimum_required` should only appear in the root CMakeLists.txt.
# Calling it mid-configure from an included module can silently reset CMake
# policy settings — any policy introduced after the version argument gets
# unset, so a root project that targets a newer minimum version loses the
# policy state it expected.
#
# This is a static check: assert that derammo_main.cmake does not contain a
# `cmake_minimum_required` call. Other included modules should be clean too.

TEST_NAME=test_derammo_main_no_cmake_minimum_required
. "$(dirname "$0")/lib/harness.sh"

assert_file_not_contains "$CMAKE_SUBMODULE/derammo_main.cmake" 'cmake_minimum_required'

printf '[PASS] %s\n' "$TEST_NAME"
