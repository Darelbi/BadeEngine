#=============================================================================
# Welcome to BadeEngine3D Build system.
#=============================================================================
cmake_minimum_required( VERSION 2.8)
project( BadeEngine3D)
                
# -DCMAKE_BUILD_TYPE:STRING=Release
# Debug, MinSizeRel, RelWithDebugInfo, Release, General
#TODO customize optimizations for RELEASE BUILD ONLY
#Override so that Release build will not do all optimizations
#unless we explicitly set for a package


#-----------------------------------CONFIGURE---------------------------------
#-----------------------------------------------------------------------------
set( CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
include( OutOfSourceBuild)

set(BADE_TARGET_NAME "GCC_492_posix_dwarf2_release" CACHE STRING
    "Give the name you like most to a logical target")
set(BADE_OPENGL3_DRIVER false CACHE BOOL
    "Compile using OpenGL 3 API, only one driver must be selected. ")
set(BADE_SDL2_DEVICE false CACHE BOOL
    "Build and use SDL2 (used for some demos and tests). ")
set(BADE_SDL2_DIRECTORY ".." CACHE PATH
    "Directory in wich SDL2/CMakeLists.txt file is found")

    
#---------------------------------CURRENT TARGET------------------------------
#°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
include( AddLibraryType)

set(SHARED_BUILD true BOOL )
add_library_type( BadeEngine3D SHARED)

set(SHARED_BUILD false )
add_library_type( libBadeEngine3D STATIC)


# Build subsystems to get their objects
if(BADE_SDL2_DEVICE)
    add_subdirectory( ${BADE_SDL2_DIRECTORY} ${CMAKE_BINARY_DIR}/SDL2)
endif()

add_subdirectory( badeSource)
add_subdirectory( badeSource/Mesh)
add_subdirectory( badeSource/Math)

  if(BADE_OPENGL3_DRIVER)
    add_subdirectory( badeSource/Mesh/gl3)
  endif()

# Having public headers and source in different folders is time wasting so we
# extract headers from source when releasing. 
file(GLOB MY_PUBLIC_HEADERS "badeSource/Bade*.hpp")
file(COPY ${MY_PUBLIC_HEADERS} DESTINATION "../../bade")
file(GLOB MY_PUBLIC_HEADERS "badeSource/Mesh/Bade*.hpp")
file(COPY ${MY_PUBLIC_HEADERS} DESTINATION "../../bade/Mesh")
file(GLOB MY_PUBLIC_HEADERS "badeSource/Math/Bade*.hpp")
file(COPY ${MY_PUBLIC_HEADERS} DESTINATION "../../bade/Math")

  if(BADE_OPENGL3_DRIVER) #this is the only real external dependency 
    find_package (OpenGL)
    target_link_libraries( BadeEngine3D ${OPENGL_gl_LIBRARY})
  endif()

  
#---------------------------------UTILITY STUFF-------------------------------
#°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°

#copy binaries to "bin" folder and to binary folder where tests are runned
add_custom_command(TARGET libBadeEngine3D POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:libBadeEngine3D> 
    "../../bin/${BADE_TARGET_NAME}/$<TARGET_FILE_NAME:libBadeEngine3D>"
)
add_custom_command(TARGET libBadeEngine3D POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:libBadeEngine3D> 
    "../../build/${BADE_TARGET_NAME}/tests/$<TARGET_FILE_NAME:libBadeEngine3D>"
)
add_custom_command(TARGET libBadeEngine3D POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:libBadeEngine3D> 
    "../../build/${BADE_TARGET_NAME}/tests/Mesh/$<TARGET_FILE_NAME:libBadeEngine3D>"
)
add_custom_command(TARGET libBadeEngine3D POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:libBadeEngine3D> 
    "../../build/${BADE_TARGET_NAME}/tests/gl3/$<TARGET_FILE_NAME:libBadeEngine3D>"
)


enable_testing()
#add_custom_target(build_and_test ${CMAKE_CTEST_COMMAND} )
add_subdirectory( tests)
add_subdirectory( tests/Mesh)

if(BADE_SDL2_DEVICE)
  if(BADE_OPENGL3_DRIVER)
  
    add_subdirectory( tests/gl3) #gl3 tests require both gl3 and SDL2
    
  endif()
endif()