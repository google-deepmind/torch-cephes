
require 'cephes'
require 'totem'
local ffi = require 'ffi'
local callTests = {}
local tester = totem.Tester()


-- Test simple calls for bdtrc
-- Signature: double bdtrc(int k, int n, double p)
function callTests.test_bdtrc()
    local k = 1
    local n = 1
    local p = 0.5
    tester:assert(cephes.bdtrc(k, n, p))
end

-- Test simple calls for bdtr
-- Signature: double bdtr(int k, int n, double p)
function callTests.test_bdtr()
    local k = 1
    local n = 1
    local p = 0.5
    tester:assert(cephes.bdtr(k, n, p))
end

-- Test simple calls for bdtri
-- Signature: double bdtri(int k, int n, double y)
function callTests.test_bdtri()
    local k = 1
    local n = 2
    local y = 0.5
    tester:assert(cephes.bdtri(k, n, y))
end

-- Test simple calls for btdtr
-- Signature: double btdtr(double a, double b, double x)
function callTests.test_btdtr()
    local a = 0.5
    local b = 0.5
    local x = 0.5
    tester:assert(cephes.btdtr(a, b, x))
end

-- Test simple calls for chdtrc
-- Signature: double chdtrc(double df, double x)
function callTests.test_chdtrc()
    local df = 2
    local x = 0.5
    tester:assert(cephes.chdtrc(df, x))
end

-- Test simple calls for chdtr
-- Signature: double chdtr(double df, double x)
function callTests.test_chdtr()
    local df = 2
    local x = 0.5
    tester:assert(cephes.chdtr(df, x))
end

-- Test simple calls for chdtri
-- Signature: double chdtri(double df, double y)
function callTests.test_chdtri()
    local df = 2
    local y = 0.5
    tester:assert(cephes.chdtri(df, y))
end

-- Test simple calls for expx2
-- Signature: double expx2(double x, int sign)
function callTests.test_expx2()
    local x = 0.5
    local sign = 1
    tester:assert(cephes.expx2(x, sign))
end

-- Test simple calls for fdtrc
-- Signature: double fdtrc(int ia, int ib, double x)
function callTests.test_fdtrc()
    local ia = 1
    local ib = 1
    local x = 0.5
    tester:assert(cephes.fdtrc(ia, ib, x))
end

-- Test simple calls for fdtr
-- Signature: double fdtr(int ia, int ib, double x)
function callTests.test_fdtr()
    local ia = 1
    local ib = 1
    local x = 0.5
    tester:assert(cephes.fdtr(ia, ib, x))
end

-- Test simple calls for fdtri
-- Signature: double fdtri(int ia, int ib, double y)
function callTests.test_fdtri()
    local ia = 1
    local ib = 1
    local y = 0.5
    tester:assert(cephes.fdtri(ia, ib, y))
end

-- Test simple calls for gamma
-- Signature: double gamma(double x)
function callTests.test_gamma()
    local x = 0.5
    tester:assert(cephes.gamma(x))
    local errorLevel = cephes.getErrorLevel()

    cephes.setErrorLevel('error')
    tester:assertErrorPattern(function() cephes.gamma(-3) end, ".*domain error.*")
    tester:assertErrorPattern(function() cephes.gamma(-4) end, ".*domain error.*")
    tester:assertErrorPattern(function() cephes.gamma(0) end, ".*domain error.*")
    cephes.setErrorLevel(errorLevel)

    tester:assert(cephes.isnan(cephes.gamma(-math.huge)))
    tester:asserteq(cephes.gamma(math.huge), math.huge)
end

-- Test simple calls for lgam
-- Signature: double lgam(double x)
function callTests.test_lgam()
    local x = 0.5
    tester:assert(cephes.lgam(x))
    tester:assert(cephes.isinf(cephes.lgam(-math.huge)))
    tester:asserteq(cephes.lgam(math.huge), math.huge)
    local errorLevel = cephes.getErrorLevel()
    cephes.setErrorLevel('error')
    tester:assertErrorPattern(function() cephes.lgam(0) end, ".*singularity error.*")
    tester:assertErrorPattern(function() cephes.lgam(-1) end, ".*singularity error.*")
    cephes.setErrorLevel(errorLevel)
end

-- Test simple calls for gdtr
-- Signature: double gdtr(double a, double b, double x)
function callTests.test_gdtr()
    local a = 0.5
    local b = 0.5
    local x = 0.5
    tester:assert(cephes.gdtr(a, b, x))
