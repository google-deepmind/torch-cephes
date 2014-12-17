/*							ellik.c
 *
 *	Incomplete elliptic integral of the first kind
 *
 *
 *
 * SYNOPSIS:
 *
 * double phi, m, y, ellik();
 *
 * y = ellik( phi, m );
 *
 *
 *
 * DESCRIPTION:
 *
 * Approximates the integral
 *
 *
 *
 *                phi
 *                 -
 *                | |
 *                |           dt
 * F(phi_\m)  =    |    ------------------
 *                |                   2
 *              | |    sqrt( 1 - m sin t )
 *               -
 *                0
 *
 * of amplitude phi and modulus m, using the arithmetic -
 * geometric mean algorithm.
 *
 *
 *
 *
 * ACCURACY:
 *
 * Tested at random points with m in [0, 1] and phi as indicated.
 *
 *                      Relative error:
 * arithmetic   domain     # trials      peak         rms
 *    IEEE     -10,10       200000      7.4e-16     1.0e-16
 *
 *
 */


/*
Cephes Math Library Release 2.8:  June, 2000
Copyright 1984, 1987, 2000 by Stephen L. Moshier
*/

/*	Incomplete elliptic integral of first kind	*/

#include "mconf.h"
#ifdef ANSIPROT
extern double torch_cephes_sqrt ( double );
extern double torch_cephes_fabs ( double );
extern double torch_cephes_log ( double );
extern double torch_cephes_tan ( double );
extern double torch_cephes_atan ( double );
extern double torch_cephes_floor ( double );
extern double torch_cephes_ellpk ( double );
double torch_cephes_ellik ( double, double );
#else
double torch_cephes_sqrt(), torch_cephes_fabs(), torch_cephes_log(),
    torch_cephes_tan(), torch_cephes_atan(), torch_cephes_floor(),
    torch_cephes_ellpk();
double torch_cephes_ellik();
#endif
extern double torch_cephes_PI, torch_cephes_PIO2, torch_cephes_MACHEP,
    torch_cephes_MAXNUM;

double torch_cephes_ellik( phi, m )
double phi, m;
{
double a, b, c, e, temp, t, K;
int d, mod, sign, npio2;

if( m == 0.0 )
	return( phi );
a = 1.0 - m;
if( a == 0.0 )
	{
	if( torch_cephes_fabs(phi) >= torch_cephes_PIO2 )
		{
		torch_cephes_mtherr( "ellik", SING );
		return( torch_cephes_MAXNUM );
		}
	return(  torch_cephes_log(  torch_cephes_tan(
            (torch_cephes_PIO2 + phi)/2.0 )  )   );
	}
npio2 = torch_cephes_floor( phi/torch_cephes_PIO2 );
if( npio2 & 1 )
	npio2 += 1;
if( npio2 )
	{
	K = torch_cephes_ellpk( a );
	phi = phi - npio2 * torch_cephes_PIO2;
	}
else
	K = 0.0;
if( phi < 0.0 )
	{
	phi = -phi;
	sign = -1;
	}
else
	sign = 0;
b = torch_cephes_sqrt(a);
t = torch_cephes_tan( phi );
if( torch_cephes_fabs(t) > 10.0 )
	{
	/* Transform the amplitude */
	e = 1.0/(b*t);
	/* ... but avoid multiple recursions.  */
	if( torch_cephes_fabs(e) < 10.0 )
		{
		e = torch_cephes_atan(e);
		if( npio2 == 0 )
			K = torch_cephes_ellpk( a );
		temp = K - torch_cephes_ellik( e, m );
		goto done;
		}
	}
a = 1.0;
c = torch_cephes_sqrt(m);
d = 1;
mod = 0;

while( torch_cephes_fabs(c/a) > torch_cephes_MACHEP )
	{
	temp = b/a;
	phi = phi + torch_cephes_atan(t*temp) + mod * torch_cephes_PI;
	mod = (phi + torch_cephes_PIO2)/torch_cephes_PI;
	t = t * ( 1.0 + temp )/( 1.0 - temp * t * t );
	c = ( a - b )/2.0;
	temp = torch_cephes_sqrt( a * b );
	a = ( a + b )/2.0;
	b = temp;
	d += d;
	}

temp = (torch_cephes_atan(t) + mod * torch_cephes_PI)/(d * a);

done:
if( sign < 0 )
	temp = -temp;
temp += npio2 * K;
return( temp );
}
