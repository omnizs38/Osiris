cmake_minimum_required(VERSION 3.24)
project(Osiris LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

if(WIN32)
  enable_language(ASM_MASM)
elseif(UNIX)
  enable_language(ASM-ATT)
endif()

set(ENABLE_TESTS "" CACHE STRING "Semicolon-separated test types to enable: unit and/or functional")
set_property(CACHE ENABLE_TESTS PROPERTY STRINGS "" unit functional "unit;functional")

set(SUPPORTED_TEST_TYPES unit functional)
foreach(TEST_TYPE IN LISTS ENABLE_TESTS)
  if(NOT TEST_TYPE IN_LIST SUPPORTED_TEST_TYPES)
    message(FATAL_ERROR
      "Unsupported test type '${TEST_TYPE}' in ENABLE_TESTS. "
      "Supported values are: unit;functional")
  endif()
endforeach()
unset(SUPPORTED_TEST_TYPES)

add_subdirectory(Source)

if(ENABLE_TESTS)
  enable_testing()
  add_subdirectory(Tests)
endif()
