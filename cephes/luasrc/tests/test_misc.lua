
require 'cephes'
require 'totem'
require 'pl.strict'
local ffi = require 'ffi'
local callTests = {}
local tester = totem.Tester()


-- Test simple calls for beta
-- Signature: double beta(double a, double b)
function callTests.test_beta()
    local a = 0.5
    local b = 0.5
    tester:assert(cephes.beta(a, b))

    tester:asserteq(cephes.beta(1, 1), 1)

    -- Check against values from matlab
    tester:assertalmosteq(cephes.beta(3, 5), 9.523809523809535e-03, 1e-14)
    tester:assertalmosteq(cephes.beta(2, 4), 5.000000000000007e-02, 1e-14)
    tester:assertalmosteq(cephes.beta(2, 13), 5.494505494505515e-03, 1e-14)
    tester:assertalmosteq(cephes.beta(4.5, 1.1), 1.797749787942192e-01, 1e-14)
end

-- Test simple calls for lbeta
-- Signature: double lbeta(double a, double b)
function callTests.test_lbeta()
    local a = 0.5
    local b = 0.5
    tester:assert(cephes.lbeta(a, b))
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
    tester:asserteq(cephes.fac(0), 1)
    tester:asserteq(cephes.fac(1), 1)
    tester:asserteq(cephes.fac(3), 6)

    -- Check against values from matlab
    tester:assertalmosteq(cephes.fac(31), 8.222838654177922e+33, 1e-14)
end

-- Test simple calls for fresnl
-- Signature: int fresnl(double xxa, double * ssa, double * cca)
function callTests.test_fresnl()
    local xxa = 0.5
    local ssa = ffi.new("double[1]", {0})
    local cca = ffi.new("double[1]", {0})
    tester:assert(cephes.fresnl(xxa, ssa, cca))
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
    local y = ffi.new("double[2]", {0, 1})
    local x = ffi.new("double[2]", {0, 1})
    local n = 1
    tester:asserteq(cephes.revers(y, x, n), nil)
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
    local si = ffi.new("double[1]", {0})
    local ci = ffi.new("double[1]", {0})
    tester:assert(cephes.shichi(x, si, ci))
end

-- Test simple calls for sici
-- Signature: int sici(double x, double * si, double * ci)
function callTests.test_sici()
    local x = 0.5
    local si = ffi.new("double[1]", {0})
    local ci = ffi.new("double[1]", {0})
    tester:assert(cephes.sici(x, si, ci))
end

-- Test simple calls for simpsn
-- Signature: double simpsn(double f[], double delta)
function callTests.test_simpsn()
    local f = ffi.new("double[8]", {0, 0, 0, 0, 0, 0, 0, 0})
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
    local x = 1.5
    local q = 0.5
    tester:assert(cephes.zeta(x, q))
end

-- Test simple calls for zetac
-- Signature: double zetac(double x)
function callTests.test_zetac()
    local x = 0.5
    tester:assert(cephes.zetac(x))
end

function callTests.test_polygamma()
    local m = 1
    local x = 0.5
    tester:assert(cephes.polygamma(m, x))

    -- Check against values from matlab
    tester:assertalmosteq(cephes.polygamma(1, 0.5), 4.934802200544679, 1e-14)
    tester:assertalmosteq(cephes.polygamma(3, 0.7), 25.879149678427737, 1e-14)

    tester:assertalmosteq(cephes.polygamma(0, 0.7), cephes.psi(0.7), 1e-14)
end

function callTests.test_betagrad()
    local x = 0.5
    local y = 0.5
    tester:assert(cephes.betagrad(x, y))

    local fdBetagrad = function(x, y)
        local a = x - 1e-10
        local b = x + 1e-10
        assert(a ~= x)

        return (cephes.beta(b, y) - cephes.beta(a, y)) / (b - a)
    end

    tester:assertalmosteq(fdBetagrad(0.5, 0.5), cephes.betagrad(0.5, 0.5), 1e-5)
    tester:assertalmosteq(fdBetagrad(60, 50), cephes.betagrad(60, 50), 1e-5)
end

function callTests.test_lmvgam()
    local x = 2.5
    local p = 10
    tester:assert(cephes.lmvgam(x,p))
end

function callTests.test_mvgam()
    local x = 2.5
    local p = 10
    tester:assert(cephes.mvgam(x,p))
end

tester:add(callTests)
return tester:run()
