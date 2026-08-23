# root of the cmake project tree
# this file was generated via `make -f cmake/config.make root`
cmake_minimum_required(VERSION 3.20)
project(cmake-example VERSION 0.1.0)

SET(CMAKE_INSTALL_PREFIX /opt/derammo/cmake-example CACHE PATH /opt/derammo/REPLACE_PROJECT_NAME FORCE)
SET(CPACK_PACKAGING_PREFIX /opt/derammo/cmake-example)

# packaging defaults
set(CPACK_PACKAGE_CONTACT "email@email.spam")
set(CPACK_PACKAGE_VENDOR "vendor name")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_SOURCE_DIR}/LICENSE.txt")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "summary description")
set(CPACK_PACKAGE_DESCRIPTION "package description")
set(CPACK_STRIP_FILES ON)

# Debian packaging
set(CPACK_DEBIAN_PACKAGE_DESCRIPTION "")
set(CPACK_DEB_COMPONENT_INSTALL ON)
set(CPACK_DEB_PACKAGE_COMPONENT ON)
set(CPACK_DEBIAN_ENABLE_COMPONENT_DEPENDS ON)
set(CPACK_DEBIAN_PACKAGE_SECTION "network")

# manually added gtest support, must be before derammo_main.cmake
include("cmake/derammo_gtest.cmake")

# main logic
include("cmake/derammo_main.cmake")

# npm workspace support, must be after derammo_main.cmake
include("cmake/derammo_npm.cmake")

# maven support, must be after derammo_main.cmake; derammo_maven_build() expects
# the JDK path in JDK and a `jdk` target that provides it, here both are satisfied
# by the system default javac
include("cmake/derammo_maven.cmake")
find_package(Java REQUIRED COMPONENTS Development)
get_filename_component(DERAMMO_JAVAC "${Java_JAVAC_EXECUTABLE}" REALPATH)
get_filename_component(DERAMMO_JAVAC_BIN_DIR "${DERAMMO_JAVAC}" DIRECTORY)
get_filename_component(JDK "${DERAMMO_JAVAC_BIN_DIR}" DIRECTORY)
add_custom_target(jdk)

# new directories should be added here manually
add_subdirectory(cpp)
add_subdirectory(typescript)
add_subdirectory(java)

# override default packaging format for testing on Darwin and other systems without .deb support
set(CPACK_GENERATOR "TGZ")

# packaging support
include(CPack)
