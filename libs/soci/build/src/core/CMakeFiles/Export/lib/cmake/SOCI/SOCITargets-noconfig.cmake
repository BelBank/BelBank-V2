#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "SOCI::soci_core" for configuration ""
set_property(TARGET SOCI::soci_core APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(SOCI::soci_core PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libsoci_core.so.4.0.3"
  IMPORTED_SONAME_NOCONFIG "libsoci_core.so.4.0"
  )

list(APPEND _IMPORT_CHECK_TARGETS SOCI::soci_core )
list(APPEND _IMPORT_CHECK_FILES_FOR_SOCI::soci_core "${_IMPORT_PREFIX}/lib/libsoci_core.so.4.0.3" )

# Import target "SOCI::soci_core_static" for configuration ""
set_property(TARGET SOCI::soci_core_static APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(SOCI::soci_core_static PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_NOCONFIG "CXX"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libsoci_core.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS SOCI::soci_core_static )
list(APPEND _IMPORT_CHECK_FILES_FOR_SOCI::soci_core_static "${_IMPORT_PREFIX}/lib/libsoci_core.a" )

# Import target "SOCI::soci_postgresql" for configuration ""
set_property(TARGET SOCI::soci_postgresql APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(SOCI::soci_postgresql PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libsoci_postgresql.so.4.0.3"
  IMPORTED_SONAME_NOCONFIG "libsoci_postgresql.so.4.0"
  )

list(APPEND _IMPORT_CHECK_TARGETS SOCI::soci_postgresql )
list(APPEND _IMPORT_CHECK_FILES_FOR_SOCI::soci_postgresql "${_IMPORT_PREFIX}/lib/libsoci_postgresql.so.4.0.3" )

# Import target "SOCI::soci_postgresql_static" for configuration ""
set_property(TARGET SOCI::soci_postgresql_static APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(SOCI::soci_postgresql_static PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_NOCONFIG "CXX"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libsoci_postgresql.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS SOCI::soci_postgresql_static )
list(APPEND _IMPORT_CHECK_FILES_FOR_SOCI::soci_postgresql_static "${_IMPORT_PREFIX}/lib/libsoci_postgresql.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
