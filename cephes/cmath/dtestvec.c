
/* Test vectors for math functions.
   See C9X section F.9.  */
/*
Cephes Math Library Release 2.8:  June, 2000
Copyright 1998, 2000 by Stephen L. Moshier
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int isfinite (double);

/* C9X spells lgam lgamma.  */
#define GLIBC2 0

extern double torch_cephes_PI;
static double MPI, PIO2, MPIO2, PIO4, MPIO4, THPIO4, MTHPIO4;

#if 0
#define PI 3.141592653589793238463E0
#define PIO2 1.570796326794896619231E0
#define PIO4 7.853981633974483096157E-1
#define THPIO4 2.35619449019234492884698
#define SQRT2 1.414213562373095048802E0
#define SQRTH 7.071067811865475244008E-1
#define INF (1.0/0.0)
#define MINF (-1.0/0.0)
#endif

extern double torch_cephes_MACHEP, torch_cephes_SQRTH, torch_cephes_SQRT2;
extern double torch_cephes_NAN, torch_cephes_INFINITY, torch_cephes_NEGZERO;
static double torch_cephes_INF, torch_cephes_MINF;
static double torch_cephes_ZERO, torch_cephes_MZERO, torch_cephes_HALF,
    torch_cephes_MHALF, torch_cephes_ONE, torch_cephes_MONE, torch_cephes_TWO,
    torch_cephes_MTWO, torch_cephes_THREE, torch_cephes_MTHREE;
/* #define NAN (1.0/0.0 - 1.0/0.0) */

/* Functions of one variable.  */
double torch_cephes_log (double);
double torch_cephes_exp ( double);
double torch_cephes_atan (double);
double torch_cephes_sin (double);
double torch_cephes_cos (double);
double torch_cephes_tan (double);
double torch_cephes_acos (double);
double torch_cephes_asin (double);
double torch_cephes_acosh (double);
double torch_cephes_asinh (double);
double torch_cephes_atanh (double);
double torch_cephes_sinh (double);
double torch_cephes_cosh (double);
double torch_cephes_tanh (double);
double torch_cephes_exp2 (double);
double torch_cephes_expm1 (double);
double torch_cephes_log10 (double);
double torch_cephes_log1p (double);
double torch_cephes_log2 (double);
double torch_cephes_fabs (double);
double torch_cephes_erf (double);
double torch_cephes_erfc (double);
double torch_cephes_gamma (double);
double torch_cephes_floor (double);
double torch_cephes_ceil (double);
double torch_cephes_cbrt (double);
#if GLIBC2
double torch_cephes_lgamma (double);
#else
double torch_cephes_lgam (double);
#endif

struct oneargument
  {
    char *name;			/* Name of the function. */
    double (*func) (double);
    double *arg1;
    double *answer;
    int thresh;			/* Error report threshold. */
  };

