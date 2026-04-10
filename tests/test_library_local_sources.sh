#!/bin/sh
# Regression test for bug #4 in cmake submodule (library target, local sources loop):
# setup.make:23-25 runs a shell `for` loop over root-level source globs
# and writes each match with `> sources.cmake` (truncate) instead of `>>`.
# When more than one root-level source file matches the glob, all but the
# last get clobbered.
#
# This test creates two root-level sources under a library directory and
# asserts that both appear in the generated sources.cmake.

TEST_NAME=test_library_local_sources
. "$(dirname "$0")/lib/harness.sh"

mk_sandbox
mkdir -p foo_project/mylib/include foo_project/mylib/src
ln -s "$CMAKE_SUBMODULE" foo_project/cmake
# `library` target has ../CMakeLists.txt as a prerequisite
touch foo_project/CMakeLists.txt

cd foo_project/mylib

# two root-level source files that both match the `*.cpp` glob
: > alpha.cpp
: > beta.cpp

# add an include and src file so the subsequent loops also have input
# (these should already use >> correctly, but we include them to make the
# test exercise the whole recipe rather than just the buggy loop)
: > include/mylib.h
: > src/mylib.cpp

# run the bootstrap
make -f ../cmake/setup.make library >/dev/null 2>&1 || fail "make -f ../cmake/setup.make library exited non-zero"

# both root-level sources must appear in sources.cmake
assert_file_contains sources.cmake 'alpha.cpp'
assert_file_contains sources.cmake 'beta.cpp'

printf '[PASS] %s\n' "$TEST_NAME"
