cmake_minimum_required(VERSION 3.2)
project(appimage-runtime)

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)

include(toolchains/musl-gcc.cmake)

add_executable(runtime src/main.c)
target_link_libraries(runtime -static)