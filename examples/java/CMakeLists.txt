# an example of a maven project: pom.xml is generated from pom.xml.in so the
# build output lands in the cmake binary directory
# requires `include("cmake/derammo_maven.cmake")` at the root
derammo_configure_pom()
derammo_maven_build()
