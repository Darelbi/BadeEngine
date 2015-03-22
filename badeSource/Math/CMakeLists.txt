#=============================================================================
# Welcome to BadeEngine3D Build system. ./badeSource/Math
#=============================================================================
cmake_minimum_required( VERSION 2.8)
project( badeMath)


#-----------------------------------CONFIGURE---------------------------------
#-----------------------------------------------------------------------------
include( EnableCpp11)
include( EnableCommonWarnings)
include( SuperStrictWarnings)
include( AddUnityObjectLibrary)

add_unity_object_library( badeMathObj)