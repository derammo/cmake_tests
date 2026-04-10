# cmake_tests

Regression tests for the [derammo/cmake](https://github.com/derammo/cmake) submodule. Lives outside the `cmake` submodule and outside `cmake-example` so that:

- consumers of the `cmake` submodule don't get test files in their tree
- the test harness is independent of any particular example project
- the submodule pin can be bumped here independently to test changes

## Requirements

Only POSIX tools: `sh`, `make`, `sed`, `find`, `grep`. No C/C++ compiler needed — these tests only exercise the text-generation parts of `cmake/setup.make`.

## Running

After cloning:

```sh
git submodule update --init
make test
```

Each `tests/test_*.sh` file is a standalone script and can be run directly:

```sh
sh tests/test_root_sed_g_flag.sh
```

## What is tested

Each test creates an isolated sandbox under `$TMPDIR`, symlinks the `cmake` submodule into it, runs `make -f .../cmake/setup.make <target>`, and asserts on the generated files.

| Test | Target in `setup.make` | Bug it covers |
| --- | --- | --- |
| `test_root_sed_g_flag.sh` | `root` | `sed` without `/g` at setup.make:58 |
| `test_library_local_sources.sh` | `library` | `>` vs `>>` in root-source loop at setup.make:23-25 |
| `test_executable_local_sources.sh` | `executable` | `>` vs `>>` in root-source loop at setup.make:46-48 |
| `test_executable_private_sources.sh` | `executable` | `>` vs `>>` in src/ loop at setup.make:49-51 |

## Updating the pin

When a fix to the `cmake` submodule should be tested:

```sh
cd cmake
git fetch
git checkout <fixed commit>
cd ..
git add cmake
git commit -m "bump cmake to <sha>"
make test
```