struct oneargument test1[] =
{
  {"atan", torch_cephes_atan, &ONE, &PIO4, 0},
  {"sin", torch_cephes_sin, &PIO2, &ONE, 0},
#if 0
  {"cos", torch_cephes_cos, &PIO4, &SQRTH, 0},
  {"sin", torch_cephes_sin, 32767., 1.8750655394138942394239E-1, 0},
  {"cos", torch_cephes_cos, 32767., 9.8226335176928229845654E-1, 0},
  {"tan", torch_cephes_tan, 32767., 1.9089234430221485740826E-1, 0},
  {"sin", torch_cephes_sin, 8388607., 9.9234509376961249835628E-1, 0},
  {"cos", torch_cephes_cos, 8388607., -1.2349580912475928183718E-1, 0},
  {"tan", torch_cephes_tan, 8388607., -8.0354556223613614748329E0, 0},
  /*
  {"sin", torch_cephes_sin, 2147483647., -7.2491655514455639054829E-1, 0},
  {"cos", torch_cephes_cos, 2147483647., -6.8883669187794383467976E-1, 0},
  {"tan", torch_cephes_tan, 2147483647., 1.0523779637351339136698E0, 0},
  */
  {"cos", torch_cephes_cos, &PIO2, 6.1232339957367574e-17, 1},
  {"sin", torch_cephes_sin, &PIO4, &SQRTH, 1},
#endif
  {"acos", torch_cephes_acos, &NAN, &NAN, 0},
  {"acos", torch_cephes_acos, &ONE, &ZERO, 0},
  {"acos", torch_cephes_acos, &TWO, &NAN, 0},
  {"acos", torch_cephes_acos, &MTWO, &NAN, 0},
  {"asin", torch_cephes_asin, &NAN, &NAN, 0},
  {"asin", torch_cephes_asin, &ZERO, &ZERO, 0},
  {"asin", torch_cephes_asin, &MZERO, &MZERO, 0},
  {"asin", torch_cephes_asin, &TWO, &NAN, 0},
  {"asin", torch_cephes_asin, &MTWO, &NAN, 0},
  {"atan", torch_cephes_atan, &NAN, &NAN, 0},
  {"atan", torch_cephes_atan, &ZERO, &ZERO, 0},
  {"atan", torch_cephes_atan, &MZERO, &MZERO, 0},
  {"atan", torch_cephes_atan, &INF, &PIO2, 0},
  {"atan", torch_cephes_atan, &MINF, &MPIO2, 0},
  {"cos", torch_cephes_cos, &NAN, &NAN, 0},
  {"cos", torch_cephes_cos, &ZERO, &ONE, 0},
  {"cos", torch_cephes_cos, &MZERO, &ONE, 0},
  {"cos", torch_cephes_cos, &INF, &NAN, 0},
  {"cos", torch_cephes_cos, &MINF, &NAN, 0},
  {"sin", torch_cephes_sin, &NAN, &NAN, 0},
  {"sin", torch_cephes_sin, &MZERO, &MZERO, 0},
  {"sin", torch_cephes_sin, &ZERO, &ZERO, 0},
  {"sin", torch_cephes_sin, &INF, &NAN, 0},
  {"sin", torch_cephes_sin, &MINF, &NAN, 0},
  {"tan", torch_cephes_tan, &NAN, &NAN, 0},
  {"tan", torch_cephes_tan, &ZERO, &ZERO, 0},
  {"tan", torch_cephes_tan, &MZERO, &MZERO, 0},
  {"tan", torch_cephes_tan, &INF, &NAN, 0},
  {"tan", torch_cephes_tan, &MINF, &NAN, 0},
  {"acosh", torch_cephes_acosh, &NAN, &NAN, 0},
  {"acosh", torch_cephes_acosh, &ONE, &ZERO, 0},
  {"acosh", torch_cephes_acosh, &INF, &INF, 0},
  {"acosh", torch_cephes_acosh, &HALF, &NAN, 0},
  {"acosh", torch_cephes_acosh, &MONE, &NAN, 0},
  {"asinh", torch_cephes_asinh, &NAN, &NAN, 0},
  {"asinh", torch_cephes_asinh, &ZERO, &ZERO, 0},
  {"asinh", torch_cephes_asinh, &MZERO, &MZERO, 0},
  {"asinh", torch_cephes_asinh, &INF, &INF, 0},
  {"asinh", torch_cephes_asinh, &MINF, &MINF, 0},
  {"atanh", torch_cephes_atanh, &NAN, &NAN, 0},
  {"atanh", torch_cephes_atanh, &ZERO, &ZERO, 0},
  {"atanh", torch_cephes_atanh, &MZERO, &MZERO, 0},
  {"atanh", torch_cephes_atanh, &ONE, &INF, 0},
  {"atanh", torch_cephes_atanh, &MONE, &MINF, 0},
  {"atanh", torch_cephes_atanh, &TWO, &NAN, 0},
  {"atanh", torch_cephes_atanh, &MTWO, &NAN, 0},
  {"cosh", torch_cephes_cosh, &NAN, &NAN, 0},
  {"cosh", torch_cephes_cosh, &ZERO, &ONE, 0},
  {"cosh", torch_cephes_cosh, &MZERO, &ONE, 0},
  {"cosh", torch_cephes_cosh, &INF, &INF, 0},
  {"cosh", torch_cephes_cosh, &MINF, &INF, 0},
  {"sinh", torch_cephes_sinh, &NAN, &NAN, 0},
  {"sinh", torch_cephes_sinh, &ZERO, &ZERO, 0},
  {"sinh", torch_cephes_sinh, &MZERO, &MZERO, 0},
  {"sinh", torch_cephes_sinh, &INF, &INF, 0},
  {"sinh", torch_cephes_sinh, &MINF, &MINF, 0},
  {"tanh", torch_cephes_tanh, &NAN, &NAN, 0},
  {"tanh", torch_cephes_tanh, &ZERO, &ZERO, 0},
  {"tanh", torch_cephes_tanh, &MZERO, &MZERO, 0},
  {"tanh", torch_cephes_tanh, &INF, &ONE, 0},
  {"tanh", torch_cephes_tanh, &MINF, &MONE, 0},
  {"exp", torch_cephes_exp, &NAN, &NAN, 0},
  {"exp", torch_cephes_exp, &ZERO, &ONE, 0},
  {"exp", torch_cephes_exp, &MZERO, &ONE, 0},
  {"exp", torch_cephes_exp, &INF, &INF, 0},
  {"exp", torch_cephes_exp, &MINF, &ZERO, 0},
#if !GLIBC2
  {"exp2", torch_cephes_exp2, &NAN, &NAN, 0},
  {"exp2", torch_cephes_exp2, &ZERO, &ONE, 0},
  {"exp2", torch_cephes_exp2, &MZERO, &ONE, 0},
  {"exp2", torch_cephes_exp2, &INF, &INF, 0},
  {"exp2", torch_cephes_exp2, &MINF, &ZERO, 0},
#endif
  {"expm1", torch_cephes_expm1, &NAN, &NAN, 0},
  {"expm1", torch_cephes_expm1, &ZERO, &ZERO, 0},
  {"expm1", torch_cephes_expm1, &MZERO, &MZERO, 0},
  {"expm1", torch_cephes_expm1, &INF, &INF, 0},
  {"expm1", torch_cephes_expm1, &MINF, &MONE, 0},
  {"log", torch_cephes_log, &NAN, &NAN, 0},
  {"log", torch_cephes_log, &ZERO, &MINF, 0},
  {"log", torch_cephes_log, &MZERO, &MINF, 0},
  {"log", torch_cephes_log, &ONE, &ZERO, 0},
  {"log", torch_cephes_log, &MONE, &NAN, 0},
  {"log", torch_cephes_log, &INF, &INF, 0},
  {"log10", torch_cephes_log10, &NAN, &NAN, 0},
  {"log10", torch_cephes_log10, &ZERO, &MINF, 0},
  {"log10", torch_cephes_log10, &MZERO, &MINF, 0},
  {"log10", torch_cephes_log10, &ONE, &ZERO, 0},
  {"log10", torch_cephes_log10, &MONE, &NAN, 0},
  {"log10", torch_cephes_log10, &INF, &INF, 0},
  {"log1p", torch_cephes_log1p, &NAN, &NAN, 0},
  {"log1p", torch_cephes_log1p, &ZERO, &ZERO, 0},
  {"log1p", torch_cephes_log1p, &MZERO, &MZERO, 0},
  {"log1p", torch_cephes_log1p, &MONE, &MINF, 0},
  {"log1p", torch_cephes_log1p, &MTWO, &NAN, 0},
  {"log1p", torch_cephes_log1p, &INF, &INF, 0},
#if !GLIBC2
  {"log2", torch_cephes_log2, &NAN, &NAN, 0},
  {"log2", torch_cephes_log2, &ZERO, &MINF, 0},
  {"log2", torch_cephes_log2, &MZERO, &MINF, 0},
  {"log2", torch_cephes_log2, &MONE, &NAN, 0},
  {"log2", torch_cephes_log2, &INF, &INF, 0},
#endif
  /*  {"fabs", fabs, NAN, NAN, 0}, */
  {"fabs", torch_cephes_fabs, &ONE, &ONE, 0},
  {"fabs", torch_cephes_fabs, &MONE, &ONE, 0},
  {"fabs", torch_cephes_fabs, &ZERO, &ZERO, 0},
  {"fabs", torch_cephes_fabs, &MZERO, &ZERO, 0},
  {"fabs", torch_cephes_fabs, &INF, &INF, 0},
  {"fabs", torch_cephes_fabs, &MINF, &INF, 0},
  {"cbrt", torch_cephes_cbrt, &NAN, &NAN, 0},
  {"cbrt", torch_cephes_cbrt, &ZERO, &ZERO, 0},
  {"cbrt", torch_cephes_cbrt, &MZERO, &MZERO, 0},
  {"cbrt", torch_cephes_cbrt, &INF, &INF, 0},
  {"cbrt", torch_cephes_cbrt, &MINF, &MINF, 0},
  {"erf", torch_cephes_erf, &NAN, &NAN, 0},
  {"erf", torch_cephes_erf, &ZERO, &ZERO, 0},
  {"erf", torch_cephes_erf, &MZERO, &MZERO, 0},
  {"erf", torch_cephes_erf, &INF, &ONE, 0},
  {"erf", torch_cephes_erf, &MINF, &MONE, 0},
  {"erfc", torch_cephes_erfc, &NAN, &NAN, 0},
  {"erfc", torch_cephes_erfc, &INF, &ZERO, 0},
  {"erfc", torch_cephes_erfc, &MINF, &TWO, 0},
  {"gamma", torch_cephes_gamma, &NAN, &NAN, 0},
  {"gamma", torch_cephes_gamma, &INF, &INF, 0},
  {"gamma", torch_cephes_gamma, &MONE, &NAN, 0},
  {"gamma", torch_cephes_gamma, &ZERO, &NAN, 0},
  {"gamma", torch_cephes_gamma, &MINF, &NAN, 0},
#if GLIBC2
  {"lgamma", torch_cephes_lgamma, &NAN, &NAN, 0},
  {"lgamma", torch_cephes_lgamma, &INF, &INF, 0},
  {"lgamma", torch_cephes_lgamma, &MONE, &INF, 0},
  {"lgamma", torch_cephes_lgamma, &ZERO, &INF, 0},
  {"lgamma", torch_cephes_lgamma, &MINF, &INF, 0},
#else
  {"lgam", torch_cephes_lgam, &NAN, &NAN, 0},
  {"lgam", torch_cephes_lgam, &INF, &INF, 0},
  {"lgam", torch_cephes_lgam, &MONE, &INF, 0},
  {"lgam", torch_cephes_lgam, &ZERO, &INF, 0},
  {"lgam", torch_cephes_lgam, &MINF, &INF, 0},
#endif
  {"ceil", torch_cephes_ceil, &NAN, &NAN, 0},
  {"ceil", torch_cephes_ceil, &ZERO, &ZERO, 0},
  {"ceil", torch_cephes_ceil, &MZERO, &MZERO, 0},
  {"ceil", torch_cephes_ceil, &INF, &INF, 0},
  {"ceil", torch_cephes_ceil, &MINF, &MINF, 0},
  {"floor", torch_cephes_floor, &NAN, &NAN, 0},
  {"floor", torch_cephes_floor, &ZERO, &ZERO, 0},
  {"floor", torch_cephes_floor, &MZERO, &MZERO, 0},
  {"floor", torch_cephes_floor, &INF, &INF, 0},
  {"floor", torch_cephes_floor, &MINF, &MINF, 0},
  {"null", NULL, &ZERO, &ZERO, 0},
};

