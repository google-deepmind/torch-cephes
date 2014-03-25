
require 'cephes'
require 'totem'
local ffi = require 'ffi'
local callTests = {}
local tester = totem.Tester()


-- Test simple calls for acosh
-- Signature: double acosh(double x)
function callTests.test_acosh()
    local x = 2.0
    tester:assert(cephes.acosh(x))
end

-- Test simple calls for asin
-- Signature: double asin(double x)
function callTests.test_asin()
    local x = 0.5
    tester:assert(cephes.asin(x))
end

-- Test simple calls for acos
-- Signature: double acos(double x)
function callTests.test_acos()
    local x = 0.5
    tester:assert(cephes.acos(x))
end

-- Test simple calls for asinh
-- Signature: double asinh(double xx)
function callTests.test_asinh()
    local xx = 0.5
    tester:assert(cephes.asinh(xx))
end

-- Test simple calls for atan
-- Signature: double atan(double x)
function callTests.test_atan()
    local x = 0.5
    tester:assert(cephes.atan(x))
end

-- Test simple calls for atan2
-- Signature: double atan2(double y, double x)
function callTests.test_atan2()
    local y = 0.5
    local x = 0.5
    tester:assert(cephes.atan2(y, x))
end

-- Test simple calls for atanh
-- Signature: double atanh(double x)
function callTests.test_atanh()
    local x = 0.5
    tester:assert(cephes.atanh(x))
end

-- Test simple calls for cbrt
-- Signature: double cbrt(double x)
function callTests.test_cbrt()
    local x = 0.5
    tester:assert(cephes.cbrt(x))
end

-- Test simple calls for chbevl
-- Signature: double chbevl(double x, double array[], int n)
function callTests.test_chbevl()
    local x = 0.5
    local array = ffi.new("double[2]", {0, 0})
    local n = 2
    tester:assert(cephes.chbevl(x, array, n))
end

-- Test simple calls for clog
-- Signature: void clog(cmplx * z, cmplx * w)
function callTests.test_clog()
    local z = cephes.new_cmplx(1, 1)
    local w = cephes.new_cmplx(1, 1)
    tester:asserteq(cephes.clog(z, w), nil)
end

-- Test simple calls for cexp
-- Signature: void cexp(cmplx * z, cmplx * w)
function callTests.test_cexp()
    local z = cephes.new_cmplx(1, 1)
    local w = cephes.new_cmplx(1, 1)
    tester:asserteq(cephes.cexp(z, w), nil)
end

-- Test simple calls for csin
-- Signature: void csin(cmplx * z, cmplx * w)
function callTests.test_csin()
    local z = cephes.new_cmplx(1, 1)
    local w = cephes.new_cmplx(1, 1)
    tester:asserteq(cephes.csin(z, w), nil)
end

-- Test simple calls for ccos
-- Signature: void ccos(cmplx * z, cmplx * w)
function callTests.test_ccos()
    local z = cephes.new_cmplx(1, 1)
    local w = cephes.new_cmplx(1, 1)
    tester:asserteq(cephes.ccos(z, w), nil)
end

-- Test simple calls for ctan
-- Signature: void ctan(cmplx * z, cmplx * w)
function callTests.test_ctan()
    local z = cephes.new_cmplx(1, 1)
    local w = cephes.new_cmplx(1, 1)
    tester:asserteq(cephes.ctan(z, w), nil)
end

-- Test simple calls for ccot
-- Signature: void ccot(cmplx * z, cmplx * w)
function callTests.test_ccot()
    local z = cephes.new_cmplx(1, 1)
    local w = cephes.new_cmplx(1, 1)
    tester:asserteq(cephes.ccot(z, w), nil)
end

-- Test simple calls for casin
-- Signature: void casin(cmplx * z, cmplx * w)
function callTests.test_casin()
    local z = cephes.new_cmplx(1, 1)
    local w = cephes.new_cmplx(1, 1)
    tester:asserteq(cephes.casin(z, w), nil)
end

-- Test simple calls for cacos
-- Signature: void cacos(cmplx * z, cmplx * w)
function callTests.test_cacos()
    local z = cephes.new_cmplx(1, 1)
    local w = cephes.new_cmplx(1, 1)
    tester:asserteq(cephes.cacos(z, w), nil)
end

-- Test simple calls for catan
-- Signature: void catan(cmplx * z, cmplx * w)
function callTests.test_catan()
    local z = cephes.new_cmplx(1, 1)
    local w = cephes.new_cmplx(1, 1)
    tester:asserteq(cephes.catan(z, w), nil)
end

