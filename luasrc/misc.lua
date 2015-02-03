
-- Formula taken from scipy:
-- https://github.com/scipy/scipy/blob/c79a9fee6b03cd196af203bad1063958cc3fe3a8/scipy/special/basic.py
function cephes.polygamma(m, x)
    if m == 0 then
        return cephes.psi(x)
    end
    return math.pow(-1, m + 1) * cephes.gamma(m + 1) * cephes.zeta(m + 1, x)
end

-- Formula taken from:
-- http://en.wikipedia.org/w/index.php?title=Beta_function&oldid=570848869#Derivatives
function cephes.betagrad(x, y)
    return cephes.beta(x, y) * (cephes.digamma(x) - cephes.digamma(x + y))
end

--[[ Log Multivariate Gamma Function.
    The multivariate Gamma function generalizes the gamma function:
    $\Gamma_p(x) = \pi^{p(p-1)/4} \prod_{j=1}^p \Gamma[x + (1-j)/2]

Parameters:

* `x` value passed to multivariate gamma function
* `p` degree of multivariate gamma function. If 1, reduces to log gamma

Returns:
 
1. log($\Gamma_p(x)$)
]]
function cephes.lmvgam(x,p)
  local result = p * (p-1) / 4 * math.log(math.pi)
  for j = 1, p do
    result = result + cephes.lgam(x + (1-j)/2)
  end
  return result
end

--[[ Multivariate Gamma Function.
    The multivariate Gamma function generalizes the gamma function:
    $\Gamma_p(x) = \pi^{p(p-1)/4} \prod_{j=1}^p \Gamma[x + (1-j)/2]

Parameters:

* `x` value passed to multivariate gamma function
* `p` degree of multivariate gamma function. If 1, reduces to log gamma

Returns:
 
1. $\Gamma_p(x)$
]]
function cephes.mvgam(...)
  return cephes.exp(cephes.lmvgam(...))
end