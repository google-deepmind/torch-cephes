---
title: Cephes Mathematical Library wrapped for Torch
layout: doc
---

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

##List of Cephes functions

See [the full list of Cephes double-precision functions](doubldoc.html). The Torch wrappers respect the same prototypes. 

**Note**: a few features of the original library have not been wrapped:

* single-precision functions: due to a few name clashes with their double counterparts, they require a slightly larger effort to wrap. Please [fill a feature request](https://github.com/jucor/torch-cephes/issues/new) if you need them.
* polynomials with rational coefficients: their names clash with the polynomials with double coefficients. We wrapped the latter, which seem more generally useful, but please [raise an issue](ahttps://github.com/jucor/torch-cephes/issues/new).

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
find torch-randomkit/luasrc/tests -name "test*lua" -exec torch {} \;
```

Those tests will soone be automatically installed with the package, once I sort out a bit of CMake resistance.

##Direct access to FFI

###cephes.ffi.*

Functions directly accessible at the top of the `cephes` table are Lua wrappers to the actual C functions from Cephes, with extra error checking. If, for any reason, you want to get rid of this error checking and of a possible overhead, the FFI-wrapper functions can be called directly via `cephes.ffi.myfunction()` instead of `cephes.myfunction()`.
