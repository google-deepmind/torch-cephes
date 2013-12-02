# install the lua code for the cephes package
FILE(GLOB src "*.lua")
# TODO: install the tests, too
# ADD_SUBDIRECTORY(tests)

set(luasrc "${src}" PARENT_SCOPE)
