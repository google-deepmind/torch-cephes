
# Cephes double precision special functions suite

<a name="acosh"></a>
## acosh - Inverse hyperbolic cosine

Inverse hyperbolic cosine

Synopsis:

    double x, y, acosh();

    y = acosh( x );

Description:

    Returns inverse hyperbolic cosine of argument.

    If 1 <= x < 1.5, a rational approximation

    sqrt(z) * P(z)/Q(z)

    where z = x-1, is used.  Otherwise,

    acosh(x)  =  log( x + sqrt( (x-1)(x+1) ).

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC       1,3         30000       4.2e-17     1.1e-17
       IEEE      1,3         30000       4.6e-16     8.7e-17

Error messages:

      message         condition      value returned
    acosh domain       |x| < 1            NAN

<a name="airy"></a>
## airy - Airy functions

Airy function

Synopsis:

    double x, ai, aip, bi, bip;
    int airy();

    airy( x, &ai, &aip, &bi, &bip );

Description:

    Solution of the differential equation

    y"(x) = xy.

    The function returns the two independent solutions Ai, Bi
    and their first derivatives Ai'(x), Bi'(x).

    Evaluation is by power series summation for small x,
    by rational minimax approximations for large x.

Accuracy:

    Error criterion is absolute when function <= 1, relative
    when function > 1, except * denotes relative error criterion.
    For large negative x, the absolute error increases as x^1.5.
    For large positive x, the relative error increases as x^1.5.

    Arithmetic  domain   function  # trials      peak         rms
    IEEE        -10, 0     Ai        10000       1.6e-15     2.7e-16
    IEEE          0, 10    Ai        10000       2.3e-14*    1.8e-15*
    IEEE        -10, 0     Ai'       10000       4.6e-15     7.6e-16
    IEEE          0, 10    Ai'       10000       1.8e-14*    1.5e-15*
    IEEE        -10, 10    Bi        30000       4.2e-15     5.3e-16
    IEEE        -10, 10    Bi'       30000       4.9e-15     7.3e-16
    DEC         -10, 0     Ai         5000       1.7e-16     2.8e-17
    DEC           0, 10    Ai         5000       2.1e-15*    1.7e-16*
    DEC         -10, 0     Ai'        5000       4.7e-16     7.8e-17
    DEC           0, 10    Ai'       12000       1.8e-15*    1.5e-16*
    DEC         -10, 10    Bi        10000       5.5e-16     6.8e-17
    DEC         -10, 10    Bi'        7000       5.3e-16     8.7e-17

<a name="asin"></a>
## asin - Inverse circular sine

Inverse circular sine

Synopsis:

    double x, y, asin();

    y = asin( x );

Description:

    Returns radian angle between -pi/2 and +pi/2 whose sine is x.

    A rational function of the form x + x**3 P(x**2)/Q(x**2)
    is used for |x| in the interval [0, 0.5].  If |x| > 0.5 it is
    transformed by the identity

       asin(x) = pi/2 - 2 asin( sqrt( (1-x)/2 ) ).

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC      -1, 1        40000       2.6e-17     7.1e-18
       IEEE     -1, 1        10^6        1.9e-16     5.4e-17

Error messages:

      message         condition      value returned
    asin domain        |x| > 1           NAN

<a name="acos"></a>
## acos - Inverse circular cosine

Inverse circular cosine

Synopsis:

    double x, y, acos();

    y = acos( x );

Description:

    Returns radian angle between 0 and pi whose cosine
    is x.

    Analytically, acos(x) = pi/2 - asin(x).  However if |x| is
    near 1, there is cancellation error in subtracting asin(x)
    from pi/2.  Hence if x < -0.5,

       acos(x) =	 pi - 2.0 * asin( sqrt((1+x)/2) );

    or if x > +0.5,

       acos(x) =	 2.0 * asin(  sqrt((1-x)/2) ).

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC       -1, 1       50000       3.3e-17     8.2e-18
       IEEE      -1, 1       10^6        2.2e-16     6.5e-17

Error messages:

      message         condition      value returned
    asin domain        |x| > 1           NAN

<a name="asinh"></a>
## asinh - Inverse hyperbolic sine

Inverse hyperbolic sine

Synopsis:

    double x, y, asinh();

    y = asinh( x );

Description:

    Returns inverse hyperbolic sine of argument.

    If |x| < 0.5, the function is approximated by a rational
    form  x + x**3 P(x)/Q(x).  Otherwise,

        asinh(x) = log( x + sqrt(1 + x*x) ).

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC      -3,3         75000       4.6e-17     1.1e-17
       IEEE     -1,1         30000       3.7e-16     7.8e-17
       IEEE      1,3         30000       2.5e-16     6.7e-17

<a name="atan"></a>
## atan - Inverse circular tangent

Inverse circular tangent
     (arctangent)

Synopsis:

    double x, y, atan();

    y = atan( x );

Description:

    Returns radian angle between -pi/2 and +pi/2 whose tangent
    is x.

    Range reduction is from three intervals into the interval
    from zero to 0.66.  The approximant uses a rational
    function of degree 4/5 of the form x + x**3 P(x)/Q(x).

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC       -10, 10     50000       2.4e-17     8.3e-18
       IEEE      -10, 10      10^6       1.8e-16     5.0e-17

<a name="atan2"></a>
## atan2 - Quadrant correct inverse circular tangent

Quadrant correct inverse circular tangent

Synopsis:

    double x, y, z, atan2();

    z = atan2( y, x );

Description:

    Returns radian angle whose tangent is y/x.
    Define compile time symbol ANSIC = 1 for ANSI standard,
    range -PI < z <= +PI, args (y,x); else ANSIC = 0 for range
    0 to 2PI, args (x,y).

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       IEEE      -10, 10      10^6       2.5e-16     6.9e-17
    See atan.c.

<a name="atanh"></a>
## atanh - Inverse hyperbolic tangent

Inverse hyperbolic tangent

Synopsis:

    double x, y, atanh();

    y = atanh( x );

Description:

    Returns inverse hyperbolic tangent of argument in the range
    MINLOG to MAXLOG.

    If |x| < 0.5, the rational form x + x**3 P(x)/Q(x) is
    employed.  Otherwise,
           atanh(x) = 0.5 * log( (1+x)/(1-x) ).

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC       -1,1        50000       2.4e-17     6.4e-18
       IEEE      -1,1        30000       1.9e-16     5.2e-17

<a name="bdtr"></a>
## bdtr - Binomial distribution

Binomial distribution

Synopsis:

    int k, n;
    double p, y, bdtr();

    y = bdtr( k, n, p );

Description:

    Returns the sum of the terms 0 through k of the Binomial
    probability density:

      k
      --  ( n )   j      n-j
      >   (   )  p  (1-p)
      --  ( j )
     j=0

    The terms are not summed directly; instead the incomplete
    beta integral is employed, according to the formula

    y = bdtr( k, n, p ) = incbet( n-k, k+1, 1-p ).

    The arguments must be positive, with p ranging from 0 to 1.

Accuracy:

    Tested at random points (a,b,p), with p between 0 and 1.

                  a,b                     Relative error:
    arithmetic  domain     # trials      peak         rms
     For p between 0.001 and 1:
       IEEE     0,100       100000      4.3e-15     2.6e-16
    See also incbet.c.

Error messages:

      message         condition      value returned
    bdtr domain         k < 0            0.0
                        n < k
                        x < 0, x > 1

<a name="bdtrc"></a>
## bdtrc - Complemented binomial distribution

Complemented binomial distribution

Synopsis:

    int k, n;
    double p, y, bdtrc();

    y = bdtrc( k, n, p );

Description:

    Returns the sum of the terms k+1 through n of the Binomial
    probability density:

      n
      --  ( n )   j      n-j
      >   (   )  p  (1-p)
      --  ( j )
     j=k+1

    The terms are not summed directly; instead the incomplete
    beta integral is employed, according to the formula

    y = bdtrc( k, n, p ) = incbet( k+1, n-k, p ).

    The arguments must be positive, with p ranging from 0 to 1.

Accuracy:

    Tested at random points (a,b,p).

                  a,b                     Relative error:
    arithmetic  domain     # trials      peak         rms
     For p between 0.001 and 1:
       IEEE     0,100       100000      6.7e-15     8.2e-16
     For p between 0 and .001:
       IEEE     0,100       100000      1.5e-13     2.7e-15

Error messages:

      message         condition      value returned
    bdtrc domain      x<0, x>1, n<k       0.0

<a name="bdtri"></a>
## bdtri - Inverse binomial distribution

Inverse binomial distribution

Synopsis:

    int k, n;
    double p, y, bdtri();

    p = bdtr( k, n, y );

Description:

    Finds the event probability p such that the sum of the
    terms 0 through k of the Binomial probability density
    is equal to the given cumulative probability y.

    This is accomplished using the inverse beta integral
    function and the relation

    1 - p = incbi( n-k, k+1, y ).

Accuracy:

    Tested at random points (a,b,p).

                  a,b                     Relative error:
    arithmetic  domain     # trials      peak         rms
     For p between 0.001 and 1:
       IEEE     0,100       100000      2.3e-14     6.4e-16
       IEEE     0,10000     100000      6.6e-12     1.2e-13
     For p between 10^-6 and 0.001:
       IEEE     0,100       100000      2.0e-12     1.3e-14
       IEEE     0,10000     100000      1.5e-12     3.2e-14
    See also incbi.c.

Error messages:

      message         condition      value returned
    bdtri domain     k < 0, n <= k         0.0
                     x < 0, x > 1

<a name="beta"></a>
## beta - Beta function

Beta function

Synopsis:

    double a, b, y, beta();

    y = beta( a, b );

Description:

                      -     -
                     | (a) | (b)
    beta( a, b )  =  -----------.
                        -
                       | (a+b)

    For large arguments the logarithm of the function is
    evaluated using lgam(), then exponentiated.

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC        0,30        1700       7.7e-15     1.5e-15
       IEEE       0,30       30000       8.1e-14     1.1e-14

Error messages:

      message         condition          value returned
    beta overflow    log(beta) > MAXLOG       0.0
                     a or b <0 integer        0.0

<a name="btdtr"></a>
## btdtr - Beta distribution

Beta distribution

Synopsis:

    double a, b, x, y, btdtr();

    y = btdtr( a, b, x );

Description:

    Returns the area from zero to x under the beta density
    function:

                             x
               -             -
              | (a+b)       | |  a-1      b-1
    P(x)  =  ----------     |   t    (1-t)    dt
              -     -     | |
             | (a) | (b)   -
                            0

    This function is identical to the incomplete beta
    integral function incbet(a, b, x).

    The complemented function is

    1 - P(1-x)  =  incbet( b, a, x );

Accuracy:

    See incbet.c.

<a name="cbrt"></a>
## cbrt - Cube root

Cube root

Synopsis:

    double x, y, cbrt();

    y = cbrt( x );

Description:

    Returns the cube root of the argument, which may be negative.

    Range reduction involves determining the power of 2 of
    the argument.  A polynomial of degree 2 applied to the
    mantissa, and multiplication by the cube root of 1, 2, or 4
    approximates the root to within about 0.1%.  Then Newton's
    iteration is used three times to converge to an accurate
    result.

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC        -10,10     200000      1.8e-17     6.2e-18
       IEEE       0,1e308     30000      1.5e-16     5.0e-17

<a name="chbevl"></a>
## chbevl - Evaluate Chebyshev series

Evaluate Chebyshev series

Synopsis:

    int N;
    double x, y, coef[N], chebevl();

    y = chbevl( x, coef, N );

Description:

    Evaluates the series

           N-1
            - '
     y  =   >   coef[i] T (x/2)
            -            i
           i=0

    of Chebyshev polynomials Ti at argument x/2.

    Coefficients are stored in reverse order, i.e. the zero
    order term is last in the array.  Note N is the number of
    coefficients, not the order; N must be greater than 1.

    If coefficients are for the interval a to b, x must
    have been transformed to x -> 2(2x - b - a)/(b-a) before
    entering the routine.  This maps x from (a, b) to (-1, 1),
    over which the Chebyshev polynomials are defined.

    If the coefficients are for the inverted interval, in
    which (a, b) is mapped to (1/b, 1/a), the transformation
    required is x -> 2(2ab/x - b - a)/(b-a).  If b is infinity,
    this becomes x -> 4a/x - 1.

Speed:

    Taking advantage of the recurrence properties of the
    Chebyshev polynomials, the routine requires one more
    addition per loop than evaluating a nested polynomial of
    the same degree.

<a name="chdtr"></a>
## chdtr - Chi-square distribution

Chi-square distribution

Synopsis:

    double df, x, y, chdtr();

    y = chdtr( df, x );

Description:

    Returns the area under the left hand tail (from 0 to x)
    of the Chi square probability density function with
    v degrees of freedom.

                                     inf.
                                       -
                           1          | |  v/2-1  -t/2
     P( x | v )   =   -----------     |   t      e     dt
                       v/2  -       | |
                      2    | (v/2)   -
                                      x

    where x is the Chi-square variable.

    The incomplete gamma integral is used, according to the
    formula

    y = chdtr( v, x ) = igam( v/2.0, x/2.0 ).

    The arguments must both be positive.

Accuracy:

    See igam().

Error messages:

      message         condition      value returned
    chdtr domain   x < 0 or v < 1        0.0

<a name="chdtrc"></a>
## chdtrc - Complemented Chi-square distribution

Complemented Chi-square distribution

Synopsis:

    double v, x, y, chdtrc();

    y = chdtrc( v, x );

Description:

    Returns the area under the right hand tail (from x to
    infinity) of the Chi square probability density function
    with v degrees of freedom:

                                     inf.
                                       -
                           1          | |  v/2-1  -t/2
     P( x | v )   =   -----------     |   t      e     dt
                       v/2  -       | |
                      2    | (v/2)   -
                                      x

    where x is the Chi-square variable.

    The incomplete gamma integral is used, according to the
    formula

    y = chdtr( v, x ) = igamc( v/2.0, x/2.0 ).

    The arguments must both be positive.

Accuracy:

    See igamc().

Error messages:

      message         condition      value returned
    chdtrc domain  x < 0 or v < 1        0.0

<a name="chdtri"></a>
## chdtri - Inverse of complemented Chi-square distribution

Inverse of complemented Chi-square distribution

Synopsis:

    double df, x, y, chdtri();

    x = chdtri( df, y );

Description:

    Finds the Chi-square argument x such that the integral
    from x to infinity of the Chi-square density is equal
    to the given cumulative probability y.

    This is accomplished using the inverse gamma integral
    function and the relation

       x/2 = igami( df/2, y );

Accuracy:

    See igami.c.

Error messages:

      message         condition      value returned
    chdtri domain   y < 0 or y > 1        0.0
                        v < 1

<a name="cheby"></a>
## cheby - Find Chebyshev coefficients

Program to calculate coefficients of the Chebyshev polynomial
expansion of a given input function.  The algorithm computes
the discrete Fourier cosine transform of the function evaluated
at unevenly spaced points.  Library routine chbevl.c uses the
coefficients to calculate an approximate value of the original
function.

<a name="clog"></a>
## clog - Complex natural logarithm

Complex natural logarithm

Synopsis:

    void clog();
    cmplx z, w;

    clog( &z, &w );

Description:

    Returns complex logarithm to the base e (2.718...) of
    the complex argument x.

    If z = x + iy, r = sqrt( x**2 + y**2 ),
    then
          w = log(r) + i arctan(y/x).

    The arctangent ranges from -PI to +PI.

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC       -10,+10      7000       8.5e-17     1.9e-17
       IEEE      -10,+10     30000       5.0e-15     1.1e-16

    Larger relative error can be observed for z near 1 +i0.
    In IEEE arithmetic the peak absolute error is 5.2e-16, rms
    absolute error 1.0e-16.

<a name="cexp"></a>
## cexp - Complex exponential function

Complex exponential function

Synopsis:

    void cexp();
    cmplx z, w;

    cexp( &z, &w );

Description:

    Returns the exponential of the complex argument z
    into the complex result w.

    If
        z = x + iy,
        r = exp(x),

    then

        w = r cos y + i r sin y.

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC       -10,+10      8700       3.7e-17     1.1e-17
       IEEE      -10,+10     30000       3.0e-16     8.7e-17

<a name="csin"></a>
## csin - Complex circular sine

Complex circular sine

Synopsis:

    void csin();
    cmplx z, w;

    csin( &z, &w );

Description:

    If
        z = x + iy,

    then

        w = sin x  cosh y  +  i cos x sinh y.

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC       -10,+10      8400       5.3e-17     1.3e-17
       IEEE      -10,+10     30000       3.8e-16     1.0e-16
    Also tested by csin(casin(z)) = z.

<a name="ccos"></a>
## ccos - Complex circular cosine

Complex circular cosine

Synopsis:

    void ccos();
    cmplx z, w;

    ccos( &z, &w );

Description:

    If
        z = x + iy,

    then

        w = cos x  cosh y  -  i sin x sinh y.

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC       -10,+10      8400       4.5e-17     1.3e-17
       IEEE      -10,+10     30000       3.8e-16     1.0e-16

<a name="ctan"></a>
## ctan - Complex circular tangent

Complex circular tangent

Synopsis:

    void ctan();
    cmplx z, w;

    ctan( &z, &w );

Description:

    If
        z = x + iy,

    then

              sin 2x  +  i sinh 2y
        w  =  --------------------.
               cos 2x  +  cosh 2y

    On the real axis the denominator is zero at odd multiples
    of PI/2.  The denominator is evaluated by its Taylor
    series near these points.

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC       -10,+10      5200       7.1e-17     1.6e-17
       IEEE      -10,+10     30000       7.2e-16     1.2e-16
    Also tested by ctan * ccot = 1 and catan(ctan(z))  =  z.

<a name="ccot"></a>
## ccot - Complex circular cotangent

Complex circular cotangent

Synopsis:

    void ccot();
    cmplx z, w;

    ccot( &z, &w );

Description:

    If
        z = x + iy,

    then

              sin 2x  -  i sinh 2y
        w  =  --------------------.
               cosh 2y  -  cos 2x

    On the real axis, the denominator has zeros at even
    multiples of PI/2.  Near these points it is evaluated
    by a Taylor series.

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC       -10,+10      3000       6.5e-17     1.6e-17
       IEEE      -10,+10     30000       9.2e-16     1.2e-16
    Also tested by ctan * ccot = 1 + i0.

<a name="casin"></a>
## casin - Complex circular arc sine

Complex circular arc sine

Synopsis:

    void casin();
    cmplx z, w;

    casin( &z, &w );

Description:

    Inverse complex sine:

                                  2
    w = -i clog( iz + csqrt( 1 - z ) ).

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC       -10,+10     10100       2.1e-15     3.4e-16
       IEEE      -10,+10     30000       2.2e-14     2.7e-15
    Larger relative error can be observed for z near zero.
    Also tested by csin(casin(z)) = z.

<a name="cacos"></a>
## cacos - Complex circular arc cosine

Complex circular arc cosine

Synopsis:

    void cacos();
    cmplx z, w;

    cacos( &z, &w );

Description:

    w = arccos z  =  PI/2 - arcsin z.

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC       -10,+10      5200      1.6e-15      2.8e-16
       IEEE      -10,+10     30000      1.8e-14      2.2e-15

<a name="catan"></a>
## catan - Complex circular arc tangent

Complex circular arc tangent

Synopsis:

    void catan();
    cmplx z, w;

    catan( &z, &w );

Description:

    If
        z = x + iy,

    then
             1       (    2x     )
    Re w  =  - arctan(-----------)  +  k PI
             2       (     2    2)
                     (1 - x  - y )

                  ( 2         2)
             1    (x  +  (y+1) )
    Im w  =  - log(------------)
             4    ( 2         2)
                  (x  +  (y-1) )

    Where k is an arbitrary integer.

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC       -10,+10      5900       1.3e-16     7.8e-18
       IEEE      -10,+10     30000       2.3e-15     8.5e-17
    The check catan( ctan(z) )  =  z, with |x| and |y| < PI/2,
    had peak relative error 1.5e-16, rms relative error
    2.9e-17.  See also clog().

<a name="csinh"></a>
## csinh - Complex hyperbolic sine

Complex hyperbolic sine

Synopsis:

    void csinh();
    cmplx z, w;

    csinh( &z, &w );

Description:

    csinh z = (cexp(z) - cexp(-z))/2
            = sinh x * cos y  +  i cosh x * sin y .

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       IEEE      -10,+10     30000       3.1e-16     8.2e-17

<a name="casinh"></a>
## casinh - Complex inverse hyperbolic sine

Complex inverse hyperbolic sine

Synopsis:

    void casinh();
    cmplx z, w;

    casinh (&z, &w);

Description:

    casinh z = -i casin iz .

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       IEEE      -10,+10     30000       1.8e-14     2.6e-15

<a name="ccosh"></a>
## ccosh - Complex hyperbolic cosine

Complex hyperbolic cosine

Synopsis:

    void ccosh();
    cmplx z, w;

    ccosh (&z, &w);

Description:

    ccosh(z) = cosh x  cos y + i sinh x sin y .

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       IEEE      -10,+10     30000       2.9e-16     8.1e-17

<a name="cacosh"></a>
## cacosh - Complex inverse hyperbolic cosine

Complex inverse hyperbolic cosine

Synopsis:

    void cacosh();
    cmplx z, w;

    cacosh (&z, &w);

Description:

    acosh z = i acos z .

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       IEEE      -10,+10     30000       1.6e-14     2.1e-15

<a name="ctanh"></a>
## ctanh - Complex hyperbolic tangent

Complex hyperbolic tangent

Synopsis:

    void ctanh();
    cmplx z, w;

    ctanh (&z, &w);

Description:

    tanh z = (sinh 2x  +  i sin 2y) / (cosh 2x + cos 2y) .

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       IEEE      -10,+10     30000       1.7e-14     2.4e-16

<a name="catanh"></a>
## catanh - Complex inverse hyperbolic tangent

Complex inverse hyperbolic tangent

Synopsis:

    void catanh();
    cmplx z, w;

    catanh (&z, &w);

Description:

    Inverse tanh, equal to  -i catan (iz);

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       IEEE      -10,+10     30000       2.3e-16     6.2e-17

<a name="cpow"></a>
## cpow - Complex power function

Complex power function

Synopsis:

    void cpow();
    cmplx a, z, w;

    cpow (&a, &z, &w);

Description:

    Raises complex A to the complex Zth power.
    Definition is per AMS55 # 4.2.8,
    analytically equivalent to cpow(a,z) = cexp(z clog(a)).

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       IEEE      -10,+10     30000       9.4e-15     1.5e-15

<a name="cmplx"></a>
## cmplx - Complex number arithmetic

Complex number arithmetic

Synopsis:

    typedef struct {
         double r;     real part
         double i;     imaginary part
        }cmplx;

    cmplx *a, *b, *c;

    cadd( a, b, c );     c = b + a
    csub( a, b, c );     c = b - a
    cmul( a, b, c );     c = b * a
    cdiv( a, b, c );     c = b / a
    cneg( c );           c = -c
    cmov( b, c );        c = b

Description:

    Addition:
       c.r  =  b.r + a.r
       c.i  =  b.i + a.i

    Subtraction:
       c.r  =  b.r - a.r
       c.i  =  b.i - a.i

    Multiplication:
       c.r  =  b.r * a.r  -  b.i * a.i
       c.i  =  b.r * a.i  +  b.i * a.r

    Division:
       d    =  a.r * a.r  +  a.i * a.i
       c.r  = (b.r * a.r  + b.i * a.i)/d
       c.i  = (b.i * a.r  -  b.r * a.i)/d
Accuracy:

    In DEC arithmetic, the test (1/z) * z = 1 had peak relative
    error 3.1e-17, rms 1.2e-17.  The test (y/z) * (z/y) = 1 had
    peak relative error 8.3e-17, rms 2.1e-17.

    Tests in the rectangle {-10,+10}:
                         Relative error:
    arithmetic   function  # trials      peak         rms
       DEC        cadd       10000       1.4e-17     3.4e-18
       IEEE       cadd      100000       1.1e-16     2.7e-17
       DEC        csub       10000       1.4e-17     4.5e-18
       IEEE       csub      100000       1.1e-16     3.4e-17
       DEC        cmul        3000       2.3e-17     8.7e-18
       IEEE       cmul      100000       2.1e-16     6.9e-17
       DEC        cdiv       18000       4.9e-17     1.3e-17
       IEEE       cdiv      100000       3.7e-16     1.1e-16

<a name="cabs"></a>
## cabs - Complex absolute value

Complex absolute value

Synopsis:

    double cabs();
    cmplx z;
    double a;

    a = cabs( &z );

Description:

    If z = x + iy

    then

          a = sqrt( x**2 + y**2 ).

    Overflow and underflow are avoided by testing the magnitudes
    of x and y before squaring.  If either is outside half of
    the floating point full scale range, both are rescaled.

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC       -30,+30     30000       3.2e-17     9.2e-18
       IEEE      -10,+10    100000       2.7e-16     6.9e-17

<a name="csqrt"></a>
## csqrt - Complex square root

Complex square root

Synopsis:

    void csqrt();
    cmplx z, w;

    csqrt( &z, &w );

Description:

    If z = x + iy,  r = |z|, then

                          1/2
    Im w  =  [ (r - x)/2 ]   ,

    Re w  =  y / 2 Im w.

    Note that -w is also a square root of z.  The root chosen
    is always in the upper half plane.

    Because of the potential for cancellation error in r - x,
    the result is sharpened by doing a Heron iteration
    (see sqrt.c) in complex arithmetic.

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC       -10,+10     25000       3.2e-17     9.6e-18
       IEEE      -10,+10    100000       3.2e-16     7.7e-17

                           2
    Also tested by csqrt( z ) = z, and tested by arguments
    close to the real axis.

<a name="const"></a>
## const - Globally declared constants

Globally declared constants

Synopsis:

    extern double nameofconstant;

Description:

    This file contains a number of mathematical constants and
    also some needed size parameters of the computer arithmetic.
    The values are supplied as arrays of hexadecimal integers
    for IEEE arithmetic; arrays of octal constants for DEC
    arithmetic; and in a normal decimal scientific notation for
    other machines.  The particular notation used is determined
    by a symbol (DEC, IBMPC, or UNK) defined in the include file
    mconf.h.

    The default size parameters are as follows.

    For DEC and UNK modes:
    MACHEP =  1.38777878078144567553E-17       2**-56
    MAXLOG =  8.8029691931113054295988E1       log(2**127)
    MINLOG = -8.872283911167299960540E1        log(2**-128)
    MAXNUM =  1.701411834604692317316873e38    2**127

    For IEEE arithmetic (IBMPC):
    MACHEP =  1.11022302462515654042E-16       2**-53
    MAXLOG =  7.09782712893383996843E2         log(2**1024)
    MINLOG = -7.08396418532264106224E2         log(2**-1022)
    MAXNUM =  1.7976931348623158E308           2**1024

    The global symbols for mathematical constants are
    PI     =  3.14159265358979323846           pi
    PIO2   =  1.57079632679489661923           pi/2
    PIO4   =  7.85398163397448309616E-1        pi/4
    SQRT2  =  1.41421356237309504880           sqrt(2)
    SQRTH  =  7.07106781186547524401E-1        sqrt(2)/2
    LOG2E  =  1.4426950408889634073599         1/log(2)
    SQ2OPI =  7.9788456080286535587989E-1      sqrt( 2/pi )
    LOGE2  =  6.93147180559945309417E-1        log(2)
    LOGSQ2 =  3.46573590279972654709E-1        log(2)/2
    THPIO4 =  2.35619449019234492885           3*pi/4
    TWOOPI =  6.36619772367581343075535E-1     2/pi

    These lists are subject to change.

<a name="cosh"></a>
## cosh - Hyperbolic cosine

Hyperbolic cosine

Synopsis:

    double x, y, cosh();

    y = cosh( x );

Description:

    Returns hyperbolic cosine of argument in the range MINLOG to
    MAXLOG.

    cosh(x)  =  ( exp(x) + exp(-x) )/2.

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC       +- 88       50000       4.0e-17     7.7e-18
       IEEE     +-MAXLOG     30000       2.6e-16     5.7e-17

Error messages:

      message         condition      value returned
    cosh overflow    |x| > MAXLOG       MAXNUM

<a name="dawsn"></a>
## dawsn - Dawson's Integral

Dawson's Integral

Synopsis:

    double x, y, dawsn();

    y = dawsn( x );

Description:

    Approximates the integral

                                x
                                -
                         2     | |        2
     dawsn(x)  =  exp( -x  )   |    exp( t  ) dt
                             | |
                              -
                              0

    Three different rational approximations are employed, for
    the intervals 0 to 3.25; 3.25 to 6.25; and 6.25 up.

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       IEEE      0,10        10000       6.9e-16     1.0e-16
       DEC       0,10         6000       7.4e-17     1.4e-17

<a name="drand"></a>
## drand - Pseudorandom number generator

Pseudorandom number generator

Synopsis:

    double y, drand();

    drand( &y );

Description:

    Yields a random number 1.0 <= y < 2.0.

    The three-generator congruential algorithm by Brian
    Wichmann and David Hill (BYTE magazine, March, 1987,
    pp 127-8) is used. The period, given by them, is
    6953607871644.

    Versions invoked by the different arithmetic compile
    time options DEC, IBMPC, and MIEEE, produce
    approximately the same sequences, differing only in the
    least significant bits of the numbers. The UNK option
    implements the algorithm as recommended in the BYTE
    article.  It may be used on all computers. However,
    the low order bits of a double precision number may
    not be adequately random, and may vary due to arithmetic
    implementation details on different computers.

    The other compile options generate an additional random
    integer that overwrites the low order bits of the double
    precision number.  This reduces the period by a factor of
    two but tends to overcome the problems mentioned.

<a name="ei"></a>
## ei - Exponential Integral

Exponential integral

Synopsis:

    double x, y, ei();

    y = ei( x );

Description:

                  x
                   -     t
                  | |   e
       Ei(x) =   -|-   ---  dt .
                | |     t
                 -
                -inf

    Not defined for x <= 0.
    See also expn.c.

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       IEEE       0,100       50000      8.6e-16     1.3e-16

<a name="eigens"></a>
## eigens - Eigenvalues and eigenvectors of a real symmetric matrix

Eigenvalues and eigenvectors of a real symmetric matrix

Synopsis:

    int n;
    double A[n*(n+1)/2], EV[n*n], E[n];
    void eigens( A, EV, E, n );

Description:

    The algorithm is due to J. vonNeumann.

    A[] is a symmetric matrix stored in lower triangular form.
    That is, A[ row, column ] = A[ (row*row+row)/2 + column ]
    or equivalently with row and column interchanged.  The
    indices row and column run from 0 through n-1.

    EV[] is the output matrix of eigenvectors stored columnwise.
    That is, the elements of each eigenvector appear in sequential
    memory order.  The jth element of the ith eigenvector is
    EV[ n*i+j ] = EV[i][j].

    E[] is the output matrix of eigenvalues.  The ith element
    of E corresponds to the ith eigenvector (the ith row of EV).

    On output, the matrix A will have been diagonalized and its
    orginal contents are destroyed.

Accuracy:

    The error is controlled by an internal parameter called RANGE
    which is set to 1e-10.  After diagonalization, the
    off-diagonal elements of A will have been reduced by
    this factor.

Error messages:

    None.

<a name="ellie"></a>
## ellie - Incomplete elliptic integral of the second kind

Incomplete elliptic integral of the second kind

Synopsis:

    double phi, m, y, ellie();

    y = ellie( phi, m );

Description:

    Approximates the integral

                   phi
                    -
                   | |
                   |                   2
    E(phi_\m)  =    |    sqrt( 1 - m sin t ) dt
                   |
                 | |    
                  -
                   0

    of amplitude phi and modulus m, using the arithmetic -
    geometric mean algorithm.

Accuracy:

    Tested at random arguments with phi in [-10, 10] and m in
    [0, 1].
                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC        0,2         2000       1.9e-16     3.4e-17
       IEEE     -10,10      150000       3.3e-15     1.4e-16

<a name="ellik"></a>
## ellik - Incomplete elliptic integral of the first kind

Incomplete elliptic integral of the first kind

Synopsis:

    double phi, m, y, ellik();

    y = ellik( phi, m );

Description:

    Approximates the integral

                   phi
                    -
                   | |
                   |           dt
    F(phi_\m)  =    |    ------------------
                   |                   2
                 | |    sqrt( 1 - m sin t )
                  -
                   0

    of amplitude phi and modulus m, using the arithmetic -
    geometric mean algorithm.

Accuracy:

    Tested at random points with m in [0, 1] and phi as indicated.

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       IEEE     -10,10       200000      7.4e-16     1.0e-16

<a name="ellpe"></a>
## ellpe - Complete elliptic integral of the second kind

Complete elliptic integral of the second kind

Synopsis:

    double m1, y, ellpe();

    y = ellpe( m1 );

Description:

    Approximates the integral

               pi/2
                -
               | |                 2
    E(m)  =    |    sqrt( 1 - m sin t ) dt
             | |    
              -
               0

    Where m = 1 - m1, using the approximation

         P(x)  -  x log x Q(x).

    Though there are no singularities, the argument m1 is used
    rather than m for compatibility with ellpk().

    E(1) = 1; E(0) = pi/2.

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC        0, 1       13000       3.1e-17     9.4e-18
       IEEE       0, 1       10000       2.1e-16     7.3e-17

Error messages:

      message         condition      value returned
    ellpe domain      x<0, x>1            0.0

<a name="ellpj"></a>
## ellpj - Jacobian elliptic functions

Jacobian Elliptic Functions

Synopsis:

    double u, m, sn, cn, dn, phi;
    int ellpj();

    ellpj( u, m, &sn, &cn, &dn, &phi );

Description:

    Evaluates the Jacobian elliptic functions sn(u|m), cn(u|m),
    and dn(u|m) of parameter m between 0 and 1, and real
    argument u.

    These functions are periodic, with quarter-period on the
    real axis equal to the complete elliptic integral
    ellpk(1.0-m).

    Relation to incomplete elliptic integral:
    If u = ellik(phi,m), then sn(u|m) = sin(phi),
    and cn(u|m) = cos(phi).  Phi is called the amplitude of u.

    Computation is by means of the arithmetic-geometric mean
    algorithm, except when m is within 1e-9 of 0 or 1.  In the
    latter case with m close to 1, the approximation applies
    only for phi < pi/2.

Accuracy:

    Tested at random points with u between 0 and 10, m between
    0 and 1.

               Absolute error (* = relative error):
    arithmetic   function   # trials      peak         rms
       DEC       sn           1800       4.5e-16     8.7e-17
       IEEE      phi         10000       9.2e-16*    1.4e-16*
       IEEE      sn          50000       4.1e-15     4.6e-16
       IEEE      cn          40000       3.6e-15     4.4e-16
       IEEE      dn          10000       1.3e-12     1.8e-14

     Peak error observed in consistency check using addition
    theorem for sn(u+v) was 4e-16 (absolute).  Also tested by
    the above relation to the incomplete elliptic integral.
    Accuracy deteriorates when u is large.

<a name="ellpk"></a>
## ellpk - Complete elliptic integral of the first kind

Complete elliptic integral of the first kind

Synopsis:

    double m1, y, ellpk();

    y = ellpk( m1 );

Description:

    Approximates the integral

               pi/2
                -
               | |
               |           dt
    K(m)  =    |    ------------------
               |                   2
             | |    sqrt( 1 - m sin t )
              -
               0

    where m = 1 - m1, using the approximation

        P(x)  -  log x Q(x).

    The argument m1 is used rather than m so that the logarithmic
    singularity at m = 1 will be shifted to the origin; this
    preserves maximum accuracy.

    K(0) = pi/2.

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC        0,1        16000       3.5e-17     1.1e-17
       IEEE       0,1        30000       2.5e-16     6.8e-17

Error messages:

      message         condition      value returned
    ellpk domain       x<0, x>1           0.0

<a name="euclid"></a>
## euclid - Rational arithmetic routines

Rational arithmetic routines

Synopsis:

    typedef struct
         {
         double n;  numerator
         double d;  denominator
         }fract;

    radd( a, b, c )      c = b + a
    rsub( a, b, c )      c = b - a
    rmul( a, b, c )      c = b * a
    rdiv( a, b, c )      c = b / a
    euclid( &n, &d )     Reduce n/d to lowest terms,
                         return greatest common divisor.

    Arguments of the routines are pointers to the structures.
    The double precision numbers are assumed, without checking,
    to be integer valued.  Overflow conditions are reported.

<a name="exp"></a>
## exp - Exponential function

Exponential function

Synopsis:

    double x, y, exp();

    y = exp( x );

Description:

    Returns e (2.71828...) raised to the x power.

    Range reduction is accomplished by separating the argument
    into an integer k and fraction f such that

        x    k  f
       e  = 2  e.

    A Pade' form  1 + 2x P(x**2)/( Q(x**2) - P(x**2) )
    of degree 2/3 is used to approximate exp(f) in the basic
    interval [-0.5, 0.5].

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC       +- 88       50000       2.8e-17     7.0e-18
       IEEE      +- 708      40000       2.0e-16     5.6e-17

    Error amplification in the exponential function can be
    a serious matter.  The error propagation involves
    exp( X(1+delta) ) = exp(X) ( 1 + X*delta + ... ),
    which shows that a 1 lsb error in representing X produces
    a relative error of X times 1 lsb in the function.
    While the routine gives an accurate result for arguments
    that are exactly represented by a double precision
    computer number, the result contains amplified roundoff
    error for large arguments not exactly represented.

Error messages:

      message         condition      value returned
    exp underflow    x < MINLOG         0.0
    exp overflow     x > MAXLOG         INFINITY

<a name="exp10"></a>
## exp10 - Base 10 exponential function

Base 10 exponential function
     (Common antilogarithm)

Synopsis:

    double x, y, exp10();

    y = exp10( x );

Description:

    Returns 10 raised to the x power.

    Range reduction is accomplished by expressing the argument
    as 10**x = 2**n 10**f, with |f| < 0.5 log10(2).
    The Pade' form

       1 + 2x P(x**2)/( Q(x**2) - P(x**2) )

    is used to approximate 10**f.

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       IEEE     -307,+307    30000       2.2e-16     5.5e-17
    Test result from an earlier version (2.1):
       DEC       -38,+38     70000       3.1e-17     7.0e-18

Error messages:

      message         condition      value returned
    exp10 underflow    x < -MAXL10        0.0
    exp10 overflow     x > MAXL10       MAXNUM

    DEC arithmetic: MAXL10 = 38.230809449325611792.
    IEEE arithmetic: MAXL10 = 308.2547155599167.

<a name="exp2"></a>
## exp2 - Base 2 exponential function

Base 2 exponential function

Synopsis:

    double x, y, exp2();

    y = exp2( x );

Description:

    Returns 2 raised to the x power.

    Range reduction is accomplished by separating the argument
    into an integer k and fraction f such that
        x    k  f
       2  = 2  2.

    A Pade' form

      1 + 2x P(x**2) / (Q(x**2) - x P(x**2) )

    approximates 2**x in the basic range [-0.5, 0.5].

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       IEEE    -1022,+1024   30000       1.8e-16     5.4e-17

    See exp.c for comments on error amplification.

Error messages:

      message         condition      value returned
    exp underflow    x < -MAXL2        0.0
    exp overflow     x > MAXL2         MAXNUM

    For DEC arithmetic, MAXL2 = 127.
    For IEEE arithmetic, MAXL2 = 1024.

<a name="expn"></a>
## expn - Exponential integral En

	Exponential integral En

Synopsis:

    int n;
    double x, y, expn();

    y = expn( n, x );

Description:

    Evaluates the exponential integral

                    inf.
                      -
                     | |   -xt
                     |    e
         E (x)  =    |    ----  dt.
          n          |      n
                   | |     t
                    -
                     1

    Both n and x must be nonnegative.

    The routine employs either a power series, a continued
    fraction, or an asymptotic formula depending on the
    relative values of n and x.

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC       0, 30        5000       2.0e-16     4.6e-17
       IEEE      0, 30       10000       1.7e-15     3.6e-16

<a name="expx2"></a>
## expx2 - Exponential of squared argument

Exponential of squared argument

Synopsis:

    double x, y, expx2();
    int sign;

    y = expx2( x, sign );

Description:

    Computes y = exp(x*x) while suppressing error amplification
    that would ordinarily arise from the inexactness of the
    exponential argument x*x.

    If sign < 0, the result is inverted; i.e., y = exp(-x*x) .

Accuracy:

                         Relative error:
    arithmetic    domain     # trials      peak         rms
      IEEE      -26.6, 26.6    10^7       3.9e-16     8.9e-17

<a name="fabs"></a>
## fabs - Absolute value

	Absolute value

Synopsis:

    double x, y;

    y = fabs( x );

Description:

    Returns the absolute value of the argument.

<a name="fac"></a>
## fac - Factorial function

Factorial function

Synopsis:

    double y, fac();
    int i;

    y = fac( i );

Description:

    Returns factorial of i  =  1 * 2 * 3 * ... * i.
    fac(0) = 1.0.

    Due to machine arithmetic bounds the largest value of
    i accepted is 33 in DEC arithmetic or 170 in IEEE
    arithmetic.  Greater values, or negative ones,
    produce an error message and return MAXNUM.

Accuracy:

    For i < 34 the values are simply tabulated, and have
    full machine accuracy.  If i > 55, fac(i) = gamma(i+1);
    see gamma.c.

                         Relative error:
    arithmetic   domain      peak
       IEEE      0, 170    1.4e-15
       DEC       0, 33      1.4e-17

<a name="fdtr"></a>
## fdtr - F distribution

F distribution

Synopsis:

    int df1, df2;
    double x, y, fdtr();

    y = fdtr( df1, df2, x );

Description:

    Returns the area from zero to x under the F density
    function (also known as Snedcor's density or the
    variance ratio density).  This is the density
    of x = (u1/df1)/(u2/df2), where u1 and u2 are random
    variables having Chi square distributions with df1
    and df2 degrees of freedom, respectively.

    The incomplete beta integral is used, according to the
    formula

    P(x) = incbet( df1/2, df2/2, (df1*x/(df2 + df1*x) ).

    The arguments a and b are greater than zero, and x is
    nonnegative.

Accuracy:

    Tested at random points (a,b,x).

                   x     a,b                     Relative error:
    arithmetic  domain  domain     # trials      peak         rms
       IEEE      0,1    0,100       100000      9.8e-15     1.7e-15
       IEEE      1,5    0,100       100000      6.5e-15     3.5e-16
       IEEE      0,1    1,10000     100000      2.2e-11     3.3e-12
       IEEE      1,5    1,10000     100000      1.1e-11     1.7e-13
    See also incbet.c.

Error messages:

      message         condition      value returned
    fdtr domain     a<0, b<0, x<0         0.0

<a name="fdtrc"></a>
## fdtrc - Complemented F distribution

Complemented F distribution

Synopsis:

    int df1, df2;
    double x, y, fdtrc();

    y = fdtrc( df1, df2, x );

Description:

    Returns the area from x to infinity under the F density
    function (also known as Snedcor's density or the
    variance ratio density).

                         inf.
                          -
                 1       | |  a-1      b-1
    1-P(x)  =  ------    |   t    (1-t)    dt
               B(a,b)  | |
                        -
                         x

    The incomplete beta integral is used, according to the
    formula

    P(x) = incbet( df2/2, df1/2, (df2/(df2 + df1*x) ).

Accuracy:

    Tested at random points (a,b,x) in the indicated intervals.
                   x     a,b                     Relative error:
    arithmetic  domain  domain     # trials      peak         rms
       IEEE      0,1    1,100       100000      3.7e-14     5.9e-16
       IEEE      1,5    1,100       100000      8.0e-15     1.6e-15
       IEEE      0,1    1,10000     100000      1.8e-11     3.5e-13
       IEEE      1,5    1,10000     100000      2.0e-11     3.0e-12
    See also incbet.c.

Error messages:

      message         condition      value returned
    fdtrc domain    a<0, b<0, x<0         0.0

<a name="fdtri"></a>
## fdtri - Inverse of complemented F distribution

Inverse of complemented F distribution

Synopsis:

    int df1, df2;
    double x, p, fdtri();

    x = fdtri( df1, df2, p );

Description:

    Finds the F density argument x such that the integral
    from x to infinity of the F density is equal to the
    given probability p.

    This is accomplished using the inverse beta integral
    function and the relations

         z = incbi( df2/2, df1/2, p )
         x = df2 (1-z) / (df1 z).

    Note: the following relations hold for the inverse of
    the uncomplemented F distribution:

         z = incbi( df1/2, df2/2, p )
         x = df2 z / (df1 (1-z)).

Accuracy:

    Tested at random points (a,b,p).

                 a,b                     Relative error:
    arithmetic  domain     # trials      peak         rms
     For p between .001 and 1:
       IEEE     1,100       100000      8.3e-15     4.7e-16
       IEEE     1,10000     100000      2.1e-11     1.4e-13
     For p between 10^-6 and 10^-3:
       IEEE     1,100        50000      1.3e-12     8.4e-15
       IEEE     1,10000      50000      3.0e-12     4.8e-14
    See also fdtrc.c.

Error messages:

      message         condition      value returned
    fdtri domain   p <= 0 or p > 1       0.0
                        v < 1

<a name="fftr"></a>
## fftr - Fast Fourier transform

FFT of Real Valued Sequence

Synopsis:

    double x[], sine[];
    int m;

    fftr( x, m, sine );

Description:

    Computes the (complex valued) discrete Fourier transform of
    the real valued sequence x[].  The input sequence x[] contains
    n = 2**m samples.  The program fills array sine[k] with
    n/4 + 1 values of sin( 2 PI k / n ).

    Data format for complex valued output is real part followed
    by imaginary part.  The output is developed in the input
    array x[].

    The algorithm takes advantage of the fact that the FFT of an
    n point real sequence can be obtained from an n/2 point
    complex FFT.

    A radix 2 FFT algorithm is used.

    Execution time on an LSI-11/23 with floating point chip
    is 1.0 sec for n = 256.

Reference:

    E. Oran Brigham, The Fast Fourier Transform;
    Prentice-Hall, Inc., 1974

<a name="floor"></a>
## floor - Floor function

<a name="ceil"></a>
## ceil - Ceil function

<a name="frexp"></a>
## frexp - Extract exponent

<a name="ldexp"></a>
## ldexp - Apply exponent
						floor()
						frexp()
						ldexp()

Floating point numeric utilities

Synopsis:

    double ceil(), floor(), frexp(), ldexp();
    double x, y;
    int expnt, n;

    y = floor(x);
    y = ceil(x);
    y = frexp( x, &expnt );
    y = ldexp( x, n );

Description:

    All four routines return a double precision floating point
    result.

    floor() returns the largest integer less than or equal to x.
    It truncates toward minus infinity.

    ceil() returns the smallest integer greater than or equal
    to x.  It truncates toward plus infinity.

    frexp() extracts the exponent from x.  It returns an integer
    power of two to expnt and the significand between 0.5 and 1
    to y.  Thus  x = y * 2**expn.

    ldexp() multiplies x by 2**n.

    These functions are part of the standard C run time library
    for many but not all C compilers.  The ones supplied are
    written in C for either DEC or IEEE arithmetic.  They should
    be used only if your compiler library does not already have
    them.

    The IEEE versions assume that denormal numbers are implemented
    in the arithmetic.  Some modifications will be required if
    the arithmetic has abrupt rather than gradual underflow.

<a name="fresnl"></a>
## fresnl - Fresnel integral

Fresnel integral

Synopsis:

    double x, S, C;
    void fresnl();

    fresnl( x, &S, &C );

Description:

    Evaluates the Fresnel integrals

              x
              -
             | |
    C(x) =   |   cos(pi/2 t**2) dt,
           | |
            -
             0

              x
              -
             | |
    S(x) =   |   sin(pi/2 t**2) dt.
           | |
            -
             0

    The integrals are evaluated by a power series for x < 1.
    For x >= 1 auxiliary functions f(x) and g(x) are employed
    such that

    C(x) = 0.5 + f(x) sin( pi/2 x**2 ) - g(x) cos( pi/2 x**2 )
    S(x) = 0.5 - f(x) cos( pi/2 x**2 ) - g(x) sin( pi/2 x**2 )

Accuracy:

     Relative error.

    Arithmetic  function   domain     # trials      peak         rms
      IEEE       S(x)      0, 10       10000       2.0e-15     3.2e-16
      IEEE       C(x)      0, 10       10000       1.8e-15     3.3e-16
      DEC        S(x)      0, 10        6000       2.2e-16     3.9e-17
      DEC        C(x)      0, 10        5000       2.3e-16     3.9e-17

<a name="gamma"></a>
## gamma - Gamma function

Gamma function

Synopsis:

    double x, y, gamma();
    extern int sgngam;

    y = gamma( x );

Description:

    Returns gamma function of the argument.  The result is
    correctly signed, and the sign (+1 or -1) is also
    returned in a global (extern) variable named sgngam.
    This variable is also filled in by the logarithmic gamma
    function lgam().

    Arguments |x| <= 34 are reduced by recurrence and the function
    approximated by a rational function of degree 6/7 in the
    interval (2,3).  Large arguments are handled by Stirling's
    formula. Large negative arguments are made positive using
    a reflection formula.  

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC      -34, 34      10000       1.3e-16     2.5e-17
       IEEE    -170,-33      20000       2.3e-15     3.3e-16
       IEEE     -33,  33     20000       9.4e-16     2.2e-16
       IEEE      33, 171.6   20000       2.3e-15     3.2e-16

    Error for arguments outside the test range will be larger
    owing to error amplification by the exponential function.

<a name="lgam"></a>
## lgam - Natural logarithm of gamma function

Natural logarithm of gamma function

Synopsis:

    double x, y, lgam();
    extern int sgngam;

    y = lgam( x );

Description:

    Returns the base e (2.718...) logarithm of the absolute
    value of the gamma function of the argument.
    The sign (+1 or -1) of the gamma function is returned in a
    global (extern) variable named sgngam.

    For arguments greater than 13, the logarithm of the gamma
    function is approximated by the logarithmic version of
    Stirling's formula using a polynomial approximation of
    degree 4. Arguments between -33 and +33 are reduced by
    recurrence to the interval [2,3] of a rational approximation.
    The cosecant reflection formula is employed for arguments
    less than -33.

    Arguments greater than MAXLGM return MAXNUM and an error
    message.  MAXLGM = 2.035093e36 for DEC
    arithmetic or 2.556348e305 for IEEE arithmetic.

Accuracy:

    arithmetic      domain        # trials     peak         rms
       DEC     0, 3                  7000     5.2e-17     1.3e-17
       DEC     2.718, 2.035e36       5000     3.9e-17     9.9e-18
       IEEE    0, 3                 28000     5.4e-16     1.1e-16
       IEEE    2.718, 2.556e305     40000     3.5e-16     8.3e-17
    The error criterion was relative when the function magnitude
    was greater than one but absolute when it was less than one.

    The following test used the relative error criterion, though
    at certain points the relative error could be much higher than
    indicated.
       IEEE    -200, -4             10000     4.8e-16     1.3e-16

<a name="gdtr"></a>
## gdtr - Gamma distribution function

Gamma distribution function

Synopsis:

    double a, b, x, y, gdtr();

    y = gdtr( a, b, x );

Description:

    Returns the integral from zero to x of the gamma probability
    density function:

                   x
           b       -
          a       | |   b-1  -at
    y =  -----    |    t    e    dt
          -     | |
         | (b)   -
                  0

     The incomplete gamma integral is used, according to the
    relation

    y = igam( b, ax ).

Accuracy:

    See igam().

Error messages:

      message         condition      value returned
    gdtr domain         x < 0            0.0

<a name="gdtrc"></a>
## gdtrc - Complemented gamma distribution function

Complemented gamma distribution function

Synopsis:

    double a, b, x, y, gdtrc();

    y = gdtrc( a, b, x );

Description:

    Returns the integral from x to infinity of the gamma
    probability density function:

                  inf.
           b       -
          a       | |   b-1  -at
    y =  -----    |    t    e    dt
          -     | |
         | (b)   -
                  x

     The incomplete gamma integral is used, according to the
    relation

    y = igamc( b, ax ).

Accuracy:

    See igamc().

Error messages:

      message         condition      value returned
    gdtrc domain         x < 0            0.0

<a name="gels"></a>
## gels - Linear system with symmetric coefficient matrix

<a name="hyp2f1"></a>
## hyp2f1 - Gauss hypergeometric function

Gauss hypergeometric function   F
                               2 1

Synopsis:

    double a, b, c, x, y, hyp2f1();

    y = hyp2f1( a, b, c, x );

Description:

     hyp2f1( a, b, c, x )  =   F ( a, b; c; x )
                              2 1

              inf.
               -   a(a+1)...(a+k) b(b+1)...(b+k)   k+1
      =  1 +   >   -----------------------------  x   .
               -         c(c+1)...(c+k) (k+1)!
             k = 0

     Cases addressed are
    Tests and escapes for negative integer a, b, or c
    Linear transformation if c - a or c - b negative integer
    Special case c = a or c = b
    Linear transformation for  x near +1
    Transformation for x < -0.5
    Psi function expansion if x > 0.5 and c - a - b integer
         Conditionally, a recurrence on c to make c-a-b > 0

    |x| > 1 is rejected.

    The parameters a, b, c are considered to be integer
    valued if they are within 1.0e-14 of the nearest integer
    (1.0e-13 for IEEE arithmetic).

Accuracy:

                  Relative error (-1 < x < 1):
    arithmetic   domain     # trials      peak         rms
       IEEE      -1,7        230000      1.2e-11     5.2e-14

    Several special cases also tested with a, b, c in
    the range -7 to 7.

Error messages:

    A "partial loss of precision" message is printed if
    the internally estimated relative error exceeds 1^-12.
    A "singularity" message is printed on overflow or
    in cases not addressed (such as x < -1).

<a name="hyperg"></a>
## hyperg - Confluent hypergeometric function

Confluent hypergeometric function

Synopsis:

    double a, b, x, y, hyperg();

    y = hyperg( a, b, x );

Description:

    Computes the confluent hypergeometric function

                             1           2
                          a x    a(a+1) x
      F ( a,b;x )  =  1 + ---- + --------- + ...
     1 1                  b 1!   b(b+1) 2!

    Many higher transcendental functions are special cases of
    this power series.

    As is evident from the formula, b must not be a negative
    integer or zero unless a is an integer with 0 >= a > b.

    The routine attempts both a direct summation of the series
    and an asymptotic expansion.  In each case error due to
    roundoff, cancellation, and nonconvergence is estimated.
    The result with smaller estimated error is returned.

Accuracy:

    Tested at random points (a, b, x), all three variables
    ranging from 0 to 30.
                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC       0,30         2000       1.2e-15     1.3e-16
       IEEE      0,30        30000       1.8e-14     1.1e-15

    Larger errors can be observed when b is near a negative
    integer or zero.  Certain combinations of arguments yield
    serious cancellation error in the power series summation
    and also are not in the region of near convergence of the
    asymptotic series.  An error message is printed if the
    self-estimated relative error is greater than 1.0e-12.

<a name="i0"></a>
## i0 - Modified Bessel function of order zero

Modified Bessel function of order zero

Synopsis:

    double x, y, i0();

    y = i0( x );

Description:

    Returns modified Bessel function of order zero of the
    argument.

    The function is defined as i0(x) = j0( ix ).

    The range is partitioned into the two intervals [0,8] and
    (8, infinity).  Chebyshev polynomial expansions are employed
    in each interval.

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC       0,30         6000       8.2e-17     1.9e-17
       IEEE      0,30        30000       5.8e-16     1.4e-16

<a name="i0e"></a>
## i0e - Exponentially scaled modified Bessel function of order zero

Modified Bessel function of order zero,
exponentially scaled

Synopsis:

    double x, y, i0e();

    y = i0e( x );

Description:

    Returns exponentially scaled modified Bessel function
    of order zero of the argument.

    The function is defined as i0e(x) = exp(-|x|) j0( ix ).

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       IEEE      0,30        30000       5.4e-16     1.2e-16
    See i0().

<a name="i1"></a>
## i1 - Modified Bessel function of order one

Modified Bessel function of order one

Synopsis:

    double x, y, i1();

    y = i1( x );

Description:

    Returns modified Bessel function of order one of the
    argument.

    The function is defined as i1(x) = -i j1( ix ).

    The range is partitioned into the two intervals [0,8] and
    (8, infinity).  Chebyshev polynomial expansions are employed
    in each interval.

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC       0, 30        3400       1.2e-16     2.3e-17
       IEEE      0, 30       30000       1.9e-15     2.1e-16

<a name="i1e"></a>
## i1e - Exponentially scaled modified Bessel function of order one

Modified Bessel function of order one,
exponentially scaled

Synopsis:

    double x, y, i1e();

    y = i1e( x );

Description:

    Returns exponentially scaled modified Bessel function
    of order one of the argument.

    The function is defined as i1(x) = -i exp(-|x|) j1( ix ).

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       IEEE      0, 30       30000       2.0e-15     2.0e-16
    See i1().

<a name="igam"></a>
## igam - Incomplete gamma integral

Incomplete gamma integral

Synopsis:

    double a, x, y, igam();

    y = igam( a, x );

Description:

    The function is defined by

                              x
                               -
                      1       | |  -t  a-1
     igam(a,x)  =   -----     |   e   t   dt.
                     -      | |
                    | (a)    -
                              0

    In this implementation both arguments must be positive.
    The integral is evaluated by either a power series or
    continued fraction expansion, depending on the relative
    values of a and x.

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       IEEE      0,30       200000       3.6e-14     2.9e-15
       IEEE      0,100      300000       9.9e-14     1.5e-14

<a name="igamc"></a>
## igamc - Complemented incomplete gamma integral

Complemented incomplete gamma integral

Synopsis:

    double a, x, y, igamc();

    y = igamc( a, x );

Description:

    The function is defined by

     igamc(a,x)   =   1 - igam(a,x)

                               inf.
                                 -
                        1       | |  -t  a-1
                  =   -----     |   e   t   dt.
                       -      | |
                      | (a)    -
                                x

    In this implementation both arguments must be positive.
    The integral is evaluated by either a power series or
    continued fraction expansion, depending on the relative
    values of a and x.

Accuracy:

    Tested at random a, x.
                   a         x                      Relative error:
    arithmetic   domain   domain     # trials      peak         rms
       IEEE     0.5,100   0,100      200000       1.9e-14     1.7e-15
       IEEE     0.01,0.5  0,100      200000       1.4e-13     1.6e-15

<a name="igami"></a>
## igami - Inverse of complemented imcomplete gamma integral

     Inverse of complemented imcomplete gamma integral

Synopsis:

    double a, x, p, igami();

    x = igami( a, p );

Description:

    Given p, the function finds x such that

     igamc( a, x ) = p.

    Starting with the approximate value

            3
     x = a t

     where

     t = 1 - d - ndtri(p) sqrt(d)

    and

     d = 1/9a,

    the routine performs up to 10 Newton iterations to find the
    root of igamc(a,x) - p = 0.

Accuracy:

    Tested at random a, p in the intervals indicated.

                   a        p                      Relative error:
    arithmetic   domain   domain     # trials      peak         rms
       IEEE     0.5,100   0,0.5       100000       1.0e-14     1.7e-15
       IEEE     0.01,0.5  0,0.5       100000       9.0e-14     3.4e-15
       IEEE    0.5,10000  0,0.5        20000       2.3e-13     3.8e-14

<a name="incbet"></a>
## incbet - Incomplete beta integral

Incomplete beta integral

Synopsis:

    double a, b, x, y, incbet();

    y = incbet( a, b, x );

Description:

    Returns incomplete beta integral of the arguments, evaluated
    from zero to x.  The function is defined as

                     x
        -            -
       | (a+b)      | |  a-1     b-1
     -----------    |   t   (1-t)   dt.
      -     -     | |
     | (a) | (b)   -
                    0

    The domain of definition is 0 <= x <= 1.  In this
    implementation a and b are restricted to positive values.
    The integral from x to 1 may be obtained by the symmetry
    relation

       1 - incbet( a, b, x )  =  incbet( b, a, 1-x ).

    The integral is evaluated by a continued fraction expansion
    or, when b*x is small, by a power series.

Accuracy:

    Tested at uniformly distributed random points (a,b,x) with a and b
    in "domain" and x between 0 and 1.
                                           Relative error
    arithmetic   domain     # trials      peak         rms
       IEEE      0,5         10000       6.9e-15     4.5e-16
       IEEE      0,85       250000       2.2e-13     1.7e-14
       IEEE      0,1000      30000       5.3e-12     6.3e-13
       IEEE      0,10000    250000       9.3e-11     7.1e-12
       IEEE      0,100000    10000       8.7e-10     4.8e-11
    Outputs smaller than the IEEE gradual underflow threshold
    were excluded from these statistics.

Error messages:

      message         condition      value returned
    incbet domain      x<0, x>1          0.0
    incbet underflow                     0.0

<a name="incbi"></a>
## incbi - Inverse of imcomplete beta integral

     Inverse of imcomplete beta integral

Synopsis:

    double a, b, x, y, incbi();

    x = incbi( a, b, y );

Description:

    Given y, the function finds x such that

     incbet( a, b, x ) = y .

    The routine performs interval halving or Newton iterations to find the
    root of incbet(a,b,x) - y = 0.

Accuracy:

                         Relative error:
                   x     a,b
    arithmetic   domain  domain  # trials    peak       rms
       IEEE      0,1    .5,10000   50000    5.8e-12   1.3e-13
       IEEE      0,1   .25,100    100000    1.8e-13   3.9e-15
       IEEE      0,1     0,5       50000    1.1e-12   5.5e-15
       VAX       0,1    .5,100     25000    3.5e-14   1.1e-15
    With a and b constrained to half-integer or integer values:
       IEEE      0,1    .5,10000   50000    5.8e-12   1.1e-13
       IEEE      0,1    .5,100    100000    1.7e-14   7.9e-16
    With a = .5, b constrained to half-integer or integer values:
       IEEE      0,1    .5,10000   10000    8.3e-11   1.0e-11

<a name="isnan"></a>
## isnan - Test for not a number

<a name="signbit"></a>
## signbit - Extract sign

<a name="isfinite"></a>
## isfinite - Test for infinity
						signbit()
						isfinite()

Floating point numeric utilities

Synopsis:

    double ceil(), floor(), frexp(), ldexp();
    int signbit(), isnan(), isfinite();
    double x, y;
    int expnt, n;

    y = floor(x);
    y = ceil(x);
    y = frexp( x, &expnt );
    y = ldexp( x, n );
    n = signbit(x);
    n = isnan(x);
    n = isfinite(x);

Description:

    All four routines return a double precision floating point
    result.

    floor() returns the largest integer less than or equal to x.
    It truncates toward minus infinity.

    ceil() returns the smallest integer greater than or equal
    to x.  It truncates toward plus infinity.

    frexp() extracts the exponent from x.  It returns an integer
    power of two to expnt and the significand between 0.5 and 1
    to y.  Thus  x = y * 2**expn.

    ldexp() multiplies x by 2**n.

    signbit(x) returns 1 if the sign bit of x is 1, else 0.

    These functions are part of the standard C run time library
    for many but not all C compilers.  The ones supplied are
    written in C for either DEC or IEEE arithmetic.  They should
    be used only if your compiler library does not already have
    them.

    The IEEE versions assume that denormal numbers are implemented
    in the arithmetic.  Some modifications will be required if
    the arithmetic has abrupt rather than gradual underflow.

<a name="iv"></a>
## iv - Modified Bessel function of noninteger order

Modified Bessel function of noninteger order

Synopsis:

    double v, x, y, iv();

    y = iv( v, x );

Description:

    Returns modified Bessel function of order v of the
    argument.  If x is negative, v must be integer valued.

    The function is defined as Iv(x) = Jv( ix ).  It is
    here computed in terms of the confluent hypergeometric
    function, according to the formula

                 v  -x
    Iv(x) = (x/2)  e   hyperg( v+0.5, 2v+1, 2x ) / gamma(v+1)

    If v is a negative integer, then v is replaced by -v.

Accuracy:

    Tested at random points (v, x), with v between 0 and
    30, x between 0 and 28.
                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC       0,30          2000      3.1e-15     5.4e-16
       IEEE      0,30         10000      1.7e-14     2.7e-15

    Accuracy is diminished if v is near a negative integer.

    See also hyperg.c.

<a name="j0"></a>
## j0 - Bessel function of order zero

Bessel function of order zero

Synopsis:

    double x, y, j0();

    y = j0( x );

Description:

    Returns Bessel function of order zero of the argument.

    The domain is divided into the intervals [0, 5] and
    (5, infinity). In the first interval the following rational
    approximation is used:

           2         2
    (w - r  ) (w - r  ) P (w) / Q (w)
          1         2    3       8

               2
    where w = x  and the two r's are zeros of the function.

    In the second interval, the Hankel asymptotic expansion
    is employed with two rational functions of degree 6/6
    and 7/7.

Accuracy:

                         Absolute error:
    arithmetic   domain     # trials      peak         rms
       DEC       0, 30       10000       4.4e-17     6.3e-18
       IEEE      0, 30       60000       4.2e-16     1.1e-16

<a name="y0"></a>
## y0 - Bessel function of the second kind, order zero

Bessel function of the second kind, order zero

Synopsis:

    double x, y, y0();

    y = y0( x );

Description:

    Returns Bessel function of the second kind, of order
    zero, of the argument.

    The domain is divided into the intervals [0, 5] and
    (5, infinity). In the first interval a rational approximation
    R(x) is employed to compute
      y0(x)  = R(x)  +   2 * log(x) * j0(x) / PI.
    Thus a call to j0() is required.

    In the second interval, the Hankel asymptotic expansion
    is employed with two rational functions of degree 6/6
    and 7/7.

Accuracy:

     Absolute error, when y0(x) < 1; else relative error:

    arithmetic   domain     # trials      peak         rms
       DEC       0, 30        9400       7.0e-17     7.9e-18
       IEEE      0, 30       30000       1.3e-15     1.6e-16

<a name="j1"></a>
## j1 - Bessel function of order one

Bessel function of order one

Synopsis:

    double x, y, j1();

    y = j1( x );

Description:

    Returns Bessel function of order one of the argument.

    The domain is divided into the intervals [0, 8] and
    (8, infinity). In the first interval a 24 term Chebyshev
    expansion is used. In the second, the asymptotic
    trigonometric representation is employed using two
    rational functions of degree 5/5.

Accuracy:

                         Absolute error:
    arithmetic   domain      # trials      peak         rms
       DEC       0, 30       10000       4.0e-17     1.1e-17
       IEEE      0, 30       30000       2.6e-16     1.1e-16

<a name="y1"></a>
## y1 - Bessel function of the second kind, order one

Bessel function of second kind of order one

Synopsis:

    double x, y, y1();

    y = y1( x );

Description:

    Returns Bessel function of the second kind of order one
    of the argument.

    The domain is divided into the intervals [0, 8] and
    (8, infinity). In the first interval a 25 term Chebyshev
    expansion is used, and a call to j1() is required.
    In the second, the asymptotic trigonometric representation
    is employed using two rational functions of degree 5/5.

Accuracy:

                         Absolute error:
    arithmetic   domain      # trials      peak         rms
       DEC       0, 30       10000       8.6e-17     1.3e-17
       IEEE      0, 30       30000       1.0e-15     1.3e-16

    (error criterion relative when |y1| > 1).

<a name="jn"></a>
## jn - Bessel function of integer order

Bessel function of integer order

Synopsis:

    int n;
    double x, y, jn();

    y = jn( n, x );

Description:

    Returns Bessel function of order n, where n is a
    (possibly negative) integer.

    The ratio of jn(x) to j0(x) is computed by backward
    recurrence.  First the ratio jn/jn-1 is found by a
    continued fraction expansion.  Then the recurrence
    relating successive orders is applied until j0 or j1 is
    reached.

    If n = 0 or 1 the routine for j0 or j1 is called
    directly.

Accuracy:

                         Absolute error:
    arithmetic   range      # trials      peak         rms
       DEC       0, 30        5500       6.9e-17     9.3e-18
       IEEE      0, 30        5000       4.4e-16     7.9e-17

    Not suitable for large n or x. Use jv() instead.

<a name="jv"></a>
## jv - Bessel function of noninteger order

Bessel function of noninteger order

Synopsis:

    double v, x, y, jv();

    y = jv( v, x );

Description:

    Returns Bessel function of order v of the argument,
    where v is real.  Negative x is allowed if v is an integer.

    Several expansions are included: the ascending power
    series, the Hankel expansion, and two transitional
    expansions for large v.  If v is not too large, it
    is reduced by recurrence to a region of best accuracy.
    The transitional expansions give 12D accuracy for v > 500.

Accuracy:

    Results for integer v are indicated by *, where x and v
    both vary from -125 to +125.  Otherwise,
    x ranges from 0 to 125, v ranges as indicated by "domain."
    Error criterion is absolute, except relative when |jv()| > 1.

    arithmetic  v domain  x domain    # trials      peak       rms
       IEEE      0,125     0,125      100000      4.6e-15    2.2e-16
       IEEE   -125,0       0,125       40000      5.4e-11    3.7e-13
       IEEE      0,500     0,500       20000      4.4e-15    4.0e-16
    Integer v:
       IEEE   -125,125   -125,125      50000      3.5e-15*   1.9e-16*

<a name="k0"></a>
## k0 - Modified Bessel function, third kind, order zero

Modified Bessel function, third kind, order zero

Synopsis:

    double x, y, k0();

    y = k0( x );

Description:

    Returns modified Bessel function of the third kind
    of order zero of the argument.

    The range is partitioned into the two intervals [0,8] and
    (8, infinity).  Chebyshev polynomial expansions are employed
    in each interval.

Accuracy:

    Tested at 2000 random points between 0 and 8.  Peak absolute
    error (relative when K0 > 1) was 1.46e-14; rms, 4.26e-15.
                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC       0, 30        3100       1.3e-16     2.1e-17
       IEEE      0, 30       30000       1.2e-15     1.6e-16

Error messages:

      message         condition      value returned
     K0 domain          x <= 0          MAXNUM

<a name="k0e"></a>
## k0e - Modified Bessel function, third kind, order zero, exponentially scaled

Modified Bessel function, third kind, order zero,
exponentially scaled

Synopsis:

    double x, y, k0e();

    y = k0e( x );

Description:

    Returns exponentially scaled modified Bessel function
    of the third kind of order zero of the argument.

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       IEEE      0, 30       30000       1.4e-15     1.4e-16
    See k0().

<a name="k1"></a>
## k1 - Modified Bessel function, third kind, order one

Modified Bessel function, third kind, order one

Synopsis:

    double x, y, k1();

    y = k1( x );

Description:

    Computes the modified Bessel function of the third kind
    of order one of the argument.

    The range is partitioned into the two intervals [0,2] and
    (2, infinity).  Chebyshev polynomial expansions are employed
    in each interval.

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC       0, 30        3300       8.9e-17     2.2e-17
       IEEE      0, 30       30000       1.2e-15     1.6e-16

Error messages:

      message         condition      value returned
    k1 domain          x <= 0          MAXNUM

<a name="k1e"></a>
## k1e - Modified Bessel function, third kind, order one, exponentially scaled

Modified Bessel function, third kind, order one,
exponentially scaled

Synopsis:

    double x, y, k1e();

    y = k1e( x );

Description:

    Returns exponentially scaled modified Bessel function
    of the third kind of order one of the argument:

         k1e(x) = exp(x) * k1(x).

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       IEEE      0, 30       30000       7.8e-16     1.2e-16
    See k1().

<a name="kn"></a>
## kn - Modified Bessel function, third kind, integer order

Modified Bessel function, third kind, integer order

Synopsis:

    double x, y, kn();
    int n;

    y = kn( n, x );

Description:

    Returns modified Bessel function of the third kind
    of order n of the argument.

    The range is partitioned into the two intervals [0,9.55] and
    (9.55, infinity).  An ascending power series is used in the
    low range, and an asymptotic expansion in the high range.

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC       0,30         3000       1.3e-9      5.8e-11
       IEEE      0,30        90000       1.8e-8      3.0e-10

     Error is high only near the crossover point x = 9.55
    between the two expansions used.

<a name="kolmogorov"></a>
## kolmogorov - Kolmogorov, Smirnov distributions

<a name="lmdif"></a>
## lmdif - Levenberg-Marquardt algorithm

    The purpose of lmdif is to minimize the sum of the squares of
    M nonlinear functions in N variables by a modification of
    the Levenberg-Marquardt algorithm. The user must provide a
    subroutine that calculates the functions.  The Jacobian is
    then calculated numerically by a forward-difference approximation.

    Refer to the source code for information on the use of the routine.

    This is a C language translation of the Fortran version of
    the corresponding routine from Argonne National Laboratories
    MINPACK subroutine suite.

<a name="levnsn"></a>
## levnsn - Linear predictive coding
linear predictive coding

| R0 R1 R2 ... RN-1 |   | A1 |       | -R1 |
| R1 R0 R1 ... RN-2 |   | A2 |       | -R2 |
| R2 R1 R0 ... RN-3 |   | A3 |   =   | -R3 |
|          ...      |   | ...|       | ... |
| RN-1 RN-2... R0   |   | AN |       | -RN |

Ref: John Makhoul, "Linear Prediction, A Tutorial Review"
Proc. IEEE Vol. 63, PP 561-580 April, 1975.

R is the input autocorrelation function.  R0 is the zero lag
term.  A is the output array of predictor coefficients.  Note
that a filter impulse response has a coefficient of 1.0 preceding
A1.  E is an array of mean square error for each prediction order
1 to N.  REFL is an output array of the reflection coefficients.

<a name="log"></a>
## log - Natural logarithm

Natural logarithm

Synopsis:

    double x, y, log();

    y = log( x );

Description:

    Returns the base e (2.718...) logarithm of x.

    The argument is separated into its exponent and fractional
    parts.  If the exponent is between -1 and +1, the logarithm
    of the fraction is approximated by

        log(1+x) = x - 0.5 x**2 + x**3 P(x)/Q(x).

    Otherwise, setting  z = 2(x-1)/x+1),

        log(x) = z + z**3 P(z)/Q(z).

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       IEEE      0.5, 2.0    150000      1.44e-16    5.06e-17
       IEEE      +-MAXNUM    30000       1.20e-16    4.78e-17
       DEC       0, 10       170000      1.8e-17     6.3e-18

    In the tests over the interval [+-MAXNUM], the logarithms
    of the random arguments were uniformly distributed over
    [0, MAXLOG].

Error messages:

    log singularity:  x = 0; returns -INFINITY
    log domain:       x < 0; returns NAN

<a name="log10"></a>
## log10 - Common logarithm

Common logarithm

Synopsis:

    double x, y, log10();

    y = log10( x );

Description:

    Returns logarithm to the base 10 of x.

    The argument is separated into its exponent and fractional
    parts.  The logarithm of the fraction is approximated by

        log(1+x) = x - 0.5 x**2 + x**3 P(x)/Q(x).

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       IEEE      0.5, 2.0     30000      1.5e-16     5.0e-17
       IEEE      0, MAXNUM    30000      1.4e-16     4.8e-17
       DEC       1, MAXNUM    50000      2.5e-17     6.0e-18

    In the tests over the interval [1, MAXNUM], the logarithms
    of the random arguments were uniformly distributed over
    [0, MAXLOG].

Error messages:

    log10 singularity:  x = 0; returns -INFINITY
    log10 domain:       x < 0; returns NAN

<a name="log2"></a>
## log2 - Base 2 logarithm

Base 2 logarithm

Synopsis:

    double x, y, log2();

    y = log2( x );

Description:

    Returns the base 2 logarithm of x.

    The argument is separated into its exponent and fractional
    parts.  If the exponent is between -1 and +1, the base e
    logarithm of the fraction is approximated by

        log(1+x) = x - 0.5 x**2 + x**3 P(x)/Q(x).

    Otherwise, setting  z = 2(x-1)/x+1),

        log(x) = z + z**3 P(z)/Q(z).

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       IEEE      0.5, 2.0    30000       2.0e-16     5.5e-17
       IEEE      exp(+-700)  40000       1.3e-16     4.6e-17

    In the tests over the interval [exp(+-700)], the logarithms
    of the random arguments were uniformly distributed.

Error messages:

    log2 singularity:  x = 0; returns -INFINITY
    log2 domain:       x < 0; returns NAN

<a name="lrand"></a>
## lrand - Pseudorandom integer number generator

Pseudorandom number generator

Synopsis:

    long y, drand();

    drand( &y );

Description:

    Yields a long integer random number.

    The three-generator congruential algorithm by Brian
    Wichmann and David Hill (BYTE magazine, March, 1987,
    pp 127-8) is used. The period, given by them, is
    6953607871644.

<a name="lsqrt"></a>
## lsqrt - Integer square root

Integer square root

Synopsis:

    long x, y;
    long lsqrt();

    y = lsqrt( x );

Description:

    Returns a long integer square root of the long integer
    argument.  The computation is by binary long division.

    The largest possible result is lsqrt(2,147,483,647)
    = 46341.

    If x < 0, the square root of |x| is returned, and an
    error message is printed.

Accuracy:

    An extra, roundoff, bit is computed; hence the result
    is the nearest integer to the actual square root.
Note:

<a name="minv"></a>
## minv - Matrix inversion

Matrix inversion

Synopsis:

    int n, errcod;
    double A[n*n], X[n*n];
    double B[n];
    int IPS[n];
    int minv();

    errcod = minv( A, X, n, B, IPS );

Description:

    Finds the inverse of the n by n matrix A.  The result goes
    to X.   B and IPS are scratch pad arrays of length n.
    The contents of matrix A are destroyed.

    The routine returns nonzero on error; error messages are printed
    by subroutine simq().

<a name="mtransp"></a>
## mtransp - Matrix transpose

Matrix transpose

Synopsis:

    int n;
    double A[n*n], T[n*n];

    mtransp( n, A, T );

Description:

    T[r][c] = A[c][r]

    Transposes the n by n square matrix A and puts the result in T.
    The output, T, may occupy the same storage as A.

<a name="nbdtr"></a>
## nbdtr - Negative binomial distribution

Negative binomial distribution

Synopsis:

    int k, n;
    double p, y, nbdtr();

    y = nbdtr( k, n, p );

Description:

    Returns the sum of the terms 0 through k of the negative
    binomial distribution:

      k
      --  ( n+j-1 )   n      j
      >   (       )  p  (1-p)
      --  (   j   )
     j=0

    In a sequence of Bernoulli trials, this is the probability
    that k or fewer failures precede the nth success.

    The terms are not computed individually; instead the incomplete
    beta integral is employed, according to the formula

    y = nbdtr( k, n, p ) = incbet( n, k+1, p ).

    The arguments must be positive, with p ranging from 0 to 1.

Accuracy:

    Tested at random points (a,b,p), with p between 0 and 1.

                  a,b                     Relative error:
    arithmetic  domain     # trials      peak         rms
       IEEE     0,100       100000      1.7e-13     8.8e-15
    See also incbet.c.

<a name="nbdtrc"></a>
## nbdtrc - Complemented negative binomial distribution

Complemented negative binomial distribution

Synopsis:

    int k, n;
    double p, y, nbdtrc();

    y = nbdtrc( k, n, p );

Description:

    Returns the sum of the terms k+1 to infinity of the negative
    binomial distribution:

      inf
      --  ( n+j-1 )   n      j
      >   (       )  p  (1-p)
      --  (   j   )
     j=k+1

    The terms are not computed individually; instead the incomplete
    beta integral is employed, according to the formula

    y = nbdtrc( k, n, p ) = incbet( k+1, n, 1-p ).

    The arguments must be positive, with p ranging from 0 to 1.

Accuracy:

    Tested at random points (a,b,p), with p between 0 and 1.

                  a,b                     Relative error:
    arithmetic  domain     # trials      peak         rms
       IEEE     0,100       100000      1.7e-13     8.8e-15
    See also incbet.c.

<a name="nbdtri"></a>
## nbdtri - Functional inverse of negative binomial distribution

Functional inverse of negative binomial distribution

Synopsis:

    int k, n;
    double p, y, nbdtri();

    p = nbdtri( k, n, y );

Description:

    Finds the argument p such that nbdtr(k,n,p) is equal to y.

Accuracy:

    Tested at random points (a,b,y), with y between 0 and 1.

                  a,b                     Relative error:
    arithmetic  domain     # trials      peak         rms
       IEEE     0,100       100000      1.5e-14     8.5e-16
    See also incbi.c.

<a name="ndtr"></a>
## ndtr - Normal distribution function

Normal distribution function

Synopsis:

    double x, y, ndtr();

    y = ndtr( x );

Description:

    Returns the area under the Gaussian probability density
    function, integrated from minus infinity to x:

                               x
                                -
                      1        | |          2
       ndtr(x)  = ---------    |    exp( - t /2 ) dt
                  sqrt(2pi)  | |
                              -
                             -inf.

                =  ( 1 + erf(z) ) / 2
                =  erfc(z) / 2

    where z = x/sqrt(2). Computation is via the functions
    erf and erfc with care to avoid error amplification in computing exp(-x^2).

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       IEEE     -13,0        30000       1.3e-15     2.2e-16

Error messages:

      message         condition         value returned
    erfc underflow    x > 37.519379347       0.0

<a name="erf"></a>
## erf - Error function

Error function

Synopsis:

    double x, y, erf();

    y = erf( x );

Description:

    The integral is

                              x 
                               -
                    2         | |          2
      erf(x)  =  --------     |    exp( - t  ) dt.
                 sqrt(pi)   | |
                             -
                              0

    The magnitude of x is limited to 9.231948545 for DEC
    arithmetic; 1 or -1 is returned outside this range.

    For 0 <= |x| < 1, erf(x) = x * P4(x**2)/Q5(x**2); otherwise
    erf(x) = 1 - erfc(x).

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC       0,1         14000       4.7e-17     1.5e-17
       IEEE      0,1         30000       3.7e-16     1.0e-16

<a name="erfc"></a>
## erfc - Complementary error function

Complementary error function

Synopsis:

    double x, y, erfc();

    y = erfc( x );

Description:

     1 - erf(x) =

                              inf. 
                                -
                     2         | |          2
      erfc(x)  =  --------     |    exp( - t  ) dt
                  sqrt(pi)   | |
                              -
                               x

    For small x, erfc(x) = 1 - erf(x); otherwise rational
    approximations are computed.

    A special function expx2.c is used to suppress error amplification
    in computing exp(-x^2).

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       IEEE      0,26.6417   30000       1.3e-15     2.2e-16

Error messages:

      message         condition              value returned
    erfc underflow    x > 9.231948545 (DEC)       0.0

<a name="ndtri"></a>
## ndtri - Inverse of normal distribution function

Inverse of Normal distribution function

Synopsis:

    double x, y, ndtri();

    x = ndtri( y );

Description:

    Returns the argument, x, for which the area under the
    Gaussian probability density function (integrated from
    minus infinity to x) is equal to y.

    For small arguments 0 < y < exp(-2), the program computes
    z = sqrt( -2.0 * log(y) );  then the approximation is
    x = z - log(z)/z  - (1/z) P(1/z) / Q(1/z).
    There are two rational functions P/Q, one for 0 < y < exp(-32)
    and the other for y up to exp(-2).  For larger arguments,
    w = y - 0.5, and  x/sqrt(2pi) = w + w**3 R(w**2)/S(w**2)).

