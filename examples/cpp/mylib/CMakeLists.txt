# an example of a library with a fixed set of source files, 
# this section was generated via `make -f ../cmake/config.make library`
add_library(mylib SHARED)
target_include_directories(mylib PUBLIC include)
target_include_directories(mylib PRIVATE src)
include(sources.cmake)

# manually added gtest support, using all source files in gtest/*
# requires `include("cmake/derammo_gtest.cmake")` at the root
derammo_add_gtest_auto(mylib SHARED)
