#=============================================================================
# Welcome to BadeEngine3D Build system. ./tests
#=============================================================================
cmake_minimum_required( VERSION 2.8)
project( badeTests)

#-----------------------------------CONFIGURE---------------------------------
#-----------------------------------------------------------------------------
include( EnableCpp11)
include( TestWarnings)
include( GenerateTestDriver)

include_directories("../badeSource")

generate_test_driver( basicTests)

#allow to find libBadeEngine3D.a or equivalent
set( ENV{PATH} "$ENV{PATH};${CMAKE_SOURCE_DIR}/bin/${TARGET_NAME}" )
target_link_libraries( basicTests libBadeEngine3D)