Accuracy:

                         Relative error:
    arithmetic   domain        # trials      peak         rms
       DEC      0.125, 1         5500       9.5e-17     2.1e-17
       DEC      6e-39, 0.135     3500       5.7e-17     1.3e-17
       IEEE     0.125, 1        20000       7.2e-16     1.3e-16
       IEEE     3e-308, 0.135   50000       4.6e-16     9.8e-17

Error messages:

      message         condition    value returned
    ndtri domain       x <= 0        -MAXNUM
    ndtri domain       x >= 1         MAXNUM

<a name="pdtr"></a>
## pdtr - Poisson distribution function

Poisson distribution

Synopsis:

    int k;
    double m, y, pdtr();

    y = pdtr( k, m );

Description:

    Returns the sum of the first k terms of the Poisson
    distribution:

      k         j
      --   -m  m
      >   e    --
      --       j!
     j=0

    The terms are not summed directly; instead the incomplete
    gamma integral is employed, according to the relation

    y = pdtr( k, m ) = igamc( k+1, m ).

    The arguments must both be positive.

Accuracy:

    See igamc().

<a name="pdtrc"></a>
## pdtrc - Complemented Poisson distribution function

Complemented poisson distribution

Synopsis:

    int k;
    double m, y, pdtrc();

    y = pdtrc( k, m );

