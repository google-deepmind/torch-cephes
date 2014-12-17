/*							hyp2f1.c
 *
 *	Gauss hypergeometric function   F
 *	                               2 1
 *
 *
 * SYNOPSIS:
 *
 * double a, b, c, x, y, hyp2f1();
 *
 * y = hyp2f1( a, b, c, x );
 *
 *
 * DESCRIPTION:
 *
 *
 *  hyp2f1( a, b, c, x )  =   F ( a, b; c; x )
 *                           2 1
 *
 *           inf.
 *            -   a(a+1)...(a+k) b(b+1)...(b+k)   k+1
 *   =  1 +   >   -----------------------------  x   .
 *            -         c(c+1)...(c+k) (k+1)!
 *          k = 0
 *
 *  Cases addressed are
 *	Tests and escapes for negative integer a, b, or c
 *	Linear transformation if c - a or c - b negative integer
 *	Special case c = a or c = b
 *	Linear transformation for  x near +1
 *	Transformation for x < -0.5
 *	Psi function expansion if x > 0.5 and c - a - b integer
 *      Conditionally, a recurrence on c to make c-a-b > 0
 *
 * |x| > 1 is rejected.
 *
 * The parameters a, b, c are considered to be integer
 * valued if they are within 1.0e-14 of the nearest integer
 * (1.0e-13 for IEEE arithmetic).
 *
 * ACCURACY:
 *
 *
 *               Relative error (-1 < x < 1):
 * arithmetic   domain     # trials      peak         rms
 *    IEEE      -1,7        230000      1.2e-11     5.2e-14
 *
 * Several special cases also tested with a, b, c in
 * the range -7 to 7.
 *
 * ERROR MESSAGES:
 *
 * A "partial loss of precision" message is printed if
 * the internally estimated relative error exceeds 1^-12.
 * A "singularity" message is printed on overflow or
 * in cases not addressed (such as x < -1).
 */

/*							hyp2f1	*/


/*
Cephes Math Library Release 2.8:  June, 2000
Copyright 1984, 1987, 1992, 2000 by Stephen L. Moshier
*/


#include "mconf.h"

#ifdef DEC
#define EPS 1.0e-14
#define EPS2 1.0e-11
#endif

#ifdef IBMPC
#define EPS 1.0e-13
#define EPS2 1.0e-10
#endif

#ifdef MIEEE
#define EPS 1.0e-13
#define EPS2 1.0e-10
#endif

#ifdef UNK
#define EPS 1.0e-13
#define EPS2 1.0e-10
#endif

#define ETHRESH 1.0e-12

#ifdef ANSIPROT
extern double torch_cephes_fabs ( double );
extern double torch_cephes_pow ( double, double );
extern double torch_cephes_round ( double );
extern double torch_cephes_gamma ( double );
extern double torch_cephes_log ( double );
extern double torch_cephes_exp ( double );
extern double torch_cephes_psi ( double );
static double hyt2f1(double, double, double, double, double *);
static double hys2f1(double, double, double, double, double *);
double torch_cephes_hyp2f1(double, double, double, double);
#else
double torch_cephes_fabs(), torch_cephes_pow(),
    torch_cephes_round(), torch_cephes_gamma(), torch_cephes_log(),
    torch_cephes_exp(), torch_cephes_psi();
static double hyt2f1();
static double hys2f1();
double torch_cephes_hyp2f1();
#endif
extern double torch_cephes_MAXNUM, torch_cephes_MACHEP;

