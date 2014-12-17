/*							pdtr.c
 *
 *	Poisson distribution
 *
 *
 *
 * SYNOPSIS:
 *
 * int k;
 * double m, y, pdtr();
 *
 * y = pdtr( k, m );
 *
 *
 *
 * DESCRIPTION:
 *
 * Returns the sum of the first k terms of the Poisson
 * distribution:
 *
 *   k         j
 *   --   -m  m
 *   >   e    --
 *   --       j!
 *  j=0
 *
 * The terms are not summed directly; instead the incomplete
 * gamma integral is employed, according to the relation
 *
 * y = pdtr( k, m ) = igamc( k+1, m ).
 *
 * The arguments must both be positive.
 *
 *
 *
 * ACCURACY:
 *
 * See igamc().
 *
 */
/*							pdtrc()
 *
 *	Complemented poisson distribution
 *
 *
 *
 * SYNOPSIS:
 *
 * int k;
 * double m, y, pdtrc();
 *
 * y = pdtrc( k, m );
 *
 *
 *
 * DESCRIPTION:
 *
 * Returns the sum of the terms k+1 to infinity of the Poisson
 * distribution:
 *
 *  inf.       j
 *   --   -m  m
 *   >   e    --
 *   --       j!
 *  j=k+1
 *
 * The terms are not summed directly; instead the incomplete
 * gamma integral is employed, according to the formula
 *
 * y = pdtrc( k, m ) = igam( k+1, m ).
 *
 * The arguments must both be positive.
 *
 *
 *
 * ACCURACY:
 *
 * See igam.c.
 *
 */
/*							pdtri()
 *
 *	Inverse Poisson distribution
 *
 *
 *
 * SYNOPSIS:
 *
 * int k;
 * double m, y, pdtr();
 *
 * m = pdtri( k, y );
 *
 *
 *
 *
 * DESCRIPTION:
 *
 * Finds the Poisson variable x such that the integral
 * from 0 to x of the Poisson density is equal to the
 * given probability y.
 *
 * This is accomplished using the inverse gamma integral
 * function and the relation
 *
 *    m = igami( k+1, y ).
 *
 *
 *
 *
 * ACCURACY:
 *
 * See igami.c.
 *
 * ERROR MESSAGES:
 *
 *   message         condition      value returned
 * pdtri domain    y < 0 or y >= 1       0.0
 *                     k < 0
 *
 */

/*
Cephes Math Library Release 2.8:  June, 2000
Copyright 1984, 1987, 1995, 2000 by Stephen L. Moshier
*/

#include "mconf.h"
#ifdef ANSIPROT
extern double torch_cephes_igam ( double, double );
extern double torch_cephes_igamc ( double, double );
extern double torch_cephes_igami ( double, double );
#else
double torch_cephes_igam(), torch_cephes_igamc(), torch_cephes_igami();
#endif

double torch_cephes_pdtrc( k, m )
int k;
double m;
{
double v;

if( (k < 0) || (m <= 0.0) )
	{
	torch_cephes_mtherr( "pdtrc", DOMAIN );
	return( 0.0 );
	}
v = k+1;
return( torch_cephes_igam( v, m ) );
}



double torch_cephes_pdtr( k, m )
int k;
double m;
{
double v;

if( (k < 0) || (m <= 0.0) )
	{
	torch_cephes_mtherr( "pdtr", DOMAIN );
	return( 0.0 );
	}
v = k+1;
return( torch_cephes_igamc( v, m ) );
}


double torch_cephes_pdtri( k, y )
int k;
double y;
{
double v;

if( (k < 0) || (y < 0.0) || (y >= 1.0) )
	{
	torch_cephes_mtherr( "pdtri", DOMAIN );
	return( 0.0 );
	}
v = k+1;
v = torch_cephes_igami( v, y );
return( v );
}
