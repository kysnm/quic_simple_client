cmake_minimum_required (VERSION 2.8.10)

project (libquic_sinple_client)

if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  message(STATUS "Setting build type to 'Debug' as none was specified.")
  set(CMAKE_BUILD_TYPE Debug CACHE STRING "Choose the type of build." FORCE)
  # Set the possible values of build type for cmake-gui
  #set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release"
  #  "MinSizeRel" "RelWithDebInfo")
endif()

set(COMMON_C_FLAGS "${COMMON_C_FLAGS} -Wall -fpic")

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${COMMON_C_FLAGS}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${COMMON_C_FLAGS} -std=gnu++11")
set(CMAKE_C_FLAGS_RELEASE "-DNDEBUG")
set(CMAKE_CXX_FLAGS_RELEASE "-DNDEBUG")
set(CMAKE_C_FLAGS_DEBUG "-g")
set(CMAKE_CXX_FLAGS_DEBUG "-g")

if (${CMAKE_SYSTEM_PROCESSOR} STREQUAL "x86_64")
  set(ARCH "amd64")
elseif (${CMAKE_SYSTEM_PROCESSOR} STREQUAL "amd64")
  set(ARCH "amd64")
#elseif (${CMAKE_SYSTEM_PROCESSOR} STREQUAL "AMD64")
#  # cmake reports AMD64 on Windows, but we might be building for 32-bit.
#  if (CMAKE_CL_64)
#    set(ARCH "amd64")
#  else()
#    set(ARCH "386")
#  endif()
elseif (${CMAKE_SYSTEM_PROCESSOR} STREQUAL "x86")
  set(ARCH "386")
elseif (${CMAKE_SYSTEM_PROCESSOR} STREQUAL "i386")
  set(ARCH "386")
elseif (${CMAKE_SYSTEM_PROCESSOR} STREQUAL "i686")
  set(ARCH "386")
elseif (${CMAKE_SYSTEM_PROCESSOR} MATCHES "^arm.*")
  set(ARCH "arm")
elseif (${CMAKE_SYSTEM_PROCESSOR} STREQUAL "aarch64")
  set(ARCH "aarch64")
else()
  message(FATAL_ERROR "Unknown processor:" ${CMAKE_SYSTEM_PROCESSOR})
endif()

if (${ARCH} STREQUAL "386" AND APPLE)
  # With CMake 2.8.x, ${CMAKE_SYSTEM_PROCESSOR} evalutes to i386 on OS X,
  # but clang defaults to 64-bit builds on OS X unless otherwise told.
  # Set ARCH to x86_64 so clang and CMake agree. This is fixed in CMake 3.
  set(ARCH "amd64")
endif()

include_directories(../../../libquic/src)
include_directories(../../../../quic_simple_client)

add_library(
  quic_simple_client
  STATIC

  quic_simple_client.cc
)

find_library(QUIC_LIBRATY NAMES libquic.a PATHS ../../../libquic/build)
target_link_libraries(quic_simple_client ${QUIC_LIBRATY})
