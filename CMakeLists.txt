cmake_minimum_required(VERSION 3.21)
cmake_policy(SET CMP0074 NEW)
cmake_policy(SET CMP0083 NEW)
cmake_policy(SET CMP0104 NEW)
if(POLICY CMP0135)
  cmake_policy(SET CMP0135 NEW)
endif()
cmake_policy(SET CMP0054 NEW)
cmake_policy(SET CMP0048 NEW)

# Project name and settings
project(
  ttb
  VERSION 0.0.0
  LANGUAGES Fortran)
set(project_name ttb)
enable_language(Fortran)
enable_testing()
include(ExternalProject)
# Set the source directory path
set(SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src")

set(test-drive_version 0.5.0)
ExternalProject_Add(
  test-drive
  URL https://github.com/fortran-lang/test-drive/archive/refs/tags/v${test-drive_version}.tar.gz
  PREFIX ${PROJECT_SOURCE_DIR}/external/test-drive
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${PROJECT_SOURCE_DIR}/lib/test-drive)
add_compile_options(-pedantic -Wampersand -Wsurprising -std=f2018)
add_compile_options(
  -g
  -fbacktrace
  -Wall
  -Wextra
  -Wunderflow
  -Wconversion
  -Wline-truncation
  -Wcharacter-truncation
  # I need to think more how to remove these warnings -Warray-temporaries
  -fcheck=all
  -finit-real=snan
  -finit-integer=-2147483648
  -finit-logical=true
  -fimplicit-none)

# Create the static library
set(ttb_lib tensor_ttbs)
# set(debug_exec_name ${project_name})

add_library(${ttb_lib} STATIC)

target_link_libraries(
  ${ttb_lib} PRIVATE ${PROJECT_SOURCE_DIR}/lib/test-drive/lib/libtest-drive.a)

# Set the library output and module directories
set_target_properties(
  ${ttb_lib} PROPERTIES ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
                        Fortran_MODULE_DIRECTORY "${CMAKE_BINARY_DIR}/modules")

include_directories(
  ${PROJECT_SOURCE_DIR}/lib/test-drive/include/test-drive/${CMAKE_Fortran_COMPILER_ID}-${CMAKE_Fortran_COMPILER_VERSION}
)
add_subdirectory(src)
add_subdirectory(test)
# add_executable(${debug_exec_name} ${PROJECT_SOURCE_DIR}/app/main.f90) Set the
# module directory for the executable
# target_include_directories(${debug_exec_name} PRIVATE
# "${CMAKE_BINARY_DIR}/modules")

# ${PROJECT_SOURCE_DIR}/lib/test-drive/lib/libtest-drive.a) Link the library to
# the executable target_link_libraries(${debug_exec_name} PRIVATE ${ttb_lib})
