local ffi = require 'ffi'


local function isTensor(v)
    if torch.typename(v) then
        return string.sub(torch.typename(v), -6, -1) == "Tensor"
    end
end

-- By default, no error reporting
local reportError = 0

-- Do we report error?
-- can be 'off'/false/0, 'error'/true/1, 'warning'/'warn'/2
function cephes.setErrorLevel(level)
    if level == 0 or level == 'off'  then
        reportError = 0
    elseif level == 1 or level == 'err' or level == 'error' then
        reportError = 1
    elseif level == 2 or level == 'warn' or level == 'warning' then
        reportError = 2
    else
        error("Unknown error level, please choose 'off'/0, 'err'/'error'/1, 'warning'/'warn'/2")
    end
end

function cephes.getErrorLevel()
    if reportError == 0  then
        return 'off'
    elseif repportError == 1 then
        return 'error'
    elseif reportError == 2 then
        return 'warning'
    end
end

-- List all functions, and wrap them automatically
local functions_list = {
    { name = 'bdtrc', arguments = { { name = 'k', type = 'int' }, { name = 'n', type = 'int' }, { name = 'p', type = 'double' } }, returnType = 'double' },
    { name = 'bdtr', arguments = { { name = 'k', type = 'int' }, { name = 'n', type = 'int' }, { name = 'p', type = 'double' } }, returnType = 'double' },
    { name = 'bdtri', arguments = { { name = 'k', type = 'int' }, { name = 'n', type = 'int' }, { name = 'y', type = 'double' } }, returnType = 'double' },
    { name = 'btdtr', arguments = { { name = 'a', type = 'double' }, { name = 'b', type = 'double' }, { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'chdtrc', arguments = { { name = 'df', type = 'double' }, { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'chdtr', arguments = { { name = 'df', type = 'double' }, { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'chdtri', arguments = { { name = 'df', type = 'double' }, { name = 'y', type = 'double' } }, returnType = 'double' },
    { name = 'drand', arguments = { { name = 'a', type = 'double *' } }, returnType = 'int' },
    { name = 'expx2', arguments = { { name = 'x', type = 'double' }, { name = 'sign', type = 'int' } }, returnType = 'double' },
    { name = 'fdtrc', arguments = { { name = 'ia', type = 'int' }, { name = 'ib', type = 'int' }, { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'fdtr', arguments = { { name = 'ia', type = 'int' }, { name = 'ib', type = 'int' }, { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'fdtri', arguments = { { name = 'ia', type = 'int' }, { name = 'ib', type = 'int' }, { name = 'y', type = 'double' } }, returnType = 'double' },
    { name = 'gamma', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'lgam', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'gdtr', arguments = { { name = 'a', type = 'double' }, { name = 'b', type = 'double' }, { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'gdtrc', arguments = { { name = 'a', type = 'double' }, { name = 'b', type = 'double' }, { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'igamc', arguments = { { name = 'a', type = 'double' }, { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'igam', arguments = { { name = 'a', type = 'double' }, { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'igami', arguments = { { name = 'a', type = 'double' }, { name = 'y0', type = 'double' } }, returnType = 'double' },
    { name = 'incbet', arguments = { { name = 'aa', type = 'double' }, { name = 'bb', type = 'double' }, { name = 'xx', type = 'double' } }, returnType = 'double' },
    { name = 'incbi', arguments = { { name = 'aa', type = 'double' }, { name = 'bb', type = 'double' }, { name = 'yy0', type = 'double' } }, returnType = 'double' },
    { name = 'nbdtrc', arguments = { { name = 'k', type = 'int' }, { name = 'n', type = 'int' }, { name = 'p', type = 'double' } }, returnType = 'double' },
    { name = 'nbdtr', arguments = { { name = 'k', type = 'int' }, { name = 'n', type = 'int' }, { name = 'p', type = 'double' } }, returnType = 'double' },
    { name = 'nbdtri', arguments = { { name = 'k', type = 'int' }, { name = 'n', type = 'int' }, { name = 'p', type = 'double' } }, returnType = 'double' },
    { name = 'ndtr', arguments = { { name = 'a', type = 'double' } }, returnType = 'double' },
    { name = 'erfc', arguments = { { name = 'a', type = 'double' } }, returnType = 'double' },
    { name = 'erf', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'ndtri', arguments = { { name = 'y0', type = 'double' } }, returnType = 'double' },
    { name = 'pdtrc', arguments = { { name = 'k', type = 'int' }, { name = 'm', type = 'double' } }, returnType = 'double' },
    { name = 'pdtr', arguments = { { name = 'k', type = 'int' }, { name = 'm', type = 'double' } }, returnType = 'double' },
    { name = 'pdtri', arguments = { { name = 'k', type = 'int' }, { name = 'y', type = 'double' } }, returnType = 'double' },
    { name = 'polevl', arguments = { { name = 'x', type = 'double' }, { name = 'coef[]', type = 'double' }, { name = 'N', type = 'int' } }, returnType = 'double' },
    { name = 'p1evl', arguments = { { name = 'x', type = 'double' }, { name = 'coef[]', type = 'double' }, { name = 'N', type = 'int' } }, returnType = 'double' },
    { name = 'stdtr', arguments = { { name = 'k', type = 'int' }, { name = 't', type = 'double' } }, returnType = 'double' },
    { name = 'stdtri', arguments = { { name = 'k', type = 'int' }, { name = 'p', type = 'double' } }, returnType = 'double' },
    { name = 'log1p', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'expm1', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'cosm1', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'beta', arguments = { { name = 'a', type = 'double' }, { name = 'b', type = 'double' } }, returnType = 'double' },
    { name = 'lbeta', arguments = { { name = 'a', type = 'double' }, { name = 'b', type = 'double' } }, returnType = 'double' },
    { name = 'chbevl', arguments = { { name = 'x', type = 'double' }, { name = 'array[]', type = 'double' }, { name = 'n', type = 'int' } }, returnType = 'double' },
    { name = 'dawsn', arguments = { { name = 'xx', type = 'double' } }, returnType = 'double' },
    { name = 'ei', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'expn', arguments = { { name = 'n', type = 'int' }, { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'fac', arguments = { { name = 'i', type = 'int' } }, returnType = 'double' },
    { name = 'fresnl', arguments = { { name = 'xxa', type = 'double' }, { name = 'ssa', type = 'double *' }, { name = 'cca', type = 'double *' } }, returnType = 'int' },
    { name = 'polevl', arguments = { { name = 'x', type = 'double' }, { name = 'coef[]', type = 'double' }, { name = 'N', type = 'int' } }, returnType = 'double' },
    { name = 'p1evl', arguments = { { name = 'x', type = 'double' }, { name = 'coef[]', type = 'double' }, { name = 'N', type = 'int' } }, returnType = 'double' },
    { name = 'psi', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'revers', arguments = { { name = 'y[]', type = 'double' }, { name = 'x[]', type = 'double' }, { name = 'n', type = 'int' } }, returnType = 'void' },
    { name = 'rgamma', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'shichi', arguments = { { name = 'x', type = 'double' }, { name = 'si', type = 'double *' }, { name = 'ci', type = 'double *' } }, returnType = 'int' },
    { name = 'sici', arguments = { { name = 'x', type = 'double' }, { name = 'si', type = 'double *' }, { name = 'ci', type = 'double *' } }, returnType = 'int' },
    { name = 'simpsn', arguments = { { name = 'f[]', type = 'double' }, { name = 'delta', type = 'double' } }, returnType = 'double' },
    { name = 'spence', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'zeta', arguments = { { name = 'x', type = 'double' }, { name = 'q', type = 'double' } }, returnType = 'double' },
    { name = 'zetac', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'cadd', arguments = { { name = 'a', type = 'cmplx *' }, { name = 'b', type = 'cmplx *' }, { name = 'c', type = 'cmplx *' } }, returnType = 'void' },
    { name = 'csub', arguments = { { name = 'a', type = 'cmplx *' }, { name = 'b', type = 'cmplx *' }, { name = 'c', type = 'cmplx *' } }, returnType = 'void' },
    { name = 'cmul', arguments = { { name = 'a', type = 'cmplx *' }, { name = 'b', type = 'cmplx *' }, { name = 'c', type = 'cmplx *' } }, returnType = 'void' },
    { name = 'cdiv', arguments = { { name = 'a', type = 'cmplx *' }, { name = 'b', type = 'cmplx *' }, { name = 'c', type = 'cmplx *' } }, returnType = 'void' },
    { name = 'cmov', arguments = { { name = 'a', type = 'void *' }, { name = 'b', type = 'void *' } }, returnType = 'void' },
    { name = 'cneg', arguments = { { name = 'a', type = 'cmplx *' } }, returnType = 'void' },
    { name = 'cabs', arguments = { { name = 'z', type = 'cmplx *' } }, returnType = 'double' },
    { name = 'csqrt', arguments = { { name = 'z', type = 'cmplx *' }, { name = 'w', type = 'cmplx *' } }, returnType = 'void' },
    { name = 'hypot', arguments = { { name = 'x', type = 'double' }, { name = 'y', type = 'double' } }, returnType = 'double' },
    { name = 'ellie', arguments = { { name = 'phi', type = 'double' }, { name = 'm', type = 'double' } }, returnType = 'double' },
    { name = 'ellik', arguments = { { name = 'phi', type = 'double' }, { name = 'm', type = 'double' } }, returnType = 'double' },
    { name = 'ellpe', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'ellpj', arguments = { { name = 'u', type = 'double' }, { name = 'm', type = 'double' }, { name = 'sn', type = 'double *' }, { name = 'cn', type = 'double *' }, { name = 'dn', type = 'double *' }, { name = 'ph', type = 'double *' } }, returnType = 'int' },
    { name = 'ellpk', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'polevl', arguments = { { name = 'x', type = 'double' }, { name = 'coef[]', type = 'double' }, { name = 'N', type = 'int' } }, returnType = 'double' },
    { name = 'p1evl', arguments = { { name = 'x', type = 'double' }, { name = 'coef[]', type = 'double' }, { name = 'N', type = 'int' } }, returnType = 'double' },
    { name = 'acosh', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'asin', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'acos', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'asinh', arguments = { { name = 'xx', type = 'double' } }, returnType = 'double' },
    { name = 'atan', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'atan2', arguments = { { name = 'y', type = 'double' }, { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'atanh', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'cbrt', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'chbevl', arguments = { { name = 'x', type = 'double' }, { name = 'array[]', type = 'double' }, { name = 'n', type = 'int' } }, returnType = 'double' },
    { name = 'clog', arguments = { { name = 'z', type = 'cmplx *' }, { name = 'w', type = 'cmplx *' } }, returnType = 'void' },
    { name = 'cexp', arguments = { { name = 'z', type = 'cmplx *' }, { name = 'w', type = 'cmplx *' } }, returnType = 'void' },
    { name = 'csin', arguments = { { name = 'z', type = 'cmplx *' }, { name = 'w', type = 'cmplx *' } }, returnType = 'void' },
    { name = 'ccos', arguments = { { name = 'z', type = 'cmplx *' }, { name = 'w', type = 'cmplx *' } }, returnType = 'void' },
    { name = 'ctan', arguments = { { name = 'z', type = 'cmplx *' }, { name = 'w', type = 'cmplx *' } }, returnType = 'void' },
    { name = 'ccot', arguments = { { name = 'z', type = 'cmplx *' }, { name = 'w', type = 'cmplx *' } }, returnType = 'void' },
    { name = 'casin', arguments = { { name = 'z', type = 'cmplx *' }, { name = 'w', type = 'cmplx *' } }, returnType = 'void' },
    { name = 'cacos', arguments = { { name = 'z', type = 'cmplx *' }, { name = 'w', type = 'cmplx *' } }, returnType = 'void' },
    { name = 'catan', arguments = { { name = 'z', type = 'cmplx *' }, { name = 'w', type = 'cmplx *' } }, returnType = 'void' },
    { name = 'cadd', arguments = { { name = 'a', type = 'cmplx *' }, { name = 'b', type = 'cmplx *' }, { name = 'c', type = 'cmplx *' } }, returnType = 'void' },
    { name = 'csub', arguments = { { name = 'a', type = 'cmplx *' }, { name = 'b', type = 'cmplx *' }, { name = 'c', type = 'cmplx *' } }, returnType = 'void' },
    { name = 'cmul', arguments = { { name = 'a', type = 'cmplx *' }, { name = 'b', type = 'cmplx *' }, { name = 'c', type = 'cmplx *' } }, returnType = 'void' },
    { name = 'cdiv', arguments = { { name = 'a', type = 'cmplx *' }, { name = 'b', type = 'cmplx *' }, { name = 'c', type = 'cmplx *' } }, returnType = 'void' },
    { name = 'cmov', arguments = { { name = 'a', type = 'void *' }, { name = 'b', type = 'void *' } }, returnType = 'void' },
    { name = 'cneg', arguments = { { name = 'a', type = 'cmplx *' } }, returnType = 'void' },
    { name = 'cabs', arguments = { { name = 'z', type = 'cmplx *' } }, returnType = 'double' },
    { name = 'csqrt', arguments = { { name = 'z', type = 'cmplx *' }, { name = 'w', type = 'cmplx *' } }, returnType = 'void' },
    { name = 'hypot', arguments = { { name = 'x', type = 'double' }, { name = 'y', type = 'double' } }, returnType = 'double' },
    { name = 'cosh', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'drand', arguments = { { name = 'a', type = 'double *' } }, returnType = 'int' },
    { name = 'exp', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'exp10', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'exp2', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'fabs', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'ceil', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'floor', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'frexp', arguments = { { name = 'x', type = 'double' }, { name = 'pw2', type = 'int *' } }, returnType = 'double' },
    { name = 'ldexp', arguments = { { name = 'x', type = 'double' }, { name = 'pw2', type = 'int' } }, returnType = 'double' },
    { name = 'signbit', arguments = { { name = 'x', type = 'double' } }, returnType = 'int' },
    { name = 'isnan', arguments = { { name = 'x', type = 'double' } }, returnType = 'int' },
    { name = 'isfinite', arguments = { { name = 'x', type = 'double' } }, returnType = 'int' },
    { name = 'log', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'log10', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'log2', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'polevl', arguments = { { name = 'x', type = 'double' }, { name = 'coef[]', type = 'double' }, { name = 'N', type = 'int' } }, returnType = 'double' },
    { name = 'p1evl', arguments = { { name = 'x', type = 'double' }, { name = 'coef[]', type = 'double' }, { name = 'N', type = 'int' } }, returnType = 'double' },
    { name = 'pow', arguments = { { name = 'x', type = 'double' }, { name = 'y', type = 'double' } }, returnType = 'double' },
    { name = 'powi', arguments = { { name = 'x', type = 'double' }, { name = 'nn', type = 'int' } }, returnType = 'double' },
    { name = 'round', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'sin', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'cos', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'radian', arguments = { { name = 'd', type = 'double' }, { name = 'm', type = 'double' }, { name = 's', type = 'double' } }, returnType = 'double' },
    { name = 'sincos', arguments = { { name = 'x', type = 'double' }, { name = 's', type = 'double *' }, { name = 'c', type = 'double *' }, { name = 'flg', type = 'int' } }, returnType = 'int' },
    { name = 'sindg', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'cosdg', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'sinh', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'sqrt', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'tan', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'cot', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'tandg', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'cotdg', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'tanh', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'log1p', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'expm1', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'cosm1', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'euclid', arguments = { { name = 'num', type = 'double *' }, { name = 'den', type = 'double *' } }, returnType = 'double' },
    { name = 'polrt', arguments = { { name = 'xcof[]', type = 'double' }, { name = 'cof[]', type = 'double' }, { name = 'm', type = 'int' }, { name = 'root[]', type = 'cmplx' } }, returnType = 'int' },
    { name = 'polini', arguments = { { name = 'maxdeg', type = 'int' } }, returnType = 'void' },
    { name = 'polprt', arguments = { { name = 'a[]', type = 'double' }, { name = 'na', type = 'int' }, { name = 'd', type = 'int' } }, returnType = 'void' },
    { name = 'polclr', arguments = { { name = 'a', type = 'double *' }, { name = 'n', type = 'int' } }, returnType = 'void' },
    { name = 'polmov', arguments = { { name = 'a', type = 'double *' }, { name = 'na', type = 'int' }, { name = 'b', type = 'double *' } }, returnType = 'void' },
    { name = 'polmul', arguments = { { name = 'a[]', type = 'double' }, { name = 'na', type = 'int' }, { name = 'b[]', type = 'double' }, { name = 'nb', type = 'int' }, { name = 'c[]', type = 'double' } }, returnType = 'void' },
    { name = 'poladd', arguments = { { name = 'a[]', type = 'double' }, { name = 'na', type = 'int' }, { name = 'b[]', type = 'double' }, { name = 'nb', type = 'int' }, { name = 'c[]', type = 'double' } }, returnType = 'void' },
    { name = 'polsub', arguments = { { name = 'a[]', type = 'double' }, { name = 'na', type = 'int' }, { name = 'b[]', type = 'double' }, { name = 'nb', type = 'int' }, { name = 'c[]', type = 'double' } }, returnType = 'void' },
    { name = 'poldiv', arguments = { { name = 'a[]', type = 'double' }, { name = 'na', type = 'int' }, { name = 'b[]', type = 'double' }, { name = 'nb', type = 'int' }, { name = 'c[]', type = 'double' } }, returnType = 'int' },
    { name = 'polsbt', arguments = { { name = 'a[]', type = 'double' }, { name = 'na', type = 'int' }, { name = 'b[]', type = 'double' }, { name = 'nb', type = 'int' }, { name = 'c[]', type = 'double' } }, returnType = 'void' },
    { name = 'poleva', arguments = { { name = 'a[]', type = 'double' }, { name = 'na', type = 'int' }, { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'polini', arguments = { { name = 'maxdeg', type = 'int' } }, returnType = 'void' },
    { name = 'revers', arguments = { { name = 'y[]', type = 'double' }, { name = 'x[]', type = 'double' }, { name = 'n', type = 'int' } }, returnType = 'void' },
    { name = 'airy', arguments = { { name = 'x', type = 'double' }, { name = 'ai', type = 'double *' }, { name = 'aip', type = 'double *' }, { name = 'bi', type = 'double *' }, { name = 'bip', type = 'double *' } }, returnType = 'int' },
    { name = 'hyp2f1', arguments = { { name = 'a', type = 'double' }, { name = 'b', type = 'double' }, { name = 'c', type = 'double' }, { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'hyperg', arguments = { { name = 'a', type = 'double' }, { name = 'b', type = 'double' }, { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'hyp2f0', arguments = { { name = 'a', type = 'double' }, { name = 'b', type = 'double' }, { name = 'x', type = 'double' }, { name = 'type', type = 'int' }, { name = 'err', type = 'double *' } }, returnType = 'double' },
    { name = 'i0', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'i0e', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'i1', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'i1e', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'iv', arguments = { { name = 'v', type = 'double' }, { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'j0', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'y0', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'j1', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'y1', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'jn', arguments = { { name = 'n', type = 'int' }, { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'jv', arguments = { { name = 'n', type = 'double' }, { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'k0', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'k0e', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'k1', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'k1e', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'kn', arguments = { { name = 'nn', type = 'int' }, { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'psi', arguments = { { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'onef2', arguments = { { name = 'a', type = 'double' }, { name = 'b', type = 'double' }, { name = 'c', type = 'double' }, { name = 'x', type = 'double' }, { name = 'err', type = 'double *' } }, returnType = 'double' },
    { name = 'threef0', arguments = { { name = 'a', type = 'double' }, { name = 'b', type = 'double' }, { name = 'c', type = 'double' }, { name = 'x', type = 'double' }, { name = 'err', type = 'double *' } }, returnType = 'double' },
    { name = 'struve', arguments = { { name = 'v', type = 'double' }, { name = 'x', type = 'double' } }, returnType = 'double' },
    { name = 'yn', arguments = { { name = 'n', type = 'int' }, { name = 'x', type = 'double' } }, returnType = 'double' },
}

-- Link to torch_merr.c error reporting
ffi.cdef[[
    int torch_cephes_merror;
    char torch_cephes_errtxt[100];
]]

local function applyNotInPlace(input, output, func)
    if not input:isContiguous() or not output:isContiguous() then
        error("applyNotInPlace only supports contiguous tensors")
    end

    if input:nElement() ~= output:nElement() then
        error("applyNotInPlace: tensor element counts are not consistent")
    end

    local inputdata = torch.data(input)
    local outputdata = torch.data(output)
    local offset = input:storageOffset()
    -- A zero-based index is used to access the data.
    -- The end index is (startIndex + nElements - 1).
    for i0 = offset - 1, offset - 1 + input:nElement() - 1 do
        outputdata[i0] = func(inputdata[i0]) or outputdata[i0]
    end
    return output
end
local function mapNotInPlace(inputA, inputB, output, func)
    if not inputA:isContiguous() or not inputB:isContiguous() or not output:isContiguous() then
        error("mapNotInPlace only supports contiguous tensors")
    end

    if inputA:nElement() ~= inputB:nElement() or inputB:nElement() ~= output:nElement() then
        error("mapNotInPlace: tensor element counts are not consistent")
    end

    local inputAdata = torch.data(inputA)
    local inputBdata = torch.data(inputB)
    local outputdata = torch.data(output)
    local offset = inputA:storageOffset()
    -- A zero-based index is used to access the data.
    -- The end index is (startIndex + nElements - 1).
    for i0 = offset - 1, offset - 1 + inputA:nElement() - 1 do
        outputdata[i0] = func(inputAdata[i0], inputBdata[i0]) or outputdata[i0]
    end
    return output
end

--[[! Argument checking for vectorized calls

Process the optional return storage, the sizes of the parameter functions, etc

@param K number of actual parameters required by the sampler
@param defaultResultType Tensor class corresponding to the expected result type (e.g. torch.DoubleTensor, torch.IntegerTensor, etc)
@param ... List of all parameters passed to the original caller

@return T vector or 1-d tensor to store the result into, N rows (or nil, if we should return a single value)
@return p1 ... pk Tensor of parameters, all N rows
--]]
function cephes._check1DParams(K, defaultResultType, ...)
    local params = { ... }
    if #params ~= K and #params ~= K+1 then
        error('CHKPARAMS: need ' .. K .. ' arguments and optionally, one result tensor, instead got ' .. #params .. ' arguments')
    end

    local result
    local Nresult = nil -- Default: unknown result size
    if #params == K then
        local numberOnly = true
        for paramIndex, param in ipairs(params) do
            numberOnly = numberOnly and not isTensor(param)
        end
        if numberOnly then
            return nil, params
        else
            result = defaultResultType.new(1)
        end
    else
        if isTensor(params[1]) then
            -- The tensor dictates the size of the result
            result = params[1]
            Nresult = result:nElement()
        else
            error("Invalid type " .. type(params[1]) .. " for result")
        end
        table.remove(params, 1)
    end

    -- Ensure that all parameters agree in size
    local Nparams = 1
    for paramIndex, param in ipairs(params) do
        local size
        if isTensor(param) then
            size = param:nElement()
        elseif type(param) == 'number' or type(param) == 'cdata' then
            size = 1
            -- Use torch's default Tensor for parameters
            params[paramIndex] = torch.Tensor{ param }
        else
            error("Invalid type " .. type(param) .. " for parameter " .. paramIndex .. ".")
        end

        if not (size == 1 or Nparams == 1 or Nparams == size) then
            error("Incoherent number of elements for parameters")
        elseif size > 1 and Nparams == 1 then
            Nparams = size
        end
    end

    if Nresult then
        -- If the result size was fixed by the caller (either via tensor or integer)
        if Nparams == 1 then
            if Nresult ~= 1 then
                error("If you have constant arguments, please do not provide a result tensor with size greater than one")
            end
            -- If only size-1 parameters, Nresult dictates the output size
            Nparams = Nresult
        else
            -- However, if the parameters dictate one size and the result another, error
            assert(Nparams == Nresult,  "Parameter's number of elements (" .. Nparams ..") does not match result's number of elements (" .. Nresult ..")" )
        end
    else
        -- If the result size was not fixed by the caller, parameters dictate it
        Nresult = Nparams
        result:resize(Nresult)
    end

    -- Expand parameters which are of the wrong size. Note: they have
    -- to be single-element to be expanded
    for paramIndex, param in ipairs(params) do
        if param:nElement() == 1 then
            local sizes = param:size()
            sizes[1] = Nparams
            params[paramIndex] = params[paramIndex]:expand(sizes)
        end
    end

    return result, params
end

local returnTypeMapping = {
    int = torch.IntTensor,
    double = torch.DoubleTensor
}

local function create_wrapper(name, parameters, returnType)

    -- Note: default to DoubleTensor for arguments we don't know how to deal with
    local tensorReturnType = returnTypeMapping[returnType] or torch.DoubleTensor

    local function help()
        local argNames = ""
        if #parameters > 0 then
            argNames = argNames .. parameters[1].name
        end
        for i = 2,#parameters do
            argNames = argNames .. ", " .. parameters[i].name

        end

        print("Usage: cephes." .. name .. "(" .. argNames .. ")")
        print("Returns: " .. returnType)
    end

    local function wrapper(...)
        local argCount = select("#", ...)
        for index = 1,argCount do
            if select(index, ...) == nil then
                error("Bad cephes call - argument " .. index .. " is nil when calling function " .. name .. "!")
            end
        end
        -- Reset error status
        cephes.ffi.torch_cephes_merror = 0
        local result, params = cephes._check1DParams(#parameters, tensorReturnType, ...)

        if result then
            local cephesFunction = cephes.ffi[name]
            if #params == 1 then
                params[1] = params[1]:contiguous()
                applyNotInPlace(params[1], result, cephesFunction)
            elseif #params == 2 then
                params[1] = params[1]:contiguous()
                params[2] = params[2]:contiguous()
                mapNotInPlace(params[1], params[2], result, cephesFunction)
            else
                error('TODO: need to implement map for ' .. #params .. 'arguments')
            end
        else
            result = cephes.ffi[name](unpack(params))
        end

        if reportError > 0 and cephes.ffi.merror ~= 0 then
            local errString =  "Cephes error '" .. ffi.string(cephes.ffi.errtxt) .. "'"
            if reportError == 1 then
                error(errString)
            else
                print('CEPHES WARNING:', errString)
            end
        end
        return result
    end
    return wrapper
end

-- To allow easy listing from lua, add one entry in the lua
-- table for each function
for _, v in ipairs(functions_list) do
    rawset(cephes, v.name, create_wrapper(v.name, v.arguments, v.returnType))
end
