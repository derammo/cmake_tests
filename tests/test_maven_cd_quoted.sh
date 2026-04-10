#!/bin/sh
# Regression test for bug #10 in cmake submodule:
# cmake/derammo_maven.cmake:20 has a raw `cd ${CMAKE_BINARY_DIR}/...`
# inside an add_custom_target COMMAND. The CMake-expanded path is not
# quoted, so if CMAKE_BINARY_DIR (or any component) contains a space —
# e.g. a build directory under a user path like `/Users/Firstname Lastname/` —
# the generated shell command breaks at `cd`.
#
# Rule enforced by this test: derammo_maven.cmake must not contain an
# unquoted `cd ${...}`. The correct form is `cd "${...}"`, or — per the
# suggested fix — moving the shell soup into a small helper script file.
# Both of those leave no literal `cd ${` substring in the file.

TEST_NAME=test_maven_cd_quoted
. "$(dirname "$0")/lib/harness.sh"

assert_file_not_contains "$CMAKE_SUBMODULE/derammo_maven.cmake" 'cd ${'

printf '[PASS] %s\n' "$TEST_NAME"
