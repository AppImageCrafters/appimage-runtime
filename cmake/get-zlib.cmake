include(ExternalProject)

set(ZLIB_LIBS ${EXTERNAL_TARGETS_PREFIX}/lib/libz.a)
externalproject_add(
    zlib
    URL https://zlib.net/zlib-1.2.12.tar.gz
    URL_HASH SHA256=91844808532e5ce316b3c010929493c0244f3d37593afd6de04f71821d5136d9
    CONFIGURE_COMMAND CC=${CMAKE_C_COMPILER} ${CMAKE_COMMAND} <SOURCE_DIR> -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${EXTERNAL_TARGETS_PREFIX}
    UPDATE_DISCONNECTED true
    CONFIGURE_HANDLED_BY_BUILD true
    BUILD_COMMAND CC=${CMAKE_C_COMPILER} ${MAKE_EXE}
)


add_library(zlib::static INTERFACE IMPORTED GLOBAL)

file(MAKE_DIRECTORY ${EXTERNAL_TARGETS_PREFIX}/include)
target_include_directories(zlib::static INTERFACE ${EXTERNAL_TARGETS_PREFIX}/include)
target_link_libraries(zlib::static INTERFACE "${ZLIB_LIBS}")

add_dependencies(zlib::static zlib)