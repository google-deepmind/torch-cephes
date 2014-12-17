/*							stdtr.c
 *
 *	Student's t distribution
 *
 *
 *
 * SYNOPSIS:
 *
 * double t, stdtr();
 * short k;
 *
 * y = stdtr( k, t );
 *
 *
 * DESCRIPTION:
 *
 * Computes the integral from minus infinity to t of the Student
 * t distribution with integer k > 0 degrees of freedom:
 *
 *                                      t
 *                                      -
 *                                     | |
 *              -                      |         2   -(k+1)/2
 *             | ( (k+1)/2 )           |  (     x   )
 *       ----------------------        |  ( 1 + --- )        dx
 *                     -               |  (      k  )
 *       sqrt( k pi ) | ( k/2 )        |
 *                                   | |
 *                                    -
 *                                   -inf.
 * 
 * Relation to incomplete beta integral:
 *
 *        1 - stdtr(k,t) = 0.5 * incbet( k/2, 1/2, z )
 * where
 *        z = k/(k + t**2).
 *
 * For t < -2, this is the method of computation.  For higher t,
 * a direct method is derived from integration by parts.
 * Since the function is symmetric about t=0, the area under the
 * right tail of the density is found by calling the function
 * with -t instead of t.
 * 
 * ACCURACY:
 *
 * Tested at random 1 <= k <= 25.  The "domain" refers to t.
 *                      Relative error:
 * arithmetic   domain     # trials      peak         rms
 *    IEEE     -100,-2      50000       5.9e-15     1.4e-15
 *    IEEE     -2,100      500000       2.7e-15     4.9e-17
 */

/*							stdtri.c
 *
 *	Functional inverse of Student's t distribution
 *
 *
 *
 * SYNOPSIS:
 *
 * double p, t, stdtri();
 * int k;
 *
 * t = stdtri( k, p );
 *
 *
 * DESCRIPTION:
 *
 * Given probability p, finds the argument t such that stdtr(k,t)
 * is equal to p.
 * 
 * ACCURACY:
 *
 * Tested at random 1 <= k <= 100.  The "domain" refers to p:
 *                      Relative error:
 * arithmetic   domain     # trials      peak         rms
 *    IEEE    .001,.999     25000       5.7e-15     8.0e-16
 *    IEEE    10^-6,.001    25000       2.0e-12     2.9e-14
 */


/*
Cephes Math Library Release 2.8:  June, 2000
Copyright 1984, 1987, 1995, 2000 by Stephen L. Moshier
*/

#include "mconf.h"

extern double torch_cephes_PI, torch_cephes_MACHEP, torch_cephes_MAXNUM;
#ifdef ANSIPROT
extern double torch_cephes_sqrt ( double );
extern double torch_cephes_atan ( double );
extern double torch_cephes_incbet ( double, double, double );
extern double torch_cephes_incbi ( double, double, double );
extern double torch_cephes_fabs ( double );
#else
double torch_cephes_sqrt(), torch_cephes_atan(), torch_cephes_incbet(),
   torch_cephes_incbi(), torch_cephes_fabs();
#endif

double torch_cephes_stdtr( k, t )
int k;
double t;
{
double x, rk, z, f, tz, p, xsqk;
int j;

if( k <= 0 )
	{
	torch_cephes_mtherr( "stdtr", DOMAIN );
	return(0.0);
	}

if( t == 0 )
	return( 0.5 );

if( t < -2.0 )
	{
	rk = k;
	z = rk / (rk + t * t);
	p = 0.5 * torch_cephes_incbet( 0.5*rk, 0.5, z );
	return( p );
	}

/*	compute integral from -t to + t */

if( t < 0 )
	x = -t;
else
	x = t;

rk = k;	/* degrees of freedom */
z = 1.0 + ( x * x )/rk;

/* test if k is odd or even */
if( (k & 1) != 0)
	{

	/*	computation for odd k	*/

	xsqk = x/torch_cephes_sqrt(rk);
	p = torch_cephes_atan( xsqk );
	if( k > 1 )
		{
		f = 1.0;
		tz = 1.0;
		j = 3;
		while(  (j<=(k-2)) && ( (tz/f) > torch_cephes_MACHEP )  )
			{
			tz *= (j-1)/( z * j );
			f += tz;
			j += 2;
			}
		p += f * xsqk/z;
		}
	p *= 2.0/torch_cephes_PI;
	}


else
	{

	/*	computation for even k	*/

	f = 1.0;
	tz = 1.0;
	j = 2;

	while(  ( j <= (k-2) ) && ( (tz/f) > torch_cephes_MACHEP )  )
		{
		tz *= (j - 1)/( z * j );
		f += tz;
		j += 2;
		}
	p = f * x/torch_cephes_sqrt(z*rk);
	}

/*	common exit	*/


if( t < 0 )
	p = -p;	/* note destruction of relative accuracy */

	p = 0.5 + 0.5 * p;
return(p);
}

double torch_cephes_stdtri( k, p )
int k;
double p;
{
double t, rk, z;
int rflg;

if( k <= 0 || p <= 0.0 || p >= 1.0 )
	{
	torch_cephes_mtherr( "stdtri", DOMAIN );
	return(0.0);
	}

rk = k;

if( p > 0.25 && p < 0.75 )
	{
	if( p == 0.5 )
		return( 0.0 );
	z = 1.0 - 2.0 * p;
	z = torch_cephes_incbi( 0.5, 0.5*rk, torch_cephes_fabs(z) );
	t = torch_cephes_sqrt( rk*z/(1.0-z) );
	if( p < 0.5 )
		t = -t;
	return( t );
	}
rflg = -1;
if( p >= 0.5)
	{
	p = 1.0 - p;
	rflg = 1;
	}
z = torch_cephes_incbi( 0.5*rk, 0.5, 2.0*p );

if( torch_cephes_MAXNUM * z < rk )
	return(rflg* torch_cephes_MAXNUM);
t = torch_cephes_sqrt( rk/z - rk );
return( rflg * t );
}
