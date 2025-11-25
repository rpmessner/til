---
published: true
---

# Symlink compile_commands.json for LSP Support

CMake generates `compile_commands.json` in the build directory, but LSP tools like clangd look for it in the project root. Create a symlink:

```bash
ln -sf build-linux/compile_commands.json /path/to/project/compile_commands.json
```

Important: If you're cross-compiling for multiple platforms, link to your **native** build's compile_commands.json, not the cross-compilation target:

```bash
# Good - LSP runs natively, needs native include paths
ln -sf build-linux/compile_commands.json compile_commands.json

# Bad - MinGW headers won't work for native LSP analysis
ln -sf build-windows/compile_commands.json compile_commands.json
```

Enable generation in CMakeLists.txt:
```cmake
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
```

This gives your editor/LSP full knowledge of:
- Include paths
- Compiler flags
- Preprocessor definitions
- Compilation units

Most LSP errors like "cannot find header" disappear once compile_commands.json is properly linked.
