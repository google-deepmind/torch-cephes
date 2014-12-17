/*							hyperg.c
 *
 *	Confluent hypergeometric function
 *
 *
 *
 * SYNOPSIS:
 *
 * double a, b, x, y, hyperg();
 *
 * y = hyperg( a, b, x );
 *
 *
 *
 * DESCRIPTION:
 *
 * Computes the confluent hypergeometric function
 *
 *                          1           2
 *                       a x    a(a+1) x
 *   F ( a,b;x )  =  1 + ---- + --------- + ...
 *  1 1                  b 1!   b(b+1) 2!
 *
 * Many higher transcendental functions are special cases of
 * this power series.
 *
 * As is evident from the formula, b must not be a negative
 * integer or zero unless a is an integer with 0 >= a > b.
 *
 * The routine attempts both a direct summation of the series
 * and an asymptotic expansion.  In each case error due to
 * roundoff, cancellation, and nonconvergence is estimated.
 * The result with smaller estimated error is returned.
 *
 *
 *
 * ACCURACY:
 *
 * Tested at random points (a, b, x), all three variables
 * ranging from 0 to 30.
 *                      Relative error:
 * arithmetic   domain     # trials      peak         rms
 *    DEC       0,30         2000       1.2e-15     1.3e-16
 qtst1:
 21800   max =  1.4200E-14   rms =  1.0841E-15  ave = -5.3640E-17 
 ltstd:
 25500   max = 1.2759e-14   rms = 3.7155e-16  ave = 1.5384e-18 
 *    IEEE      0,30        30000       1.8e-14     1.1e-15
 *
 * Larger errors can be observed when b is near a negative
 * integer or zero.  Certain combinations of arguments yield
 * serious cancellation error in the power series summation
 * and also are not in the region of near convergence of the
 * asymptotic series.  An error message is printed if the
 * self-estimated relative error is greater than 1.0e-12.
 *
 */

/*							hyperg.c */


/*
Cephes Math Library Release 2.8:  June, 2000
Copyright 1984, 1987, 1988, 2000 by Stephen L. Moshier
*/

#include "mconf.h"

#ifdef ANSIPROT
extern double torch_cephes_exp ( double );
extern double torch_cephes_log ( double );
extern double torch_cephes_gamma ( double );
extern double torch_cephes_lgam ( double );
extern double torch_cephes_fabs ( double );
double torch_cephes_hyp2f0 ( double, double, double, int, double * );
static double hy1f1p(double, double, double, double *);
static double hy1f1a(double, double, double, double *);
double torch_cephes_hyperg (double, double, double);
#else
double torch_cephes_exp(), torch_cephes_log(), torch_cephes_gamma(),
    torch_cephes_lgam(), torch_cephes_fabs(), torch_cephes_hyp2f0();
static double hy1f1p();
static double hy1f1a();
double torch_cephes_hyperg();
#endif
extern double torch_cephes_MAXNUM, torch_cephes_MACHEP;

double torch_cephes_hyperg( a, b, x)
double a, b, x;
{
double asum, psum, acanc, pcanc, temp;

/* See if a Kummer transformation will help */
temp = b - a;
if( torch_cephes_fabs(temp) < 0.001 * torch_cephes_fabs(a) )
	return( torch_cephes_exp(x) * torch_cephes_hyperg( temp, b, -x )  );


psum = hy1f1p( a, b, x, &pcanc );
if( pcanc < 1.0e-15 )
	goto done;


/* try asymptotic series */

asum = hy1f1a( a, b, x, &acanc );


/* Pick the result with less estimated error */

if( acanc < pcanc )
	{
	pcanc = acanc;
	psum = asum;
	}

done:
if( pcanc > 1.0e-12 )
	torch_cephes_mtherr( "hyperg", PLOSS );

return( psum );
}




/* Power series summation for confluent hypergeometric function		*/


static double hy1f1p( a, b, x, err )
double a, b, x;
double *err;
{
double n, a0, sum, t, u, temp;
double an, bn, maxt, pcanc;


/* set up for power series summation */
an = a;
bn = b;
a0 = 1.0;
sum = 1.0;
n = 1.0;
t = 1.0;
maxt = 0.0;


while( t > torch_cephes_MACHEP )
	{
	if( bn == 0 )			/* check bn first since if both	*/
		{
		torch_cephes_mtherr( "hyperg", SING );
		return( torch_cephes_MAXNUM ); 
                /* an and bn are zero it is	*/
		}
	if( an == 0 )			/* a singularity		*/
		return( sum );
	if( n > 200 )
		goto pdone;
	u = x * ( an / (bn * n) );

	/* check for blowup */
	temp = torch_cephes_fabs(u);
	if( (temp > 1.0 ) && (maxt > (torch_cephes_MAXNUM/temp)) )
		{
		pcanc = 1.0;	/* estimate 100% error */
		goto blowup;
		}

	a0 *= u;
	sum += a0;
	t = torch_cephes_fabs(a0);
	if( t > maxt )
		maxt = t;
/*
	if( (maxt/fabs(sum)) > 1.0e17 )
		{
		pcanc = 1.0;
		goto blowup;
		}
*/
	an += 1.0;
	bn += 1.0;
	n += 1.0;
	}

pdone:

/* estimate error due to roundoff and cancellation */
if( sum != 0.0 )
	maxt /= torch_cephes_fabs(sum);
maxt *= torch_cephes_MACHEP; 	/* this way avoids multiply overflow */
pcanc = torch_cephes_fabs( torch_cephes_MACHEP * n  +  maxt );

blowup:

*err = pcanc;

return( sum );
}


