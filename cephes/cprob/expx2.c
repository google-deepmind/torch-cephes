/*							expx2.c
 *
 *	Exponential of squared argument
 *
 *
 *
 * SYNOPSIS:
 *
 * double x, y, expx2();
 * int sign;
 *
 * y = expx2( x, sign );
 *
 *
 *
 * DESCRIPTION:
 *
 * Computes y = exp(x*x) while suppressing error amplification
 * that would ordinarily arise from the inexactness of the
 * exponential argument x*x.
 *
 * If sign < 0, the result is inverted; i.e., y = exp(-x*x) .
 * 
 *
 * ACCURACY:
 *
 *                      Relative error:
 * arithmetic    domain     # trials      peak         rms
 *   IEEE      -26.6, 26.6    10^7       3.9e-16     8.9e-17
 *
 */

/*
Cephes Math Library Release 2.9:  June, 2000
Copyright 2000 by Stephen L. Moshier
*/

#include "mconf.h"

#ifdef ANSIPROT
extern double torch_cephes_fabs (double);
extern double torch_cephes_floor (double);
extern double torch_cephes_exp (double);
#else
double torch_cephes_fabs();
double torch_cephes_floor();
double torch_cephes_exp();
#endif

#ifdef DEC
#define M 32.0
#define MINV .03125
#else
#define M 128.0
#define MINV .0078125
#endif

extern double torch_cephes_MAXLOG;
extern double torch_cephes_INFINITY;

double torch_cephes_expx2 (x, sign)
     double x;
     int sign;
{
  double u, u1, m, f;

  x = torch_cephes_fabs (x);
  if (sign < 0)
    x = -x;

  /* Represent x as an exact multiple of M plus a residual.
     M is a power of 2 chosen so that exp(m * m) does not overflow
     or underflow and so that |x - m| is small.  */
  m = MINV * torch_cephes_floor(M * x + 0.5);
  f = x - m;

  /* x^2 = m^2 + 2mf + f^2 */
  u = m * m;
  u1 = 2 * m * f  +  f * f;

  if (sign < 0)
    {
      u = -u;
      u1 = -u1;
    }

  if ((u+u1) > torch_cephes_MAXLOG)
    return (torch_cephes_INFINITY);

  /* u is exact, u1 is small.  */
  u = torch_cephes_exp(u) * torch_cephes_exp(u1);
  return(u);
}