-- Test simple calls for cadd
-- Signature: void cadd(cmplx * a, cmplx * b, cmplx * c)
function callTests.test_cadd()
    local a = cephes.new_cmplx(1, 1)
    local b = cephes.new_cmplx(1, 1)
    local c = cephes.new_cmplx(1, 1)
    tester:asserteq(cephes.cadd(a, b, c), nil)
end

-- Test simple calls for csub
-- Signature: void csub(cmplx * a, cmplx * b, cmplx * c)
function callTests.test_csub()
    local a = cephes.new_cmplx(1, 1)
    local b = cephes.new_cmplx(1, 1)
    local c = cephes.new_cmplx(1, 1)
    tester:asserteq(cephes.csub(a, b, c), nil)
end

-- Test simple calls for cmul
-- Signature: void cmul(cmplx * a, cmplx * b, cmplx * c)
function callTests.test_cmul()
    local a = cephes.new_cmplx(1, 1)
    local b = cephes.new_cmplx(1, 1)
    local c = cephes.new_cmplx(1, 1)
    tester:asserteq(cephes.cmul(a, b, c), nil)
end

-- Test simple calls for cdiv
-- Signature: void cdiv(cmplx * a, cmplx * b, cmplx * c)
function callTests.test_cdiv()
    local a = cephes.new_cmplx(1, 1)
    local b = cephes.new_cmplx(1, 1)
    local c = cephes.new_cmplx(1, 1)
    tester:asserteq(cephes.cdiv(a, b, c), nil)
end

-- Test simple calls for cmov
-- Signature: void cmov(void * a, void * b)
function callTests.test_cmov()
    local a = cephes.new_cmplx(1, 1)
    local b = cephes.new_cmplx(1, 1)
    tester:asserteq(cephes.cmov(a, b), nil)
end

-- Test simple calls for cneg
-- Signature: void cneg(cmplx * a)
function callTests.test_cneg()
    local a = cephes.new_cmplx(1, 1)
    tester:asserteq(cephes.cneg(a), nil)
    tester:asserteq(a.i, -1)
    tester:asserteq(a.r, -1)
end

-- Test simple calls for cabs
-- Signature: double cabs(cmplx * z)
function callTests.test_cabs()
    local z = cephes.new_cmplx(1, 1)
    tester:assert(cephes.cabs(z))
end

-- Test simple calls for csqrt
-- Signature: void csqrt(cmplx * z, cmplx * w)
function callTests.test_csqrt()
    local z = cephes.new_cmplx(1, 1)
    local w = cephes.new_cmplx(1, 1)
    tester:asserteq(cephes.csqrt(z, w), nil)
end

-- Test simple calls for hypot
-- Signature: double hypot(double x, double y)
function callTests.test_hypot()
    local x = 0.5
    local y = 0.5
    tester:assert(cephes.hypot(x, y))
end

-- Test simple calls for cosh
-- Signature: double cosh(double x)
function callTests.test_cosh()
    local x = 0.5
    tester:assert(cephes.cosh(x))
end

-- Test simple calls for drand
-- Signature: int drand(double * a)
function callTests.test_drand()
    local a = ffi.new("double[1]", {0})
    tester:assert(cephes.drand(a))
end

-- Test simple calls for exp
-- Signature: double exp(double x)
function callTests.test_exp()
    local x = 0.5
    tester:assert(cephes.exp(x))
end

-- Test simple calls for exp10
-- Signature: double exp10(double x)
function callTests.test_exp10()
    local x = 0.5
    tester:assert(cephes.exp10(x))
end

-- Test simple calls for exp2
-- Signature: double exp2(double x)
function callTests.test_exp2()
    local x = 0.5
    tester:assert(cephes.exp2(x))
end

-- Test simple calls for fabs
-- Signature: double fabs(double x)
function callTests.test_fabs()
    local x = 0.5
    tester:assert(cephes.fabs(x))
end

-- Test simple calls for ceil
-- Signature: double ceil(double x)
function callTests.test_ceil()
    local x = 0.5
    tester:assert(cephes.ceil(x))
end

-- Test simple calls for floor
-- Signature: double floor(double x)
function callTests.test_floor()
    local x = 0.5
    tester:assert(cephes.floor(x))
end

-- Test simple calls for frexp
-- Signature: double frexp(double x, int * pw2)
function callTests.test_frexp()
    local x = 0.5
    local pw2 = ffi.new("int[1]", {0})
    tester:assert(cephes.frexp(x, pw2))
end

-- Test simple calls for ldexp
-- Signature: double ldexp(double x, int pw2)
function callTests.test_ldexp()
    local x = 0.5
    local pw2 = 1
    tester:assert(cephes.ldexp(x, pw2))
end

-- Test simple calls for signbit
-- Signature: int signbit(double x)
function callTests.test_signbit()
    local x = 0.5
    tester:assert(cephes.signbit(x))
