cmake_minimum_required(VERSION 3.6)
project(appimage-runtime)

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)

include(cmake/dependencies.cmake)

add_executable(runtime src/main.c)
target_link_libraries(runtime -static PkgConfig::FUSE PkgConfig::SQUASHFUSE_LL PkgConfig::ZSTD PkgConfig::ZLIB)
target_compile_definitions(runtime PRIVATE -D_FILE_OFFSET_BITS=64)