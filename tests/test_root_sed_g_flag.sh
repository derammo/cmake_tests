#!/bin/sh
# Regression test for bug #3 in cmake submodule:
# setup.make:58 invokes `sed` without the /g flag, so lines in
# CMakeLists.init that contain more than one REPLACE_PROJECT_NAME
# token have only their first occurrence substituted.
#
# Line 4 of CMakeLists.init has 2 occurrences on one line, so this
# test expects zero unreplaced REPLACE_PROJECT_NAME tokens in the
# generated CMakeLists.txt after running `make -f cmake/setup.make root`.

TEST_NAME=test_root_sed_g_flag
. "$(dirname "$0")/lib/harness.sh"

mk_sandbox
mkdir foo_project
cd foo_project
ln -s "$CMAKE_SUBMODULE" cmake

# run the bootstrap
make -f cmake/setup.make root >/dev/null 2>&1 || fail "make -f cmake/setup.make root exited non-zero"

# the template has 4 total REPLACE_PROJECT_NAME tokens (lines 2, 4, 4, 5).
# after a correct /g substitution, zero should remain.
assert_line_count CMakeLists.txt 'REPLACE_PROJECT_NAME' 0

printf '[PASS] %s\n' "$TEST_NAME"
