
require 'cephes'
local ffi = require 'ffi'
local callTests = {}
local tester = torch.Tester()


-- Test simple calls for beta
-- Signature: double beta(double a, double b)
function callTests.test_beta()
    local a = 0.5
    local b = 0.5
    tester:assert(cephes.beta(a, b))
end

-- Test simple calls for lbeta
-- Signature: double lbeta(double a, double b)
function callTests.test_lbeta()
    local a = 0.5
    local b = 0.5
    tester:assert(cephes.lbeta(a, b))
end

-- Test simple calls for chbevl
-- Signature: double chbevl(double x, double array[], int n)
function callTests.test_chbevl()
    local x = 0.5
    local array = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    local n = 1
    tester:assert(cephes.chbevl(x, array, n))
end

-- Test simple calls for dawsn
-- Signature: double dawsn(double xx)
function callTests.test_dawsn()
    local xx = 0.5
    tester:assert(cephes.dawsn(xx))
end

-- Test simple calls for ei
-- Signature: double ei(double x)
function callTests.test_ei()
    local x = 0.5
    tester:assert(cephes.ei(x))
end

-- Test simple calls for expn
-- Signature: double expn(int n, double x)
function callTests.test_expn()
    local n = 1
    local x = 0.5
    tester:assert(cephes.expn(n, x))
end

-- Test simple calls for fac
-- Signature: double fac(int i)
function callTests.test_fac()
    local i = 1
    tester:assert(cephes.fac(i))
end

-- Test simple calls for fresnl
-- Signature: int fresnl(double xxa, double * ssa, double * cca)
function callTests.test_fresnl()
    local xxa = 0.5
    local ssa = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    local cca = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    tester:assert(cephes.fresnl(xxa, ssa, cca))
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

-- Test simple calls for psi
-- Signature: double psi(double x)
function callTests.test_psi()
    local x = 0.5
    tester:assert(cephes.psi(x))
end

-- Test simple calls for revers
-- Signature: void revers(double y[], double x[], int n)
function callTests.test_revers()
    local y = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    local x = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    local n = 1
    tester:assert(cephes.revers(y, x, n))
end

-- Test simple calls for rgamma
-- Signature: double rgamma(double x)
function callTests.test_rgamma()
    local x = 0.5
    tester:assert(cephes.rgamma(x))
end

-- Test simple calls for shichi
-- Signature: int shichi(double x, double * si, double * ci)
function callTests.test_shichi()
    local x = 0.5
    local si = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    local ci = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    tester:assert(cephes.shichi(x, si, ci))
end

-- Test simple calls for sici
-- Signature: int sici(double x, double * si, double * ci)
function callTests.test_sici()
    local x = 0.5
    local si = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    local ci = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    tester:assert(cephes.sici(x, si, ci))
end

-- Test simple calls for simpsn
-- Signature: double simpsn(double f[], double delta)
function callTests.test_simpsn()
    local f = ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")
    local delta = 0.5
    tester:assert(cephes.simpsn(f, delta))
end

-- Test simple calls for spence
-- Signature: double spence(double x)
function callTests.test_spence()
    local x = 0.5
    tester:assert(cephes.spence(x))
end

-- Test simple calls for zeta
-- Signature: double zeta(double x, double q)
function callTests.test_zeta()
    local x = 0.5
    local q = 0.5
    tester:assert(cephes.zeta(x, q))
end

-- Test simple calls for zetac
-- Signature: double zetac(double x)
function callTests.test_zetac()
    local x = 0.5
    tester:assert(cephes.zetac(x))
end

tester:add(callTests)
tester:run()
