#!/bin/sh
# Regression test for improvement #11 in cmake submodule:
# every `cmake/derammo_*.cmake` module should begin with `include_guard()`
# so that repeated inclusion (e.g. via nested submodules that also use this
# cmake framework) does not redefine functions/macros.
#
# This test enumerates every derammo_*.cmake file in the submodule and
# asserts that each one contains an `include_guard(` call.

TEST_NAME=test_include_guards
. "$(dirname "$0")/lib/harness.sh"

found_any=0
missing=""
for f in "$CMAKE_SUBMODULE"/derammo_*.cmake ; do
    [ -f "$f" ] || continue
    found_any=1
    if ! grep -q 'include_guard(' "$f" ; then
        missing="$missing $f"
    fi
done

if [ "$found_any" -eq 0 ] ; then
    fail "no derammo_*.cmake modules found under $CMAKE_SUBMODULE"
fi

if [ -n "$missing" ] ; then
    printf '  modules missing include_guard():\n' >&2
    for f in $missing ; do
        printf '    %s\n' "$f" >&2
    done
    fail "one or more derammo_*.cmake modules are missing include_guard()"
fi

printf '[PASS] %s\n' "$TEST_NAME"
