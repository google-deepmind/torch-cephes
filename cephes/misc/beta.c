/*							beta.c
 *
 *	Beta function
 *
 *
 *
 * SYNOPSIS:
 *
 * double a, b, y, beta();
 *
 * y = beta( a, b );
 *
 *
 *
 * DESCRIPTION:
 *
 *                   -     -
 *                  | (a) | (b)
 * beta( a, b )  =  -----------.
 *                     -
 *                    | (a+b)
 *
 * For large arguments the logarithm of the function is
 * evaluated using lgam(), then exponentiated.
 *
 *
 *
 * ACCURACY:
 *
 *                      Relative error:
 * arithmetic   domain     # trials      peak         rms
 *    DEC        0,30        1700       7.7e-15     1.5e-15
 *    IEEE       0,30       30000       8.1e-14     1.1e-14
 *
 * ERROR MESSAGES:
 *
 *   message         condition          value returned
 * beta overflow    log(beta) > MAXLOG       0.0
 *                  a or b <0 integer        0.0
 *
 */

/*							beta.c	*/


/*
Cephes Math Library Release 2.0:  April, 1987
Copyright 1984, 1987 by Stephen L. Moshier
Direct inquiries to 30 Frost Street, Cambridge, MA 02140
*/

#include "mconf.h"

#ifdef UNK
#define MAXGAM 34.84425627277176174
#endif
#ifdef DEC
#define MAXGAM 34.84425627277176174
#endif
#ifdef IBMPC
#define MAXGAM 171.624376956302725
#endif
#ifdef MIEEE
#define MAXGAM 171.624376956302725
#endif

#ifdef ANSIPROT
extern double torch_cephes_fabs ( double );
extern double torch_cephes_gamma ( double );
extern double torch_cephes_lgam ( double );
extern double torch_cephes_exp ( double );
extern double torch_cephes_log ( double );
extern double torch_cephes_floor ( double );
#else
double torch_cephes_fabs(), torch_cephes_gamma(), torch_cephes_lgam(),
    torch_cephes_exp(), torch_cephes_log(), torch_cephes_floor();
#endif
extern double torch_cephes_MAXLOG, torch_cephes_MAXNUM;
extern int torch_cephes_sgngam;

double torch_cephes_beta( a, b )
double a, b;
{
double y;
int sign;

sign = 1;

if( a <= 0.0 )
	{
	if( a == torch_cephes_floor(a) )
		goto over;
	}
if( b <= 0.0 )
	{
	if( b == torch_cephes_floor(b) )
		goto over;
	}


y = a + b;
if( torch_cephes_fabs(y) > MAXGAM )
	{
	y = torch_cephes_lgam(y);
	sign *= torch_cephes_sgngam; /* keep track of the sign */
	y = torch_cephes_lgam(b) - y;
	sign *= torch_cephes_sgngam;
	y = torch_cephes_lgam(a) + y;
	sign *= torch_cephes_sgngam;
	if( y > torch_cephes_MAXLOG )
		{
over:
		torch_cephes_mtherr( "beta", OVERFLOW );
		return( sign * torch_cephes_MAXNUM );
		}
	return( sign * torch_cephes_exp(y) );
	}

y = torch_cephes_gamma(y);
if( y == 0.0 )
	goto over;

if( a > b )
	{
	y = torch_cephes_gamma(a)/y;
	y *= torch_cephes_gamma(b);
	}
else
	{
	y = torch_cephes_gamma(b)/y;
	y *= torch_cephes_gamma(a);
	}

return(y);
}



/* Natural log of |beta|.  Return the sign of beta in sgngam.  */

double torch_cephes_lbeta( a, b )
double a, b;
{
double y;
int sign;

sign = 1;

if( a <= 0.0 )
	{
	if( a == torch_cephes_floor(a) )
		goto over;
	}
if( b <= 0.0 )
	{
	if( b == torch_cephes_floor(b) )
		goto over;
	}


y = a + b;
if( torch_cephes_fabs(y) > MAXGAM )
	{
	y = torch_cephes_lgam(y);
	sign *= torch_cephes_sgngam; /* keep track of the sign */
	y = torch_cephes_lgam(b) - y;
	sign *= torch_cephes_sgngam;
	y = torch_cephes_lgam(a) + y;
	sign *= torch_cephes_sgngam;
	torch_cephes_sgngam = sign;
	return( y );
	}

y = torch_cephes_gamma(y);
if( y == 0.0 )
	{
over:
	torch_cephes_mtherr( "lbeta", OVERFLOW );
	return( sign * torch_cephes_MAXNUM );
	}

if( a > b )
	{
	y = torch_cephes_gamma(a)/y;
	y *= torch_cephes_gamma(b);
	}
else
	{
	y = torch_cephes_gamma(b)/y;
	y *= torch_cephes_gamma(a);
	}

if( y < 0 )
  {
    torch_cephes_sgngam = -1;
    y = -y;
  }
else
  torch_cephes_sgngam = 1;

return( torch_cephes_log(y) );
}
