# this one is important
set(CMAKE_SYSTEM_NAME Linux)
#this one not so much
set(CMAKE_SYSTEM_VERSION 1)

set(HOST x86_64-linux-musl)

include(FetchContent)
fetchcontent_declare(
    toolchain
    URL https://musl.cc/x86_64-linux-musl-cross.tgz
    UPDATE_DISCONNECTED true
    CONFIGURE_HANDLED_BY_BUILD true
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ""
    TEST_COMMAND "<SOURCE_DIR>/bin/${HOST}-gcc --version"
)
fetchcontent_makeavailable(toolchain)

# specify the cross compiler
set(CMAKE_C_COMPILER ${toolchain_SOURCE_DIR}/bin/${HOST}-gcc)
set(CMAKE_CXX_COMPILER ${toolchain_SOURCE_DIR}/bin/${HOST}-g++)

# where is the target environment
set(CMAKE_FIND_ROOT_PATH ${toolchain_SOURCE_DIR}/lib/${HOST} ${toolchain_SOURCE_DIR}/lib/${HOST}/cmake/)

# search for programs in the build host directories
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

# for libraries and headers in the target directories
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
