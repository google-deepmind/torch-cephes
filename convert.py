# -*- coding:utf-8 -*-

import argparse
import glob
import os
import collections
import re

class ConvertFunctionError(RuntimeError):
    pass


def extractFunctions(functions, inputPath):

    print("=" * 120)

    functionRegex = {}

    totalFunctions = 0
    totalArguments = 0

    for function in functions:
        typeRegex = "\w+"
        funcNameRegex = function

        functionRegex[function] = re.compile("""
                ^                # Start of line
                (%s)             # Type (group 1)
                \                # Space
                %s               # Function name
                \(               # Open bracket
                ([^()]*)         # All of the arguments
                \)               # Close bracket
                $                # End of line
                """ % (typeRegex, funcNameRegex)
            , re.VERBOSE)

    inFunctionDeclaration = None
    argumentTypes = None
    arguments = None


    with open(inputPath, 'r') as inputFile:
        for line in inputFile:
            if inFunctionDeclaration:
                if line.startswith("{"):
                    functionDescription = {
                            'returnType' : returnType,
                            'functionName' : inFunctionDeclaration,
                            'arguments' : [ (x, argumentTypes[x]) for x in arguments ]
                        }
#                    print("*****")
#                    print("types:" + str(types))
#                    print("arguments:" + str(arguments))
#                    functionString = str(returnType) + " " + str(inFunctionDeclaration)
#                    argsWithTypes = [ argumentTypes[x] + " " + x for x in arguments ]
#                    functionString += "(" + (", ".join(argsWithTypes)) + ");"
#                    yield functionString
                    yield functionDescription
#                    print(functionString)
                    print("*****")
                    inFunctionDeclaration = None
                else:
                    print("## %s ## " % (inFunctionDeclaration,) + line)
                    typeName = line.split()[0]
                    for argumentName in "".join(line.split()[1:]).strip(";").split(","):
                        if argumentName.startswith("*"):
                            argumentTypes[argumentName[1:]] = typeName + " *"
                        else:
                            argumentTypes[argumentName] = typeName

            else:
                for function in functions:
                    match = functionRegex[function].match(line)
                    if match:
                        print("Found function %s:" % (function,))
                        print(line)
                        print(match.groups())
                        returnType = match.group(1)
                        arguments = [ x.strip(" ,") for x in match.group(2).split(",") ]
                        totalArguments += len(arguments)
                        totalFunctions += 1
                        print("return type: " + returnType)
                        print("arguments " + str(arguments))
                        inFunctionDeclaration = function
                        argumentTypes = {}


    print("=" * 120)
    print




parser = argparse.ArgumentParser()
parser.add_argument("functionList")
parser.add_argument("inputPath")

args = parser.parse_args()

with open(args.functionList, 'r') as functionFile:
    functions = functionFile.read().split()

print functions

tF, tA = 0, 0

sectionName = os.path.basename(args.inputPath)

ffiFilePath = os.path.join("ffi_%s.lua" % (sectionName,))
testFilePath = os.path.join("tests/test_%s.lua" % (sectionName,))

print("OUTPUTTING TO: " + str(ffiFilePath) + "; " + str(testFilePath))

def testsForFunction(function):
    return "TODO TEST"

def ffiForFunction(function):
    functionString = str(function['returnType']) + " " + str(function['functionName'])
    argsWithTypes = [ typeName + " " + arg for (arg, typeName) in function['arguments'] ]
    functionString += "(" + (", ".join(argsWithTypes)) + ");\n"
    return functionString



with open(testFilePath, 'w') as testFile:
    with open(ffiFilePath, 'w') as ffiFile:
        for cFile in glob.glob(os.path.join(args.inputPath,"*.c")):
#            output = os.path.join(args.outputPath, os.path.splitext(os.path.basename(cFile))[0] + ".h")
            #totalFunctions, totalArguments = 
            ffiFile.write("// %s\n" %(cFile,))
            for extractedFunction in extractFunctions(functions, cFile):
                ffiFile.write(ffiForFunction(extractedFunction))
#                outputFile.write(str(functionString) + "\n")
                testFile.write(testsForFunction(extractedFunction))

#    tF += totalFunctions
#    tA += totalArguments

#print("TOTAL FUNCTIONS:" + str(tF))
#print("TOTAL ARGUMENTS:" + str(tA))
#print("MEAN ARGS:" + str(float(tA) / tF))
