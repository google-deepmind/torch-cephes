
require 'cephes'
require 'totem'
local ffi = require 'ffi'
local callTests = {}
local tester = totem.Tester()


-- Test simple calls for ellie
-- Signature: double ellie(double phi, double m)
function callTests.test_ellie()
    local phi = 0.5
    local m = 0.5
    tester:assert(cephes.ellie(phi, m))
end

-- Test simple calls for ellik
-- Signature: double ellik(double phi, double m)
function callTests.test_ellik()
    local phi = 0.5
    local m = 0.5
    tester:assert(cephes.ellik(phi, m))
end

-- Test simple calls for ellpe
-- Signature: double ellpe(double x)
function callTests.test_ellpe()
    local x = 0.5
    tester:assert(cephes.ellpe(x))
end

-- Test simple calls for ellpj
-- Signature: int ellpj(double u, double m, double * sn, double * cn, double * dn, double * ph)
function callTests.test_ellpj()
    local u = 0.5
    local m = 0.5
    local sn = ffi.new("double[1]", {0})
    local cn = ffi.new("double[1]", {0})
    local dn = ffi.new("double[1]", {0})
    local ph = ffi.new("double[1]", {0})
    tester:assert(cephes.ellpj(u, m, sn, cn, dn, ph))
end

-- Test simple calls for ellpk
-- Signature: double ellpk(double x)
function callTests.test_ellpk()
    local x = 0.5
    tester:assert(cephes.ellpk(x))
end

tester:add(callTests)
return tester:run()