Description:

    Returns the sum of the terms k+1 to infinity of the Poisson
    distribution:

     inf.       j
      --   -m  m
      >   e    --
      --       j!
     j=k+1

    The terms are not summed directly; instead the incomplete
    gamma integral is employed, according to the formula

    y = pdtrc( k, m ) = igam( k+1, m ).

    The arguments must both be positive.

Accuracy:

    See igam.c.

<a name="pdtri"></a>
## pdtri - Inverse of Poisson distribution function

Inverse Poisson distribution

Synopsis:

    int k;
    double m, y, pdtr();

    m = pdtri( k, y );

Description:

    Finds the Poisson variable x such that the integral
    from 0 to x of the Poisson density is equal to the
    given probability y.

    This is accomplished using the inverse gamma integral
    function and the relation

       m = igami( k+1, y ).

Accuracy:

    See igami.c.

Error messages:

      message         condition      value returned
    pdtri domain    y < 0 or y >= 1       0.0
                        k < 0

<a name="planck"></a>
## planck - Integral of Planck's black body radiation formula

Integral of Planck's black body radiation formula

Synopsis:

    double lambda, T, y, plancki();

    y = plancki( lambda, T );

Description:

     Evaluates the definite integral, from wavelength 0 to lambda,
     of Planck's radiation formula
                         -5
               c1  lambda
        E =  ------------------
               c2/(lambda T)
              e             - 1

    Physical constants c1 = 3.7417749e-16 and c2 = 0.01438769 are built in
    to the function program.  They are scaled to provide a result
    in watts per square meter.  Argument T represents temperature in degrees
    Kelvin; lambda is wavelength in meters.

    The integral is expressed in closed form, in terms of polylogarithms
    (see polylog.c).

    The total area under the curve is
         (-1/8) (42 zeta(4) - 12 pi^2 zeta(2) + pi^4 ) c1 (T/c2)^4
          = (pi^4 / 15)  c1 (T/c2)^4
          =  5.6705032e-8 T^4
    where sigma = 5.6705032e-8 W m^2 K^-4 is the Stefan-Boltzmann constant.

