
require 'cephes'
require 'totem'
local ffi = require 'ffi'
local callTests = {}
local tester = totem.Tester()


-- Test simple calls for airy
-- Signature: int airy(double x, double * ai, double * aip, double * bi, double * bip)
function callTests.test_airy()
    local x = 0.5
    local ai = ffi.new("double[1]", {0})
    local aip = ffi.new("double[1]", {0})
    local bi = ffi.new("double[1]", {0})
    local bip = ffi.new("double[1]", {0})
    tester:assert(cephes.airy(x, ai, aip, bi, bip))
end

-- Test simple calls for hyp2f1
-- Signature: double hyp2f1(double a, double b, double c, double x)
function callTests.test_hyp2f1()
    local a = 0.5
    local b = 0.5
    local c = 0.5
    local x = 0.5
    tester:assert(cephes.hyp2f1(a, b, c, x))
end

-- Test simple calls for hyperg
-- Signature: double hyperg(double a, double b, double x)
function callTests.test_hyperg()
    local a = 1.0
    local b = 0.5
    local x = 0.5
    tester:assert(cephes.hyperg(a, b, x))
end

-- Test simple calls for hyp2f0
-- Signature: double hyp2f0(double a, double b, double x, int type, double * err)
function callTests.test_hyp2f0()
    local a = 0.5
    local b = 0.5
    local x = 0.5
    local type = 1
    local err = ffi.new("double[1]", {0})
    tester:assert(cephes.hyp2f0(a, b, x, type, err))
end

-- Test simple calls for i0
-- Signature: double i0(double x)
function callTests.test_i0()
    local x = 0.5
    tester:assert(cephes.i0(x))
end

-- Test simple calls for i0e
-- Signature: double i0e(double x)
function callTests.test_i0e()
    local x = 0.5
    tester:assert(cephes.i0e(x))
end

-- Test simple calls for i1
-- Signature: double i1(double x)
function callTests.test_i1()
    local x = 0.5
    tester:assert(cephes.i1(x))
end

-- Test simple calls for i1e
-- Signature: double i1e(double x)
function callTests.test_i1e()
    local x = 0.5
    tester:assert(cephes.i1e(x))
end

-- Test simple calls for iv
-- Signature: double iv(double v, double x)
function callTests.test_iv()
    local v = 0.5
    local x = 0.5
    tester:assert(cephes.iv(v, x))
end

-- Test simple calls for j0
-- Signature: double j0(double x)
function callTests.test_j0()
    local x = 0.5
    tester:assert(cephes.j0(x))
end

-- Test simple calls for y0
-- Signature: double y0(double x)
function callTests.test_y0()
    local x = 0.5
    tester:assert(cephes.y0(x))
end

-- Test simple calls for j1
-- Signature: double j1(double x)
function callTests.test_j1()
    local x = 0.5
    tester:assert(cephes.j1(x))
end

-- Test simple calls for y1
-- Signature: double y1(double x)
function callTests.test_y1()
    local x = 0.5
    tester:assert(cephes.y1(x))
end

-- Test simple calls for jn
-- Signature: double jn(int n, double x)
function callTests.test_jn()
    local n = 1
    local x = 0.5
    tester:assert(cephes.jn(n, x))
end

-- Test simple calls for jv
-- Signature: double jv(double n, double x)
function callTests.test_jv()
    local n = 0.5
    local x = 0.5
    tester:assert(cephes.jv(n, x))
end

-- Test simple calls for k0
-- Signature: double k0(double x)
function callTests.test_k0()
    local x = 0.5
    tester:assert(cephes.k0(x))
end

-- Test simple calls for k0e
-- Signature: double k0e(double x)
function callTests.test_k0e()
    local x = 0.5
    tester:assert(cephes.k0e(x))
end

-- Test simple calls for k1
-- Signature: double k1(double x)
function callTests.test_k1()
    local x = 0.5
    tester:assert(cephes.k1(x))
end

-- Test simple calls for k1e
-- Signature: double k1e(double x)
function callTests.test_k1e()
    local x = 0.5
    tester:assert(cephes.k1e(x))
end

-- Test simple calls for kn
-- Signature: double kn(int nn, double x)
function callTests.test_kn()
    local nn = 1
    local x = 0.5
    tester:assert(cephes.kn(nn, x))
end

-- Test simple calls for psi
-- Signature: double psi(double x)
function callTests.test_psi()
    local x = 0.5
    tester:assert(cephes.psi(x))
    tester:assert(cephes.isinf(cephes.psi(math.huge)))

    local errorLevel = cephes.getErrorLevel()
    cephes.setErrorLevel('error')
    tester:assertErrorPattern(function() cephes.psi(0) end, ".*singularity error.*")
    cephes.setErrorLevel(errorLevel)
end

-- Test simple calls for onef2
-- Signature: double onef2(double a, double b, double c, double x, double * err)
function callTests.test_onef2()
    local a = 0.5
    local b = 0.5
    local c = 0.5
    local x = 0.5
    local err = ffi.new("double[1]", {0})
    tester:assert(cephes.onef2(a, b, c, x, err))
end

-- Test simple calls for threef0
-- Signature: double threef0(double a, double b, double c, double x, double * err)
function callTests.test_threef0()
    local a = 0.5
    local b = 0.5
    local c = 0.5
    local x = 0.5
    local err = ffi.new("double[1]", {0})
    tester:assert(cephes.threef0(a, b, c, x, err))
end

-- Test simple calls for struve
-- Signature: double struve(double v, double x)
function callTests.test_struve()
    local v = 0.5
    local x = 0.5
    tester:assert(cephes.struve(v, x))
end

-- Test simple calls for yn
-- Signature: double yn(int n, double x)
function callTests.test_yn()
    local n = 1
    local x = 0.5
    tester:assert(cephes.yn(n, x))
end

tester:add(callTests)
return tester:run()