/* Functions of two variables.  */
double torch_cephes_atan2 (double, double);
double torch_cephes_pow (double, double);

struct twoarguments
  {
    char *name;			/* Name of the function. */
    double (*func) (double, double);
    double *arg1;
    double *arg2;
    double *answer;
    int thresh;
  };

struct twoarguments test2[] =
{
  {"atan2", torch_cephes_atan2, &ZERO, &ONE, &ZERO, 0},
  {"atan2", torch_cephes_atan2, &MZERO, &ONE, &MZERO, 0},
  {"atan2", torch_cephes_atan2, &ZERO, &ZERO, &ZERO, 0},
  {"atan2", torch_cephes_atan2, &MZERO, &ZERO, &MZERO, 0},
  {"atan2", torch_cephes_atan2, &ZERO, &MONE, &PI, 0},
  {"atan2", torch_cephes_atan2, &MZERO, &MONE, &MPI, 0},
  {"atan2", torch_cephes_atan2, &ZERO, &MZERO, &PI, 0},
  {"atan2", torch_cephes_atan2, &MZERO, &MZERO, &MPI, 0},
  {"atan2", torch_cephes_atan2, &ONE, &ZERO, &PIO2, 0},
  {"atan2", torch_cephes_atan2, &ONE, &MZERO, &PIO2, 0},
  {"atan2", torch_cephes_atan2, &MONE, &ZERO, &MPIO2, 0},
  {"atan2", torch_cephes_atan2, &MONE, &MZERO, &MPIO2, 0},
  {"atan2", torch_cephes_atan2, &ONE, &INF, &ZERO, 0},
  {"atan2", torch_cephes_atan2, &MONE, &INF, &MZERO, 0},
  {"atan2", torch_cephes_atan2, &INF, &ONE, &PIO2, 0},
  {"atan2", torch_cephes_atan2, &INF, &MONE, &PIO2, 0},
  {"atan2", torch_cephes_atan2, &MINF, &ONE, &MPIO2, 0},
  {"atan2", torch_cephes_atan2, &MINF, &MONE, &MPIO2, 0},
  {"atan2", torch_cephes_atan2, &ONE, &MINF, &PI, 0},
  {"atan2", torch_cephes_atan2, &MONE, &MINF, &MPI, 0},
  {"atan2", torch_cephes_atan2, &INF, &INF, &PIO4, 0},
  {"atan2", torch_cephes_atan2, &MINF, &INF, &MPIO4, 0},
  {"atan2", torch_cephes_atan2, &INF, &MINF, &THPIO4, 0},
  {"atan2", torch_cephes_atan2, &MINF, &MINF, &MTHPIO4, 0},
  {"atan2", torch_cephes_atan2, &ONE, &ONE, &PIO4, 0},
  {"atan2", torch_cephes_atan2, &NAN, &ONE, &NAN, 0},
  {"atan2", torch_cephes_atan2, &ONE, &NAN, &NAN, 0},
  {"atan2", torch_cephes_atan2, &NAN, &NAN, &NAN, 0},
  {"pow", torch_cephes_pow, &ONE, &ZERO, &ONE, 0},
  {"pow", torch_cephes_pow, &ONE, &MZERO, &ONE, 0},
  {"pow", torch_cephes_pow, &MONE, &ZERO, &ONE, 0},
  {"pow", torch_cephes_pow, &MONE, &MZERO, &ONE, 0},
  {"pow", torch_cephes_pow, &INF, &ZERO, &ONE, 0},
  {"pow", torch_cephes_pow, &INF, &MZERO, &ONE, 0},
  {"pow", torch_cephes_pow, &NAN, &ZERO, &ONE, 0},
  {"pow", torch_cephes_pow, &NAN, &MZERO, &ONE, 0},
  {"pow", torch_cephes_pow, &TWO, &INF, &INF, 0},
  {"pow", torch_cephes_pow, &MTWO, &INF, &INF, 0},
  {"pow", torch_cephes_pow, &HALF, &INF, &ZERO, 0},
  {"pow", torch_cephes_pow, &MHALF, &INF, &ZERO, 0},
  {"pow", torch_cephes_pow, &TWO, &MINF, &ZERO, 0},
  {"pow", torch_cephes_pow, &MTWO, &MINF, &ZERO, 0},
  {"pow", torch_cephes_pow, &HALF, &MINF, &INF, 0},
  {"pow", torch_cephes_pow, &MHALF, &MINF, &INF, 0},
  {"pow", torch_cephes_pow, &INF, &HALF, &INF, 0},
  {"pow", torch_cephes_pow, &INF, &TWO, &INF, 0},
  {"pow", torch_cephes_pow, &INF, &MHALF, &ZERO, 0},
  {"pow", torch_cephes_pow, &INF, &MTWO, &ZERO, 0},
  {"pow", torch_cephes_pow, &MINF, &THREE, &MINF, 0},
  {"pow", torch_cephes_pow, &MINF, &TWO, &INF, 0},
  {"pow", torch_cephes_pow, &MINF, &MTHREE, &MZERO, 0},
  {"pow", torch_cephes_pow, &MINF, &MTWO, &ZERO, 0},
  {"pow", torch_cephes_pow, &NAN, &ONE, &NAN, 0},
  {"pow", torch_cephes_pow, &ONE, &NAN, &NAN, 0},
  {"pow", torch_cephes_pow, &NAN, &NAN, &NAN, 0},
  {"pow", torch_cephes_pow, &ONE, &INF, &NAN, 0},
  {"pow", torch_cephes_pow, &MONE, &INF, &NAN, 0},
  {"pow", torch_cephes_pow, &ONE, &MINF, &NAN, 0},
  {"pow", torch_cephes_pow, &MONE, &MINF, &NAN, 0},
  {"pow", torch_cephes_pow, &MTWO, &HALF, &NAN, 0},
  {"pow", torch_cephes_pow, &ZERO, &MTHREE, &INF, 0},
  {"pow", torch_cephes_pow, &MZERO, &MTHREE, &MINF, 0},
  {"pow", torch_cephes_pow, &ZERO, &MHALF, &INF, 0},
  {"pow", torch_cephes_pow, &MZERO, &MHALF, &INF, 0},
  {"pow", torch_cephes_pow, &ZERO, &THREE, &ZERO, 0},
  {"pow", torch_cephes_pow, &MZERO, &THREE, &MZERO, 0},
  {"pow", torch_cephes_pow, &ZERO, &HALF, &ZERO, 0},
  {"pow", torch_cephes_pow, &MZERO, &HALF, &ZERO, 0},
  {"null", NULL, &ZERO, &ZERO, &ZERO, 0},
};

