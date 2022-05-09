include(ExternalProject)

set(FUSE_LIBS ${EXTERNAL_TARGETS_PREFIX}/lib/libfuse3.a)
externalproject_add(
    libfuse

    GIT_REPOSITORY https://github.com/libfuse/libfuse.git
    GIT_TAG fuse-3.11.0
    UPDATE_DISCONNECTED true
    CONFIGURE_HANDLED_BY_BUILD true
    CONFIGURE_COMMAND
        CC=${CMAKE_C_COMPILER}
        LDFLAGS=-static
        meson <SOURCE_DIR>
            -D default_library=static
            -D libdir=lib
            -D disable-mtab=true
            -D useroot=false
            -D tests=false
            -D utils=false
            -D examples=false
            -D b_pie=false
            -D c_link_args=-static
            -D prefix=${EXTERNAL_TARGETS_PREFIX}
            -D buildtype=minsize
            -D debug=false
    BUILD_COMMAND CC=${CMAKE_C_COMPILER} ninja
    INSTALL_COMMAND ninja install
    BYPRODUCTS "${FUSE_LIBS}"
    TEST_COMMAND ""
)

add_library(libfuse::static INTERFACE IMPORTED GLOBAL)

file(MAKE_DIRECTORY ${EXTERNAL_TARGETS_PREFIX}/include/fuse3)
target_include_directories(libfuse::static INTERFACE ${EXTERNAL_TARGETS_PREFIX}/include ${EXTERNAL_TARGETS_PREFIX}/include/fuse3)

target_link_libraries(libfuse::static INTERFACE "${FUSE_LIBS}" -lpthread -pthread -ldl -lrt)

add_dependencies(libfuse::static libfuse)