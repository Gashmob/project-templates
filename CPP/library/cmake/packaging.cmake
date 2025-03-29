# MIT License
#
# Copyright (c) 2025-Present Kevin Traini
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
include_guard()

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

function(lib_package)
    set(CPACK_PACKAGE_NAME "${PROJECT_NAME}")
    set(CPACK_PACKAGE_VENDOR "lib developers")
    set(CPACK_PACKAGE_MAINTAINER "${CPACK_PACKAGE_VENDOR}")
    set(CPACK_PACKAGE_CONTACT "Kevin Traini <kevin@ktraini.com>")
    set(CPACK_PACKAGE_DESCRIPTION "My library")
    set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "My library")
    set(CPACK_PACKAGE_HOMEPAGE_URL "https://example.com")
    set(CPACK_PACKAGE_CHECKSUM "SHA512")
    set(CPACK_RESOURCE_FILE_LICENSE "${PROJECT_SOURCE_DIR}/LICENSE.md")
    set(CPACK_RESOURCE_FILE_README "${PROJECT_SOURCE_DIR}/README.md")

    # RPM package
    set(CPACK_RPM_PACKAGE_LICENSE "MIT")
    set(CPACK_RPM_PACKAGE_GROUP "Development/Tools")
    set(CPACK_RPM_PACKAGE_DESCRIPTION "My library")
    set(CPACK_RPM_CHANGELOG_FILE "${CMAKE_CURRENT_BINARY_DIR}/changelog")

    # CMake package
    set(INCLUDE_INSTALL_DIR ${CMAKE_INSTALL_INCLUDEDIR}/my_lib CACHE PATH "Location of header files")
    set(MY_LIB_CMAKE_DIR "${CMAKE_INSTALL_LIBDIR}/cmake/my_lib" CACHE STRING "Installation directory for cmake files, relative to ${CMAKE_INSTALL_PREFIX}.")
    set(version_config "${PROJECT_BINARY_DIR}/my_lib-config-version.cmake")
    set(project_config "${PROJECT_BINARY_DIR}/my_lib-config.cmake")
    set(targets_export_name my_lib-targets)
    set(PACKAGE_TEMPLATE_DIR "${PROJECT_SOURCE_DIR}/cmake/package")
    write_basic_package_version_file(
            ${version_config}
            VERSION ${VERSION}
            COMPATIBILITY SameMajorVersion
            ARCH_INDEPENDENT
    )
    configure_package_config_file(
            "${PACKAGE_TEMPLATE_DIR}/my_lib-config.cmake.in"
            ${project_config}
            INSTALL_DESTINATION ${MY_LIB_CMAKE_DIR}
            PATH_VARS INCLUDE_INSTALL_DIR
    )
    export(TARGETS my_lib NAMESPACE my_lib::
            FILE ${PROJECT_BINARY_DIR}/${targets_export_name}.cmake)

    install(FILES ${project_config} ${version_config}
            DESTINATION ${MY_LIB_CMAKE_DIR})
    install(EXPORT ${targets_export_name} DESTINATION ${MY_LIB_CMAKE_DIR}
            NAMESPACE my_lib::)
    install(TARGETS my_lib EXPORT ${targets_export_name} DESTINATION ${CMAKE_INSTALL_LIBDIR})
    install(FILES ${PROJECT_SOURCE_DIR}/include/my_lib.h DESTINATION ${INCLUDE_INSTALL_DIR})

    include(CPack)
endfunction()
