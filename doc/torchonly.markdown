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

##Error Handling

By default, Torch-Cephes <b>does not signal any error</b> (domain, singularity, overflow, underflow, precision). It is as non-intrusive as possible and tries to return a value which is hopefully usable: it might be NaN, it might be inf.

However, the user can ask Cephes to generate lua errors with the following functions.

###cephes.setErrorLevel(level)

Sets the level of error reporting.

><b>Input:</b>  `level` : can be any of
>   - 'off'/`false`/`0` to be entirely quiet
>   - 'error'/`true`/1 to issue Lua errors with stack trace
>   - 'warning'/'warn'/2 to print a warning on stdout
>
><b>Returns:</b> None

###cephes.getErrorLevel()

Returns the current level of error reporting, for example to save and restore later.

><b>Input:</b>  None
>
><b>Returns:</b> integer 0, 1, or 2, representing the current error reporting level, see `setErrorLevel()`

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
