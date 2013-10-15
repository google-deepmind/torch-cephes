# Cephes mathematical library wrapped for Torch

Provides and wraps the mathematical functions from the [Cephes mathematical library](http://www.netlib.org/cephes/), just as scipy does.

This C library has a <b>lot</b> of math functions, as you can see in [its documentation](cephes/cephes.doc). Lots of it requires to look at the comments in the C files, but they are as clear as any Matlab file, so do not worry.

### Using already wrapped Cephes functions

You can call any of the functions already imported:

```lua
require 'cephes'
cephes.chdtr(3,1)
```

See the list of imported functions in [`init.lua`](init.lua). 
There is a (very) small subset already imported. Please add new imports as you need, following the instructions below.

### Wrapping new Cephes functions

Cephes has many functions, that we will import as required. If you need a function not imported, yet, please add it:

1. Locate the C one-line declaration in the Cephes C file you need.

2. Copy the declaration to the [`init.lua`](init.lua) FFI call, for example:

    ```lua
    -- Add here all needed Cephes imports
    ffi.cdef[[
    double chdtr(double df, double x); // chi2 CDF from cprob
    double ndtr(double df); // Gaussian CDF from cprob
    ]]
    ```
3. Please add a quick unit test in [`testCephes.lua`](tests/testCephes.lua) to make sure it works :)

and that's all!
