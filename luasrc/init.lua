local ffi = require("ffi")
require 'torch'

cephes = {}
cephes.ffi = ffi.load(package.searchpath('libcephes', package.cpath))

-- Define cmplx struct
ffi.cdef[[
typedef struct
	{
	double r;
	double i;
	}cmplx;
]]

-- imports for folder bessel
ffi.cdef[[
   // cephes/bessel/airy.c
   int airy(double x, double * ai, double * aip, double * bi, double * bip);
   // cephes/bessel/hyp2f1.c
   double hyp2f1(double a, double b, double c, double x);
   // cephes/bessel/hyperg.c
   double hyperg(double a, double b, double x);
   double hyp2f0(double a, double b, double x, int type, double * err);
   // cephes/bessel/i0.c
   double i0(double x);
   double i0e(double x);
   // cephes/bessel/i1.c
   double i1(double x);
   double i1e(double x);
   // cephes/bessel/iv.c
   double iv(double v, double x);
   // cephes/bessel/j0.c
   double j0(double x);
   double y0(double x);
   // cephes/bessel/j1.c
   double j1(double x);
   double y1(double x);
   // cephes/bessel/jn.c
   double jn(int n, double x);
   // cephes/bessel/jv.c
   double jv(double n, double x);
   // cephes/bessel/k0.c
   double k0(double x);
   double k0e(double x);
   // cephes/bessel/k1.c
   double k1(double x);
   double k1e(double x);
   // cephes/bessel/kn.c
   double kn(int nn, double x);
   // cephes/bessel/psi.c
   double psi(double x);
   // cephes/bessel/struve.c
   double onef2(double a, double b, double c, double x, double * err);
   double threef0(double a, double b, double c, double x, double * err);
   double struve(double v, double x);
   // cephes/bessel/yn.c
   double yn(int n, double x);
]]

-- imports for folder cmath
ffi.cdef[[
   // cephes/cmath/acosh.c
   double acosh(double x);
   // cephes/cmath/asin.c
   double asin(double x);
   double acos(double x);
   // cephes/cmath/asinh.c
   double asinh(double xx);
   // cephes/cmath/atan.c
   double atan(double x);
   double atan2(double y, double x);
   // cephes/cmath/atanh.c
   double atanh(double x);
   // cephes/cmath/cbrt.c
   double cbrt(double x);
   // cephes/cmath/chbevl.c
   double chbevl(double x, double array[], int n);
   // cephes/cmath/clog.c
   void clog(cmplx * z, cmplx * w);
   void cexp(cmplx * z, cmplx * w);
   void csin(cmplx * z, cmplx * w);
   void ccos(cmplx * z, cmplx * w);
   void ctan(cmplx * z, cmplx * w);
   void ccot(cmplx * z, cmplx * w);
   void casin(cmplx * z, cmplx * w);
   void cacos(cmplx * z, cmplx * w);
   void catan(cmplx * z, cmplx * w);
   // cephes/cmath/cmplx.c
   void cadd(cmplx * a, cmplx * b, cmplx * c);
   void csub(cmplx * a, cmplx * b, cmplx * c);
   void cmul(cmplx * a, cmplx * b, cmplx * c);
   void cdiv(cmplx * a, cmplx * b, cmplx * c);
   void cmov(void * a, void * b);
   void cneg(cmplx * a);
   double cabs(cmplx * z);
   void csqrt(cmplx * z, cmplx * w);
   double hypot(double x, double y);
   // cephes/cmath/cosh.c
   double cosh(double x);
   // cephes/cmath/drand.c
   int drand(double * a);
   // cephes/cmath/exp.c
   double exp(double x);
   // cephes/cmath/exp10.c
   double exp10(double x);
   // cephes/cmath/exp2.c
   double exp2(double x);
   // cephes/cmath/fabs.c
   double fabs(double x);
   // cephes/cmath/floor.c
   double ceil(double x);
   double floor(double x);
   double frexp(double x, int * pw2);
   double ldexp(double x, int pw2);
   // cephes/cmath/isnan.c
   int signbit(double x);
   // cephes/cmath/log.c
   double log(double x);
   // cephes/cmath/log10.c
   double log10(double x);
   // cephes/cmath/log2.c
   double log2(double x);
   // cephes/cmath/polevl.c
   double polevl(double x, double coef[], int N);
   double p1evl(double x, double coef[], int N);
   // cephes/cmath/pow.c
   double pow(double x, double y);
   // cephes/cmath/powi.c
   double powi(double x, int nn);
   // cephes/cmath/round.c
   double round(double x);
   // cephes/cmath/sin.c
   double sin(double x);
   double cos(double x);
   double radian(double d, double m, double s);
   // cephes/cmath/sincos.c
   int sincos(double x, double * s, double * c, int flg);
   // cephes/cmath/sindg.c
   double sindg(double x);
   double cosdg(double x);
   // cephes/cmath/sinh.c
   double sinh(double x);
   // cephes/cmath/sqrt.c
   double sqrt(double x);
   // cephes/cmath/tan.c
   double tan(double x);
   double cot(double x);
   // cephes/cmath/tandg.c
   double tandg(double x);
   double cotdg(double x);
   // cephes/cmath/tanh.c
   double tanh(double x);
   // cephes/cmath/unity.c
   double log1p(double x);
   double expm1(double x);
   double cosm1(double x);
]]

