
require 'cephes'
local ffi = require 'ffi'
local callTests = {}
local tester = torch.Tester()


-- Test simple calls for cadd
-- Signature: void cadd(cmplx * a, cmplx * b, cmplx * c)
function callTests.test_cadd()
    local a = cephes.new_cmplx(1, 1) ; error(' TODO: check this pointer makes sense!')
    local b = cephes.new_cmplx(1, 1) ; error(' TODO: check this pointer makes sense!')
    local c = cephes.new_cmplx(1, 1) ; error(' TODO: check this pointer makes sense!')
    tester:assert(cephes.cadd(a, b, c))
end

-- Test simple calls for csub
-- Signature: void csub(cmplx * a, cmplx * b, cmplx * c)
function callTests.test_csub()
    local a = cephes.new_cmplx(1, 1) ; error(' TODO: check this pointer makes sense!')
    local b = cephes.new_cmplx(1, 1) ; error(' TODO: check this pointer makes sense!')
    local c = cephes.new_cmplx(1, 1) ; error(' TODO: check this pointer makes sense!')
    tester:assert(cephes.csub(a, b, c))
end

-- Test simple calls for cmul
-- Signature: void cmul(cmplx * a, cmplx * b, cmplx * c)
function callTests.test_cmul()
    local a = cephes.new_cmplx(1, 1) ; error(' TODO: check this pointer makes sense!')
    local b = cephes.new_cmplx(1, 1) ; error(' TODO: check this pointer makes sense!')
    local c = cephes.new_cmplx(1, 1) ; error(' TODO: check this pointer makes sense!')
    tester:assert(cephes.cmul(a, b, c))
end

-- Test simple calls for cdiv
-- Signature: void cdiv(cmplx * a, cmplx * b, cmplx * c)
function callTests.test_cdiv()
    local a = cephes.new_cmplx(1, 1) ; error(' TODO: check this pointer makes sense!')
    local b = cephes.new_cmplx(1, 1) ; error(' TODO: check this pointer makes sense!')
    local c = cephes.new_cmplx(1, 1) ; error(' TODO: check this pointer makes sense!')
    tester:assert(cephes.cdiv(a, b, c))
end

-- Test simple calls for cmov
-- Signature: void cmov(void * a, void * b)
function callTests.test_cmov()
    local a = nil ; error(' TODO: void * parameter needed!')
    local b = nil ; error(' TODO: void * parameter needed!')
    tester:assert(cephes.cmov(a, b))
end

-- Test simple calls for cneg
-- Signature: void cneg(cmplx * a)
function callTests.test_cneg()
    local a = cephes.new_cmplx(1, 1) ; error(' TODO: check this pointer makes sense!')
    tester:assert(cephes.cneg(a))
end

-- Test simple calls for cabs
-- Signature: double cabs(cmplx * z)
function callTests.test_cabs()
    local z = cephes.new_cmplx(1, 1) ; error(' TODO: check this pointer makes sense!')
    tester:assert(cephes.cabs(z))
end

-- Test simple calls for csqrt
-- Signature: void csqrt(cmplx * z, cmplx * w)
function callTests.test_csqrt()
    local z = cephes.new_cmplx(1, 1) ; error(' TODO: check this pointer makes sense!')
    local w = cephes.new_cmplx(1, 1) ; error(' TODO: check this pointer makes sense!')
    tester:assert(cephes.csqrt(z, w))
end

-- Test simple calls for hypot
-- Signature: double hypot(double x, double y)
function callTests.test_hypot()
    local x = 0.5
    local y = 0.5
    tester:assert(cephes.hypot(x, y))
end

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
    local sn = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    local cn = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    local dn = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    local ph = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    tester:assert(cephes.ellpj(u, m, sn, cn, dn, ph))
end

-- Test simple calls for ellpk
-- Signature: double ellpk(double x)
function callTests.test_ellpk()
    local x = 0.5
    tester:assert(cephes.ellpk(x))
end

-- Test simple calls for polevl
-- Signature: double polevl(double x, double coef[], int N)
function callTests.test_polevl()
    local x = 0.5
    local coef = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    local N = 1
    tester:assert(cephes.polevl(x, coef, N))
end

-- Test simple calls for p1evl
-- Signature: double p1evl(double x, double coef[], int N)
function callTests.test_p1evl()
    local x = 0.5
    local coef = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    local N = 1
    tester:assert(cephes.p1evl(x, coef, N))
end

tester:add(callTests)
tester:run()
