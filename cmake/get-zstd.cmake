include(ExternalProject)

set(ZSTD_LIBS ${EXTERNAL_TARGETS_PREFIX}/usr/local/lib/libzstd.a)
externalproject_add(
    zstd

    GIT_REPOSITORY https://github.com/facebook/zstd.git
    GIT_TAG  v1.5.2
    UPDATE_DISCONNECTED true
    CONFIGURE_HANDLED_BY_BUILD true
    CONFIGURE_COMMAND ""
    BUILD_COMMAND cd <SOURCE_DIR> && make -j$(nproc)
    INSTALL_COMMAND cd <SOURCE_DIR> &&  DESTDIR=${EXTERNAL_TARGETS_PREFIX} make install
    BYPRODUCTS "${ZSTD_LIBS}"
    TEST_COMMAND ""
)

add_library(zstd::static INTERFACE IMPORTED GLOBAL)

file(MAKE_DIRECTORY ${EXTERNAL_TARGETS_PREFIX}/usr/local/include)
target_include_directories(zstd::static INTERFACE ${EXTERNAL_TARGETS_PREFIX}/usr/local/include)

target_link_libraries(zstd::static INTERFACE "${ZSTD_LIBS}")

add_dependencies(zstd::static zstd)