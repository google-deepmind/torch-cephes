#Torch-only functions

Those functions are not part of the original Cephes library

##Using wrapped Cephes functions

###Direct call

You can call any of the functions already wrapped.
The C functions can be called from Lua with the same synopsis, for example:

```lua
require 'cephes'
x = cephes.ndtr(0)
```

See the list of wrapped functions in [`init.lua`](init.lua). 

There is a (very) small subset already wrapped. Adding new wraps is very easy, feel free to do it as described below, and submit pull-requests.

###Applying to a whole tensor

Cephes functions do not know of Torch tensors, and most only apply to a double and return a double. You can apply to a whole tensor using the  `apply` function from the [`torchffi` package](https://github.com/torch/ffi):


```lua
require 'cephes'

-- Without torchffi: need to wrap with extra function
a=torch.randn(10)
a:apply(function(x) return cephes.ndtr(x) end)
print(a)

-- With torchffi: much simpler!
require 'torchffi'
a:apply(cephes.ndtr)
print(a)
```

##Extra functions

###cephes.digamma(x)

Alias for `cephes.psi(x)`

###cephes.polygamma(m, x)

The `(m+1)`-th derivative of the logarithm of the gamma function [(see MathWorld definition)](http://mathworld.wolfram.com/PolygammaFunction.html).

><b>Input:</b> 
>
> * `m` : non-negative integer
> * `x` : real number
>
><b>Returns:</b> `(m+1)`-th derivative of the logarithm of the gamma function, evaluated at `x`

###cephes.betagrad(x, y)

The partial-derivative of the beta function, with respect to the first variable.

><b>Input:</b> 
>
> * `x` : positive real number
> * `y` : positive real number
>
><b>Returns:</b> Partial-derivative of the beta function with respect to the first variable, evaluated at (`x`, `y`)


##Limits

Convenience functions to check for finiteness.

###cephes.nan
Stands for not a number, clearer alias for `0/0` 

###cephes.isnan(x)
Checks if `x` is not a number.

><b>Input:</b> `x` : any number
>
><b>Returns:</b> `true` if `x` is `cephes.nan`, `false` otherwise


###cephes.isinf(x)
Checks is a number is infinite.

><b>Input:</b> `x` : any number
>
><b>Returns:</b></b> `true` if `x` is `math.huge` or `-math.huge` or `cephes.nan`, `false` otherwise.

###cephes.isfinite(x)
Checks if a number is finite.

><b>Input:</b>  `x` : any number
>
><b>Returns:</b>  `not cephes.isinf(x) and not cephes.isnan(x)`

##Complex numbers

###cephes.new_cmplx(re, im)
><b>Input:</b> 
>
> * `re` : any number, to initialize the real part
> * `im` : any number, to initalize the imaginary part
>
><b>Returns:</b> a pointer to a new Cephes FFI complex number with real part `r` and imaginary part `im`.

##Direct access to FFI

###cephes.ffi.*

Functions directly accessible at the top of the `cephes` table are Lua wrappers to the actual C functions from Cephes, with extra error checking. If, for any reason, you want to get rid of this error checking and of a possible overhead, the FFI-wrapper functions can be called directly via `cephes.ffi.myfunction()` instead of `cephes.myfunction()`.
