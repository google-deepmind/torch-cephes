
/* Re Kolmogorov statistics, here is Birnbaum and Tingey's formula for the
   distribution of D+, the maximum of all positive deviations between a
   theoretical distribution function P(x) and an empirical one Sn(x)
   from n samples.

     +
    D  =         sup     [P(x) - S (x)]
     n     -inf < x < inf         n


                  [n(1-e)]
        +            -                    v-1              n-v
    Pr{D   > e} =    >    C    e (e + v/n)    (1 - e - v/n)
        n            -   n v
                    v=0

    [n(1-e)] is the largest integer not exceeding n(1-e).
    nCv is the number of combinations of n things taken v at a time.  */


#include "mconf.h"
#ifdef ANSIPROT
extern double torch_cephes_pow ( double, double );
extern double torch_cephes_floor ( double );
extern double torch_cephes_lgam ( double );
extern double torch_cephes_exp ( double );
extern double torch_cephes_sqrt ( double );
extern double torch_cephes_log ( double );
extern double torch_cephes_fabs ( double );
double torch_cephes_smirnov ( int, double );
double torch_cephes_kolmogorov ( double );
#else
double torch_cephes_pow (), torch_cephes_floor (), torch_cephes_lgam (),
    torch_cephes_exp (), torch_cephes_sqrt (), torch_cephes_log (),
    torch_cephes_fabs ();
double torch_cephes_smirnov (), torch_cephes_kolmogorov ();
#endif
extern double torch_cephes_MAXLOG;

/* Exact Smirnov statistic, for one-sided test.  */
double
torch_cephes_smirnov (n, e)
     int n;
     double e;
{
  int v, nn;
  double evn, omevn, p, t, c, lgamnp1;

  if (n <= 0 || e < 0.0 || e > 1.0)
    return (-1.0);
  nn = torch_cephes_floor ((double) n * (1.0 - e));
  p = 0.0;
  if (n < 1013)
    {
      c = 1.0;
      for (v = 0; v <= nn; v++)
	{
	  evn = e + ((double) v) / n;
	  p += c * torch_cephes_pow (evn, (double) (v - 1))
	    * torch_cephes_pow (1.0 - evn, (double) (n - v));
	  /* Next combinatorial term; worst case error = 4e-15.  */
	  c *= ((double) (n - v)) / (v + 1);
	}
    }
  else
    {
      lgamnp1 = torch_cephes_lgam ((double) (n + 1));
      for (v = 0; v <= nn; v++)
	{
	  evn = e + ((double) v) / n;
	  omevn = 1.0 - evn;
	  if (torch_cephes_fabs (omevn) > 0.0)
	    {
	      t = lgamnp1
		- torch_cephes_lgam ((double) (v + 1))
		- torch_cephes_lgam ((double) (n - v + 1))
		+ (v - 1) * torch_cephes_log (evn)
		+ (n - v) * torch_cephes_log (omevn);
	      if (t > -torch_cephes_MAXLOG)
		p += torch_cephes_exp (t);
	    }
	}
    }
  return (p * e);
}


/* Kolmogorov's limiting distribution of two-sided test, returns
   probability that sqrt(n) * max deviation > y,
   or that max deviation > y/sqrt(n).
   The approximation is useful for the tail of the distribution
   when n is large.  */
double
torch_cephes_kolmogorov (y)
     double y;
{
  double p, t, r, sign, x;

  x = -2.0 * y * y;
  sign = 1.0;
  p = 0.0;
  r = 1.0;
  do
    {
      t = torch_cephes_exp (x * r * r);
      p += sign * t;
      if (t == 0.0)
	break;
      r += 1.0;
      sign = -sign;
    }
  while ((t / p) > 1.1e-16);
  return (p + p);
}

/* Functional inverse of Smirnov distribution
   finds e such that smirnov(n,e) = p.  */
double
torch_cephes_smirnovi (n, p)
     int n;
     double p;
{
  double e, t, dpde;

  if (p <= 0.0 || p > 1.0)
    {
      torch_cephes_mtherr ("smirnovi", DOMAIN);
      return 0.0;
    }
  /* Start with approximation p = exp(-2 n e^2).  */
  e = torch_cephes_sqrt (-torch_cephes_log (p) / (2.0 * n));
  do
    {
      /* Use approximate derivative in Newton iteration. */
      t = -2.0 * n * e;
      dpde = 2.0 * t * torch_cephes_exp (t * e);
      if (torch_cephes_fabs (dpde) > 0.0)
	t = (p - torch_cephes_smirnov (n, e)) / dpde;
      else
	{
	  torch_cephes_mtherr ("smirnovi", UNDERFLOW);
	  return 0.0;
	}
      e = e + t;
      if (e >= 1.0 || e <= 0.0)
	{
	  torch_cephes_mtherr ("smirnovi", OVERFLOW);
	  return 0.0;
	}
    }
  while (torch_cephes_fabs (t / e) > 1e-10);
  return (e);
}


/* Functional inverse of Kolmogorov statistic for two-sided test.
   Finds y such that kolmogorov(y) = p.
   If e = smirnovi (n,p), then kolmogi(2 * p) / sqrt(n) should
   be close to e.  */
double
torch_cephes_kolmogi (p)
     double p;
{
  double y, t, dpdy;

  if (p <= 0.0 || p > 1.0)
    {
      torch_cephes_mtherr ("kolmogi", DOMAIN);
      return 0.0;
    }
  /* Start with approximation p = 2 exp(-2 y^2).  */
  y = torch_cephes_sqrt (-0.5 * torch_cephes_log (0.5 * p));
  do
    {
      /* Use approximate derivative in Newton iteration. */
      t = -2.0 * y;
      dpdy = 4.0 * t * exp (t * y);
      if (torch_cephes_fabs (dpdy) > 0.0)
	t = (p - torch_cephes_kolmogorov (y)) / dpdy;
      else
	{
	  torch_cephes_mtherr ("kolmogi", UNDERFLOW);
	  return 0.0;
	}
      y = y + t;
    }
  while (torch_cephes_fabs (t / y) > 1e-10);
  return (y);
}


#ifdef SALONE
/* Type in a number.  */
void
getnum (s, px)
     char *s;
     double *px;
{
  char str[30];

  printf (" %s (%.15e) ? ", s, *px);
  gets (str);
  if (str[0] == '\0' || str[0] == '\n')
    return;
  sscanf (str, "%lf", px);
  printf ("%.15e\n", *px);
}

/* Type in values, get answers.  */
void
main ()
{
  int n;
  double e, p, ps, pk, ek, y;

  n = 5;
  e = 0.0;
  p = 0.1;
loop:
  ps = n;
  getnum ("n", &ps);
  n = ps;
  if (n <= 0)
    {
      printf ("? Operator error.\n");
      goto loop;
    }
  /*
  getnum ("e", &e);
  ps = smirnov (n, e);
  y = sqrt ((double) n) * e;
  printf ("y = %.4e\n", y);
  pk = kolmogorov (y);
  printf ("Smirnov = %.15e, Kolmogorov/2 = %.15e\n", ps, pk / 2.0);
*/
  getnum ("p", &p);
  e = smirnovi (n, p);
  printf ("Smirnov e = %.15e\n", e);
  y = kolmogi (2.0 * p);
  ek = y / sqrt ((double) n);
  printf ("Kolmogorov e = %.15e\n", ek);
  goto loop;
}
#endif
