#Cephes Mathematical Functions Library, wrapped for Torch

Provides and wraps the mathematical functions from the [Cephes mathematical library](http://www.netlib.org/cephes/), developped by [Stephen L. Moshier](http://www.moshier.net).

This C library provides a <b>lot</b> of mathematical functions, as you can see in [its function list](doc/cephes.doc) and [its documentation for double-precision](http://www.netlib.org/cephes/doubldoc.html). It is used, among many other places, [at the heart of SciPy](https://github.com/scipy/scipy/tree/master/scipy/special/cephes).

##Using already wrapped Cephes functions

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

##Wrapping new Cephes functions

Cephes has many functions, that we will wrap as required. If you need a function not wrpaped yet, please add it:

1. Locate the C one-line declaration in the Cephes C file you need.

2. Copy the declaration in C-ANSI format to the [`init.lua`](init.lua) FFI call, for example:

    ```lua
    -- Add here all needed Cephes imports
    ffi.cdef[[
    double chdtr(double df, double x); // chi2 CDF from cprob
    double ndtr(double df); // Gaussian CDF from cprob
    ]]
    ```
3. Please add a quick unit test in the [`tests`](tests/) folder to make sure it works :)

and that's all!
