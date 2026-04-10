# shellcheck shell=sh
# shared test harness for cmake_tests
# sourced by each tests/test_*.sh script
#
# provides:
#   mk_sandbox            - create a temp sandbox, cd into it, set up cleanup trap
#   assert_file_contains <file> <pattern>
#   assert_file_not_contains <file> <pattern>
#   assert_line_count <file> <pattern> <expected>
#   fail <msg>            - print failure and exit 1
#
# conventions:
#   - CMAKE_TESTS_ROOT is the absolute path to the cmake_tests repo root
#   - CMAKE_SUBMODULE is the absolute path to the cmake submodule inside this repo
#   - tests should set TEST_NAME before sourcing this file (used in messages)

set -eu

# locate the repo root (parent of tests/) regardless of where test is invoked from
_harness_dir=$(cd "$(dirname "$0")" && pwd)
CMAKE_TESTS_ROOT=$(cd "$_harness_dir/.." && pwd)
CMAKE_SUBMODULE="$CMAKE_TESTS_ROOT/cmake"

: "${TEST_NAME:=$(basename "$0" .sh)}"

if [ ! -f "$CMAKE_SUBMODULE/setup.make" ]; then
    printf '%s: cmake submodule not initialized at %s\n' "$TEST_NAME" "$CMAKE_SUBMODULE" >&2
    printf '  run: git submodule update --init\n' >&2
    exit 2
fi

fail() {
    printf '[FAIL] %s: %s\n' "$TEST_NAME" "$1" >&2
    exit 1
}

mk_sandbox() {
    SANDBOX=$(mktemp -d "${TMPDIR:-/tmp}/cmake_tests.XXXXXX")
    # shellcheck disable=SC2064
    trap "rm -rf '$SANDBOX'" EXIT INT TERM
    cd "$SANDBOX"
}

assert_file_contains() {
    _file=$1
    _pattern=$2
    if [ ! -f "$_file" ]; then
        fail "expected file '$_file' does not exist"
    fi
    if ! grep -q -- "$_pattern" "$_file"; then
        printf '  file contents:\n' >&2
        sed 's/^/    /' "$_file" >&2
        fail "file '$_file' does not contain pattern '$_pattern'"
    fi
}

assert_file_not_contains() {
    _file=$1
    _pattern=$2
    if [ ! -f "$_file" ]; then
        fail "expected file '$_file' does not exist"
    fi
    if grep -q -- "$_pattern" "$_file"; then
        printf '  file contents:\n' >&2
        sed 's/^/    /' "$_file" >&2
        fail "file '$_file' unexpectedly contains pattern '$_pattern'"
    fi
}

assert_line_count() {
    _file=$1
    _pattern=$2
    _expected=$3
    if [ ! -f "$_file" ]; then
        fail "expected file '$_file' does not exist"
    fi
    _actual=$(grep -c -- "$_pattern" "$_file" || true)
    if [ "$_actual" != "$_expected" ]; then
        printf '  file contents:\n' >&2
        sed 's/^/    /' "$_file" >&2
        fail "file '$_file' has $_actual lines matching '$_pattern', expected $_expected"
    fi
}
