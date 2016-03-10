local ffi = require("ffi")
require 'torch'

cephes = {}
cephes._ffi = ffi.load(package.searchpath('libcephes', package.cpath))
cephes.ffi = {}
setmetatable(cephes.ffi, {__index = function(t, key)
                              return cephes._ffi['torch_cephes_' .. key]
                            end,
                          __newindex = function(t, key, value)
                              cephes._ffi[key] = value
                         end})

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
   int torch_cephes_airy(double x, double * ai, double * aip,
                         double * bi, double * bip);
   // cephes/bessel/hyp2f1.c
   double torch_cephes_hyp2f1(double a, double b, double c, double x);
   // cephes/bessel/hyperg.c
   double torch_cephes_hyperg(double a, double b, double x);
   double torch_cephes_hyp2f0(double a, double b, double x,
                              int type, double * err);
   // cephes/bessel/i0.c
   double torch_cephes_i0(double x);
   double torch_cephes_i0e(double x);
   // cephes/bessel/i1.c
   double torch_cephes_i1(double x);
   double torch_cephes_i1e(double x);
   // cephes/bessel/iv.c
   double torch_cephes_iv(double v, double x);
   // cephes/bessel/j0.c
   double torch_cephes_j0(double x);
   double torch_cephes_y0(double x);
   // cephes/bessel/j1.c
   double torch_cephes_j1(double x);
   double torch_cephes_y1(double x);
   // cephes/bessel/jn.c
   double torch_cephes_jn(int n, double x);
   // cephes/bessel/jv.c
   double torch_cephes_jv(double n, double x);
   // cephes/bessel/k0.c
   double torch_cephes_k0(double x);
   double torch_cephes_k0e(double x);
   // cephes/bessel/k1.c
   double torch_cephes_k1(double x);
   double torch_cephes_k1e(double x);
   // cephes/bessel/kn.c
   double torch_cephes_kn(int nn, double x);
   // cephes/bessel/psi.c
   double torch_cephes_psi(double x);
   // cephes/bessel/struve.c
   double torch_cephes_onef2(double a, double b, double c, double x,
                             double * err);
   double torch_cephes_threef0(double a, double b, double c,
                               double x, double * err);
   double torch_cephes_struve(double v, double x);
   // cephes/bessel/yn.c
   double torch_cephes_yn(int n, double x);
]]

-- imports for folder cmath
ffi.cdef[[
   // cephes/cmath/acosh.c
   double torch_cephes_acosh(double x);
   // cephes/cmath/asin.c
   double torch_cephes_asin(double x);
   double torch_cephes_acos(double x);
   // cephes/cmath/asinh.c
   double torch_cephes_asinh(double xx);
   // cephes/cmath/atan.c
   double torch_cephes_atan(double x);
   double torch_cephes_atan2(double y, double x);
   // cephes/cmath/atanh.c
   double torch_cephes_atanh(double x);
   // cephes/cmath/cbrt.c
   double torch_cephes_cbrt(double x);
   // cephes/cmath/chbevl.c
   double torch_cephes_chbevl(double x, double array[], int n);
   // cephes/cmath/clog.c
   void torch_cephes_clog(cmplx * z, cmplx * w);
   void torch_cephes_cexp(cmplx * z, cmplx * w);
   void torch_cephes_csin(cmplx * z, cmplx * w);
   void torch_cephes_ccos(cmplx * z, cmplx * w);
   void torch_cephes_ctan(cmplx * z, cmplx * w);
   void torch_cephes_ccot(cmplx * z, cmplx * w);
   void torch_cephes_casin(cmplx * z, cmplx * w);
   void torch_cephes_cacos(cmplx * z, cmplx * w);
   void torch_cephes_catan(cmplx * z, cmplx * w);
   // cephes/cmath/cmplx.c
   void torch_cephes_cadd(cmplx * a, cmplx * b, cmplx * c);
   void torch_cephes_csub(cmplx * a, cmplx * b, cmplx * c);
   void torch_cephes_cmul(cmplx * a, cmplx * b, cmplx * c);
   void torch_cephes_cdiv(cmplx * a, cmplx * b, cmplx * c);
   void torch_cephes_cmov(void * a, void * b);
   void torch_cephes_cneg(cmplx * a);
   double torch_cephes_cabs(cmplx * z);
   void torch_cephes_csqrt(cmplx * z, cmplx * w);
   double torch_cephes_hypot(double x, double y);
   // cephes/cmath/cosh.c
   double torch_cephes_cosh(double x);
   // cephes/cmath/drand.c
   int torch_cephes_drand(double * a);
   // cephes/cmath/exp.c
   double torch_cephes_exp(double x);
   // cephes/cmath/exp10.c
   double torch_cephes_exp10(double x);
   // cephes/cmath/exp2.c
   double torch_cephes_exp2(double x);
   // cephes/cmath/fabs.c
   double torch_cephes_fabs(double x);
   // cephes/cmath/floor.c
   double torch_cephes_ceil(double x);
   double torch_cephes_floor(double x);
   double torch_cephes_frexp(double x, int * pw2);
   double torch_cephes_ldexp(double x, int pw2);
   // cephes/cmath/isnan.c
   int torch_cephes_signbit(double x);
   // cephes/cmath/log.c
   double torch_cephes_log(double x);
   // cephes/cmath/log10.c
   double torch_cephes_log10(double x);
   // cephes/cmath/log2.c
   double torch_cephes_log2(double x);
   // cephes/cmath/polevl.c
   double torch_cephes_polevl(double x, double coef[], int N);
   double torch_cephes_p1evl(double x, double coef[], int N);
   // cephes/cmath/pow.c
   double torch_cephes_pow(double x, double y);
   // cephes/cmath/powi.c
   double torch_cephes_powi(double x, int nn);
   // cephes/cmath/round.c
   double torch_cephes_round(double x);
   // cephes/cmath/sin.c
   double torch_cephes_sin(double x);
   double torch_cephes_cos(double x);
   double torch_cephes_radian(double d, double m, double s);
   // cephes/cmath/sincos.c
   int torch_cephes_sincos(double x, double * s, double * c, int flg);
   // cephes/cmath/sindg.c
   double torch_cephes_sindg(double x);
   double torch_cephes_cosdg(double x);
   // cephes/cmath/sinh.c
   double torch_cephes_sinh(double x);
   // cephes/cmath/sqrt.c
   double torch_cephes_sqrt(double x);
   // cephes/cmath/tan.c
   double torch_cephes_tan(double x);
   double torch_cephes_cot(double x);
   // cephes/cmath/tandg.c
   double torch_cephes_tandg(double x);
   double torch_cephes_cotdg(double x);
   // cephes/cmath/tanh.c
   double torch_cephes_tanh(double x);
   // cephes/cmath/unity.c
   double torch_cephes_log1p(double x);
   double torch_cephes_expm1(double x);
   double torch_cephes_cosm1(double x);
]]