/* Integer functions of one variable.  */

int torch_cephes_isnan (double);
int torch_cephes_signbit (double);

struct intans
  {
    char *name;			/* Name of the function. */
    int (*func) (double);
    double *arg1;
    int ianswer;
  };

struct intans test3[] =
{
  {"isfinite", torch_cephes_isfinite, &ZERO, 1},
  {"isfinite", torch_cephes_isfinite, &INF, 0},
  {"isfinite", torch_cephes_isfinite, &MINF, 0},
  {"isnan", torch_cephes_isnan, &NAN, 1},
  {"isnan", torch_cephes_isnan, &INF, 0},
  {"isnan", torch_cephes_isnan, &ZERO, 0},
  {"isnan", torch_cephes_isnan, &MZERO, 0},
  {"signbit", torch_cephes_signbit, &MZERO, 1},
  {"signbit", torch_cephes_signbit, &MONE, 1},
  {"signbit", torch_cephes_signbit, &ZERO, 0},
  {"signbit", torch_cephes_signbit, &ONE, 0},
  {"signbit", torch_cephes_signbit, &MINF, 1},
  {"signbit", torch_cephes_signbit, &INF, 0},
  {"null", NULL, &ZERO, 0},
};

static volatile double x1;
static volatile double x2;
static volatile double y;
static volatile double answer;

