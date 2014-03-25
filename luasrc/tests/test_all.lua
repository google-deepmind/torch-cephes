#!/usr/bin/env th

require 'totem'

local tester = totem.Tester()
tester:add('testCprob.lua')
tester:add('testErrorHandling.lua')
tester:add('test_bessel.lua')
tester:add('test_cmath.lua')
tester:add('test_cprob.lua')
tester:add('test_ellf.lua')
tester:add('test_limits.lua')
tester:add('test_misc.lua')
tester:add('test_polyn.lua')
tester:add('test_vectorized.lua')
return tester:run()
