/*							ellpj.c
 *
 *	Jacobian Elliptic Functions
 *
 *
 *
 * SYNOPSIS:
 *
 * double u, m, sn, cn, dn, phi;
 * int ellpj();
 *
 * ellpj( u, m, _&sn, _&cn, _&dn, _&phi );
 *
 *
 *
 * DESCRIPTION:
 *
 *
 * Evaluates the Jacobian elliptic functions sn(u|m), cn(u|m),
 * and dn(u|m) of parameter m between 0 and 1, and real
 * argument u.
 *
 * These functions are periodic, with quarter-period on the
 * real axis equal to the complete elliptic integral
 * ellpk(1.0-m).
 *
 * Relation to incomplete elliptic integral:
 * If u = ellik(phi,m), then sn(u|m) = sin(phi),
 * and cn(u|m) = cos(phi).  Phi is called the amplitude of u.
 *
 * Computation is by means of the arithmetic-geometric mean
 * algorithm, except when m is within 1e-9 of 0 or 1.  In the
 * latter case with m close to 1, the approximation applies
 * only for phi < pi/2.
 *
 * ACCURACY:
 *
 * Tested at random points with u between 0 and 10, m between
 * 0 and 1.
 *
 *            Absolute error (* = relative error):
 * arithmetic   function   # trials      peak         rms
 *    DEC       sn           1800       4.5e-16     8.7e-17
 *    IEEE      phi         10000       9.2e-16*    1.4e-16*
 *    IEEE      sn          50000       4.1e-15     4.6e-16
 *    IEEE      cn          40000       3.6e-15     4.4e-16
 *    IEEE      dn          10000       1.3e-12     1.8e-14
 *
 *  Peak error observed in consistency check using addition
 * theorem for sn(u+v) was 4e-16 (absolute).  Also tested by
 * the above relation to the incomplete elliptic integral.
 * Accuracy deteriorates when u is large.
 *
 */

/*							ellpj.c		*/


/*
Cephes Math Library Release 2.8:  June, 2000
Copyright 1984, 1987, 2000 by Stephen L. Moshier
*/

#include "mconf.h"
#ifdef ANSIPROT
extern double torch_cephes_sqrt ( double );
extern double torch_cephes_fabs ( double );
extern double torch_cephes_sin ( double );
extern double torch_cephes_cos ( double );
extern double torch_cephes_asin ( double );
extern double torch_cephes_tanh ( double );
extern double torch_cephes_sinh ( double );
extern double torch_cephes_cosh ( double );
extern double torch_cephes_atan ( double );
extern double torch_cephes_exp ( double );
#else
double torch_cephes_sqrt(), torch_cephes_fabs(), torch_cephes_sin(),
    torch_cephes_cos(), torch_cephes_asin(), torch_cephes_tanh();
double torch_cephes_sinh(), torch_cephes_cosh(), torch_cephes_atan(),
    torch_cephes_exp();
#endif
extern double torch_cephes_PIO2, torch_cephes_MACHEP;

int torch_cephes_ellpj( u, m, sn, cn, dn, ph )
double u, m;
double *sn, *cn, *dn, *ph;
{
double ai, b, phi, t, twon;
double a[9], c[9];
int i;


/* Check for special cases */

if( m < 0.0 || m > 1.0 )
	{
	torch_cephes_mtherr( "ellpj", DOMAIN );
	*sn = 0.0;
	*cn = 0.0;
	*ph = 0.0;
	*dn = 0.0;
	return(-1);
	}
if( m < 1.0e-9 )
	{
	t = torch_cephes_sin(u);
	b = torch_cephes_cos(u);
	ai = 0.25 * m * (u - t*b);
	*sn = t - ai*b;
	*cn = b + ai*t;
	*ph = u - ai;
	*dn = 1.0 - 0.5*m*t*t;
	return(0);
	}

if( m >= 0.9999999999 )
	{
	ai = 0.25 * (1.0-m);
	b = torch_cephes_cosh(u);
	t = torch_cephes_tanh(u);
	phi = 1.0/b;
	twon = b * torch_cephes_sinh(u);
	*sn = t + ai * (twon - u)/(b*b);
	*ph = 2.0*torch_cephes_atan(torch_cephes_exp(u)) - torch_cephes_PIO2 +
            ai*(twon - u)/b;
	ai *= t * phi;
	*cn = phi - ai * (twon - u);
	*dn = phi + ai * (twon + u);
	return(0);
	}


/*	A. G. M. scale		*/
a[0] = 1.0;
b = torch_cephes_sqrt(1.0 - m);
c[0] = torch_cephes_sqrt(m);
twon = 1.0;
i = 0;

while( torch_cephes_fabs(c[i]/a[i]) > torch_cephes_MACHEP )
	{
	if( i > 7 )
		{
		torch_cephes_mtherr( "ellpj", OVERFLOW );
		goto done;
		}
	ai = a[i];
	++i;
	c[i] = ( ai - b )/2.0;
	t = torch_cephes_sqrt( ai * b );
	a[i] = ( ai + b )/2.0;
	b = t;
	twon *= 2.0;
	}

done:

/* backward recurrence */
phi = twon * a[i] * u;
do
	{
	t = c[i] * torch_cephes_sin(phi) / a[i];
	b = phi;
	phi = (torch_cephes_asin(t) + phi)/2.0;
	}
while( --i );

*sn = torch_cephes_sin(phi);
t = torch_cephes_cos(phi);
*cn = t;
*dn = t/torch_cephes_cos(phi-b);
*ph = phi;
return(0);
}