Accuracy:

    The left tail of the function experiences some relative error
    amplification in computing the dominant term exp(-c2/(lambda T)).
    For the right-hand tail see planckc, below.

                         Relative error.
      The domain refers to lambda T / c2.
    arithmetic   domain     # trials      peak         rms
       IEEE      0.1, 10      50000      7.1e-15     5.4e-16

<a name="polevl"></a>
## polevl - Evaluate polynomial

<a name="p1evl"></a>
## p1evl - Evaluate polynomial
						p1evl.c

Evaluate polynomial

Synopsis:

    int N;
    double x, y, coef[N+1], polevl[];

    y = polevl( x, coef, N );

Description:

N:

                        2          N
    y  =  C  + C x + C x  +...+ C x
           0    1     2          N

    Coefficients are stored in reverse order:

    coef[0] = C  , ..., coef[N] = C  .
               N                   0

     The function p1evl() assumes that coef[N] = 1.0 and is
    omitted from the array.  Its calling arguments are
    otherwise the same as polevl(). N must be greater than 1.

Speed:

    In the interest of speed, there are no checks for out
    of bounds arithmetic.  This routine is used by most of
    the functions in the library.  Depending on available
    equipment features, the user may wish to rewrite the
    program in microcode or assembly language.

<a name="polmisc"></a>
## polmisc - Functions of a polynomial
Square root, sine, cosine, and arctangent of polynomial.
See polyn.c for data structures and discussion.

