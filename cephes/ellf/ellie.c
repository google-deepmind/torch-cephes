/*							ellie.c
 *
 *	Incomplete elliptic integral of the second kind
 *
 *
 *
 * SYNOPSIS:
 *
 * double phi, m, y, ellie();
 *
 * y = ellie( phi, m );
 *
 *
 *
 * DESCRIPTION:
 *
 * Approximates the integral
 *
 *
 *                phi
 *                 -
 *                | |
 *                |                   2
 * E(phi_\m)  =    |    sqrt( 1 - m sin t ) dt
 *                |
 *              | |    
 *               -
 *                0
 *
 * of amplitude phi and modulus m, using the arithmetic -
 * geometric mean algorithm.
 *
 *
 *
 * ACCURACY:
 *
 * Tested at random arguments with phi in [-10, 10] and m in
 * [0, 1].
 *                      Relative error:
 * arithmetic   domain     # trials      peak         rms
 *    DEC        0,2         2000       1.9e-16     3.4e-17
 *    IEEE     -10,10      150000       3.3e-15     1.4e-16
 *
 *
 */


/*
Cephes Math Library Release 2.8:  June, 2000
Copyright 1984, 1987, 1993, 2000 by Stephen L. Moshier
*/

/*	Incomplete elliptic integral of second kind	*/
#include "mconf.h"
extern double torch_cephes_PI, torch_cephes_PIO2, torch_cephes_MACHEP;
#ifdef ANSIPROT
extern double torch_cephes_sqrt ( double );
extern double torch_cephes_fabs ( double );
extern double torch_cephes_log ( double );
extern double torch_cephes_sin ( double x );
extern double torch_cephes_tan ( double x );
extern double torch_cephes_atan ( double );
extern double torch_cephes_floor ( double );
extern double torch_cephes_ellpe ( double );
extern double torch_cephes_ellpk ( double );
double torch_cephes_ellie ( double, double );
#else
double torch_cephes_sqrt(), torch_cephes_fabs(), torch_cephes_log(),
    torch_cephes_sin(), torch_cephes_tan(), torch_cephes_atan(),
    torch_cephes_floor();
double torch_cephes_ellpe(), torch_cephes_ellpk(),
    torch_cephes_ellie();
#endif

double torch_cephes_ellie( phi, m )
double phi, m;
{
double a, b, c, e, temp;
double lphi, t, E;
int d, mod, npio2, sign;

if( m == 0.0 )
	return( phi );
lphi = phi;
npio2 = torch_cephes_floor( lphi/torch_cephes_PIO2 );
if( npio2 & 1 )
	npio2 += 1;
lphi = lphi - npio2 * torch_cephes_PIO2;
if( lphi < 0.0 )
	{
	lphi = -lphi;
	sign = -1;
	}
else
	{
	sign = 1;
	}
a = 1.0 - m;
E = torch_cephes_ellpe( a );
if( a == 0.0 )
	{
	temp = torch_cephes_sin( lphi );
	goto done;
	}
t = torch_cephes_tan( lphi );
b = torch_cephes_sqrt(a);
/* Thanks to Brian Fitzgerald <fitzgb@mml0.meche.rpi.edu>
   for pointing out an instability near odd multiples of pi/2.  */
if( torch_cephes_fabs(t) > 10.0 )
	{
	/* Transform the amplitude */
	e = 1.0/(b*t);
	/* ... but avoid multiple recursions.  */
	if( torch_cephes_fabs(e) < 10.0 )
		{
		e = torch_cephes_atan(e);
		temp = E + m * torch_cephes_sin( lphi ) * torch_cephes_sin( e )
                    - torch_cephes_ellie( e, m );
		goto done;
		}
	}
c = torch_cephes_sqrt(m);
a = 1.0;
d = 1;
e = 0.0;
mod = 0;

while( torch_cephes_fabs(c/a) > torch_cephes_MACHEP )
	{
	temp = b/a;
	lphi = lphi + torch_cephes_atan(t*temp) + mod * torch_cephes_PI;
	mod = (lphi + torch_cephes_PIO2)/torch_cephes_PI;
	t = t * ( 1.0 + temp )/( 1.0 - temp * t * t );
	c = ( a - b )/2.0;
	temp = torch_cephes_sqrt( a * b );
	a = ( a + b )/2.0;
	b = temp;
	d += d;
	e += c * torch_cephes_sin(lphi);
	}

temp = E / torch_cephes_ellpk( 1.0 - m );
temp *= (torch_cephes_atan(t) + mod * torch_cephes_PI)/(d * a);
temp += e;

done:

if( sign < 0 )
	temp = -temp;
temp += npio2 * E;
return( temp );
}
