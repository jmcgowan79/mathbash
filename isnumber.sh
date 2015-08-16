#!/bin/bash
# test if a string is a number, report type of the number (e.g. INTEGER, REAL, etc.)
# exit code is 0 for success -- string is a NUMBER
# exit code is 1 for failure -- string is NOT A NUMBER
#
# illustrates regular expressions for recognizing number strings
#
# bash is sometimes in /usr/local/bin/bash
#
# (C) 2015 John F. McGowan, Ph.D. 

if [[ "$#" -ne 1 || "$1" == "-h" || "$1" == "-?" ]]; then
    echo "Usage: `basename $0` <possible_number_string> "
    echo "  -- reports number type of possible_number_string "
    echo "  -- POSITIVE INTEGER, NON-NEGATIVE INTEGER, SIGNED INTEGER"
    echo "  -- HEXADECIMAL, REAL NUMBER, VECTOR, ZIP CODE, TELEPHONE NUMBER "
    echo "  -- CREDIT CARD NUMBER"
    echo " "
    echo "  -- ILLUSTRATES REGULAR EXPRESSIONS FOR RECOGNIZING NUMBER STRINGS"
    echo " "
    echo '  -- use bash$ echo $? to test exit code'
    echo "  -- use enclosing quotes for string with spaces such as credit card numbers"
    echo " "
    echo " Author: John F. McGowan, Ph.D. (jmcgowan79@gmail.com)"
    echo " "
   exit 0
fi

# Unix/bash exit code of 0 means success (is a number in this case)
is_number=1  # start no number found

number_string=$1

# regular expressions match patterns of characters
#
# caret ^ represents the start of a string or line outside of brackets
# dollar $ represents the end of a string or line
# square brackets [1-9] represent all characters in the brackets
# [abc] for example can be "a," "b," or "c"
# hyphen inside brackets indicates a range of characters
# typically digits or letters
# [1-9] represents the digits in range 1,2,3,...9
# [a-c] represents the letters a,b,c
#
# inside brackets caret ^ negates the list of characters
# for example [^0-9] represents all characters EXCEPT 0,1,2,...9
#
# ? indicates 0 or 1 of preceding pattern
# * indicates 0 or more of preceding pattern
# + indicates 1 or more of preceding pattern
# . matches any single character
#
# (...) is a group
# for example, (ab)? matches (nothing) or ab
# for example, (ab)* matches (nothing), ab, abab, ...
# for example, (ab)+ matches ab, abab, ababab, ...
# (...){n,m} indicates from n to m repetitions of the pattern
# for example, (ab){2,3} matches only abab and ababab
# the backlash is used to escape the characters with special meanings
# \^ \$ \( \) \[ \] \{ \} \* \. \? \+
#
# =~ is the reguar expression pattern matching operator in bash

# positive integers/counting numbers (1,2,3,...)
if [[ $number_string =~ ^[1-9][0-9]*$ ]]; then
    echo "POSITIVE INTEGER"
    is_number=0
fi

# add zero to numbers
# zero was remarkably difficult to invent
# the ancient Babylonians had a place-value
# number system based on 60 (not 10) which
# included an implicit zero, but the explicit
# symbol for zero took many more centuries to
# invent

# non-negative integers (0,1,2,...)
if [[ $number_string =~ ^[0-9]+$ ]]; then
    echo "NON-NEGATIVE INTEGER"
    is_number=0
fi

# negative numbers are even less obvious

# signed integers (..., -2, -1, 0, 1, 2,...)
if [[ $number_string =~ ^[+-][0-9]+$ ]]; then
    echo "SIGNED INTEGER"
    is_number=0
fi

# hexadecimal numbers are used with computers
# and low-level programming of computers

# hexadecimal (base 16) numbers such as AA12 or 0x12ab etc.
if [[ $number_string =~ ^(0[xX])?[0-9a-fA-F]+$ ]]; then
    # also recognize C format hex numbers such as 0xaf12
    echo "HEXADECIMAL NUMBER (INTEGER)"
    is_number=0
fi

# fractions such as 1/2, 1/3 date to antiquity but the
# concept of real numbers such as square root of 2
# proved difficult to grasp.  The ancient Greeks
# knew a proof that the square root of 2 could not
# be a ratio of two integers, but were apparently
# unable to make the leap to real numbers.

# real numbers/decimal numbers (0.0, ..., 0.5, ..., 1.0, ..., 3.1415...,...)
real_regexp="[+-]?([0-9]+|[0-9]+\.[0-9]*|\.[0-9]+)"
if [[ $number_string =~ ^$real_regexp$ ]]; then
    echo "REAL NUMBER"
    is_number=0
fi

# vectors are usually used to represent a magnitude
# with a direction such as the direction and speed
# of the wind or an ocean current (early uses of
# the vector concept)

# vector with enclosing parenthesis, e.g. (1, 2, 3)
vector_regexp="\(( *$real_regexp, *)+$real_regexp *\)"
if [[ $number_string =~  ^$vector_regexp$ ]]; then
    echo "VECTOR"
    is_number=0
fi

# vector with enclosing brackets, e.g. [1, 2, 3]
vector_regexp="\[( *$real_regexp, *)+$real_regexp *\]"
if [[ $number_string =~  ^$vector_regexp$ ]]; then
    echo "VECTOR"
    is_number=0
fi

# vector with enclosing curly braces, e.g {1, 2, 3}
vector_regexp="\{( *$real_regexp, *)+$real_regexp *\}"
if [[ $number_string =~  ^$vector_regexp$ ]]; then
    echo "VECTOR"
    is_number=0
fi

# the imaginary numbers turned up in roots of
# polynomials and are now used in everthing from
# electrical engineering, cryptography, to
# quantum mechanics, but remain mysterious.

# pure imaginary numbers i = square root(-1)
if [[ $number_string =~ ^$real_regexp[iI]$ ]]; then
    echo "PURE IMAGINARY NUMBER";
    is_number=0
fi

# complex numbers (1.1 + 2i, -1 + 2.1i, ...)
#
complex_regexp="$real_regexp( *[+-] *($real_regexp)?[iI])?"
if [[ $number_string =~ ^$complex_regexp$ ]]; then
    echo "COMPLEX NUMBER"
    is_number=0
fi

# large integers are frequently used as unique identifiers

# zip code (United States)
if [[ $number_string =~ ^[0-9]{5,5}(-[0-9]{4,4})?$ ]]; then
    echo "ZIP CODE (USA)"
    is_number=0
fi

# telephone number (USA)

if [[ $number_string =~ ^(([0-9]( |-))?[0-9]{3,3} +|([0-9]( |-))?\([0-9]{3,3}\) *)?[0-9]{3,3}( |-)[0-9]{4,4}$ ]]; then
    echo "TELEPHONE NUMBER (USA)"
    is_number=0
fi

# credit card number  (16 digits)

if [[ $number_string =~ ^[0-9]{16,16}|([0-9]{4,4} ?){4,4}$ ]]; then
    echo "CREDIT CARD NUMBER"
    # remove spaces from credit card number
    number_string_cleaned=${number_string// /}
#    echo "<$number_string_cleaned>"
    if [[ $number_string_cleaned =~ ^4[0-9]{6,}$ ]]; then
	echo "PROBABLE VISA CARD (VISA CARD START WITH 4)";
    fi
    if [[ $number_string_cleaned =~ ^5[1-5][0-9]{5,}$ ]]; then
	echo "PROBABLE MASTER CARD";
    fi
    is_number=0
fi

# report if string is not a number
#
if [[ $is_number == 1 ]]; then
    echo "NOT A NUMBER"
fi

exit $is_number