<a name="polrt"></a>
## polrt - Roots of a polynomial

Find roots of a polynomial

Synopsis:

    typedef struct
    {
    double r;
    double i;
    }cmplx;

    double xcof[], cof[];
    int m;
    cmplx root[];

    polrt( xcof, cof, m, root )

Description:

    Iterative determination of the roots of a polynomial of
    degree m whose coefficient vector is xcof[].  The
    coefficients are arranged in ascending order; i.e., the
    coefficient of x**m is xcof[m].

    The array cof[] is working storage the same size as xcof[].
    root[] is the output array containing the complex roots.

Accuracy:

    Termination depends on evaluation of the polynomial at
    the trial values of the roots.  The values of multiple roots
    or of roots that are nearly equal may have poor relative
    accuracy after the first root in the neighborhood has been
    found.

<a name="polylog"></a>
## polylog - Polylogarithms

Polylogarithms

Synopsis:

    double x, y, polylog();
    int n;

    y = polylog( n, x );

    The polylogarithm of order n is defined by the series

                 inf   k
                  -   x
     Li (x)  =    >   ---  .
       n          -     n
                 k=1   k

     For x = 1,

                  inf
                   -    1
      Li (1)  =    >   ---   =  Riemann zeta function (n)  .
        n          -     n
                  k=1   k

     When n = 2, the function is the dilogarithm, related to Spence's integral:

                    x                      1-x
                    -                        -
                   | |  -ln(1-t)            | |  ln t
      Li (x)  =    |    -------- dt    =    |    ------ dt    =   spence(1-x) .
        2        | |       t              | |    1 - t
                  -                        -
                   0                        1

     See also the program cpolylog.c for the complex polylogarithm,
     whose definition is extended to x > 1.

     References:

     Lewin, L., _Polylogarithms and Associated Functions_,
     North Holland, 1981.

     Lewin, L., ed., _Structural Properties of Polylogarithms_,
     American Mathematical Society, 1991.

