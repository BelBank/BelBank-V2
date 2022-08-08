# Install script for directory: F:/Documents/BSUIR/BelBank-V2/libs/soci/src/core

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "C:/Program Files (x86)/SOCI")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/soci" TYPE FILE FILES
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/backend-loader.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/bind-values.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/blob-exchange.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/blob.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/boost-fusion.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/boost-gregorian-date.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/boost-optional.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/boost-tuple.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/callbacks.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/column-info.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/connection-parameters.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/connection-pool.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/error.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/exchange-traits.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/into-type.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/into.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/logger.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/noreturn.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/once-temp-type.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/prepare-temp-type.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/procedure.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/query_transformation.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/ref-counted-prepare-info.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/ref-counted-statement.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/row-exchange.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/row.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/rowid-exchange.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/rowid.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/rowset.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/session.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/soci-backend.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/soci-platform.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/soci-simple.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/soci.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/statement.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/transaction.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/type-conversion-traits.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/type-conversion.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/type-holder.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/type-ptr.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/type-wrappers.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/unsigned-types.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/use-type.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/use.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/values-exchange.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/values.h"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/include/soci/version.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "F:/Documents/BSUIR/BelBank-V2/libs/soci/build/lib/Debug/soci_core_4_0.lib")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "F:/Documents/BSUIR/BelBank-V2/libs/soci/build/lib/Release/soci_core_4_0.lib")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "F:/Documents/BSUIR/BelBank-V2/libs/soci/build/lib/MinSizeRel/soci_core_4_0.lib")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "F:/Documents/BSUIR/BelBank-V2/libs/soci/build/lib/RelWithDebInfo/soci_core_4_0.lib")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE SHARED_LIBRARY FILES "F:/Documents/BSUIR/BelBank-V2/libs/soci/build/bin/Debug/soci_core_4_0.dll")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE SHARED_LIBRARY FILES "F:/Documents/BSUIR/BelBank-V2/libs/soci/build/bin/Release/soci_core_4_0.dll")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE SHARED_LIBRARY FILES "F:/Documents/BSUIR/BelBank-V2/libs/soci/build/bin/MinSizeRel/soci_core_4_0.dll")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE SHARED_LIBRARY FILES "F:/Documents/BSUIR/BelBank-V2/libs/soci/build/bin/RelWithDebInfo/soci_core_4_0.dll")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "F:/Documents/BSUIR/BelBank-V2/libs/soci/build/lib/Debug/libsoci_core_4_0.lib")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "F:/Documents/BSUIR/BelBank-V2/libs/soci/build/lib/Release/libsoci_core_4_0.lib")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "F:/Documents/BSUIR/BelBank-V2/libs/soci/build/lib/MinSizeRel/libsoci_core_4_0.lib")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "F:/Documents/BSUIR/BelBank-V2/libs/soci/build/lib/RelWithDebInfo/libsoci_core_4_0.lib")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/SOCI/SOCITargets.cmake")
    file(DIFFERENT _cmake_export_file_changed FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/SOCI/SOCITargets.cmake"
         "F:/Documents/BSUIR/BelBank-V2/libs/soci/build/src/core/CMakeFiles/Export/39447b8616a7e0144dc6bdda034be1e2/SOCITargets.cmake")
    if(_cmake_export_file_changed)
      file(GLOB _cmake_old_config_files "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/SOCI/SOCITargets-*.cmake")
      if(_cmake_old_config_files)
        string(REPLACE ";" ", " _cmake_old_config_files_text "${_cmake_old_config_files}")
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/SOCI/SOCITargets.cmake\" will be replaced.  Removing files [${_cmake_old_config_files_text}].")
        unset(_cmake_old_config_files_text)
        file(REMOVE ${_cmake_old_config_files})
      endif()
      unset(_cmake_old_config_files)
    endif()
    unset(_cmake_export_file_changed)
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/SOCI" TYPE FILE FILES "F:/Documents/BSUIR/BelBank-V2/libs/soci/build/src/core/CMakeFiles/Export/39447b8616a7e0144dc6bdda034be1e2/SOCITargets.cmake")
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/SOCI" TYPE FILE FILES "F:/Documents/BSUIR/BelBank-V2/libs/soci/build/src/core/CMakeFiles/Export/39447b8616a7e0144dc6bdda034be1e2/SOCITargets-debug.cmake")
  endif()
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/SOCI" TYPE FILE FILES "F:/Documents/BSUIR/BelBank-V2/libs/soci/build/src/core/CMakeFiles/Export/39447b8616a7e0144dc6bdda034be1e2/SOCITargets-minsizerel.cmake")
  endif()
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/SOCI" TYPE FILE FILES "F:/Documents/BSUIR/BelBank-V2/libs/soci/build/src/core/CMakeFiles/Export/39447b8616a7e0144dc6bdda034be1e2/SOCITargets-relwithdebinfo.cmake")
  endif()
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/SOCI" TYPE FILE FILES "F:/Documents/BSUIR/BelBank-V2/libs/soci/build/src/core/CMakeFiles/Export/39447b8616a7e0144dc6bdda034be1e2/SOCITargets-release.cmake")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/SOCI" TYPE FILE FILES
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/build/src/core/SOCIConfig.cmake"
    "F:/Documents/BSUIR/BelBank-V2/libs/soci/build/src/core/SOCIConfigVersion.cmake"
    )
endif()

