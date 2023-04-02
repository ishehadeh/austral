#!/usr/bin/env bash
# Part of the Austral project, under the Apache License v2.0 with LLVM Exceptions.
# See LICENSE file for details.
#
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

set -euxo pipefail

opam exec -- dune build

function std() {
    echo "standard/src/${1}.aui,standard/src/${1}.aum"
}

function compile() {
    dir="$1"
    module="$2"
    echo -n -e "$3" > expected.txt

    shift 3
    ./austral compile "$@" "$dir/$module.aui,$dir/$module.aum" --entrypoint=Example.$module:main --output=testbin
    ./testbin > actual.txt

    diff actual.txt expected.txt
    rm testbin
    rm actual.txt
    rm expected.txt
}

compile examples/constant Constant ""
compile examples/identity Identity ""
compile examples/ffi FFI "aHello, world!\n"
compile examples/fib Fibonacci ""
compile examples/named-argument NamedArgument ""
compile examples/memory Memory ""
compile examples/record Record ""
compile examples/union Union ""
compile examples/concrete-typeclass ConcreteTypeclass ""
compile examples/generic-record GenericRecord ""
compile examples/generic-union GenericUnion ""
compile examples/generic-typeclass GenericTypeclass ""
compile examples/string String "HHello, world!\nA\nA\nA\nA\nA\n    B\nA\n    B\nC\n"
compile examples/box Box "aaaaa"
compile examples/pointer-to-record PTR "a"
compile examples/ref-to-record RTR "aa"
compile examples/array Array "TFT"
compile examples/buffer Buffer "ae"
compile examples/haversine Haversine ""
compile examples/either Either "aa"
compile examples/gauss-jordan GaussJordan "2.500000 2.500000 2.500000\n2.500000 1.000000 1.000000\n1.000000 1.000000 1.000000\n" "$(std 'Buffer')" "$(std 'Box')"
