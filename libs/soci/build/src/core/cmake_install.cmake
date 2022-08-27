# Install script for directory: /home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/src/core

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
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

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/soci" TYPE FILE FILES
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/backend-loader.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/bind-values.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/blob-exchange.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/blob.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/boost-fusion.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/boost-gregorian-date.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/boost-optional.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/boost-tuple.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/callbacks.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/column-info.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/connection-parameters.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/connection-pool.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/error.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/exchange-traits.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/into-type.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/into.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/logger.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/noreturn.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/once-temp-type.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/prepare-temp-type.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/procedure.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/query_transformation.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/ref-counted-prepare-info.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/ref-counted-statement.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/row-exchange.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/row.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/rowid-exchange.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/rowid.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/rowset.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/session.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/soci-backend.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/soci-platform.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/soci-simple.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/soci.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/statement.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/transaction.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/type-conversion-traits.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/type-conversion.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/type-holder.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/type-ptr.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/type-wrappers.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/unsigned-types.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/use-type.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/use.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/values-exchange.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/values.h"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/include/soci/version.h"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libsoci_core.so.4.0.3"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libsoci_core.so.4.0"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      file(RPATH_CHECK
           FILE "${file}"
           RPATH "")
    endif()
  endforeach()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/build/lib/libsoci_core.so.4.0.3"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/build/lib/libsoci_core.so.4.0"
    )
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libsoci_core.so.4.0.3"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libsoci_core.so.4.0"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      if(CMAKE_INSTALL_DO_STRIP)
        execute_process(COMMAND "/usr/bin/strip" "${file}")
      endif()
    endif()
  endforeach()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libsoci_core.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libsoci_core.so")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libsoci_core.so"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/build/lib/libsoci_core.so")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libsoci_core.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libsoci_core.so")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libsoci_core.so")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/build/lib/libsoci_core.a")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/SOCI/SOCITargets.cmake")
    file(DIFFERENT EXPORT_FILE_CHANGED FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/SOCI/SOCITargets.cmake"
         "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/build/src/core/CMakeFiles/Export/lib/cmake/SOCI/SOCITargets.cmake")
    if(EXPORT_FILE_CHANGED)
      file(GLOB OLD_CONFIG_FILES "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/SOCI/SOCITargets-*.cmake")
      if(OLD_CONFIG_FILES)
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/SOCI/SOCITargets.cmake\" will be replaced.  Removing files [${OLD_CONFIG_FILES}].")
        file(REMOVE ${OLD_CONFIG_FILES})
      endif()
    endif()
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/SOCI" TYPE FILE FILES "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/build/src/core/CMakeFiles/Export/lib/cmake/SOCI/SOCITargets.cmake")
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^()$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/SOCI" TYPE FILE FILES "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/build/src/core/CMakeFiles/Export/lib/cmake/SOCI/SOCITargets-noconfig.cmake")
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/SOCI" TYPE FILE FILES
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/build/src/core/SOCIConfig.cmake"
    "/home/alexander/programming/qt/bsuir/BelBank-V2/libs/soci/build/src/core/SOCIConfigVersion.cmake"
    )
endif()

