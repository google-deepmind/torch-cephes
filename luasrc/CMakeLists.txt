# install the lua code for the cephes package
FILE(GLOB luasrc "*.lua")
# TODO: install the tests, too
# ADD_SUBDIRECTORY(tests)
ADD_TORCH_PACKAGE(cephes FALSE "${luasrc}")
