-- Test the error handling done by error_handling.lua
require 'cephes'
require 'totem'

errTest = {}
tester = totem.Tester()

function errTest.testNoError()
    tester:assert(cephes.chdtr(3, .5))
end

function errTest.testError()
    local df = 4
    local previousLevel = cephes.getErrorLevel()
    cephes.setErrorLevel('off')
    tester:assert(function() cephes.chdtr(-1,1) end)
    cephes.setErrorLevel('error')
    tester:assertError(function() cephes.chdtr(-1,1) end)
    cephes.setErrorLevel(previousLevel)
end

tester:add(errTest)
return tester:run()
