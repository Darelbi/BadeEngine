macro( add_library_type   name  type )

  add_library( ${name} ${type}  Empty.cpp #DO NOT REMOVE
                                $<TARGET_OBJECTS:badeObj>
                                $<TARGET_OBJECTS:badeMeshObj>
                                $<TARGET_OBJECTS:badeMathObj>
                                $<TARGET_OBJECTS:badeMeshImplObj>)
  set_target_properties( ${name}  PROPERTIES
                                  PREFIX ""   )

    if(SHARED_BUILD)
    
        target_compile_definitions( ${name}
                                PRIVATE   BADE_BUILD_LIBRARY
                                PRIVATE   BADE_BUILD_DLL
                                INTERFACE BADE_USE_DLL
                                )
    else()

        target_compile_definitions( ${name}
                                PRIVATE   BADE_BUILD_LIBRARY
                                )
        set_target_properties( ${name}  PROPERTIES
                                        PREFIX "static_"   )
    endif()
    
    #list( REMOVE_ITEM COMPILE_DEFINITIONS_RELEASE NDEBUG)
    
endmacro( add_library_type)