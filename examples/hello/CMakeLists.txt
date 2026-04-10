# an example of an executable with a fixed set of source files, 
# this section was generated via `make -f ../cmake/config.make executable`
add_executable(hello)
target_include_directories(hello PRIVATE include)
include(sources.cmake)