-- imports for folder cprob
ffi.cdef[[
   // cephes/cprob/bdtr.c
   double torch_cephes_bdtrc(int k, int n, double p);
   double torch_cephes_bdtr(int k, int n, double p);
   double torch_cephes_bdtri(int k, int n, double y);
   // cephes/cprob/btdtr.c
   double torch_cephes_btdtr(double a, double b, double x);
   // cephes/cprob/chdtr.c
   double torch_cephes_chdtrc(double df, double x);
   double torch_cephes_chdtr(double df, double x);
   double torch_cephes_chdtri(double df, double y);
   // cephes/cprob/expx2.c
   double torch_cephes_expx2(double x, int sign);
   // cephes/cprob/fdtr.c
   double torch_cephes_fdtrc(int ia, int ib, double x);
   double torch_cephes_fdtr(int ia, int ib, double x);
   double torch_cephes_fdtri(int ia, int ib, double y);
   // cephes/cprob/gamma.c
   double torch_cephes_gamma(double x);
   int torch_cephes_sgngam;
   double torch_cephes_lgam(double x);
   // cephes/cprob/gdtr.c
   double torch_cephes_gdtr(double a, double b, double x);
   double torch_cephes_gdtrc(double a, double b, double x);
   // cephes/cprob/igam.c
   double torch_cephes_igamc(double a, double x);
   double torch_cephes_igam(double a, double x);
   // cephes/cprob/igami.c
   double torch_cephes_igami(double a, double y0);
   // cephes/cprob/incbet.c
   double torch_cephes_incbet(double aa, double bb, double xx);
   // cephes/cprob/incbi.c
   double torch_cephes_incbi(double aa, double bb, double yy0);
   // cephes/cprob/nbdtr.c
   double torch_cephes_nbdtrc(int k, int n, double p);
   double torch_cephes_nbdtr(int k, int n, double p);
   double torch_cephes_nbdtri(int k, int n, double p);
   // cephes/cprob/ndtr.c
   double torch_cephes_ndtr(double a);
   double torch_cephes_erfc(double a);
   double torch_cephes_erf(double x);
   // cephes/cprob/ndtri.c
   double torch_cephes_ndtri(double y0);
   // cephes/cprob/pdtr.c
   double torch_cephes_pdtrc(int k, double m);
   double torch_cephes_pdtr(int k, double m);
   double torch_cephes_pdtri(int k, double y);
   // cephes/cprob/stdtr.c
   double torch_cephes_stdtr(int k, double t);
   double torch_cephes_stdtri(int k, double p);
]]

