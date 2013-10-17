# -*- coding:utf-8 -*-

import argparse
import glob
import os
import collections
import re
import cPickle as pickle
import logging
from collections import defaultdict
logging.basicConfig(level=logging.INFO)

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
                \s*              # Optional whitespace
                \(               # Open bracket
                ([^()]*)         # All of the arguments
                \)               # Close bracket
                \s*              # Optional whitespace
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
                    logging.debug(argumentTypes)
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
                            'arguments' : argumentsWithTypes,
                            'origin' : inputPath
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
                        logging.debug("REGISTER :" + typeName + " " + str(lineWords))
                    else:
                        typeName = lineWords[0]
                        lineWords = lineWords[1:]
                        logging.debug("NORMAL :" + typeName + " " + str(lineWords))

                    for argumentName in "".join(lineWords).strip().split(","):
                        if argumentName.startswith("*"):
                            argumentTypes[argumentName[1:]] = typeName + " *"
                        else:
                            argumentTypes[argumentName] = typeName

            else:
                for function in functions:
                    match = functionRegex[function].match(line)
                    if match:
                        logging.debug("Found function %s:" % (function,))
                        logging.debug(line)
                        logging.debug(match.groups())
                        returnType = match.group(1)
                        arguments = [ x.strip(" ,") for x in match.group(2).split(",") ]
                        totalArguments += len(arguments)
                        totalFunctions += 1
                        logging.debug("return type: " + returnType)
                        logging.debug("arguments " + str(arguments))
                        inFunctionDeclaration = function
                        argumentTypes = {}

parser = argparse.ArgumentParser()
parser.add_argument("functionList")
parser.add_argument("outputPath")
parser.add_argument("--input", action='append')
parser.add_argument("--debug", action='store_true')

args = parser.parse_args()

if args.debug:
    logging.getLogger().setLevel(logging.DEBUG)

with open(args.functionList, 'r') as functionFile:
    functions = functionFile.read().split()

allFunctions = defaultdict(lambda: [])
seenNames = set()

for inputDir in args.input:
    sectionName = os.path.basename(inputDir)
    logging.info("Processing directory %s" %(sectionName,))

    for cFile in glob.glob(os.path.join(inputDir,"*.c")):
        logging.info("Looking for functions in %s" %(cFile))
        for function in extractFunctions(functions, cFile):
            logging.info("Extracted function %s" % (function['functionName'],))
            allFunctions[sectionName].append(function)
            seenNames.add(function['functionName'])

logging.info("Writing function list to: " + str(args.outputPath))
with open(args.outputPath, 'w') as outputFile:
    pickle.dump(dict(allFunctions), outputFile)


missingNames = set(functions) - seenNames
for name in missingNames:
    logging.warn("Could not find %s" % (name,))

