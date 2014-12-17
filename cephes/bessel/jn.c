/*							jn.c
 *
 *	Bessel function of integer order
 *
 *
 *
 * SYNOPSIS:
 *
 * int n;
 * double x, y, jn();
 *
 * y = jn( n, x );
 *
 *
 *
 * DESCRIPTION:
 *
 * Returns Bessel function of order n, where n is a
 * (possibly negative) integer.
 *
 * The ratio of jn(x) to j0(x) is computed by backward
 * recurrence.  First the ratio jn/jn-1 is found by a
 * continued fraction expansion.  Then the recurrence
 * relating successive orders is applied until j0 or j1 is
 * reached.
 *
 * If n = 0 or 1 the routine for j0 or j1 is called
 * directly.
 *
 *
 *
 * ACCURACY:
 *
 *                      Absolute error:
 * arithmetic   range      # trials      peak         rms
 *    DEC       0, 30        5500       6.9e-17     9.3e-18
 *    IEEE      0, 30        5000       4.4e-16     7.9e-17
 *
 *
 * Not suitable for large n or x. Use jv() instead.
 *
 */

/*							jn.c
Cephes Math Library Release 2.8:  June, 2000
Copyright 1984, 1987, 2000 by Stephen L. Moshier
*/
#include "mconf.h"
#ifdef ANSIPROT
extern double torch_cephes_fabs ( double );
extern double torch_cephes_j0 ( double );
extern double torch_cephes_j1 ( double );
#else
double torch_cephes_fabs(), torch_cephes_j0(), torch_cephes_j1();
#endif
extern double torch_cephes_MACHEP;

double torch_cephes_jn( n, x )
int n;
double x;
{
double pkm2, pkm1, pk, xk, r, ans;
int k, sign;

if( n < 0 )
	{
	n = -n;
	if( (n & 1) == 0 )	/* -1**n */
		sign = 1;
	else
		sign = -1;
	}
else
	sign = 1;

if( x < 0.0 )
	{
	if( n & 1 )
		sign = -sign;
	x = -x;
	}

if( n == 0 )
	return( sign * torch_cephes_j0(x) );
if( n == 1 )
	return( sign * torch_cephes_j1(x) );
if( n == 2 )
	return( sign * (2.0 * torch_cephes_j1(x) / x  -  torch_cephes_j0(x)) );

if( x < torch_cephes_MACHEP )
	return( 0.0 );

/* continued fraction */
#ifdef DEC
k = 56;
#else
k = 53;
#endif

pk = 2 * (n + k);
ans = pk;
xk = x * x;

do
	{
	pk -= 2.0;
	ans = pk - (xk/ans);
	}
while( --k > 0 );
ans = x/ans;

/* backward recurrence */

pk = 1.0;
pkm1 = 1.0/ans;
k = n-1;
r = 2 * k;

do
	{
	pkm2 = (pkm1 * r  -  pk * x) / x;
	pk = pkm1;
	pkm1 = pkm2;
	r -= 2.0;
	}
while( --k > 0 );

if( torch_cephes_fabs(pk) > torch_cephes_fabs(pkm1) )
	ans = j1(x)/pk;
else
	ans = j0(x)/pkm1;
return( sign * ans );
}
