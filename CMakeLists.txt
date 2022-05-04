cmake_minimum_required(VERSION 3.13)
project(appimage-runtime)

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)

include(cmake/dependencies.cmake)
add_subdirectory(src)
