
require 'cephes'
local ffi = require 'ffi'
local callTests = {}
local tester = torch.Tester()


-- Test simple calls for euclid
-- Signature: double euclid(double * num, double * den)
function callTests.test_euclid()
    local num = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    local den = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    tester:assert(cephes.euclid(num, den))
end

-- Test simple calls for polrt
-- Signature: int polrt(double xcof[], double cof[], int m, cmplx root[])
function callTests.test_polrt()
    local xcof = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    local cof = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    local m = 1
    local root = cephes.new_cmplx(1, 1) ; error(' TODO: check this pointer makes sense!')
    tester:assert(cephes.polrt(xcof, cof, m, root))
end

-- Test simple calls for polini
-- Signature: void polini(int maxdeg)
function callTests.test_polini()
    local maxdeg = 1
    tester:assert(cephes.polini(maxdeg))
end

-- Test simple calls for polprt
-- Signature: void polprt(double a[], int na, int d)
function callTests.test_polprt()
    local a = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    local na = 1
    local d = 1
    tester:assert(cephes.polprt(a, na, d))
end

-- Test simple calls for polclr
-- Signature: void polclr(double * a, int n)
function callTests.test_polclr()
    local a = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    local n = 1
    tester:assert(cephes.polclr(a, n))
end

-- Test simple calls for polmov
-- Signature: void polmov(double * a, int na, double * b)
function callTests.test_polmov()
    local a = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    local na = 1
    local b = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    tester:assert(cephes.polmov(a, na, b))
end

-- Test simple calls for polmul
-- Signature: void polmul(double a[], int na, double b[], int nb, double c[])
function callTests.test_polmul()
    local a = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    local na = 1
    local b = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    local nb = 1
    local c = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    tester:assert(cephes.polmul(a, na, b, nb, c))
end

-- Test simple calls for poladd
-- Signature: void poladd(double a[], int na, double b[], int nb, double c[])
function callTests.test_poladd()
    local a = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    local na = 1
    local b = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    local nb = 1
    local c = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    tester:assert(cephes.poladd(a, na, b, nb, c))
end

-- Test simple calls for polsub
-- Signature: void polsub(double a[], int na, double b[], int nb, double c[])
function callTests.test_polsub()
    local a = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    local na = 1
    local b = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    local nb = 1
    local c = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    tester:assert(cephes.polsub(a, na, b, nb, c))
end

-- Test simple calls for poldiv
-- Signature: int poldiv(double a[], int na, double b[], int nb, double c[])
function callTests.test_poldiv()
    local a = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    local na = 1
    local b = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    local nb = 1
    local c = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    tester:assert(cephes.poldiv(a, na, b, nb, c))
end

-- Test simple calls for polsbt
-- Signature: void polsbt(double a[], int na, double b[], int nb, double c[])
function callTests.test_polsbt()
    local a = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    local na = 1
    local b = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    local nb = 1
    local c = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    tester:assert(cephes.polsbt(a, na, b, nb, c))
end

-- Test simple calls for poleva
-- Signature: double poleva(double a[], int na, double x)
function callTests.test_poleva()
    local a = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    local na = 1
    local x = 0.5
    tester:assert(cephes.poleva(a, na, x))
end

-- Test simple calls for polini
-- Signature: void polini(int maxdeg)
function callTests.test_polini()
    local maxdeg = 1
    tester:assert(cephes.polini(maxdeg))
end

-- Test simple calls for polprt
-- Signature: void polprt(fract a[], int na, int d)
function callTests.test_polprt()
    local a = nil ; error(' TODO: fract * parameter needed!')
    local na = 1
    local d = 1
    tester:assert(cephes.polprt(a, na, d))
end

-- Test simple calls for polclr
-- Signature: void polclr(fract a[], int n)
function callTests.test_polclr()
    local a = nil ; error(' TODO: fract * parameter needed!')
    local n = 1
    tester:assert(cephes.polclr(a, n))
end

-- Test simple calls for polmov
-- Signature: void polmov(fract a[], int na, fract b[])
function callTests.test_polmov()
    local a = nil ; error(' TODO: fract * parameter needed!')
    local na = 1
    local b = nil ; error(' TODO: fract * parameter needed!')
    tester:assert(cephes.polmov(a, na, b))
end

-- Test simple calls for polmul
-- Signature: void polmul(fract a[], int na, fract b[], int nb, fract c[])
function callTests.test_polmul()
    local a = nil ; error(' TODO: fract * parameter needed!')
    local na = 1
    local b = nil ; error(' TODO: fract * parameter needed!')
    local nb = 1
    local c = nil ; error(' TODO: fract * parameter needed!')
    tester:assert(cephes.polmul(a, na, b, nb, c))
end

-- Test simple calls for poladd
-- Signature: void poladd(fract a[], int na, fract b[], int nb, fract c[])
function callTests.test_poladd()
    local a = nil ; error(' TODO: fract * parameter needed!')
    local na = 1
    local b = nil ; error(' TODO: fract * parameter needed!')
    local nb = 1
    local c = nil ; error(' TODO: fract * parameter needed!')
    tester:assert(cephes.poladd(a, na, b, nb, c))
end

-- Test simple calls for polsub
-- Signature: void polsub(fract a[], int na, fract b[], int nb, fract c[])
function callTests.test_polsub()
    local a = nil ; error(' TODO: fract * parameter needed!')
    local na = 1
    local b = nil ; error(' TODO: fract * parameter needed!')
    local nb = 1
    local c = nil ; error(' TODO: fract * parameter needed!')
    tester:assert(cephes.polsub(a, na, b, nb, c))
end

-- Test simple calls for poldiv
-- Signature: int poldiv(fract a[], int na, fract b[], int nb, fract c[])
function callTests.test_poldiv()
    local a = nil ; error(' TODO: fract * parameter needed!')
    local na = 1
    local b = nil ; error(' TODO: fract * parameter needed!')
    local nb = 1
    local c = nil ; error(' TODO: fract * parameter needed!')
    tester:assert(cephes.poldiv(a, na, b, nb, c))
end

-- Test simple calls for polsbt
-- Signature: void polsbt(fract a[], int na, fract b[], int nb, fract c[])
function callTests.test_polsbt()
    local a = nil ; error(' TODO: fract * parameter needed!')
    local na = 1
    local b = nil ; error(' TODO: fract * parameter needed!')
    local nb = 1
    local c = nil ; error(' TODO: fract * parameter needed!')
    tester:assert(cephes.polsbt(a, na, b, nb, c))
end

-- Test simple calls for poleva
-- Signature: void poleva(fract a[], int na, fract * x, fract * s)
function callTests.test_poleva()
    local a = nil ; error(' TODO: fract * parameter needed!')
    local na = 1
    local x = nil ; error(' TODO: fract * parameter needed!')
    local s = nil ; error(' TODO: fract * parameter needed!')
    tester:assert(cephes.poleva(a, na, x, s))
end

-- Test simple calls for revers
-- Signature: void revers(double y[], double x[], int n)
function callTests.test_revers()
    local y = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    local x = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    local n = 1
    tester:assert(cephes.revers(y, x, n))
end

tester:add(callTests)
tester:run()
