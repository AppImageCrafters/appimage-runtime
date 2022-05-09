include(ExternalProject)

set(PKG_CONFIG_PATH ${EXTERNAL_TARGETS_PREFIX}/lib/pkgconfig)

set(SQUASHFUSE_LIBS "${EXTERNAL_TARGETS_PREFIX}/lib/libsquashfuse_ll.a" "${EXTERNAL_TARGETS_PREFIX}/lib/libsquashfuse.a")
externalproject_add(
    squashfuse

    GIT_REPOSITORY https://github.com/vasi/squashfuse.git
    GIT_TAG master
    UPDATE_DISCONNECTED true
    CONFIGURE_HANDLED_BY_BUILD true
    CONFIGURE_COMMAND
        # additional header dir need to allow `#include <fuse3/fuse.h>`
        CC=${CMAKE_C_COMPILER}
        CFLAGS=-I${EXTERNAL_TARGETS_PREFIX}/include
        LDFLAGS=-L${EXTERNAL_TARGETS_PREFIX}/lib
        PKG_CONFIG_PATH=${PKG_CONFIG_PATH}
        <SOURCE_DIR>/configure prefix=${EXTERNAL_TARGETS_PREFIX}
            --enable-shared=no
            --enable-static=yes
            --disable-demo
            --with-pic=no-PIC
            --host=${HOST}
    BUILD_COMMAND make
    INSTALL_COMMAND make install
    BYPRODUCTS "${SQUASHFUSE_LIBS}"
    TEST_COMMAND ""
)


externalproject_add_step(
    squashfuse
    bootstrap
    COMMAND PKG_CONFIG_PATH=${PKG_CONFIG_PATH} <SOURCE_DIR>/autogen.sh
    WORKING_DIRECTORY <SOURCE_DIR>
    DEPENDEES download
    DEPENDERS configure
)

ExternalProject_Get_property(squashfuse SOURCE_DIR)
file(MAKE_DIRECTORY ${SOURCE_DIR})

add_library(squashfuse::static INTERFACE IMPORTED GLOBAL)
file(MAKE_DIRECTORY ${EXTERNAL_TARGETS_PREFIX}/include/squashfuse)
target_include_directories(squashfuse::static INTERFACE ${EXTERNAL_TARGETS_PREFIX}/include ${EXTERNAL_TARGETS_PREFIX}/include/squashfuse ${SOURCE_DIR}/..)
target_link_libraries(squashfuse::static INTERFACE "${SQUASHFUSE_LIBS}")

add_dependencies(squashfuse::static squashfuse)
