-- Test the wrappers to the cprob folder
require 'cephes'
require 'totem'

myTest = {}
tester = totem.Tester()

function myTest.testChdtr()
    local df = 4
    tester:assert(cephes.chdtr(df, 1))
    tester:assert(cephes.chdtri(df, 0.9))
    tester:assert(cephes.chdtrc(df, 0.5))
end

function myTest.testNdtr()
    tester:assert(cephes.ndtr(2))
    tester:assert(cephes.erf(2))
    tester:assert(cephes.erfc(.1))
end

function myTest.testNdtri()
    tester:assert(cephes.ndtri(.1))
end

function myTest.testGamma()
    tester:assert(cephes.gamma(.1))
    tester:assert(cephes.lgam(.1))
end

function myTest.testStdtr()
    tester:assert(cephes.stdtr(1, 2))
    tester:assert(cephes.stdtri(1, .5))
end


-- Add here calling tests for newly imported functions

tester:add(myTest)
return tester:run()