end

-- Test simple calls for gdtrc
-- Signature: double gdtrc(double a, double b, double x)
function callTests.test_gdtrc()
    local a = 0.5
    local b = 0.5
    local x = 0.5
    tester:assert(cephes.gdtrc(a, b, x))
end

-- Test simple calls for igamc
-- Signature: double igamc(double a, double x)
function callTests.test_igamc()
    local a = 0.5
    local x = 0.5
    tester:assert(cephes.igamc(a, x))
end

-- Test simple calls for igam
-- Signature: double igam(double a, double x)
function callTests.test_igam()
    local a = 0.5
    local x = 0.5
    tester:assert(cephes.igam(a, x))

    tester:asserteq(cephes.igam(a, 0), 0)

    -- Check against values from matlab
    tester:assertalmosteq(cephes.igam(1.5, 0.5), 1.987480430987991e-01, 1e-14)
    tester:assertalmosteq(cephes.igam(2.5, 0.3), 1.199675720590626e-02, 1e-14)
    tester:assertalmosteq(cephes.igam(10, 1), 1.114254783387200e-07, 1e-14)
end

-- Test simple calls for igami
-- Signature: double igami(double a, double y0)
function callTests.test_igami()
    local a = 0.5
    local y0 = 0.5
    tester:assert(cephes.igami(a, y0))
end

-- Test simple calls for incbet
-- Signature: double incbet(double aa, double bb, double xx)
function callTests.test_incbet()
    local aa = 0.5
    local bb = 0.5
    local xx = 0.5
    tester:assert(cephes.incbet(aa, bb, xx))
end

-- Test simple calls for incbi
-- Signature: double incbi(double aa, double bb, double yy0)
function callTests.test_incbi()
    local aa = 0.5
    local bb = 0.5
    local yy0 = 0.5
    tester:assert(cephes.incbi(aa, bb, yy0))
end

-- Test simple calls for nbdtrc
-- Signature: double nbdtrc(int k, int n, double p)
function callTests.test_nbdtrc()
    local k = 1
    local n = 1
    local p = 0.5
    tester:assert(cephes.nbdtrc(k, n, p))
end

-- Test simple calls for nbdtr
-- Signature: double nbdtr(int k, int n, double p)
function callTests.test_nbdtr()
    local k = 1
    local n = 1
    local p = 0.5
    tester:assert(cephes.nbdtr(k, n, p))
end

-- Test simple calls for nbdtri
-- Signature: double nbdtri(int k, int n, double p)
function callTests.test_nbdtri()
    local k = 1
    local n = 1
    local p = 0.5
    tester:assert(cephes.nbdtri(k, n, p))
end

-- Test simple calls for ndtr
-- Signature: double ndtr(double a)
function callTests.test_ndtr()
    local a = 0.5
    tester:assert(cephes.ndtr(a))
end

-- Test simple calls for erfc
-- Signature: double erfc(double a)
function callTests.test_erfc()
    local a = 0.5
    tester:assert(cephes.erfc(a))
end

-- Test simple calls for erf
-- Signature: double erf(double x)
function callTests.test_erf()
    local x = 0.5
    tester:assert(cephes.erf(x))
end

-- Test simple calls for ndtri
-- Signature: double ndtri(double y0)
function callTests.test_ndtri()
    local y0 = 0.5
    tester:assert(cephes.ndtri(y0))
end

-- Test simple calls for pdtrc
-- Signature: double pdtrc(int k, double m)
function callTests.test_pdtrc()
    local k = 1
    local m = 0.5
    tester:assert(cephes.pdtrc(k, m))
end

-- Test simple calls for pdtr
-- Signature: double pdtr(int k, double m)
function callTests.test_pdtr()
    local k = 1
    local m = 0.5
    tester:assert(cephes.pdtr(k, m))
end

-- Test simple calls for pdtri
-- Signature: double pdtri(int k, double y)
function callTests.test_pdtri()
    local k = 1
    local y = 0.5
    tester:assert(cephes.pdtri(k, y))
end

-- Test simple calls for stdtr
-- Signature: double stdtr(int k, double t)
function callTests.test_stdtr()
    local k = 1
    local t = 0.5
    tester:assert(cephes.stdtr(k, t))
end

-- Test simple calls for stdtri
-- Signature: double stdtri(int k, double p)
function callTests.test_stdtri()
    local k = 1
    local p = 0.5
    tester:assert(cephes.stdtri(k, p))
end

tester:add(callTests)
return tester:run()