void
pvec(x)
double x;
{
  union
  {
    double d;
    unsigned short s[4];
  } u;
  int i;

  u.d = x;
  for (i = 0; i < 4; i++)
    printf ("0x%04x ", u.s[i]);
  printf ("\n");
}


int
main ()
{
  int i, nerrors, k, ianswer, ntests;
  double (*fun1) (double);
  double (*fun2) (double, double);
  int (*fun3) (double);
  double e;
  union
    {
      double d;
      char c[8];
    } u, v;

  ZERO = 0.0;
  MZERO = NEGZERO;
  HALF = 0.5;
  MHALF = -HALF;
  ONE = 1.0;
  MONE = -ONE;
  TWO = 2.0;
  MTWO = -TWO;
  THREE = 3.0;
  MTHREE = -THREE;
  INF = INFINITY;
  MINF = -INFINITY;
  MPI = -PI;
  PIO2 = 0.5 * PI;
  MPIO2 = -PIO2;
  PIO4 = 0.5 * PIO2;
  MPIO4 = -PIO4;
  THPIO4 = 3.0 * PIO4;
  MTHPIO4 = -THPIO4;

  nerrors = 0;
  ntests = 0;
  i = 0;
  for (;;)
    {
      fun1 = test1[i].func;
      if (fun1 == NULL)
	break;
      x1 = *(test1[i].arg1);
      y = (*(fun1)) (x1);
      answer = *(test1[i].answer);
      if (test1[i].thresh == 0)
	{
	  v.d = answer;
	  u.d = y;
	  if (memcmp(u.c, v.c, 8) != 0)
	    {
	      if( isnan(v.d) && isnan(u.d) )
		goto nxttest1;
	      goto wrongone;
	    }
	  else
	    goto nxttest1;
	}
      if (y != answer)
	{
	  e = y - answer;
	  if (answer != 0.0)
	    e = e / answer;
	  if (e < 0)
	    e = -e;
	  if (e > test1[i].thresh * MACHEP)
	    {
wrongone:
	      printf ("%s (%.16e) = %.16e\n    should be %.16e\n",
		      test1[i].name, x1, y, answer);
	      nerrors += 1;
	    }
	}
nxttest1:
      ntests += 1;
      i += 1;
    }

  i = 0;
  for (;;)
    {
      fun2 = test2[i].func;
      if (fun2 == NULL)
	break;
      x1 = *(test2[i].arg1);
      x2 = *(test2[i].arg2);
      y = (*(fun2)) (x1, x2);
      answer = *(test2[i].answer);
      if (test2[i].thresh == 0)
	{
	  v.d = answer;
	  u.d = y;
	  if (memcmp(u.c, v.c, 8) != 0)
	    {
	      if( isnan(v.d) && isnan(u.d) )
		goto nxttest2;
#if 0
	      if( isnan(v.d) )
		pvec(v.d);
	      if( isnan(u.d) )
		pvec(u.d);
#endif
	    goto wrongtwo;
	    }
	  else
	    goto nxttest2;
	}
      if (y != answer)
	{
	  e = y - answer;
	  if (answer != 0.0)
	    e = e / answer;
	  if (e < 0)
	    e = -e;
	  if (e > test2[i].thresh * MACHEP)
	    {
wrongtwo:
	      printf ("%s (%.16e, %.16e) = %.16e\n    should be %.16e\n",
		      test2[i].name, x1, x2, y, answer);
	      nerrors += 1;
	    }
	}
nxttest2:
      ntests += 1;
      i += 1;
    }


  i = 0;
  for (;;)
    {
      fun3 = test3[i].func;
      if (fun3 == NULL)
	break;
      x1 = *(test3[i].arg1);
      k = (*(fun3)) (x1);
      ianswer = test3[i].ianswer;
      if (k != ianswer)
	{
	  printf ("%s (%.16e) = %d\n    should be. %d\n",
		  test3[i].name, x1, k, ianswer);
	  nerrors += 1;
	}
      ntests += 1;
      i += 1;
    }

  printf ("testvect: %d errors in %d tests\n", nerrors, ntests);
  exit (0);
}
