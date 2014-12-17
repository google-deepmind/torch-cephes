/*							cosh.c
 *
 *	Hyperbolic cosine
 *
 *
 *
 * SYNOPSIS:
 *
 * double x, y, cosh();
 *
 * y = cosh( x );
 *
 *
 *
 * DESCRIPTION:
 *
 * Returns hyperbolic cosine of argument in the range MINLOG to
 * MAXLOG.
 *
 * cosh(x)  =  ( exp(x) + exp(-x) )/2.
 *
 *
 *
 * ACCURACY:
 *
 *                      Relative error:
 * arithmetic   domain     # trials      peak         rms
 *    DEC       +- 88       50000       4.0e-17     7.7e-18
 *    IEEE     +-MAXLOG     30000       2.6e-16     5.7e-17
 *
 *
 * ERROR MESSAGES:
 *
 *   message         condition      value returned
 * cosh overflow    |x| > MAXLOG       MAXNUM
 *
 *
 */

/*							cosh.c */

/*
Cephes Math Library Release 2.8:  June, 2000
Copyright 1985, 1995, 2000 by Stephen L. Moshier
*/

#include "mconf.h"
#ifdef ANSIPROT
extern double torch_cephes_exp ( double );
extern int torch_cephes_isnan ( double );
extern int torch_cephes_isfinite ( double );
#else
double torch_cephes_exp();
int torch_cephes_isnan(), torch_cephes_isfinite();
#endif
extern double torch_cephes_MAXLOG, torch_cephes_INFINITY, torch_cephes_LOGE2;

double torch_cephes_cosh(x)
double x;
{
double y;

#ifdef NANS
if( torch_cephes_isnan(x) )
	return(x);
#endif
if( x < 0 )
	x = -x;
if( x > (torch_cephes_MAXLOG + torch_cephes_LOGE2) )
	{
	torch_cephes_mtherr( "cosh", OVERFLOW );
	return( torch_cephes_INFINITY );
	}	
if( x >= (torch_cephes_MAXLOG - torch_cephes_LOGE2) )
	{
	y = torch_cephes_exp(0.5 * x);
	y = (0.5 * y) * y;
	return(y);
	}
y = torch_cephes_exp(x);
y = 0.5 * (y + 1.0 / y);
return( y );
}
