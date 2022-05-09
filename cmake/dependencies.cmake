include(FindPkgConfig)

set(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
#pkg_check_modules(ZLIB REQUIRED IMPORTED_TARGET zlib)
#pkg_check_modules(ZSTD REQUIRED IMPORTED_TARGET libzstd)

# the EXTERNAL_TARGETS_PREFIX will be used as install location for libfuse and squashfuse
set(EXTERNAL_TARGETS_PREFIX ${CMAKE_CURRENT_BINARY_DIR}/external)

include(cmake/get-zlib.cmake)
include(cmake/get-zstd.cmake)

include(cmake/get-libfuse.cmake)
add_dependencies(libfuse zlib)
add_dependencies(libfuse zstd)

include(cmake/get-squashfuse.cmake)
add_dependencies(squashfuse libfuse)