double torch_cephes_hyp2f1( a, b, c, x )
double a, b, c, x;
{
double d, d1, d2, e;
double p, q, r, s, y, ax;
double ia, ib, ic, id, err;
int flag, i, aid;

err = 0.0;
ax = torch_cephes_fabs(x);
s = 1.0 - x;
flag = 0;
ia = torch_cephes_round(a); /* nearest integer to a */
ib = torch_cephes_round(b);

if( a <= 0 )
	{
	if( torch_cephes_fabs(a-ia) < EPS ) /* a is a negative integer */
		flag |= 1;
	}

if( b <= 0 )
	{
	if( torch_cephes_fabs(b-ib) < EPS ) /* b is a negative integer */
		flag |= 2;
	}

if( ax < 1.0 )
	{
	if( torch_cephes_fabs(b-c) < EPS )		/* b = c */
		{
		y = torch_cephes_pow( s, -a );	/* s to the -a power */
		goto hypdon;
		}
	if( torch_cephes_fabs(a-c) < EPS )		/* a = c */
		{
		y = torch_cephes_pow( s, -b );	/* s to the -b power */
		goto hypdon;
		}
	}



if( c <= 0.0 )
	{
	ic = torch_cephes_round(c); 	/* nearest integer to c */
	if( torch_cephes_fabs(c-ic) < EPS ) /* c is a negative integer */
		{
		/* check if termination before explosion */
		if( (flag & 1) && (ia > ic) )
			goto hypok;
		if( (flag & 2) && (ib > ic) )
			goto hypok;
		goto hypdiv;
		}
	}

if( flag )			/* function is a polynomial */
	goto hypok;

if( ax > 1.0 )			/* series diverges	*/
	goto hypdiv;

p = c - a;
ia = torch_cephes_round(p); /* nearest integer to c-a */
if( (ia <= 0.0) && (torch_cephes_fabs(p-ia) < EPS) )	/* negative int c - a */
	flag |= 4;

r = c - b;
ib = torch_cephes_round(r); /* nearest integer to c-b */
if( (ib <= 0.0) && (torch_cephes_fabs(r-ib) < EPS) )	/* negative int c - b */
	flag |= 8;

d = c - a - b;
id = torch_cephes_round(d); /* nearest integer to d */
q = torch_cephes_fabs(d-id);

/* Thanks to Christian Burger <BURGER@DMRHRZ11.HRZ.Uni-Marburg.DE>
 * for reporting a bug here.  */
if( torch_cephes_fabs(ax-1.0) < EPS )			/* |x| == 1.0	*/
	{
	if( x > 0.0 )
		{
		if( flag & 12 ) /* negative int c-a or c-b */
			{
			if( d >= 0.0 )
				goto hypf;
			else
				goto hypdiv;
			}
		if( d <= 0.0 )
			goto hypdiv;
		y = torch_cephes_gamma(c)*torch_cephes_gamma(d)/
                    (torch_cephes_gamma(p)*torch_cephes_gamma(r));
		goto hypdon;
		}

	if( d <= -1.0 )
		goto hypdiv;

	}

/* Conditionally make d > 0 by recurrence on c
 * AMS55 #15.2.27
 */
if( d < 0.0 )
	{
/* Try the power series first */
	y = hyt2f1( a, b, c, x, &err );
	if( err < ETHRESH )
		goto hypdon;
/* Apply the recurrence if power series fails */
	err = 0.0;
	aid = 2 - id;
	e = c + aid;
	d2 = torch_cephes_hyp2f1(a,b,e,x);
	d1 = torch_cephes_hyp2f1(a,b,e+1.0,x);
	q = a + b + 1.0;
	for( i=0; i<aid; i++ )
		{
		r = e - 1.0;
		y = (e*(r-(2.0*e-q)*x)*d2 + (e-a)*(e-b)*x*d1)/(e*r*s);
		e = r;
		d1 = d2;
		d2 = y;
		}
	goto hypdon;
	}


if( flag & 12 )
	goto hypf; /* negative integer c-a or c-b */

hypok:
y = hyt2f1( a, b, c, x, &err );


hypdon:
if( err > ETHRESH )
	{
	torch_cephes_mtherr( "hyp2f1", PLOSS );
/*	printf( "Estimated err = %.2e\n", err ); */
	}
return(y);

/* The transformation for c-a or c-b negative integer
 * AMS55 #15.3.3
 */
hypf:
y = torch_cephes_pow( s, d ) * hys2f1( c-a, c-b, c, x, &err );
goto hypdon;

/* The alarm exit */
hypdiv:
torch_cephes_mtherr( "hyp2f1", OVERFLOW );
return( torch_cephes_MAXNUM );
}






/* Apply transformations for |x| near 1
 * then call the power series
 */
