# my_lib

[![License: MIT](https://img.shields.io/github/license/gashmob/project-templates)](https://opensource.org/licenses/MIT)
![Version](https://img.shields.io/github/v/release/gashmob/project-templates?include_prereleases)

## How to use (where to rename)

- [.github/workflows/package.yml](.github/workflows/package.yml) -> archive package name
- [cmake/packaging.cmake](cmake/packaging.cmake) -> some set
- [cmake/package/my_lib-config.cmake.in](cmake/package/my_lib-config.cmake.in) -> filename + set
- [CMakeLists.txt](CMakeLists.txt) and [tests/CMakeLists.txt](tests/CMakeLists.txt) -> lib target name + project name
- [shell.nix](shell.nix) -> environment name
- [tools/nix/my_lib.nix](tools/nix/my_lib.nix) -> file name + package name and its usage in `default.nix`
- [README.md](README.md) -> remove this text + title + badges

- [CHANGELOG.md](CHANGELOG.md) -> set first version + *in development*
