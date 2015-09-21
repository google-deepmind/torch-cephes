
#Cephes Mathematical Functions Library, wrapped for Torch

Provides and wraps the mathematical functions from the [Cephes mathematical library](http://www.netlib.org/cephes/), developed by [Stephen L. Moshier](http://www.moshier.net). This C library provides a <b>lot</b> of mathematical functions. It is used, among many other places, [at the heart of SciPy](https://github.com/scipy/scipy/tree/master/scipy/special/cephes).

##Example

###Simple call on a number

The wrapped functions can be called from Lua with the same synopsis as their C coutnerpart, and will then return a number, for example:

```lua
require 'cephes'
x = cephes.igam(2, 3) -- returns a number
```

###Calling on tensors

Our wrappers for cephes functions are vectorized, meaning they can 

* take tensors as arguments, evaluating the function for each element of the arguments, and return the result into a vector. 
* mix tensors and numbers as arguments, numbers are automatically expanded
* **shape does not matter**, only the number of elements.

Like most torch functions, they also accept an optional Tensor as first argument to store the result into.

```lua
require 'cephes'
-- Call over a whole tensor of parameters
result = cephes.ndtr(torch.randn(10)) -- returns a new tensor 
                                      -- of 10 elements

-- Several tensor arguments, pairing them map-like
-- Below returns a vector of 100 elements
x = torch.rand(100)
y = torch.rand(100)
result = cephes.igam(x, y)

-- Mix number and tensors: numbers are automatically expanded
-- Below returns a vector of 100 elements
result = cephes.igam(4, y)

-- Can also use matrices: only the number of elements matters
-- Below with a 3D array and a vector, return a vector of 100 elts
z = torch.rand(2,5,10)
result = cephes.igam(z, y)

-- And of course you can store the result into an 
-- existing tensor of the right number of elements
-- Below stores into an existing 3D tensors of 100 elements
result = torch.Tensor(2,5,10)
cephes.igam(result, x, y)
```

##Installation

From a terminal:

```bash
torch-rocks install cephes
```

##Error Handling

By default, Torch-Cephes **does not signal any error** (domain, singularity, overflow, underflow, precision). It is as non-intrusive as possible and tries to return a value which is hopefully usable: it might be NaN, it might be inf.

However, the user can ask Cephes to generate lua errors with the following functions.

###cephes.setErrorLevel(level)

Sets the level of error reporting.

>**Input:**  `level` : can be any of
>   - `'off'`/`0` to be entirely quiet
>   - `'error'`/`1` to issue Lua errors with stack trace
>   - `'warning'`/`2` to print a warning on stdout
>
>**Returns:** None

###cephes.getErrorLevel()

Returns the current level of error reporting, for example to save and restore later.

>**Input:**  None
>
>**Returns:** integer 0, 1, or 2, representing the current error reporting level, see `setErrorLevel()`

##List of Cephes functions

See [the full list of Cephes double-precision functions](doubldoc.md). The Torch wrappers respect the same prototypes. 

**Note**: a few features of the original library have not been wrapped:

* single-precision functions: due to a few name clashes with their double counterparts, they require a slightly larger effort to wrap. Please [fill a feature request](https://github.com/jucor/torch-cephes/issues/new) if you need them.
* polynomials with rational coefficients: their names clash with the polynomials with double coefficients. We wrapped the latter, which seem more generally useful, but please [raise an issue](ahttps://github.com/jucor/torch-cephes/issues/new).
* linear algebra functions: torch already has those.

So, here goes the whole list, click for details:

* **acosh**, [Inverse hyperbolic cosine](doubldoc.md#acosh)
* **airy**, [Airy functions](doubldoc.md#airy)
* **asin**, [Inverse circular sine](doubldoc.md#asin)
* **acos**, [Inverse circular cosine](doubldoc.md#acos)
* **asinh**, [Inverse hyperbolic sine](doubldoc.md#asinh)
* **atan**, [Inverse circular tangent](doubldoc.md#atan)
* **atan2**, [Quadrant correct inverse circular tangent](doubldoc.md#atan2)
* **atanh**, [Inverse hyperbolic tangent](doubldoc.md#atanh)
* **bdtr**, [Binomial distribution](doubldoc.md#bdtr)
* **bdtrc**, [Complemented binomial distribution](doubldoc.md#bdtrc)
* **bdtri**, [Inverse binomial distribution](doubldoc.md#bdtri)
* **beta**, [Beta function](doubldoc.md#beta)
* **btdtr**, [Beta distribution](doubldoc.md#btdtr)
* **cbrt**, [Cube root](doubldoc.md#cbrt)
* **chbevl**, [Evaluate Chebyshev series](doubldoc.md#chbevl)
* **chdtr**, [Chi-square distribution](doubldoc.md#chdtr)
* **chdtrc**, [Complemented Chi-square distribution](doubldoc.md#chdtrc)
* **chdtri**, [Inverse of complemented Chi-square distribution](doubldoc.md#chdtri)
* **cheby**, [Find Chebyshev coefficients](doubldoc.md#cheby)
* **clog**, [Complex natural logarithm](doubldoc.md#clog)
* **cexp**, [Complex exponential function](doubldoc.md#cexp)
* **csin**, [Complex circular sine](doubldoc.md#csin)
* **ccos**, [Complex circular cosine](doubldoc.md#ccos)
* **ctan**, [Complex circular tangent](doubldoc.md#ctan)
* **ccot**, [Complex circular cotangent](doubldoc.md#ccot)
* **casin**, [Complex circular arc sine](doubldoc.md#casin)
* **cacos**, [Complex circular arc cosine](doubldoc.md#cacos)
* **catan**, [Complex circular arc tangent](doubldoc.md#catan)
* **csinh**, [Complex hyperbolic sine](doubldoc.md#csinh)
* **casinh**, [Complex inverse hyperbolic sine](doubldoc.md#casinh)
* **ccosh**, [Complex hyperbolic cosine](doubldoc.md#ccosh)
* **cacosh**, [Complex inverse hyperbolic cosine](doubldoc.md#cacosh)
* **ctanh**, [Complex hyperbolic tangent](doubldoc.md#ctanh)
* **catanh**, [Complex inverse hyperbolic tangent](doubldoc.md#catanh)
* **cpow**, [Complex power function](doubldoc.md#cpow)
* **cmplx**, [Complex number arithmetic](doubldoc.md#cmplx)
* **cabs**, [Complex absolute value](doubldoc.md#cabs)
* **csqrt**, [Complex square root](doubldoc.md#csqrt)
* **const**, [Globally declared constants](doubldoc.md#const)
* **cosh**, [Hyperbolic cosine](doubldoc.md#cosh)
* **dawsn**, [Dawson's Integral](doubldoc.md#dawsn)
* **drand**, [Pseudorandom number generator](doubldoc.md#drand)
* **ei**, [Exponential Integral](doubldoc.md#ei)
* **eigens**, [Eigenvalues and eigenvectors of a real symmetric matrix](doubldoc.md#eigens)
* **ellie**, [Incomplete elliptic integral of the second kind](doubldoc.md#ellie)
* **ellik**, [Incomplete elliptic integral of the first kind](doubldoc.md#ellik)
* **ellpe**, [Complete elliptic integral of the second kind](doubldoc.md#ellpe)
* **ellpj**, [Jacobian elliptic functions](doubldoc.md#ellpj)
* **ellpk**, [Complete elliptic integral of the first kind](doubldoc.md#ellpk)
* **euclid**, [Rational arithmetic routines](doubldoc.md#euclid)
* **exp**, [Exponential function](doubldoc.md#exp)
* **exp10**, [Base 10 exponential function](doubldoc.md#exp10)
* **exp2**, [Base 2 exponential function](doubldoc.md#exp2)
* **expn**, [Exponential integral En](doubldoc.md#expn)
* **expx2**, [Exponential of squared argument](doubldoc.md#expx2)
* **fabs**, [Absolute value](doubldoc.md#fabs)
* **fac**, [Factorial function](doubldoc.md#fac)
* **fdtr**, [F distribution](doubldoc.md#fdtr)
* **fdtrc**, [Complemented F distribution](doubldoc.md#fdtrc)
* **fdtri**, [Inverse of complemented F distribution](doubldoc.md#fdtri)
* **fftr**, [Fast Fourier transform](doubldoc.md#fftr)
* **floor**, [Floor function](doubldoc.md#floor)
* **ceil**, [Ceil function](doubldoc.md#ceil)
* **frexp**, [Extract exponent](doubldoc.md#frexp)
* **ldexp**, [Apply exponent](doubldoc.md#ldexp)
* **fresnl**, [Fresnel integral](doubldoc.md#fresnl)
* **gamma**, [Gamma function](doubldoc.md#gamma)
* **lgam**, [Natural logarithm of gamma function](doubldoc.md#lgam)
* **gdtr**, [Gamma distribution function](doubldoc.md#gdtr)
* **gdtrc**, [Complemented gamma distribution function](doubldoc.md#gdtrc)
* **gels**, [Linear system with symmetric coefficient matrix](doubldoc.md#gels)
* **hyp2f1**, [Gauss hypergeometric function](doubldoc.md#hyp2f1)
* **hyperg**, [Confluent hypergeometric function](doubldoc.md#hyperg)
* **i0**, [Modified Bessel function of order zero](doubldoc.md#i0)
* **i0e**, [Exponentially scaled modified Bessel function of order zero](doubldoc.md#i0e)
* **i1**, [Modified Bessel function of order one](doubldoc.md#i1)
* **i1e**, [Exponentially scaled modified Bessel function of order one](doubldoc.md#i1e)
* **igam**, [Incomplete gamma integral](doubldoc.md#igam)
* **igamc**, [Complemented incomplete gamma integral](doubldoc.md#igamc)
* **igami**, [Inverse of complemented imcomplete gamma integral](doubldoc.md#igami)
* **incbet**, [Incomplete beta integral](doubldoc.md#incbet)
* **incbi**, [Inverse of imcomplete beta integral](doubldoc.md#incbi)
* **isnan**, [Test for not a number](doubldoc.md#isnan)
* **isfinite**, [Test for infinity](doubldoc.md#isfinite)
* **signbit**, [Extract sign](doubldoc.md#signbit)
* **iv**, [Modified Bessel function of noninteger order](doubldoc.md#iv)
* **j0**, [Bessel function of order zero](doubldoc.md#j0)
* **y0**, [Bessel function of the second kind, order zero](doubldoc.md#y0)
* **j1**, [Bessel function of order one](doubldoc.md#j1)
* **y1**, [Bessel function of the second kind, order one](doubldoc.md#y1)
* **jn**, [Bessel function of integer order](doubldoc.md#jn)
* **jv**, [Bessel function of noninteger order](doubldoc.md#jv)
* **k0**, [Modified Bessel function, third kind, order zero](doubldoc.md#k0)
* **k0e**, [Modified Bessel function, third kind, order zero, exponentially scaled](doubldoc.md#k0e)
* **k1**, [Modified Bessel function, third kind, order one](doubldoc.md#k1)
* **k1e**, [Modified Bessel function, third kind, order one, exponentially scaled](doubldoc.md#k1e)
* **kn**, [Modified Bessel function, third kind, integer order](doubldoc.md#kn)
* **kolmogorov**, [Kolmogorov, Smirnov distributions](doubldoc.md#kolmogorov)
* **levnsn**, [Linear predictive coding](doubldoc.md#levnsn)
* **lmdif**, [Levenberg-Marquardt algorithm](doubldoc.md#lmdif)
* **log**, [Natural logarithm](doubldoc.md#log)
* **log10**, [Common logarithm](doubldoc.md#log10)
* **log2**, [Base 2 logarithm](doubldoc.md#log2)
* **lrand**, [Pseudorandom integer number generator](doubldoc.md#lrand)
* **lsqrt**, [Integer square root](doubldoc.md#lsqrt)
* **minv**, [Matrix inversion](doubldoc.md#minv)
* **mtransp**, [Matrix transpose](doubldoc.md#mtransp)
* **nbdtr**, [Negative binomial distribution](doubldoc.md#nbdtr)
* **nbdtrc**, [Complemented negative binomial distribution](doubldoc.md#nbdtrc)
* **nbdtri**, [Functional inverse of negative binomial distribution](doubldoc.md#nbdtri)
* **ndtr**, [Normal distribution function](doubldoc.md#ndtr)
* **erf**, [Error function](doubldoc.md#erf)
* **erfc**, [Complementary error function](doubldoc.md#erfc)
* **ndtri**, [Inverse of normal distribution function](doubldoc.md#ndtri)
* **pdtr**, [Poisson distribution function](doubldoc.md#pdtr)
* **pdtrc**, [Complemented Poisson distribution function](doubldoc.md#pdtrc)
* **pdtri**, [Inverse of Poisson distribution function](doubldoc.md#pdtri)
* **planck**, [Integral of Planck's black body radiation formula](doubldoc.md#planck)
* **polevl**, [Evaluate polynomial](doubldoc.md#polevl)
* **p1evl**, [Evaluate polynomial](doubldoc.md#p1evl)
* **polmisc**, [Functions of a polynomial](doubldoc.md#polmisc)
* **polrt**, [Roots of a polynomial](doubldoc.md#polrt)
* **polylog**, [Polylogarithms](doubldoc.md#polylog)
* **polyn**, [Arithmetic operations on polynomials](doubldoc.md#polyn)
* **pow**, [Power function](doubldoc.md#pow)
* **powi**, [Integer power function](doubldoc.md#powi)
* **psi**, [Psi (digamma) function](doubldoc.md#psi)
* **revers**, [Reversion of power series](doubldoc.md#revers)
* **rgamma**, [Reciprocal gamma function](doubldoc.md#rgamma)
* **round**, [Round to nearest or even integer](doubldoc.md#round)
* **shichi**, [Hyperbolic sine and cosine integrals](doubldoc.md#shichi)
* **sici**, [Sine and cosine integrals](doubldoc.md#sici)
* **simpsn**, [Numerical integration of tabulated function](doubldoc.md#simpsn)
* **simq**, [Simultaneous linear equations](doubldoc.md#simq)
* **sin**, [Circular sine](doubldoc.md#sin)
* **cos**, [Circular cosine](doubldoc.md#cos)
* **sincos**, [Sine and cosine by interpolation](doubldoc.md#sincos)
* **sindg**, [Circular sine of angle in degrees](doubldoc.md#sindg)
* **cosdg**, [Circular cosine of angle in degrees](doubldoc.md#cosdg)
* **sinh**, [Hyperbolic sine](doubldoc.md#sinh)
* **spence**, [Dilogarithm](doubldoc.md#spence)
* **sqrt**, [Square root](doubldoc.md#sqrt)
* **stdtr**, [Student's t distribution](doubldoc.md#stdtr)
* **stdtri**, [Functional inverse of Student's t distribution](doubldoc.md#stdtri)
* **struve**, [Struve function](doubldoc.md#struve)
* **tan**, [Circular tangent](doubldoc.md#tan)
* **cot**, [Circular cotangent](doubldoc.md#cot)
* **tandg**, [Circular tangent of argument in degrees](doubldoc.md#tandg)
* **cotdg**, [Circular cotangent of argument in degrees](doubldoc.md#cotdg)
* **tanh**, [Hyperbolic tangent](doubldoc.md#tanh)
* **log1p**, [Relative error logarithm](doubldoc.md#log1p)
* **expm1**, [Relative error exponential](doubldoc.md#expm1)
* **cosm1**, [Relative error cosine](doubldoc.md#cosm1)
* **yn**, [Bessel function of second kind of integer order](doubldoc.md#yn)
* **zeta**, [Zeta function of two arguments](doubldoc.md#zeta)
* **zetac**, [Riemann zeta function of two arguments](doubldoc.md#zetac)

##List of Torch-only functions

Those functions are not part of the original Cephes library

###cephes.digamma(x)

Alias for `cephes.psi(x)`

###cephes.polygamma(m, x)

The `(m+1)`-th derivative of the logarithm of the gamma function [(see MathWorld definition)](http://mathworld.wolfram.com/PolygammaFunction.html).

>**Input:** 
>
> * `m` : non-negative integer
> * `x` : real number
>
>**Returns:** `(m+1)`-th derivative of the logarithm of the gamma function, evaluated at `x`

###cephes.betagrad(x, y)

The partial-derivative of the beta function, with respect to the first variable.

>**Input:** 
>
> * `x` : positive real number
> * `y` : positive real number
>
>**Returns:** Partial-derivative of the beta function with respect to the first variable, evaluated at (`x`, `y`)

##Limits

Convenience functions to check for finiteness.

###cephes.nan
Stands for not a number, clearer alias for `0/0` 

###cephes.isnan(x)
Checks if `x` is not a number.

>**Input:** `x` : any number
>
>**Returns:** `true` if `x` is `cephes.nan`, `false` otherwise

###cephes.isinf(x)
Checks is a number is infinite.

>**Input:** `x` : any number
>
>**Returns:**** `true` if `x` is `math.huge` or `-math.huge` or `cephes.nan`, `false` otherwise.

###cephes.isfinite(x)
Checks if a number is finite.

>**Input:**  `x` : any number
>
>**Returns:**  `not cephes.isinf(x) and not cephes.isnan(x)`

##Complex numbers

###cephes.new_cmplx(re, im)
>**Input:** 
>
> * `re` : any number, to initialize the real part
> * `im` : any number, to initalize the imaginary part
>
>**Returns:** a pointer to a new Cephes FFI complex number with real part `r` and imaginary part `im`.

##Unit Tests

Last but not least, the unit tests are in the folder
[`luasrc/tests`](https://github.com/jucor/torch-cephes/tree/master/luasrc/tests). You can run them from your local clone of the repostiory with:

```bash
git clone https://www.github.com/jucor/torch-cephes
find torch-cephes/luasrc/tests -name "test*lua" -exec torch {} \;
```

Those tests will soone be automatically installed with the package, once I sort out a bit of CMake resistance.

##Direct access to FFI

###cephes.ffi.*

Functions directly accessible at the top of the `cephes` table are Lua wrappers to the actual C functions from Cephes, with extra error checking. If, for any reason, you want to get rid of this error checking and of a possible overhead, the FFI-wrapper functions can be called directly via `cephes.ffi.myfunction()` instead of `cephes.myfunction()`.
