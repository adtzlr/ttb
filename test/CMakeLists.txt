# Unit testing
set(tests "suite1")
set(test-srcs "main_tests.f90")
foreach(t IN LISTS tests)
  string(MAKE_C_IDENTIFIER ${t} t)
  list(APPEND test-srcs "test_${t}.f90")
endforeach()

set(test_exec "${project_name}-tester")
add_executable(${test_exec} "${test-srcs}")
if("${CMAKE_Fortran_COMPILER_ID}" STREQUAL "GNU")
  target_compile_options(${ttb_lib} PRIVATE $<$<COMPILE_LANGUAGE:Fortran>: >)
elseif("${CMAKE_Fortran_COMPILER_ID}" STREQUAL "Cray")

elseif("${CMAKE_Fortran_COMPILER_ID}" STREQUAL "Intel"
       OR ${CMAKE_Fortran_COMPILER_ID} STREQUAL "IntelLLVM")

elseif("${CMAKE_Fortran_COMPILER_ID}" STREQUAL "NVHPC")

elseif("${CMAKE_Fortran_COMPILER_ID}" STREQUAL "LLVMFlang")

endif()

set_target_properties(
  "${project_name}-tester"
  PROPERTIES ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
             Fortran_MODULE_DIRECTORY "${CMAKE_BINARY_DIR}/modules")
target_link_libraries(
  "${project_name}-tester"
  PRIVATE "${ttb_lib}" ${PROJECT_SOURCE_DIR}/lib/test-drive/lib/libtest-drive.a)

foreach(t IN LISTS tests)
  message(STATUS "${project_name}/${t} ${project_name}-tester ${t}")
  add_test("${project_name}/${t}" "${project_name}-tester" "${t}")
endforeach()