-- imports for folder cprob
ffi.cdef[[
   // cephes/cprob/bdtr.c
   double bdtrc(int k, int n, double p);
   double bdtr(int k, int n, double p);
   double bdtri(int k, int n, double y);
   // cephes/cprob/btdtr.c
   double btdtr(double a, double b, double x);
   // cephes/cprob/chdtr.c
   double chdtrc(double df, double x);
   double chdtr(double df, double x);
   double chdtri(double df, double y);
   // cephes/cprob/expx2.c
   double expx2(double x, int sign);
   // cephes/cprob/fdtr.c
   double fdtrc(int ia, int ib, double x);
   double fdtr(int ia, int ib, double x);
   double fdtri(int ia, int ib, double y);
   // cephes/cprob/gamma.c
   double gamma(double x);
   int sgngam;
   double lgam(double x);
   // cephes/cprob/gdtr.c
   double gdtr(double a, double b, double x);
   double gdtrc(double a, double b, double x);
   // cephes/cprob/igam.c
   double igamc(double a, double x);
   double igam(double a, double x);
   // cephes/cprob/igami.c
   double igami(double a, double y0);
   // cephes/cprob/incbet.c
   double incbet(double aa, double bb, double xx);
   // cephes/cprob/incbi.c
   double incbi(double aa, double bb, double yy0);
   // cephes/cprob/nbdtr.c
   double nbdtrc(int k, int n, double p);
   double nbdtr(int k, int n, double p);
   double nbdtri(int k, int n, double p);
   // cephes/cprob/ndtr.c
   double ndtr(double a);
   double erfc(double a);
   double erf(double x);
   // cephes/cprob/ndtri.c
   double ndtri(double y0);
   // cephes/cprob/pdtr.c
   double pdtrc(int k, double m);
   double pdtr(int k, double m);
   double pdtri(int k, double y);
   // cephes/cprob/stdtr.c
   double stdtr(int k, double t);
   double stdtri(int k, double p);
]]

-- imports for folder misc
ffi.cdef[[
   // cephes/misc/beta.c
   double beta(double a, double b);
   double lbeta(double a, double b);
   // cephes/misc/dawsn.c
   double dawsn(double xx);
   // cephes/misc/ei.c
   double ei(double x);
   // cephes/misc/expn.c
   double expn(int n, double x);
   // cephes/misc/fac.c
   double fac(int i);
   // cephes/misc/fresnl.c
   int fresnl(double xxa, double * ssa, double * cca);
   // cephes/misc/psi.c
   double psi(double x);
   // cephes/misc/revers.c
   void revers(double y[], double x[], int n);
   // cephes/misc/rgamma.c
   double rgamma(double x);
   // cephes/misc/shichi.c
   int shichi(double x, double * si, double * ci);
   // cephes/misc/sici.c
   int sici(double x, double * si, double * ci);
   // cephes/misc/simpsn.c
   double simpsn(double f[], double delta);
   // cephes/misc/spence.c
   double spence(double x);
   // cephes/misc/zeta.c
   double zeta(double x, double q);
   // cephes/misc/zetac.c
   double zetac(double x);
]]

-- imports for folder ellf
ffi.cdef[[
   // cephes/ellf/ellie.c
   double ellie(double phi, double m);
   // cephes/ellf/ellik.c
   double ellik(double phi, double m);
   // cephes/ellf/ellpe.c
   double ellpe(double x);
   // cephes/ellf/ellpj.c
   int ellpj(double u, double m, double * sn, double * cn, double * dn, double * ph);
   // cephes/ellf/ellpk.c
   double ellpk(double x);
]]

-- imports for folder polyn
ffi.cdef[[
   // cephes/polyn/euclid.c
   double euclid(double * num, double * den);
   // cephes/polyn/polrt.c
   int polrt(double xcof[], double cof[], int m, cmplx root[]);
   // cephes/polyn/polyn.c
   void polini(int maxdeg);
   void polprt(double a[], int na, int d);
   void polclr(double * a, int n);
   void polmov(double * a, int na, double * b);
   void polmul(double a[], int na, double b[], int nb, double c[]);
   void poladd(double a[], int na, double b[], int nb, double c[]);
   void polsub(double a[], int na, double b[], int nb, double c[]);
   int poldiv(double a[], int na, double b[], int nb, double c[]);
   void polsbt(double a[], int na, double b[], int nb, double c[]);
   double poleva(double a[], int na, double x);
   // cephes/polyn/polyr.c: disabled to avoid naming clash with regular polynomials
   // cephes/polyn/revers.c
   void revers(double y[], double x[], int n);
]]

-- For those few exceptions that escaped our automatic parser
ffi.cdef[[
    // Escaped due to return type on a line per itself
    // cephes/cmath/clog.c
    void csinh(cmplx *z, cmplx *w);
    void casinh(cmplx *z, cmplx *w);
    void ccosh(cmplx *z, cmplx *w);
    void cacosh(cmplx *z, cmplx *w);
    void ctanh(cmplx *z, cmplx *w);
    void catanh(cmplx *z, cmplx *w);
    void cpow(cmplx *a, cmplx *z, cmplx *w);
    // cephes/cprob/kolmogorov.c
    double kolmogi(double p);
    double kolmogorov(double y);
    double smirnov(int n, double e);
    double smirnovi(int n, double e);
    // cephes/polyn/polmisc.c
    void polatn(double num[], double den[], double ans[], int nn);
    void polsqt(double pol[], double ans[], int nn);
    void polsin(double x[], double y[], int nn);
    void polcos(double x[], double y[], int nn);
    // cephes/misc/polylog.c
    double polylog(int n, double x);
]]

-- Error handling with soft wrapping of all functions
torch.include('cephes', 'error_handling.lua')
torch.include('cephes', 'limits.lua')
torch.include('cephes', 'cmath.lua')
torch.include('cephes', 'bessel.lua')
torch.include('cephes', 'misc.lua')

-- Use metatable to pass all undefined indexing to cephes.ffi
local mt = {}
setmetatable(cephes, mt)
mt.__index = function(table, key)
    return rawget(cephes, key) or cephes.ffi[key]
end

return cephes

