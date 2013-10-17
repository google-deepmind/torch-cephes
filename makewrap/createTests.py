import cPickle as pickle
import os
import argparse
import itertools
import logging
logging.basicConfig(level=logging.DEBUG)


parser = argparse.ArgumentParser()
parser.add_argument("functions")
args = parser.parse_args()

# cephes.ffi.cmplx

testValues = {
    'double' : [0.0, 1.0, 10.0, "math.huge"],
    'int' : [0, 1, -1],
    'cmplx' : [], # TODO
    'fract' : [], # TODO
    'cmplx *' : [], # TODO
    'void *' : [], # TODO
    'double *' : [], # TODO
    'int *' : [], # TODO
    'fract *' : [] # TODO
}

def testsForFunction(function):
    logging.debug("Generating tests for %s" % (function['functionName'],))
    logging.debug("Return type: "  + function['returnType'])
    logging.debug("Args: " + str(function['arguments']))

    functionCArgs = ", ".join(argType + " " + argName for argName, argType in function['arguments'])

    valueGenerators = [ testValues[argType] for argName, argType in function['arguments'] ]

    # TODO handle case of argName ending in [] ...!

    testString = """
-- Test simple calls for {functionName}
-- Signature: {returnType} {functionName}({functionCArgs})
function callTests.test_{functionName}()
""".format(
        returnType = function['returnType'],
        functionName = function['functionName'],
        functionCArgs = functionCArgs
    )

    for argValues in itertools.product(*valueGenerators):
        testString += """
    tester:assert(cephes.{functionName}({functionArgs}))""".format(
            functionName = function['functionName'],
            functionArgs = ", ".join(str(x) for x in argValues),
        )
    testString += """
end
"""

    return testString

with open(args.functions, 'r') as inputFile:
    allFunctions = pickle.load(inputFile)

for sectionName, functions in allFunctions.iteritems():
    testFilePath = os.path.join("testsFOO/test_%s.lua" % (sectionName,))
    with open(testFilePath, 'w') as testFile:
        testFile.write("""
require 'cephes'
local callTests = {}
local tester = torch.Tester()

""")
        for function in functions:
            testFile.write(testsForFunction(function))
        testFile.write("""
tester:add(callTests)
tester:run()
""")

