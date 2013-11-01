
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
