require 'cephes'

local vectorizeTests = {}
local tester = torch.Tester()

local function eq(tensor1, tensor2, message)
   tester:assertTensorEq(tensor1, tensor2, 1e-300, message)
end

function vectorizeTests.testGamma()

    local x = torch.linspace(1, 6, 6)
    local result = cephes.gamma(x)

    tester:assert(result)
    tester:asserteq(torch.typename(result), "DoubleTensor")
    eq(result, torch.DoubleTensor({1, 1, 2, 6, 24, 120}, "expected vectorized gamma"))
end

tester:add(vectorizeTests)
tester:run()