-- imports for folder misc
ffi.cdef[[
   // cephes/misc/beta.c
   double torch_cephes_beta(double a, double b);
   double torch_cephes_lbeta(double a, double b);
   // cephes/misc/dawsn.c
   double torch_cephes_dawsn(double xx);
   // cephes/misc/ei.c
   double torch_cephes_ei(double x);
   // cephes/misc/expn.c
   double torch_cephes_expn(int n, double x);
   // cephes/misc/fac.c
   double torch_cephes_fac(int i);
   // cephes/misc/fresnl.c
   int torch_cephes_fresnl(double xxa, double * ssa, double * cca);
   // cephes/misc/psi.c
   double torch_cephes_psi(double x);
   // cephes/misc/revers.c
   void torch_cephes_revers(double y[], double x[], int n);
   // cephes/misc/rgamma.c
   double torch_cephes_rgamma(double x);
   // cephes/misc/shichi.c
   int torch_cephes_shichi(double x, double * si, double * ci);
   // cephes/misc/sici.c
   int torch_cephes_sici(double x, double * si, double * ci);
   // cephes/misc/simpsn.c
   double torch_cephes_simpsn(double f[], double delta);
   // cephes/misc/spence.c
   double torch_cephes_spence(double x);
   // cephes/misc/zeta.c
   double torch_cephes_zeta(double x, double q);
   // cephes/misc/zetac.c
   double torch_cephes_zetac(double x);
]]

-- imports for folder ellf
ffi.cdef[[
   // cephes/ellf/ellie.c
   double torch_cephes_ellie(double phi, double m);
   // cephes/ellf/ellik.c
   double torch_cephes_ellik(double phi, double m);
   // cephes/ellf/ellpe.c
   double torch_cephes_ellpe(double x);
   // cephes/ellf/ellpj.c
   int torch_cephes_ellpj(double u, double m, double * sn, double * cn,
                          double * dn, double * ph);
   // cephes/ellf/ellpk.c
   double torch_cephes_ellpk(double x);
]]

-- imports for folder polyn
ffi.cdef[[
   // cephes/polyn/euclid.c
   double torch_cephes_euclid(double * num, double * den);
   // cephes/polyn/polrt.c
   int torch_cephes_polrt(double xcof[], double cof[], int m, cmplx root[]);
   // cephes/polyn/polyn.c
   void torch_cephes_polini(int maxdeg);
   void torch_cephes_polprt(double a[], int na, int d);
   void torch_cephes_polclr(double * a, int n);
   void torch_cephes_polmov(double * a, int na, double * b);
   void torch_cephes_polmul(double a[], int na, double b[], int nb, double c[]);
   void torch_cephes_poladd(double a[], int na, double b[], int nb, double c[]);
   void torch_cephes_polsub(double a[], int na, double b[], int nb, double c[]);
   int torch_cephes_poldiv(double a[], int na, double b[], int nb, double c[]);
   void torch_cephes_polsbt(double a[], int na, double b[], int nb, double c[]);
   double torch_cephes_poleva(double a[], int na, double x);
   // cephes/polyn/polyr.c: disabled to avoid naming clash with regular polynomials
   // cephes/polyn/revers.c
   void torch_cephes_revers(double y[], double x[], int n);
]]

-- For those few exceptions that escaped our automatic parser
ffi.cdef[[
    // Escaped due to return type on a line per itself
    // cephes/cmath/clog.c
    void torch_cephes_csinh(cmplx *z, cmplx *w);
    void torch_cephes_casinh(cmplx *z, cmplx *w);
    void torch_cephes_ccosh(cmplx *z, cmplx *w);
    void torch_cephes_cacosh(cmplx *z, cmplx *w);
    void torch_cephes_ctanh(cmplx *z, cmplx *w);
    void torch_cephes_catanh(cmplx *z, cmplx *w);
    void torch_cephes_cpow(cmplx *a, cmplx *z, cmplx *w);
    // cephes/cprob/kolmogorov.c
    double torch_cephes_kolmogi(double p);
    double torch_cephes_kolmogorov(double y);
    double torch_cephes_smirnov(int n, double e);
    double torch_cephes_smirnovi(int n, double e);
    // cephes/polyn/polmisc.c
    void torch_cephes_polatn(double num[], double den[], double ans[], int nn);
    void torch_cephes_polsqt(double pol[], double ans[], int nn);
    void torch_cephes_polsin(double x[], double y[], int nn);
    void torch_cephes_polcos(double x[], double y[], int nn);
    // cephes/misc/polylog.c
    double torch_cephes_polylog(int n, double x);
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

