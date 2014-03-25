require 'cephes'
require 'totem'
local ffi = require 'ffi'
local callTests = {}
local tester = totem.Tester()

local max_pol = 3
cephes.polini(max_pol)

-- Test simple calls for euclid
-- Signature: double euclid(double * num, double * den)
function callTests.test_euclid()
    local num = ffi.new("double[4]", {0})
    local den = ffi.new("double[4]", {0})
    tester:assert(cephes.euclid(num, den))
end

-- Test simple calls for polrt
-- Signature: int polrt(double xcof[], double cof[], int m, cmplx root[])
function callTests.test_polrt()
    local xcof = ffi.new("double[4]", {0})
    local cof = ffi.new("double[4]", {0})
    local m = 1
    local root = cephes.new_cmplx(1, 1)
    tester:assert(cephes.polrt(xcof, cof, m, root))
end

-- Test simple calls for polini
-- Signature: void polini(int maxdeg)
function callTests.test_polini()
    local maxdeg = 1
    tester:asserteq(cephes.polini(maxdeg), nil)
    cephes.polini(max_pol)
end

-- Test simple calls for polprt
-- Signature: void polprt(double a[], int na, int d)
function callTests.test_polprt()
    local a = ffi.new("double[3]", {1, 1, 1})
    local na = 2
    local d = 2
    tester:asserteq(cephes.polprt(a, na, d), nil)
end

-- Test simple calls for polclr
-- Signature: void polclr(double * a, int n)
function callTests.test_polclr()
    local a = ffi.new("double[4]", {0})
    local n = 1
    tester:asserteq(cephes.polclr(a, n), nil)
end

-- Test simple calls for polmov
-- Signature: void polmov(double * a, int na, double * b)
function callTests.test_polmov()
    local a = ffi.new("double[4]", {0})
    local na = 1
    local b = ffi.new("double[4]", {0})
    tester:asserteq(cephes.polmov(a, na, b), nil)
end

-- Test simple calls for polmul
-- Signature: void polmul(double a[], int na, double b[], int nb, double c[])
function callTests.test_polmul()
    local a = ffi.new("double[2]", {0, 0})
    local na = 1
    local b = ffi.new("double[2]", {0, 0})
    local nb = 1
    local c = ffi.new("double[3]", {0, 0, 0})
    tester:asserteq(cephes.polmul(a, na, b, nb, c), nil)
end

-- Test simple calls for poladd
-- Signature: void poladd(double a[], int na, double b[], int nb, double c[])
function callTests.test_poladd()
    local a = ffi.new("double[2]", {0, 0})
    local na = 1
    local b = ffi.new("double[2]", {0, 0})
    local nb = 1
    local c = ffi.new("double[2]", {0, 0})
    tester:asserteq(cephes.poladd(a, na, b, nb, c), nil)
end

-- Test simple calls for polsub
-- Signature: void polsub(double a[], int na, double b[], int nb, double c[])
function callTests.test_polsub()
    local a = ffi.new("double[4]", {0})
    local na = 1
    local b = ffi.new("double[4]", {0})
    local nb = 1
    local c = ffi.new("double[4]", {0})
    tester:asserteq(cephes.polsub(a, na, b, nb, c), nil)
end

-- Test simple calls for poldiv
-- Signature: int poldiv(double a[], int na, double b[], int nb, double c[])
function callTests.test_poldiv()
    local a = ffi.new("double[4]", {1})
    local na = 1
    local b = ffi.new("double[4]", {1})
    local nb = 1
    local c = ffi.new("double[4]", {0, 0, 0, 0})
    tester:assert(cephes.poldiv(a, na, b, nb, c))
end

-- Test simple calls for polsbt
-- Signature: void polsbt(double a[], int na, double b[], int nb, double c[])
function callTests.test_polsbt()
    local a = ffi.new("double[3]", {0, 0, 0})
    local na = 2
    local b = ffi.new("double[3]", {0, 0, 0})
    local nb = 2
    local c = ffi.new("double[4]", {0, 0, 0, 0})
    tester:asserteq(cephes.polsbt(a, na, b, nb, c), nil)
end

-- Test simple calls for poleva
-- Signature: double poleva(double a[], int na, double x)
function callTests.test_poleva()
    local a = ffi.new("double[4]", {0})
    local na = 1
    local x = 0.5
    tester:assert(cephes.poleva(a, na, x))
end

-- Test simple calls for revers
-- Signature: void revers(double y[], double x[], int n)
function callTests.test_revers()
    local y = ffi.new("double[4]", {0, 1})
    local x = ffi.new("double[4]", {0})
    local n = 1
    tester:asserteq(cephes.revers(y, x, n), nil)
end

tester:add(callTests)
return tester:run()
