#=============================================================================
# Welcome to BadeEngine3D Build system. ./tests
#=============================================================================
cmake_minimum_required( VERSION 2.8)
project( badeGL3Tests)

#-----------------------------------CONFIGURE---------------------------------
#-----------------------------------------------------------------------------
include( EnableCpp11)
include( TestWarnings)
include( GenerateTestDriver)

include_directories("../../badeSource")
include_directories("../../../SDL2-2.0.3/include")
generate_test_driver( GL3Tests)

#allow to find libBadeEngine3D.a or equivalent
set( ENV{PATH} "$ENV{PATH};${CMAKE_SOURCE_DIR}/bin/${TARGET_NAME}" )
target_link_libraries( GL3Tests libBadeEngine3D)
target_link_libraries( GL3Tests SDL2)
find_package (OpenGL)
target_link_libraries( GL3Tests ${OPENGL_gl_LIBRARY})