static double hyt2f1( a, b, c, x, loss )
double a, b, c, x;
double *loss;
{
double p, q, r, s, t, y, d, err, err1;
double ax, id, d1, d2, e, y1;
int i, aid;

err = 0.0;
s = 1.0 - x;
if( x < -0.5 )
	{
	if( b > a )
		y = torch_cephes_pow( s, -a ) *
                    hys2f1( a, c-b, c, -x/s, &err );

	else
		y = torch_cephes_pow( s, -b ) *
                    hys2f1( c-a, b, c, -x/s, &err );

	goto done;
	}

d = c - a - b;
id = torch_cephes_round(d);	/* nearest integer to d */

if( x > 0.9 )
{
if( torch_cephes_fabs(d-id) > EPS ) /* test for integer c-a-b */
	{
/* Try the power series first */
	y = hys2f1( a, b, c, x, &err );
	if( err < ETHRESH )
		goto done;
/* If power series fails, then apply AMS55 #15.3.6 */
	q = hys2f1( a, b, 1.0-d, s, &err );
	q *= torch_cephes_gamma(d) /(torch_cephes_gamma(c-a) *
                                     torch_cephes_gamma(c-b));
	r = torch_cephes_pow(s,d) * hys2f1(
            c-a, c-b, d+1.0, s, &err1 );
	r *= torch_cephes_gamma(-d)/(torch_cephes_gamma(a) *
                                     torch_cephes_gamma(b));
	y = q + r;

	q = torch_cephes_fabs(q); /* estimate cancellation error */
	r = torch_cephes_fabs(r);
	if( q > r )
		r = q;
	err += err1 + (torch_cephes_MACHEP*r)/y;

	y *= torch_cephes_gamma(c);
	goto done;
	}
else
	{
/* Psi function expansion, AMS55 #15.3.10, #15.3.11, #15.3.12 */
	if( id >= 0.0 )
		{
		e = d;
		d1 = d;
		d2 = 0.0;
		aid = id;
		}
	else
		{
		e = -d;
		d1 = 0.0;
		d2 = d;
		aid = -id;
		}

	ax = torch_cephes_log(s);

	/* sum for t = 0 */
	y = torch_cephes_psi(1.0) + torch_cephes_psi(1.0+e) -
            torch_cephes_psi(a+d1) - torch_cephes_psi(b+d1) - ax;
	y /= torch_cephes_gamma(e+1.0);

	p = (a+d1) * (b+d1) * s / torch_cephes_gamma(e+2.0); /* Poch for t=1 */
	t = 1.0;
	do
		{
		r = torch_cephes_psi(1.0+t) + torch_cephes_psi(1.0+t+e)
                    - torch_cephes_psi(a+t+d1)
			- torch_cephes_psi(b+t+d1) - ax;
		q = p * r;
		y += q;
		p *= s * (a+t+d1) / (t+1.0);
		p *= (b+t+d1) / (t+1.0+e);
		t += 1.0;
		}
	while( torch_cephes_fabs(q/y) > EPS );


	if( id == 0.0 )
		{
		y *= torch_cephes_gamma(c)/(torch_cephes_gamma(a)*
                                            torch_cephes_gamma(b));
		goto psidon;
		}

	y1 = 1.0;

	if( aid == 1 )
		goto nosum;

	t = 0.0;
	p = 1.0;
	for( i=1; i<aid; i++ )
		{
		r = 1.0-e+t;
		p *= s * (a+t+d2) * (b+t+d2) / r;
		t += 1.0;
		p /= t;
		y1 += p;
		}
nosum:
	p = torch_cephes_gamma(c);
	y1 *= torch_cephes_gamma(e) * p / (torch_cephes_gamma(a+d1) *
                                           torch_cephes_gamma(b+d1));

	y *= p / (torch_cephes_gamma(a+d2) * torch_cephes_gamma(b+d2));
	if( (aid & 1) != 0 )
		y = -y;

	q = torch_cephes_pow( s, id );	/* s to the id power */
	if( id > 0.0 )
		y *= q;
	else
		y1 *= q;

	y += y1;
psidon:
	goto done;
	}

}

/* Use defining power series if no special cases */
y = hys2f1( a, b, c, x, &err );

done:
*loss = err;
return(y);
}





/* Defining power series expansion of Gauss hypergeometric function */

static double hys2f1( a, b, c, x, loss )
double a, b, c, x;
double *loss; /* estimates loss of significance */
{
double f, g, h, k, m, s, u, umax;
int i;

i = 0;
umax = 0.0;
f = a;
g = b;
h = c;
s = 1.0;
u = 1.0;
k = 0.0;
do
	{
	if( fabs(h) < EPS )
		{
		*loss = 1.0;
		return( torch_cephes_MAXNUM );
		}
	m = k + 1.0;
	u = u * ((f+k) * (g+k) * x / ((h+k) * m));
	s += u;
	k = fabs(u);  /* remember largest term summed */
	if( k > umax )
		umax = k;
	k = m;
	if( ++i > 10000 ) /* should never happen */
		{
		*loss = 1.0;
		return(s);
		}
	}
while( torch_cephes_fabs(u/s) > torch_cephes_MACHEP );

/* return estimated relative error */
*loss = (torch_cephes_MACHEP*umax)/torch_cephes_fabs(s) +
    (torch_cephes_MACHEP*i);

return(s);
}
