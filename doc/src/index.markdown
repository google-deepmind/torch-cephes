---
title: Document Center
layout: doc
---

#Cephes Mathematical Functions Library, wrapped for Torch

* Toc will go here
{:toc}

Provides and wraps the mathematical functions from the [Cephes mathematical library](http://www.netlib.org/cephes/), developed by [Stephen L. Moshier](http://www.moshier.net). This C library provides a <b>lot</b> of mathematical functions. It is used, among many other places, [at the heart of SciPy](https://github.com/scipy/scipy/tree/master/scipy/special/cephes).


##Example

###Elementary call

You can call any of the functions already wrapped.
The C functions can be called from Lua with the same synopsis, for example:

{% highlight lua %}
require 'cephes'
x = cephes.ndtr(0)
{% endhighlight %}


###Applying to a whole tensor

Cephes functions do not know of Torch tensors, and most only apply to a double and return a double. You can apply to a whole tensor using the  `apply` function from the [`torchffi` package](https://github.com/torch/ffi):


{% highlight lua %}
require 'cephes'

-- Without torchffi: need to wrap with extra function
a=torch.randn(10)
a:apply(function(x) return cephes.ndtr(x) end)
print(a)

-- With torchffi: much simpler!
require 'torchffi'
a:apply(cephes.ndtr)
print(a)
{% endhighlight %}

##Installation

From a terminal:
{% highlight bash %}
torch-rocks install cephes
{% endhighlight %}

##List of Cephes functions

See [the full list of Cephes double-precision functions](doubldoc.html). The Torch wrappers respect the same prototypes.

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

##Direct access to FFI

###cephes.ffi.&ast;

Functions directly accessible at the top of the `cephes` table are Lua wrappers to the actual C functions from Cephes, with extra error checking. If, for any reason, you want to get rid of this error checking and of a possible overhead, the FFI-wrapper functions can be called directly via `cephes.ffi.myfunction()` instead of `cephes.myfunction()`.