Accuracy:

                         Relative error:
    arithmetic   domain   n   # trials      peak         rms
       IEEE      0, 1     2     50000      6.2e-16     8.0e-17
       IEEE      0, 1     3    100000      2.5e-16     6.6e-17
       IEEE      0, 1     4     30000      1.7e-16     4.9e-17
       IEEE      0, 1     5     30000      5.1e-16     7.8e-17

<a name="polyn"></a>
## polyn - Arithmetic operations on polynomials
						polyr.c
Arithmetic operations on polynomials

In the following descriptions a, b, c are polynomials of degree
na, nb, nc respectively.  The degree of a polynomial cannot
exceed a run-time value MAXPOL.  An operation that attempts
to use or generate a polynomial of higher degree may produce a
result that suffers truncation at degree MAXPOL.  The value of
MAXPOL is set by calling the function

    polini( maxpol );

where maxpol is the desired maximum degree.  This must be
done prior to calling any of the other functions in this module.
Memory for internal temporary polynomial storage is allocated
by polini().

Each polynomial is represented by an array containing its
coefficients, together with a separately declared integer equal
to the degree of the polynomial.  The coefficients appear in
ascending order; that is,

                                       2                      na
a(x)  =  a[0]  +  a[1] * x  +  a[2] * x   +  ...  +  a[na] * x  .

