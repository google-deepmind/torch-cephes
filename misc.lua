
-- Formula taken from scipy
function cephes.polygamma(m, x)
    if m == 0 then
        return cephes.psi(x)
    end
    return math.pow(-1, m + 1) * cephes.gamma(m + 1) * cephes.zeta(m + 1, x)
end
