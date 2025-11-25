# Cross-Compile Windows Executables from Linux with MinGW

You can build Windows `.exe` files directly from Linux using MinGW-w64, avoiding the need for a Windows development environment.

Install the cross-compiler:
```bash
sudo apt-get install mingw-w64
```

This gives you:
- `x86_64-w64-mingw32-gcc` - C compiler for Windows
- `x86_64-w64-mingw32-g++` - C++ compiler for Windows

Create a CMake build script:
```bash
#!/bin/bash
mkdir -p build-windows && cd build-windows

cmake .. \
    -DCMAKE_TOOLCHAIN_FILE=../vcpkg/scripts/buildsystems/vcpkg.cmake \
    -DVCPKG_TARGET_TRIPLET=x64-mingw-dynamic \
    -DCMAKE_C_COMPILER=x86_64-w64-mingw32-gcc \
    -DCMAKE_CXX_COMPILER=x86_64-w64-mingw32-g++ \
    -DCMAKE_SYSTEM_NAME=Windows \
    -DCMAKE_BUILD_TYPE=Release

cmake --build . --config Release
```

Use vcpkg for Windows dependencies:
```bash
./vcpkg/vcpkg install glfw3:x64-mingw-dynamic vulkan:x64-mingw-dynamic
```

Verify the output:
```bash
$ file build-windows/myapp.exe
myapp.exe: PE32+ executable (console) x86-64, for MS Windows
```

Copy the required DLLs alongside your exe:
```bash
cp vcpkg/installed/x64-mingw-dynamic/bin/*.dll /destination/
```
