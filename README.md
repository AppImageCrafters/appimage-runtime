# appimage-runtime

Statically linked runtime for AppImages

# build

```shell
cmake -DCMAKE_TOOLCHAIN_FILE=cmake/toolchains/x86_64-linux-musl.cmake .
make
```

# Tested Systems

The following list contains systems where the runtime has been proved.

- Ubuntu (x86_64): 14.04, 16.04, 18.04, 20.04, 22.04
- Debian (x86_64): 10, 11
- Centos (x86_64): 7
- Fedora (x86_64): 31, 32
- Linux Mint (x86_64): 19.3
- Manjaro (x86_64): 19.0.2, 21.2.6
- openSUSE (x86_64): 15.1
- Archlinux