/*							hy1f1a()	*/
/* asymptotic formula for hypergeometric function:
 *
 *        (    -a                         
 *  --    ( |z|                           
 * |  (b) ( -------- 2f0( a, 1+a-b, -1/x )
 *        (  --                           
 *        ( |  (b-a)                      
 *
 *
 *                                x    a-b                     )
 *                               e  |x|                        )
 *                             + -------- 2f0( b-a, 1-a, 1/x ) )
 *                                --                           )
 *                               |  (a)                        )
 */

static double hy1f1a( a, b, x, err )
double a, b, x;
double *err;
{
double h1, h2, t, u, temp, acanc, asum, err1, err2;

if( x == 0 )
	{
	acanc = 1.0;
	asum = torch_cephes_MAXNUM;
	goto adone;
	}
temp = torch_cephes_log( torch_cephes_fabs(x) );
t = x + temp * (a-b);
u = -temp * a;

if( b > 0 )
	{
	temp = torch_cephes_lgam(b);
	t += temp;
	u += temp;
	}

h1 = torch_cephes_hyp2f0( a, a-b+1, -1.0/x, 1, &err1 );

temp = torch_cephes_exp(u) / torch_cephes_gamma(b-a);
h1 *= temp;
err1 *= temp;

h2 = torch_cephes_hyp2f0( b-a, 1.0-a, 1.0/x, 2, &err2 );

if( a < 0 )
	temp = torch_cephes_exp(t) / torch_cephes_gamma(a);
else
	temp = torch_cephes_exp( t - torch_cephes_lgam(a) );

h2 *= temp;
err2 *= temp;

if( x < 0.0 )
	asum = h1;
else
	asum = h2;

acanc = torch_cephes_fabs(err1) + torch_cephes_fabs(err2);


if( b < 0 )
	{
	temp = gamma(b);
	asum *= temp;
	acanc *= torch_cephes_fabs(temp);
	}


if( asum != 0.0 )
	acanc /= torch_cephes_fabs(asum);

acanc *= 30.0;	/* fudge factor, since error of asymptotic formula
		 * often seems this much larger than advertised */

adone:


*err = acanc;
return( asum );
}

/*							hyp2f0()	*/

double torch_cephes_hyp2f0( a, b, x, type, err )
double a, b, x;
int type;	/* determines what converging factor to use */
double *err;
{
double a0, alast, t, tlast, maxt;
double n, an, bn, u, sum, temp;

an = a;
bn = b;
a0 = 1.0e0;
alast = 1.0e0;
sum = 0.0;
n = 1.0e0;
t = 1.0e0;
tlast = 1.0e9;
maxt = 0.0;

do
	{
	if( an == 0 )
		goto pdone;
	if( bn == 0 )
		goto pdone;

	u = an * (bn * x / n);

	/* check for blowup */
	temp = torch_cephes_fabs(u);
	if( (temp > 1.0 ) && (maxt > (torch_cephes_MAXNUM/temp)) )
		goto error;

	a0 *= u;
	t = torch_cephes_fabs(a0);

	/* terminating condition for asymptotic series */
	if( t > tlast )
		goto ndone;

	tlast = t;
	sum += alast;	/* the sum is one term behind */
	alast = a0;

	if( n > 200 )
		goto ndone;

	an += 1.0e0;
	bn += 1.0e0;
	n += 1.0e0;
	if( t > maxt )
		maxt = t;
	}
while( t > torch_cephes_MACHEP );


pdone:	/* series converged! */

/* estimate error due to roundoff and cancellation */
*err = torch_cephes_fabs(  torch_cephes_MACHEP * (n + maxt)  );

alast = a0;
goto done;

ndone:	/* series did not converge */

/* The following "Converging factors" are supposed to improve accuracy,
 * but do not actually seem to accomplish very much. */

n -= 1.0;
x = 1.0/x;

switch( type )	/* "type" given as subroutine argument */
{
case 1:
	alast *= ( 0.5 + (0.125 + 0.25*b - 0.5*a + 0.25*x - 0.25*n)/x );
	break;

case 2:
	alast *= 2.0/3.0 - b + 2.0*a + x - n;
	break;

default:
	;
}

/* estimate error due to roundoff, cancellation, and nonconvergence */
*err = torch_cephes_MACHEP * (n + maxt)  +  torch_cephes_fabs ( a0 );


done:
sum += alast;
return( sum );

/* series blew up: */
error:
*err = torch_cephes_MAXNUM;
torch_cephes_mtherr( "hyperg", TLOSS );
return( sum );
}