sum = poleva( a, na, x );	Evaluate polynomial a(t) at t = x.
polprt( a, na, D );		Print the coefficients of a to D digits.
polclr( a, na );		Set a identically equal to zero, up to a[na].
polmov( a, na, b );		Set b = a.
poladd( a, na, b, nb, c );	c = b + a, nc = max(na,nb)
polsub( a, na, b, nb, c );	c = b - a, nc = max(na,nb)
polmul( a, na, b, nb, c );	c = b * a, nc = na+nb

Division:

i = poldiv( a, na, b, nb, c );	c = b / a, nc = MAXPOL

returns i = the degree of the first nonzero coefficient of a.
The computed quotient c must be divided by x^i.  An error message
is printed if a is identically zero.

Change of variables:
If a and b are polynomials, and t = a(x), then
    c(t) = b(a(x))
is a polynomial found by substituting a(x) for t.  The
subroutine call for this is

polsbt( a, na, b, nb, c );

Notes:
poldiv() is an integer routine; poleva() is double.
Any of the arguments a, b, c may refer to the same array.

<a name="polyr"></a>
## polyr - Arithmetic operations on polynomials with rational coefficients

In the following descriptions a, b, c are polynomials of degree
na, nb, nc respectively.  The degree of a polynomial cannot
exceed a run-time value MAXPOL.  An operation that attempts
to use or generate a polynomial of higher degree may produce a
result that suffers truncation at degree MAXPOL.  The value of
MAXPOL is set by calling the function

    polini( maxpol );

where maxpol is the desired maximum degree.  This must be
done prior to calling any of the other functions in this module.
Memory for internal temporary polynomial storage is allocated
by polini().

Each polynomial is represented by an array containing its
coefficients, together with a separately declared integer equal
to the degree of the polynomial.  The coefficients appear in
ascending order; that is,

                                       2                      na
a(x)  =  a[0]  +  a[1] * x  +  a[2] * x   +  ...  +  a[na] * x  .

`a', `b', `c' are arrays of fracts.
poleva( a, na, &x, &sum );	Evaluate polynomial a(t) at t = x.
polprt( a, na, D );		Print the coefficients of a to D digits.
polclr( a, na );		Set a identically equal to zero, up to a[na].
polmov( a, na, b );		Set b = a.
poladd( a, na, b, nb, c );	c = b + a, nc = max(na,nb)
polsub( a, na, b, nb, c );	c = b - a, nc = max(na,nb)
polmul( a, na, b, nb, c );	c = b * a, nc = na+nb

Division:

i = poldiv( a, na, b, nb, c );	c = b / a, nc = MAXPOL

returns i = the degree of the first nonzero coefficient of a.
The computed quotient c must be divided by x^i.  An error message
is printed if a is identically zero.

Change of variables:
If a and b are polynomials, and t = a(x), then
    c(t) = b(a(x))
is a polynomial found by substituting a(x) for t.  The
subroutine call for this is

polsbt( a, na, b, nb, c );

Notes:
poldiv() is an integer routine; poleva() is double.
Any of the arguments a, b, c may refer to the same array.

<a name="pow"></a>
## pow - Power function

Power function

Synopsis:

    double x, y, z, pow();

    z = pow( x, y );

Description:

    Computes x raised to the yth power.  Analytically,

         x**y  =  exp( y log(x) ).

    Following Cody and Waite, this program uses a lookup table
    of 2**-i/16 and pseudo extended precision arithmetic to
    obtain an extra three bits of accuracy in both the logarithm
    and the exponential.

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       IEEE     -26,26       30000      4.2e-16      7.7e-17
       DEC      -26,26       60000      4.8e-17      9.1e-18
    1/26 < x < 26, with log(x) uniformly distributed.
    -26 < y < 26, y uniformly distributed.
       IEEE     0,8700       30000      1.5e-14      2.1e-15
    0.99 < x < 1.01, 0 < y < 8700, uniformly distributed.

Error messages:

      message         condition      value returned
    pow overflow     x**y > MAXNUM      INFINITY
    pow underflow   x**y < 1/MAXNUM       0.0
    pow domain      x<0 and y noninteger  0.0

<a name="powi"></a>
## powi - Integer power function

Real raised to integer power

Synopsis:

    double x, y, powi();
    int n;

    y = powi( x, n );

Description:

    Returns argument x raised to the nth power.
    The routine efficiently decomposes n as a sum of powers of
    two. The desired power is a product of two-to-the-kth
    powers of x.  Thus to compute the 32767 power of x requires
    28 multiplications instead of 32767 multiplications.

Accuracy:

                         Relative error:
    arithmetic   x domain   n domain  # trials      peak         rms
       DEC       .04,26     -26,26    100000       2.7e-16     4.3e-17
       IEEE      .04,26     -26,26     50000       2.0e-15     3.8e-16
       IEEE        1,2    -1022,1023   50000       8.6e-14     1.6e-14

    Returns MAXNUM on overflow, zero on underflow.

<a name="psi"></a>
## psi - Psi (digamma) function

Psi (digamma) function

Synopsis:

    double x, y, psi();

    y = psi( x );

Description:

                 d      -
      psi(x)  =  -- ln | (x)
                 dx

    is the logarithmic derivative of the gamma function.
    For integer x,
                      n-1
                       -
    psi(n) = -EUL  +   >  1/k.
                       -
                      k=1

    This formula is used for 0 < n <= 10.  If x is negative, it
    is transformed to a positive argument by the reflection
    formula  psi(1-x) = psi(x) + pi cot(pi x).
    For general positive x, the argument is made greater than 10
    using the recurrence  psi(x+1) = psi(x) + 1/x.
    Then the following asymptotic expansion is applied:

                              inf.   B
                               -      2k
    psi(x) = log(x) - 1/2x -   >   -------
                               -        2k
                              k=1   2k x

    where the B2k are Bernoulli numbers.

Accuracy:

       Relative error (except absolute when |psi| < 1):
    arithmetic   domain     # trials      peak         rms
       DEC       0,30         2500       1.7e-16     2.0e-17
       IEEE      0,30        30000       1.3e-15     1.4e-16
       IEEE      -30,0       40000       1.5e-15     2.2e-16

Error messages:

        message         condition      value returned
    psi singularity    x integer <=0      MAXNUM

<a name="revers"></a>
## revers - Reversion of power series

Reversion of power series

Synopsis:

    extern int MAXPOL;
    int n;
    double x[n+1], y[n+1];

    polini(n);
    revers( y, x, n );

     Note, polini() initializes the polynomial arithmetic subroutines;
     see polyn.c.

Description:

    If

             inf
              -       i
     y(x)  =  >   a  x
              -    i
             i=1

    then

             inf
              -       j
     x(y)  =  >   A  y    ,
              -    j
             j=1

    where
                      1
            A    =   ---
             1        a
                       1

    etc.  The coefficients of x(y) are found by expanding

             inf      inf
              -        -      i
     x(y)  =  >   A    >  a  x
              -    j   -   i
             j=1      i=1

     and setting each coefficient of x , higher than the first,
     to zero.

Restrictions:

     y[0] must be zero, and y[1] must be nonzero.

<a name="rgamma"></a>
## rgamma - Reciprocal gamma function

Reciprocal gamma function

Synopsis:

    double x, y, rgamma();

    y = rgamma( x );

Description:

    Returns one divided by the gamma function of the argument.

    The function is approximated by a Chebyshev expansion in
    the interval [0,1].  Range reduction is by recurrence
    for arguments between -34.034 and +34.84425627277176174.
    1/MAXNUM is returned for positive arguments outside this
    range.  For arguments less than -34.034 the cosecant
    reflection formula is applied; lograrithms are employed
    to avoid unnecessary overflow.

    The reciprocal gamma function has no singularities,
    but overflow and underflow may occur for large arguments.
    These conditions return either MAXNUM or 1/MAXNUM with
    appropriate sign.

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC      -30,+30       4000       1.2e-16     1.8e-17
       IEEE     -30,+30      30000       1.1e-15     2.0e-16
    For arguments less than -34.034 the peak error is on the
    order of 5e-15 (DEC), excepting overflow or underflow.

<a name="round"></a>
## round - Round to nearest or even integer

Round double to nearest or even integer valued double

Synopsis:

    double x, y, round();

    y = round(x);

Description:

    Returns the nearest integer to x as a double precision
    floating point result.  If x ends in 0.5 exactly, the
    nearest even integer is chosen.

Accuracy:

    If x is greater than 1/(2*MACHEP), its closest machine
    representation is already an integer, so rounding does
    not change it.

<a name="shichi"></a>
## shichi - Hyperbolic sine and cosine integrals

Hyperbolic sine and cosine integrals

Synopsis:

    double x, Chi, Shi, shichi();

    shichi( x, &Chi, &Shi );

Description:

    Approximates the integrals

                               x
                               -
                              | |   cosh t - 1
      Chi(x) = eul + ln x +   |    -----------  dt,
                            | |          t
                             -
                             0

                  x
                  -
                 | |  sinh t
      Shi(x) =   |    ------  dt
               | |       t
                -
                0

    where eul = 0.57721566490153286061 is Euler's constant.
    The integrals are evaluated by power series for x < 8
    and by Chebyshev expansions for x between 8 and 88.
    For large x, both functions approach exp(x)/2x.
    Arguments greater than 88 in magnitude return MAXNUM.

Accuracy:

    Test interval 0 to 88.
                         Relative error:
    arithmetic   function  # trials      peak         rms
       DEC          Shi       3000       9.1e-17
       IEEE         Shi      30000       6.9e-16     1.6e-16
           Absolute error, except relative when |Chi| > 1:
       DEC          Chi       2500       9.3e-17
       IEEE         Chi      30000       8.4e-16     1.4e-16

<a name="sici"></a>
## sici - Sine and cosine integrals

Sine and cosine integrals

Synopsis:

    double x, Ci, Si, sici();

    sici( x, &Si, &Ci );

Description:

    Evaluates the integrals

                             x
                             -
                            |  cos t - 1
      Ci(x) = eul + ln x +  |  --------- dt,
                            |      t
                           -
                            0
                x
                -
               |  sin t
      Si(x) =  |  ----- dt
               |    t
              -
               0

    where eul = 0.57721566490153286061 is Euler's constant.
    The integrals are approximated by rational functions.
    For x > 8 auxiliary functions f(x) and g(x) are employed
    such that

    Ci(x) = f(x) sin(x) - g(x) cos(x)
    Si(x) = pi/2 - f(x) cos(x) - g(x) sin(x)

Accuracy:

       Test interval = [0,50].
    Absolute error, except relative when > 1:
    arithmetic   function   # trials      peak         rms
       IEEE        Si        30000       4.4e-16     7.3e-17
       IEEE        Ci        30000       6.9e-16     5.1e-17
       DEC         Si         5000       4.4e-17     9.0e-18
       DEC         Ci         5300       7.9e-17     5.2e-18

<a name="simpsn"></a>
## simpsn - Numerical integration of tabulated function
Numerical integration of function tabulated
at equally spaced arguments

<a name="simq"></a>
## simq - Simultaneous linear equations

Solution of simultaneous linear equations AX = B
by Gaussian elimination with partial pivoting

Synopsis:

    double A[n*n], B[n], X[n];
    int n, flag;
    int IPS[];
    int simq();

    ercode = simq( A, B, X, n, flag, IPS );

Description:

    B, X, IPS are vectors of length n.
    A is an n x n matrix (i.e., a vector of length n*n),
    stored row-wise: that is, A(i,j) = A[ij],
    where ij = i*n + j, which is the transpose of the normal
    column-wise storage.

    The contents of matrix A are destroyed.

    Set flag=0 to solve.
    Set flag=-1 to do a new back substitution for different B vector
    using the same A matrix previously reduced when flag=0.

    The routine returns nonzero on error; messages are printed.

Accuracy:

    Depends on the conditioning (range of eigenvalues) of matrix A.

Reference:

    Computer Solution of Linear Algebraic Systems,
    by George E. Forsythe and Cleve B. Moler; Prentice-Hall, 1967.

<a name="sin"></a>
## sin - Circular sine

Circular sine

Synopsis:

    double x, y, sin();

    y = sin( x );

Description:

    Range reduction is into intervals of pi/4.  The reduction
    error is nearly eliminated by contriving an extended precision
    modular arithmetic.

    Two polynomial approximating functions are employed.
    Between 0 and pi/4 the sine is approximated by
         x  +  x**3 P(x**2).
    Between pi/4 and pi/2 the cosine is represented as
         1  -  x**2 Q(x**2).

Accuracy:

                         Relative error:
    arithmetic   domain      # trials      peak         rms
       DEC       0, 10       150000       3.0e-17     7.8e-18
       IEEE -1.07e9,+1.07e9  130000       2.1e-16     5.4e-17

Error messages:

      message           condition        value returned
    sin total loss   x > 1.073741824e9      0.0

    Partial loss of accuracy begins to occur at x = 2**30
    = 1.074e9.  The loss is not gradual, but jumps suddenly to
    about 1 part in 10e7.  Results may be meaningless for
    x > 2**49 = 5.6e14.  The routine as implemented flags a
    TLOSS error for x > 2**30 and returns 0.0.

<a name="cos"></a>
## cos - Circular cosine

Circular cosine

Synopsis:

    double x, y, cos();

    y = cos( x );

Description:

    Range reduction is into intervals of pi/4.  The reduction
    error is nearly eliminated by contriving an extended precision
    modular arithmetic.

    Two polynomial approximating functions are employed.
    Between 0 and pi/4 the cosine is approximated by
         1  -  x**2 Q(x**2).
    Between pi/4 and pi/2 the sine is represented as
         x  +  x**3 P(x**2).

Accuracy:

                         Relative error:
    arithmetic   domain      # trials      peak         rms
       IEEE -1.07e9,+1.07e9  130000       2.1e-16     5.4e-17
       DEC        0,+1.07e9   17000       3.0e-17     7.2e-18

<a name="sincos"></a>
## sincos - Sine and cosine by interpolation

