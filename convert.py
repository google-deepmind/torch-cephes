# -*- coding:utf-8 -*-

import argparse
import glob
import os
import collections
import re

class ConvertFunctionError(RuntimeError):
    pass


def extractFunctions(functions, inputPath):

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
                    argumentsWithTypes = []
                    print(argumentTypes)
                    for arg in arguments:
                        if arg in argumentTypes:
                            argumentsWithTypes.append((arg, argumentTypes[arg]))
                        elif arg + "[]" in argumentTypes:
                            # If we can't find the argument directly, check whether it was stored as an array type
                            argumentsWithTypes.append((arg + "[]", argumentTypes[arg + "[]"]))
                        else:
                            raise RuntimeError("Cannot find type for argument %s" % (arg,))

                    functionDescription = {
                            'returnType' : returnType,
                            'functionName' : inFunctionDeclaration,
                            'arguments' : argumentsWithTypes
                        }
                    yield functionDescription
                    inFunctionDeclaration = None
                else:
                    lineBeforeSemicolon = line.split(";")[0]
                    lineWords = lineBeforeSemicolon.split()

                    typeName = None
                    if lineWords[0] == "register":
                        typeName = lineWords[1]
                        lineWords = lineWords[2:]
                        print("REGISTER :" + typeName + " " + str(lineWords))
                    else:
                        typeName = lineWords[0]
                        lineWords = lineWords[1:]
                        print("NORMAL :" + typeName + " " + str(lineWords))

                    for argumentName in "".join(lineWords).strip().split(","):
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





parser = argparse.ArgumentParser()
parser.add_argument("functionList")
parser.add_argument("inputPath")

args = parser.parse_args()

with open(args.functionList, 'r') as functionFile:
    functions = functionFile.read().split()

tF, tA = 0, 0

sectionName = os.path.basename(args.inputPath)

ffiFilePath = os.path.join("ffi.lua")
testFilePath = os.path.join("tests/test_%s.lua" % (sectionName,))

print("OUTPUTTING TO: " + str(ffiFilePath) + "; " + str(testFilePath))

def testsForFunction(function):
    return "TODO TEST"

def ffiForFunction(function):
    functionString = str(function['returnType']) + " " + str(function['functionName'])
    argsWithTypes = [ typeName + " " + arg for (arg, typeName) in function['arguments'] ]
    functionString += "(" + (", ".join(argsWithTypes)) + ");\n"
    return "   " + functionString



with open(testFilePath, 'w') as testFile:
    with open(ffiFilePath, 'a') as ffiFile:
        ffiFile.write(
"""
-- imports for folder %s
ffi.cdef[[
""" % (sectionName,))
        for cFile in glob.glob(os.path.join(args.inputPath,"*.c")):
            print("checking C file %s" %(cFile))
            #totalFunctions, totalArguments = 
            extracted = list(extractFunctions(functions, cFile))
            if extracted:
                ffiFile.write("   // %s\n" %(cFile,))
            for extractedFunction in extracted:
                ffiFile.write(ffiForFunction(extractedFunction))
#                outputFile.write(str(functionString) + "\n")
                testFile.write(testsForFunction(extractedFunction))

        ffiFile.write("]]\n")

#    tF += totalFunctions
#    tA += totalArguments

#print("TOTAL FUNCTIONS:" + str(tF))
#print("TOTAL ARGUMENTS:" + str(tA))
#print("MEAN ARGS:" + str(float(tA) / tF))
