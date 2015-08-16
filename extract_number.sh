#!/bin/bash
#
# example of extracting number from text using regular expressions in bash
# -- we frequently want to extract numerical data from unstructured text
#
# illustrates regular expressions for recognizing number strings
#
# bash is sometimes in /usr/local/bin/bash
#
# (C) 2015 John F. McGowan, Ph.D. (jmcgowan79@gmail.com)


if [[ "$1" == "-h" || "$1" == "-?" ]]; then
    echo "Usage: `basename $0` <string> extract number from string "
    echo "       -- exit code 1 if no number found"
    echo "       -- exit code 0 if a number is found"
    echo "       -- reports number if found"
    echo " "
    echo " Author: John F. McGowan, Ph.D. (jmcgowan79@gmail.com)"
    echo " "
    exit 0
fi

found_number=1  # haven't found number yet
#
# inside brackets, caret negates the list of characters
# [^0-9] matches all characters except for 0,1,2...9
#
# real numbers/decimal numbers (0.0, ..., 0.5, ..., 1.0, ..., 3.1415...,...)
real_regexp="[+-]?([0-9]+|[0-9]+\.[0-9]*|\.[0-9]+)"
complex_regexp="$real_regexp( *[+-] *($real_regexp)?[iI])?"

if [[ $1 =~ [^0-9\-]*($complex_regexp) ]]; then
    echo ${BASH_REMATCH[1]}
    found_number=0
fi

exit $found_number

