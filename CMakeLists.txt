CMAKE_MINIMUM_REQUIRED(VERSION 2.6 FATAL_ERROR)
CMAKE_POLICY(VERSION 2.6)
FIND_PACKAGE(Torch REQUIRED)
enable_language (Fortran)
SET(VERBOSE 1)

# libcephes compilation and installation is in its own subdirectory
ADD_SUBDIRECTORY(cephes)
ADD_SUBDIRECTORY(cdflib)
ADD_SUBDIRECTORY(luasrc)
SET(src "${cdflib_src}" "${cephes_src}")
MESSAge(STATUS  "${src}")
ADD_TORCH_PACKAGE(cephes "${src}" "${luasrc}")
