macro( add_unity_object_library    arg1)

  file(GLOB sourceFiles
      "*.cpp"
      "*.c"
      "*.c++"
      "*.cc")
  file(GLOB headers
      "*.hpp"
      "*.h++"
      "*.h"
      "*.hh")
      
  set(          unit_build_file   ${CMAKE_CURRENT_BINARY_DIR}/all.cpp)
  
  file( WRITE ${unit_build_file} 
                                "// Auto-generated single compile unit file\n")

  foreach(source_file ${sourceFiles} )
    file( APPEND ${unit_build_file} "#include \"${source_file}\"\n")
  endforeach(source_file)
  
  # Do not build source files...
  set_source_files_properties( ${sourceFiles} PROPERTIES HEADER_FILE_ONLY true)
  set_source_files_properties( ${headers} PROPERTIES HEADER_FILE_ONLY true)
  
  # ...Build "all.cpp" instead
  add_library( ${arg1} OBJECT all.cpp 
    ${sourceFiles}  #Add source files to the IDE
    ${headers}      #Add headers to the IDE
  )
  
endmacro( add_unity_object_library)