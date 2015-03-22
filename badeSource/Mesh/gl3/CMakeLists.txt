#=============================================================================
# Welcome to BadeEngine3D Build system. ./badeSource/Mesh
#=============================================================================
cmake_minimum_required( VERSION 2.8)
project( badeMeshImpl)


#-----------------------------------CONFIGURE---------------------------------
#-----------------------------------------------------------------------------
include( EnableCpp11)
include( EnableCommonWarnings)
include( StrictWarnings)
include( AddUnityObjectLibrary)

add_unity_object_library( badeMeshImplObj)