end

-- Test simple calls for log
-- Signature: double log(double x)
function callTests.test_log()
    local x = 0.5
    tester:assert(cephes.log(x))
end

-- Test simple calls for log10
-- Signature: double log10(double x)
function callTests.test_log10()
    local x = 0.5
    tester:assert(cephes.log10(x))
end

-- Test simple calls for log2
-- Signature: double log2(double x)
function callTests.test_log2()
    local x = 0.5
    tester:assert(cephes.log2(x))
end

-- Test simple calls for polevl
-- Signature: double polevl(double x, double coef[], int N)
function callTests.test_polevl()
    local x = 0.5
    local coef = ffi.new("double[2]", {0, 0})
    local N = 1
    tester:assert(cephes.polevl(x, coef, N))
end

-- Test simple calls for p1evl
-- Signature: double p1evl(double x, double coef[], int N)
function callTests.test_p1evl()
    local x = 0.5
    local coef = ffi.new("double[3]", {0, 0, 0})
    local N = 2
    tester:assert(cephes.p1evl(x, coef, N))
end

-- Test simple calls for pow
-- Signature: double pow(double x, double y)
function callTests.test_pow()
    local x = 0.5
    local y = 0.5
    tester:assert(cephes.pow(x, y))
end

-- Test simple calls for powi
-- Signature: double powi(double x, int nn)
function callTests.test_powi()
    local x = 0.5
    local nn = 1
    tester:assert(cephes.powi(x, nn))
end

-- Test simple calls for round
-- Signature: double round(double x)
function callTests.test_round()
    local x = 0.5
    tester:assert(cephes.round(x))
end

-- Test simple calls for sin
-- Signature: double sin(double x)
function callTests.test_sin()
    local x = 0.5
    tester:assert(cephes.sin(x))
end

-- Test simple calls for cos
-- Signature: double cos(double x)
function callTests.test_cos()
    local x = 0.5
    tester:assert(cephes.cos(x))
end

-- Test simple calls for radian
-- Signature: double radian(double d, double m, double s)
function callTests.test_radian()
    local d = 0.5
    local m = 0.5
    local s = 0.5
    tester:assert(cephes.radian(d, m, s))
end

-- Test simple calls for sincos
-- Signature: int sincos(double x, double * s, double * c, int flg)
function callTests.test_sincos()
    local x = 0.5
    local s = ffi.new("double[1]", {0})
    local c = ffi.new("double[1]", {0})
    local flg = 1
    tester:assert(cephes.sincos(x, s, c, flg))
end

-- Test simple calls for sindg
-- Signature: double sindg(double x)
function callTests.test_sindg()
    local x = 0.5
    tester:assert(cephes.sindg(x))
end

-- Test simple calls for cosdg
-- Signature: double cosdg(double x)
function callTests.test_cosdg()
    local x = 0.5
    tester:assert(cephes.cosdg(x))
end

-- Test simple calls for sinh
-- Signature: double sinh(double x)
function callTests.test_sinh()
    local x = 0.5
    tester:assert(cephes.sinh(x))
end

-- Test simple calls for sqrt
-- Signature: double sqrt(double x)
function callTests.test_sqrt()
    local x = 0.5
    tester:assert(cephes.sqrt(x))
end

-- Test simple calls for tan
-- Signature: double tan(double x)
function callTests.test_tan()
    local x = 0.5
    tester:assert(cephes.tan(x))
end

-- Test simple calls for cot
-- Signature: double cot(double x)
function callTests.test_cot()
    local x = 0.5
    tester:assert(cephes.cot(x))
end

-- Test simple calls for tandg
-- Signature: double tandg(double x)
function callTests.test_tandg()
    local x = 0.5
    tester:assert(cephes.tandg(x))
end

-- Test simple calls for cotdg
-- Signature: double cotdg(double x)
function callTests.test_cotdg()
    local x = 0.5
    tester:assert(cephes.cotdg(x))
end

-- Test simple calls for tanh
-- Signature: double tanh(double x)
function callTests.test_tanh()
    local x = 0.5
    tester:assert(cephes.tanh(x))
end

-- Test simple calls for log1p
-- Signature: double log1p(double x)
function callTests.test_log1p()
    local x = 0.5
    tester:assert(cephes.log1p(x))
end

-- Test simple calls for expm1
-- Signature: double expm1(double x)
function callTests.test_expm1()
    local x = 0.5
    tester:assert(cephes.expm1(x))
end

-- Test simple calls for cosm1
-- Signature: double cosm1(double x)
function callTests.test_cosm1()
    local x = 0.5
    tester:assert(cephes.cosm1(x))
end

tester:add(callTests)
return tester:run()