Circular sine and cosine of argument in degrees
Table lookup and interpolation algorithm

Synopsis:

    double x, sine, cosine, flg, sincos();

    sincos( x, &sine, &cosine, flg );

Description:

    Returns both the sine and the cosine of the argument x.
    Several different compile time options and minimax
    approximations are supplied to permit tailoring the
    tradeoff between computation speed and accuracy.

    Since range reduction is time consuming, the reduction
    of x modulo 360 degrees is also made optional.

    sin(i) is internally tabulated for 0 <= i <= 90 degrees.
    Approximation polynomials, ranging from linear interpolation
    to cubics in (x-i)**2, compute the sine and cosine
    of the residual x-i which is between -0.5 and +0.5 degree.
    In the case of the high accuracy options, the residual
    and the tabulated values are combined using the trigonometry
    formulas for sin(A+B) and cos(A+B).

    Compile time options are supplied for 5, 11, or 17 decimal
    relative accuracy (ACC5, ACC11, ACC17 respectively).
    A subroutine flag argument "flg" chooses betwen this
    accuracy and table lookup only (peak absolute error
    = 0.0087).

    If the argument flg = 1, then the tabulated value is
    returned for the nearest whole number of degrees. The
    approximation polynomials are not computed.  At
    x = 0.5 deg, the absolute error is then sin(0.5) = 0.0087.

    An intermediate speed and precision can be obtained using
    the compile time option LINTERP and flg = 1.  This yields
    a linear interpolation using a slope estimated from the sine
    or cosine at the nearest integer argument.  The peak absolute
    error with this option is 3.8e-5.  Relative error at small
    angles is about 1e-5.

    If flg = 0, then the approximation polynomials are computed
    and applied.

Speed:

    Relative speed comparisons follow for 6MHz IBM AT clone
    and Microsoft C version 4.0.  These figures include
    software overhead of do loop and function calls.
    Since system hardware and software vary widely, the
    numbers should be taken as representative only.

    		flg=0	flg=0	flg=1	flg=1
    		ACC11	ACC5	LINTERP	Lookup only
    In-line 8087 (/FPi)
    sin(), cos()		1.0	1.0	1.0	1.0

    In-line 8087 (/FPi)
    sincos()		1.1	1.4	1.9	3.0

    Software (/FPa)
    sin(), cos()		0.19	0.19	0.19	0.19

    Software (/FPa)
    sincos()		0.39	0.50	0.73	1.7

Accuracy:

    The accurate approximations are designed with a relative error
    criterion.  The absolute error is greatest at x = 0.5 degree.
    It decreases from a local maximum at i+0.5 degrees to full
    machine precision at each integer i degrees.  With the
    ACC5 option, the relative error of 6.3e-6 is equivalent to
    an absolute angular error of 0.01 arc second in the argument
    at x = i+0.5 degrees.  For small angles < 0.5 deg, the ACC5
    accuracy is 6.3e-6 (.00063%) of reading; i.e., the absolute
    error decreases in proportion to the argument.  This is true
    for both the sine and cosine approximations, since the latter
    is for the function 1 - cos(x).

    If absolute error is of most concern, use the compile time
    option ABSERR to obtain an absolute error of 2.7e-8 for ACC5
    precision.  This is about half the absolute error of the
    relative precision option.  In this case the relative error
    for small angles will increase to 9.5e-6 -- a reasonable
    tradeoff.

<a name="sindg"></a>
## sindg - Circular sine of angle in degrees

Circular sine of angle in degrees

Synopsis:

    double x, y, sindg();

    y = sindg( x );

Description:

    Range reduction is into intervals of 45 degrees.

    Two polynomial approximating functions are employed.
    Between 0 and pi/4 the sine is approximated by
         x  +  x**3 P(x**2).
    Between pi/4 and pi/2 the cosine is represented as
         1  -  x**2 P(x**2).

Accuracy:

                         Relative error:
    arithmetic   domain      # trials      peak         rms
       DEC       +-1000        3100      3.3e-17      9.0e-18
       IEEE      +-1000       30000      2.3e-16      5.6e-17

Error messages:

      message           condition        value returned
    sindg total loss   x > 8.0e14 (DEC)      0.0
                       x > 1.0e14 (IEEE)

<a name="cosdg"></a>
## cosdg - Circular cosine of angle in degrees

Circular cosine of angle in degrees

Synopsis:

    double x, y, cosdg();

    y = cosdg( x );

Description:

    Range reduction is into intervals of 45 degrees.

    Two polynomial approximating functions are employed.
    Between 0 and pi/4 the cosine is approximated by
         1  -  x**2 P(x**2).
    Between pi/4 and pi/2 the sine is represented as
         x  +  x**3 P(x**2).

Accuracy:

                         Relative error:
    arithmetic   domain      # trials      peak         rms
       DEC      +-1000         3400       3.5e-17     9.1e-18
       IEEE     +-1000        30000       2.1e-16     5.7e-17
     See also sin().

<a name="sinh"></a>
## sinh - Hyperbolic sine

Hyperbolic sine

Synopsis:

    double x, y, sinh();

    y = sinh( x );

Description:

    Returns hyperbolic sine of argument in the range MINLOG to
    MAXLOG.

    The range is partitioned into two segments.  If |x| <= 1, a
    rational function of the form x + x**3 P(x)/Q(x) is employed.
    Otherwise the calculation is sinh(x) = ( exp(x) - exp(-x) )/2.

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC      +- 88        50000       4.0e-17     7.7e-18
       IEEE     +-MAXLOG     30000       2.6e-16     5.7e-17

<a name="spence"></a>
## spence - Dilogarithm

Dilogarithm

Synopsis:

    double x, y, spence();

    y = spence( x );

Description:

    Computes the integral

                       x
                       -
                      | | log t
    spence(x)  =  -   |   ----- dt
                    | |   t - 1
                     -
                     1

    for x >= 0.  A rational approximation gives the integral in
    the interval (0.5, 1.5).  Transformation formulas for 1/x
    and 1-x are employed outside the basic expansion range.

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       IEEE      0,4         30000       3.9e-15     5.4e-16
       DEC       0,4          3000       2.5e-16     4.5e-17

<a name="sqrt"></a>
## sqrt - Square root

Square root

Synopsis:

    double x, y, sqrt();

    y = sqrt( x );

Description:

    Returns the square root of x.

    Range reduction involves isolating the power of two of the
    argument and using a polynomial approximation to obtain
    a rough value for the square root.  Then Heron's iteration
    is used three times to converge to an accurate value.

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC       0, 10       60000       2.1e-17     7.9e-18
       IEEE      0,1.7e308   30000       1.7e-16     6.3e-17

Error messages:

      message         condition      value returned
    sqrt domain        x < 0            0.0

<a name="stdtr"></a>
## stdtr - Student's t distribution

Student's t distribution

Synopsis:

    double t, stdtr();
    short k;

    y = stdtr( k, t );

Description:

    Computes the integral from minus infinity to t of the Student
    t distribution with integer k > 0 degrees of freedom:

                                         t
                                         -
                                        | |
                 -                      |         2   -(k+1)/2
                | ( (k+1)/2 )           |  (     x   )
          ----------------------        |  ( 1 + --- )        dx
                        -               |  (      k  )
          sqrt( k pi ) | ( k/2 )        |
                                      | |
                                       -
                                      -inf.

    Relation to incomplete beta integral:

           1 - stdtr(k,t) = 0.5 * incbet( k/2, 1/2, z )
    where
           z = k/(k + t**2).

    For t < -2, this is the method of computation.  For higher t,
    a direct method is derived from integration by parts.
    Since the function is symmetric about t=0, the area under the
    right tail of the density is found by calling the function
    with -t instead of t.

Accuracy:

    Tested at random 1 <= k <= 25.  The "domain" refers to t.
                         Relative error:
    arithmetic   domain     # trials      peak         rms
       IEEE     -100,-2      50000       5.9e-15     1.4e-15
       IEEE     -2,100      500000       2.7e-15     4.9e-17

<a name="stdtri"></a>
## stdtri - Functional inverse of Student's t distribution

Functional inverse of Student's t distribution

Synopsis:

    double p, t, stdtri();
    int k;

    t = stdtri( k, p );

Description:

    Given probability p, finds the argument t such that stdtr(k,t)
    is equal to p.

Accuracy:

    Tested at random 1 <= k <= 100.  The "domain" refers to p:
                         Relative error:
    arithmetic   domain     # trials      peak         rms
       IEEE    .001,.999     25000       5.7e-15     8.0e-16
       IEEE    10^-6,.001    25000       2.0e-12     2.9e-14

<a name="struve"></a>
## struve - Struve function

     Struve function

Synopsis:

    double v, x, y, struve();

    y = struve( v, x );

Description:

    Computes the Struve function Hv(x) of order v, argument x.
    Negative x is rejected unless v is an integer.

    This module also contains the hypergeometric functions 1F2
    and 3F0 and a routine for the Bessel function Yv(x) with
    noninteger v.

Accuracy:

    Not accurately characterized, but spot checked against tables.

<a name="tan"></a>
## tan - Circular tangent

Circular tangent

Synopsis:

    double x, y, tan();

    y = tan( x );

Description:

    Returns the circular tangent of the radian argument x.

    Range reduction is modulo pi/4.  A rational function
          x + x**3 P(x**2)/Q(x**2)
    is employed in the basic interval [0, pi/4].

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC      +-1.07e9      44000      4.1e-17     1.0e-17
       IEEE     +-1.07e9      30000      2.9e-16     8.1e-17

Error messages:

      message         condition          value returned
    tan total loss   x > 1.073741824e9     0.0

<a name="cot"></a>
## cot - Circular cotangent

Circular cotangent

Synopsis:

    double x, y, cot();

    y = cot( x );

Description:

    Returns the circular cotangent of the radian argument x.

    Range reduction is modulo pi/4.  A rational function
          x + x**3 P(x**2)/Q(x**2)
    is employed in the basic interval [0, pi/4].

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       IEEE     +-1.07e9      30000      2.9e-16     8.2e-17

Error messages:

      message         condition          value returned
    cot total loss   x > 1.073741824e9       0.0
    cot singularity  x = 0                  INFINITY

<a name="tandg"></a>
## tandg - Circular tangent of argument in degrees

Circular tangent of argument in degrees

Synopsis:

    double x, y, tandg();

    y = tandg( x );

Description:

    Returns the circular tangent of the argument x in degrees.

    Range reduction is modulo pi/4.  A rational function
          x + x**3 P(x**2)/Q(x**2)
    is employed in the basic interval [0, pi/4].

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC      0,10          8000      3.4e-17      1.2e-17
       IEEE     0,10         30000      3.2e-16      8.4e-17

Error messages:

      message         condition          value returned
    tandg total loss   x > 8.0e14 (DEC)      0.0
                       x > 1.0e14 (IEEE)
    tandg singularity  x = 180 k  +  90     MAXNUM

<a name="cotdg"></a>
## cotdg - Circular cotangent of argument in degrees

Circular cotangent of argument in degrees

Synopsis:

    double x, y, cotdg();

    y = cotdg( x );

Description:

    Returns the circular cotangent of the argument x in degrees.

    Range reduction is modulo pi/4.  A rational function
          x + x**3 P(x**2)/Q(x**2)
    is employed in the basic interval [0, pi/4].

Error messages:

      message         condition          value returned
    cotdg total loss   x > 8.0e14 (DEC)      0.0
                       x > 1.0e14 (IEEE)
    cotdg singularity  x = 180 k            MAXNUM

<a name="tanh"></a>
## tanh - Hyperbolic tangent

Hyperbolic tangent

Synopsis:

    double x, y, tanh();

    y = tanh( x );

Description:

    Returns hyperbolic tangent of argument in the range MINLOG to
    MAXLOG.

    A rational function is used for |x| < 0.625.  The form
    x + x**3 P(x)/Q(x) of Cody & Waite is employed.
    Otherwise,
       tanh(x) = sinh(x)/cosh(x) = 1  -  2/(exp(2x) + 1).

Accuracy:

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       DEC       -2,2        50000       3.3e-17     6.4e-18
       IEEE      -2,2        30000       2.5e-16     5.8e-17

<a name="log1p"></a>
## log1p - Relative error logarithm

<a name="expm1"></a>
## expm1 - Relative error exponential

<a name="cosm1"></a>
## cosm1 - Relative error cosine

Relative error approximations for function arguments near
unity.

   log1p(x) = log(1+x)
   expm1(x) = exp(x) - 1
   cosm1(x) = cos(x) - 1

<a name="yn"></a>
## yn - Bessel function of second kind of integer order

Bessel function of second kind of integer order

Synopsis:

    double x, y, yn();
    int n;

    y = yn( n, x );

Description:

    Returns Bessel function of order n, where n is a
    (possibly negative) integer.

    The function is evaluated by forward recurrence on
    n, starting with values computed by the routines
    y0() and y1().

    If n = 0 or 1 the routine for y0 or y1 is called
    directly.

Accuracy:

                         Absolute error, except relative
                         when y > 1:
    arithmetic   domain     # trials      peak         rms
       DEC       0, 30        2200       2.9e-16     5.3e-17
       IEEE      0, 30       30000       3.4e-15     4.3e-16

Error messages:

      message         condition      value returned
    yn singularity   x = 0              MAXNUM
    yn overflow                         MAXNUM

    Spot checked against tables for x, n between 0 and 100.

<a name="zeta"></a>
## zeta - Zeta function of two arguments

Riemann zeta function of two arguments

Synopsis:

    double x, q, y, zeta();

    y = zeta( x, q );

Description:

                    inf.
                     -        -x
      zeta(x,q)  =   >   (k+q)  
                     -
                    k=0

    where x > 1 and q is not a negative integer or zero.
    The Euler-Maclaurin summation formula is used to obtain
    the expansion

                   n         
                   -       -x
    zeta(x,q)  =   >  (k+q)  
                   -         
                  k=1        

              1-x                 inf.  B   x(x+1)...(x+2j)
         (n+q)           1         -     2j
     +  ---------  -  -------  +   >    --------------------
           x-1              x      -                   x+2j+1
                      2(n+q)      j=1       (2j)! (n+q)

    where the B2j are Bernoulli numbers.  Note that (see zetac.c)
    zeta(x,1) = zetac(x) + 1.

Accuracy:

Reference:

    Gradshteyn, I. S., and I. M. Ryzhik, Tables of Integrals,
    Series, and Products, p. 1073; Academic Press, 1980.

<a name="zetac"></a>
## zetac - Riemann zeta function of two arguments

Riemann zeta function

Synopsis:

    double x, y, zetac();

    y = zetac( x );

Description:

                   inf.
                    -    -x
      zetac(x)  =   >   k   ,   x > 1,
                    -
                   k=2

    is related to the Riemann zeta function by

    Riemann zeta(x) = zetac(x) + 1.

    Extension of the function definition for x < 1 is implemented.
    Zero is returned for x > log2(MAXNUM).

    An overflow error may occur for large negative x, due to the
    gamma function in the reflection formula.

Accuracy:

    Tabulated values have full machine accuracy.

                         Relative error:
    arithmetic   domain     # trials      peak         rms
       IEEE      1,50        10000       9.8e-16	    1.3e-16
       DEC       1,50         2000       1.1e-16     1.9e-17

