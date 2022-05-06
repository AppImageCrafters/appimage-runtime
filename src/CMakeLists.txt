add_executable(runtime main.c)
target_link_options(runtime PRIVATE -T ${CMAKE_CURRENT_SOURCE_DIR}/data_sections.ld)

set(EXTRA_LINK_ARGS)
if ("${STATIC}")
    set(EXTRA_LINK_ARGS -static)
endif ()

target_link_libraries(runtime libfuse::static squashfuse::static zstd::static zlib::static ${EXTRA_LINK_ARGS})
target_compile_definitions(runtime PRIVATE -D_FILE_OFFSET_BITS=64)

# add type 2 magic bytes
set(MAGIC_BYTES_FILE ${CMAKE_CURRENT_BINARY_DIR}/type2_magic_bytes)
if (NOT EXISTS "${MAGIC_BYTES_FILE}")
    string(ASCII 2 APPIMAGE_VERSION)
    file(WRITE "${MAGIC_BYTES_FILE}" "AI${APPIMAGE_VERSION}")
endif ()

add_custom_command(
    TARGET runtime
    POST_BUILD
    COMMENT "-- Adding AppImage Type 2 Magic Bytes to runtime"
    COMMAND dd if=${MAGIC_BYTES_FILE} of="$<TARGET_FILE:runtime>" bs=1 count=3 seek=8 conv=notrunc status=none
)
