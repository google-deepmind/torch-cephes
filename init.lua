local ffi = require("ffi")
cephes = ffi.load(package.searchpath('libcephes', package.cpath))

-- Add here all needed Cephes imports
ffi.cdef[[
]]

return cephes
