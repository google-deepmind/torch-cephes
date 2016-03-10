local ffi = require("ffi")
cephes.new_cmplx = function(re, im)
    local z = ffi.new("cmplx")
    z.r = re
    z.i = im
    return z
end
