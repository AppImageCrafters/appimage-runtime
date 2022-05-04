include(FindPkgConfig)

set(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
pkg_check_modules(ZLIB REQUIRED IMPORTED_TARGET zlib)
pkg_check_modules(ZSTD REQUIRED IMPORTED_TARGET libzstd)
pkg_check_modules(FUSE REQUIRED IMPORTED_TARGET fuse)
pkg_search_module(SQUASHFUSE_LL REQUIRED IMPORTED_TARGET squashfuse_ll libsquashfs0 squashfuse)
