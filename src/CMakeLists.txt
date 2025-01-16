file(GLOB TTB_FILES *.f90)
target_sources(${ttb_lib} PRIVATE ${TTB_FILES})
