CMAKE_MINIMUM_REQUIRED(VERSION 2.6 FATAL_ERROR)
CMAKE_POLICY(VERSION 2.6)
FIND_PACKAGE(Torch REQUIRED)

# libcephes compilation and installation is in its own subdirectory
ADD_SUBDIRECTORY(cephes)

# install the lua code for the cephes package
SET(luasrc init.lua)
ADD_TORCH_PACKAGE(cephes "${src}" "${luasrc}")

# SUBDIRS(doc)
SUBDIRS(tests)
