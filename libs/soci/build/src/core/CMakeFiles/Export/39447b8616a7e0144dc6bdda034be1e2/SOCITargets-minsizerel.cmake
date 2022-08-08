#----------------------------------------------------------------
# Generated CMake target import file for configuration "MinSizeRel".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "SOCI::soci_core" for configuration "MinSizeRel"
set_property(TARGET SOCI::soci_core APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(SOCI::soci_core PROPERTIES
  IMPORTED_IMPLIB_MINSIZEREL "${_IMPORT_PREFIX}/lib/soci_core_4_0.lib"
  IMPORTED_LOCATION_MINSIZEREL "${_IMPORT_PREFIX}/bin/soci_core_4_0.dll"
  )

list(APPEND _cmake_import_check_targets SOCI::soci_core )
list(APPEND _cmake_import_check_files_for_SOCI::soci_core "${_IMPORT_PREFIX}/lib/soci_core_4_0.lib" "${_IMPORT_PREFIX}/bin/soci_core_4_0.dll" )

# Import target "SOCI::soci_core_static" for configuration "MinSizeRel"
set_property(TARGET SOCI::soci_core_static APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(SOCI::soci_core_static PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_MINSIZEREL "CXX"
  IMPORTED_LOCATION_MINSIZEREL "${_IMPORT_PREFIX}/lib/libsoci_core_4_0.lib"
  )

list(APPEND _cmake_import_check_targets SOCI::soci_core_static )
list(APPEND _cmake_import_check_files_for_SOCI::soci_core_static "${_IMPORT_PREFIX}/lib/libsoci_core_4_0.lib" )

# Import target "SOCI::soci_postgresql" for configuration "MinSizeRel"
set_property(TARGET SOCI::soci_postgresql APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(SOCI::soci_postgresql PROPERTIES
  IMPORTED_IMPLIB_MINSIZEREL "${_IMPORT_PREFIX}/lib/soci_postgresql_4_0.lib"
  IMPORTED_LOCATION_MINSIZEREL "${_IMPORT_PREFIX}/bin/soci_postgresql_4_0.dll"
  )

list(APPEND _cmake_import_check_targets SOCI::soci_postgresql )
list(APPEND _cmake_import_check_files_for_SOCI::soci_postgresql "${_IMPORT_PREFIX}/lib/soci_postgresql_4_0.lib" "${_IMPORT_PREFIX}/bin/soci_postgresql_4_0.dll" )

# Import target "SOCI::soci_postgresql_static" for configuration "MinSizeRel"
set_property(TARGET SOCI::soci_postgresql_static APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(SOCI::soci_postgresql_static PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_MINSIZEREL "CXX"
  IMPORTED_LOCATION_MINSIZEREL "${_IMPORT_PREFIX}/lib/libsoci_postgresql_4_0.lib"
  )

list(APPEND _cmake_import_check_targets SOCI::soci_postgresql_static )
list(APPEND _cmake_import_check_files_for_SOCI::soci_postgresql_static "${_IMPORT_PREFIX}/lib/libsoci_postgresql_4_0.lib" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
