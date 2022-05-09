cmake_minimum_required(VERSION 3.13)
project(appimage-runtime)

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)

# determine Git commit ID
execute_process(
    COMMAND git rev-parse --short HEAD
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
    OUTPUT_VARIABLE GIT_COMMIT
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

include(cmake/dependencies.cmake)

option(STATIC "Build static runtime" Yes)
add_subdirectory(src)
