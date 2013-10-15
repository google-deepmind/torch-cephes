local ffi = require("ffi")
cephes = ffi.load(package.searchpath('libcephes', package.cpath))

-- Add here all needed Cephes imports
ffi.cdef[[
// from cprob/chdtr.c
double chdtr(double df, double x);
double chdtrc(double df, double x);
double chdtri(double df, double y);
// from cprob/ndtr.c
double erf(double df);
double erfc(double df);
double ndtr(double df);
double ndtrc(double df);
// from cprob/ndtri.c
double ndtri(double df);
// form cprob/gamma.c
double gamma(double x);
double lgam(double x);
// from cprob/stdtr.c
double stdtr( int k, double t);
double stdtri( int k, double p );
]]

return cephes
