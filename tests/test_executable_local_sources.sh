#!/bin/sh
# Regression test for bug #4 in cmake submodule (executable target, local sources loop):
# setup.make:46-48 runs a shell `for` loop over root-level source globs
# and writes each match with `> sources.cmake` (truncate) instead of `>>`.
# Same bug as the library target's local loop, but in the executable target.

TEST_NAME=test_executable_local_sources
. "$(dirname "$0")/lib/harness.sh"

mk_sandbox
mkdir -p foo_project/mytool/include foo_project/mytool/src
ln -s "$CMAKE_SUBMODULE" foo_project/cmake
touch foo_project/CMakeLists.txt

cd foo_project/mytool

: > alpha.cpp
: > beta.cpp

make -f ../cmake/setup.make executable >/dev/null 2>&1 || fail "make -f ../cmake/setup.make executable exited non-zero"

assert_file_contains sources.cmake 'alpha.cpp'
assert_file_contains sources.cmake 'beta.cpp'

printf '[PASS] %s\n' "$TEST_NAME"
