require 'cephes'
require 'totem'
local limitsTests = {}
local tester = totem.Tester()

function limitsTests.test_isnan()
    tester:assert(cephes.isnan(cephes.nan))
    tester:assert(cephes.isnan(0/0))
    tester:assert(not cephes.isnan(math.huge))
    tester:assert(not cephes.isnan(-math.huge))
    tester:assert(not cephes.isnan(0))
    tester:assert(not cephes.isnan(1/0))
    tester:assert(not cephes.isnan(-1/0))
end

function limitsTests.test_isinf()
    tester:assert(cephes.isinf(1/0))
    tester:assert(cephes.isinf(-1/0))
    tester:assert(cephes.isinf(math.huge))
    tester:assert(cephes.isinf(-math.huge))
    tester:assert(not cephes.isinf(cephes.nan))
    tester:assert(not cephes.isinf(-cephes.nan))
    tester:assert(not cephes.isinf(0))
    tester:assert(not cephes.isinf(0/0))
end

function limitsTests.test_isfinite()
    tester:assert(cephes.isfinite(0))
    tester:assert(cephes.isfinite(1))
    tester:assert(cephes.isfinite(-1))
    tester:assert(not cephes.isfinite(1/0))
    tester:assert(not cephes.isfinite(-1/0))
    tester:assert(not cephes.isfinite(math.huge))
    tester:assert(not cephes.isfinite(-math.huge))
    tester:assert(not cephes.isfinite(cephes.nan))
    tester:assert(not cephes.isfinite(-cephes.nan))
    tester:assert(not cephes.isfinite(0/0))
end

tester:add(limitsTests)
return tester:run()
