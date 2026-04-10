#!/bin/sh
# Regression test for bug #4 in cmake submodule (executable target, private sources loop):
# setup.make:49-51 runs a shell `for` loop over files under src/ and
# writes each match with `> sources.cmake` (truncate) instead of `>>`.
# When more than one src/ file matches, all but the last get clobbered.

TEST_NAME=test_executable_private_sources
. "$(dirname "$0")/lib/harness.sh"

mk_sandbox
mkdir -p foo_project/mytool/include foo_project/mytool/src
ln -s "$CMAKE_SUBMODULE" foo_project/cmake
touch foo_project/CMakeLists.txt

cd foo_project/mytool

# deliberately no root-level sources, so the buggy local loop at lines 46-48
# does NOT run; we want to isolate the bug at lines 49-51 (the src/ loop).
: > src/alpha.cpp
: > src/beta.cpp

make -f ../cmake/setup.make executable >/dev/null 2>&1 || fail "make -f ../cmake/setup.make executable exited non-zero"

assert_file_contains sources.cmake 'src/alpha.cpp'
assert_file_contains sources.cmake 'src/beta.cpp'

printf '[PASS] %s\n' "$TEST_NAME"
