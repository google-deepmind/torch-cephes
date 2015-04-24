require 'cephes'
require 'totem'
local ffi = require 'ffi'
local callTests = {}
local tester = totem.Tester()


-- Bug reported by Alex Graves
function callTests.testRowVector()
  local x = torch.Tensor({{1, 2}})
  local a = cephes.erf(x)
  tester:assertTensorEq(a,
                        torch.Tensor{{cephes.erf(1),
                        cephes.erf(2)}},
                        1e-16,
                        'Wrong output')
end

function callTests.testColumnVector()
  local x = torch.Tensor({{1}, {2}})
  local a = cephes.erf(x)
  tester:assertTensorEq(a,
                        torch.Tensor{{cephes.erf(1)},
                        {cephes.erf(2)}},
                        1e-16,
                        'Wrong output')
end
tester:add(callTests)
return tester:run()
