import cPickle as pickle
import argparse
parser = argparse.ArgumentParser()
parser.add_argument("functions")
args = parser.parse_args()

def ffiForFunction(function):
    functionString = str(function['returnType']) + " " + str(function['functionName'])
    argsWithTypes = [ typeName + " " + arg for (arg, typeName) in function['arguments'] ]
    functionString += "(" + (", ".join(argsWithTypes)) + ");\n"
    return "   " + functionString

with open(args.functions, 'r') as inputFile:
    allFunctions = pickle.load(inputFile)

seenFiles = set()
ffiFilePath = "ffi.lua"
with open(ffiFilePath, 'w') as ffiFile:
    ffiFile.write(
"""
local ffi = require("ffi")
cephes = ffi.load(package.searchpath('libcephes', package.cpath))

-- Define cmplx struct
ffi.cdef[[
typedef struct
        {
        double r;
        double i;
        }cmplx;
]]
""")

    for sectionName, functions in allFunctions.iteritems():
        ffiFile.write(
"""
-- imports for folder %s
ffi.cdef[[
""" % (sectionName,))

        for function in functions:
            if not function['origin'] in seenFiles:
                ffiFile.write("   // %s\n" %(function['origin'],))
                seenFiles.add(function['origin'])
            ffiFile.write(ffiForFunction(function))

        ffiFile.write("]]\n")

    ffiFile.write(
"""
return cephes
""")
