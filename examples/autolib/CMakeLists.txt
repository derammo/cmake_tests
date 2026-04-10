# an example of a library that automatically includes all source files in its directory
# this section was manually written
derammo_add_library_auto(autolib SHARED)

# manually added gtest support, using all source files in gtest/*
# requires `include("cmake/derammo_gtest.cmake")` at the root
derammo_add_gtest_auto(autolib SHARED)