cephes.nan = tonumber("nan")

function cephes.isnan(x)
    return x ~= x
end

function cephes.isinf(x)
    return (x == math.huge) or (x == -math.huge)
end

function cephes.isfinite(x)
    return (not cephes.isinf(x)) and (not cephes.isnan(x))
end
