/*							expn.c
 *
 *		Exponential integral En
 *
 *
 *
 * SYNOPSIS:
 *
 * int n;
 * double x, y, expn();
 *
 * y = expn( n, x );
 *
 *
 *
 * DESCRIPTION:
 *
 * Evaluates the exponential integral
 *
 *                 inf.
 *                   -
 *                  | |   -xt
 *                  |    e
 *      E (x)  =    |    ----  dt.
 *       n          |      n
 *                | |     t
 *                 -
 *                  1
 *
 *
 * Both n and x must be nonnegative.
 *
 * The routine employs either a power series, a continued
 * fraction, or an asymptotic formula depending on the
 * relative values of n and x.
 *
 * ACCURACY:
 *
 *                      Relative error:
 * arithmetic   domain     # trials      peak         rms
 *    DEC       0, 30        5000       2.0e-16     4.6e-17
 *    IEEE      0, 30       10000       1.7e-15     3.6e-16
 *
 */

/*							expn.c	*/

/* Cephes Math Library Release 2.8:  June, 2000
   Copyright 1985, 2000 by Stephen L. Moshier */

#include "mconf.h"
#ifdef ANSIPROT
extern double torch_cephes_pow ( double, double );
extern double torch_cephes_gamma ( double );
extern double torch_cephes_log ( double );
extern double torch_cephes_exp ( double );
extern double torch_cephes_fabs ( double );
#else
double torch_cephes_pow(), torch_cephes_gamma(), torch_cephes_log(),
    torch_cephes_exp(), torch_cephes_fabs();
#endif
#define EUL 0.57721566490153286060
#define BIG  1.44115188075855872E+17
extern double torch_cephes_MAXNUM, torch_cephes_MACHEP, torch_cephes_MAXLOG;

double torch_cephes_expn( n, x )
int n;
double x;
{
double ans, r, t, yk, xk;
double pk, pkm1, pkm2, qk, qkm1, qkm2;
double psi, z;
int i, k;
static double big = BIG;

if( n < 0 )
	goto domerr;

if( x < 0 )
	{
domerr:	torch_cephes_mtherr( "expn", DOMAIN );
	return( torch_cephes_MAXNUM );
	}

if( x > torch_cephes_MAXLOG )
	return( 0.0 );

if( x == 0.0 )
	{
	if( n < 2 )
		{
		torch_cephes_mtherr( "expn", SING );
		return( torch_cephes_MAXNUM );
		}
	else
		return( 1.0/(n-1.0) );
	}

if( n == 0 )
	return( torch_cephes_exp(-x)/x );

/*							expn.c	*/
/*		Expansion for large n		*/

if( n > 5000 )
	{
	xk = x + n;
	yk = 1.0 / (xk * xk);
	t = n;
	ans = yk * t * (6.0 * x * x  -  8.0 * t * x  +  t * t);
	ans = yk * (ans + t * (t  -  2.0 * x));
	ans = yk * (ans + t);
	ans = (ans + 1.0) * torch_cephes_exp( -x ) / xk;
	goto done;
	}

if( x > 1.0 )
	goto cfrac;

/*							expn.c	*/

/*		Power series expansion		*/

psi = -EUL - log(x);
for( i=1; i<n; i++ )
	psi = psi + 1.0/i;

z = -x;
xk = 0.0;
yk = 1.0;
pk = 1.0 - n;
if( n == 1 )
	ans = 0.0;
else
	ans = 1.0/pk;
do
	{
	xk += 1.0;
	yk *= z/xk;
	pk += 1.0;
	if( pk != 0.0 )
		{
		ans += yk/pk;
		}
	if( ans != 0.0 )
		t = fabs(yk/ans);
	else
		t = 1.0;
	}
while( t > torch_cephes_MACHEP );
k = xk;
t = n;
r = n - 1;
ans = (torch_cephes_pow(z, r) * psi / gamma(t)) - ans;
goto done;

/*							expn.c	*/
/*		continued fraction		*/
cfrac:
k = 1;
pkm2 = 1.0;
qkm2 = x;
pkm1 = 1.0;
qkm1 = x + n;
ans = pkm1/qkm1;

do
	{
	k += 1;
	if( k & 1 )
		{
		yk = 1.0;
		xk = n + (k-1)/2;
		}
	else
		{
		yk = x;
		xk = k/2;
		}
	pk = pkm1 * yk  +  pkm2 * xk;
	qk = qkm1 * yk  +  qkm2 * xk;
	if( qk != 0 )
		{
		r = pk/qk;
		t = torch_cephes_fabs( (ans - r)/r );
		ans = r;
		}
	else
		t = 1.0;
	pkm2 = pkm1;
	pkm1 = pk;
	qkm2 = qkm1;
	qkm1 = qk;
if( fabs(pk) > big )
		{
		pkm2 /= big;
		pkm1 /= big;
		qkm2 /= big;
		qkm1 /= big;
		}
	}
while( t > torch_cephes_MACHEP );

ans *= torch_cephes_exp( -x );

done:
return( ans );
}
