import cPickle as pickle
import os
import argparse
import itertools
import logging
logging.basicConfig(level=logging.INFO)

parser = argparse.ArgumentParser()
parser.add_argument("functions")
parser.add_argument("--outputDir", default="tests")
parser.add_argument("--debug", action='store_true')
args = parser.parse_args()

if args.debug:
    logging.getLogger().setLevel(logging.DEBUG)

testValues = {
#    'double' : [0.0, 1.0, 10.0, "math.huge"],
    'double' : [0.5],
    'int' : [1],
    'cmplx' : ["cephes.new_cmplx(1, 1);"],
    'fract' : ["nil ; error('TODO: fract parameter needed!')"],
    'cmplx *' : ["cephes.new_cmplx(1, 1) ; error(' TODO: check this pointer makes sense!')"],
    'void *' : ["nil ; error(' TODO: void * parameter needed!')"],
    'double *' : ['ffi.new("double[1]", {0}) ; error(" TODO: check this array is sensible!")'],
    'int *' : ['ffi.new("int[1]", {0}) ; error(" TODO: check this array is sensible!")'],
    'fract *' : ["nil ; error(' TODO: fract * parameter needed!')"]
}

def testsForFunction(function):
    logging.debug("Generating tests for %s" % (function['functionName'],))
    logging.debug("Return type: "  + function['returnType'])
    logging.debug("Args: " + str(function['arguments']))

    functionCArgs = ", ".join(argType + " " + argName for argName, argType in function['arguments'])

    for i, (argName, argType) in enumerate(function['arguments']):
        if argName.endswith("[]"):
            argType += " *"
            argName = argName[0:-2]
            function['arguments'][i] = (argName, argType)

    valueGenerators = [ testValues[argType] for argName, argType in function['arguments'] ]

    testString = """
-- Test simple calls for {functionName}
-- Signature: {returnType} {functionName}({functionCArgs})
function callTests.test_{functionName}()
""".format(
        returnType = function['returnType'],
        functionName = function['functionName'],
        functionCArgs = functionCArgs
    )

    argNames = [ argName for argName, _ in function['arguments'] ]

    for argValues in itertools.product(*valueGenerators):
        testString += """    {argDeclarations}
    tester:assert(cephes.{functionName}({functionArgs}))""".format(
            functionName = function['functionName'],
            functionArgs = ", ".join(str(x) for x in argNames),
            argDeclarations = "\n    ".join("local %s = %s" % (argNames[i], argValue) for i, argValue in enumerate(argValues))
        )
    testString += """
end
"""

    return testString

with open(args.functions, 'r') as inputFile:
    allFunctions = pickle.load(inputFile)

for sectionName, functions in allFunctions.iteritems():
    testFilePath = os.path.join(args.outputDir, "test_%s.lua" % (sectionName,))
    with open(testFilePath, 'w') as testFile:
        testFile.write("""
require 'cephes'
local ffi = require 'ffi'
local callTests = {}
local tester = torch.Tester()

""")
        for function in functions:
            testFile.write(testsForFunction(function))
        testFile.write("""
tester:add(callTests)
tester:run()
""")

