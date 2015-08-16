#!/bin/bash
#
# test script for isnumber.sh
#
# Author: John F. McGowan Ph.D. (jmcgowan79@gmail.com)
# (C) 2015 John F. McGowan
#

# test non-numbers
#
ntests=0
nfails=0

echo "NOT A NUMBER TESTS"
report=`./isnumber.sh dog`
result=$?  # need to assign this to result immediately after isnumber.sh exits
ntests=`expr $ntests + 1`
if [[ $result == "1" ]]; then
    echo "PASSED"    
else
    echo "FAILED"
    nfails=`expr $nfails + 1`
fi

report=`./isnumber.sh 123x`
result=$?
ntests=`expr $ntests + 1`
if [[ $result == "1" ]]; then
    echo "PASSED"    
else
    echo "FAILED"
    nfails=`expr $nfails + 1`
fi

report=`./isnumber.sh 1.2.3`
result=$?
ntests=`expr $ntests + 1`
if [[ $result == "1" ]]; then
    echo "PASSED"    
else
    echo "FAILED"
    nfails=`expr $nfails + 1`
fi

report=`./isnumber.sh 1.2.i`
result=$?
ntests=`expr $ntests + 1`
if [[ $result == "1" ]]; then
    echo "PASSED"
else
    echo "FAILED"
    nfails=`expr $nfails + 1`
fi

# test numbers
#
echo "NUMBER TESTS"
# integer
report=`./isnumber.sh 1`
result=$?
ntests=`expr $ntests + 1`
if [[ $result == "1" ]]; then
    echo "FAILED"
    nfails=`expr $nfails + 1`
else
    echo "PASSED"
fi

# zero
report=`./isnumber.sh 0`
result=$?
ntests=`expr $ntests + 1`
if [[ $result == "1" ]]; then
    echo "FAILED"
    nfails=`expr $nfails + 1`
else
    echo "PASSED"
fi

# negative integer
report=`./isnumber.sh -1`
result=$?
ntests=`expr $ntests + 1`
if [[ $result == "1" ]]; then
    echo "FAILED"
    nfails=`expr $nfails + 1`
else
    echo "PASSED"
fi

report=`./isnumber.sh 1.23`
result=$?
ntests=`expr $ntests + 1`
if [[ $result == "1" ]]; then
    echo "FAILED"
    nfails=`expr $nfails + 1`
else
    echo "PASSED"
fi

report=`./isnumber.sh .1`
result=$?
ntests=`expr $ntests + 1`
if [[ $result == "1" ]]; then
    echo "FAILED"
    nfails=`expr $nfails + 1`
else
    echo "PASSED"
fi

report=`./isnumber.sh 0.1`
result=$?
ntests=`expr $ntests + 1`
if [[ $result == "1" ]]; then
    echo "FAILED"
    nfails=`expr $nfails + 1`
else
    echo "PASSED"
fi

report=`./isnumber.sh af`
result=$?
ntests=`expr $ntests + 1`
if [[ $result == "1" ]]; then
    echo "FAILED"
    nfails=`expr $nfails + 1`
else
    echo "PASSED"
fi

report=`./isnumber.sh 0xaf`
result=$?
ntests=`expr $ntests + 1`
if [[ $result == "1" ]]; then
    echo "FAILED"
    nfails=`expr $nfails + 1`
else
    echo "PASSED"
fi

report=`./isnumber.sh "(1,2,3)"`
result=$?
ntests=`expr $ntests + 1`
if [[ $result == "1" ]]; then
    echo "FAILED"
    nfails=`expr $nfails + 1`
else
    echo "PASSED"
fi

report=`./isnumber.sh [1,2,3]`
result=$?
ntests=`expr $ntests + 1`
if [[ $result == "1" ]]; then
    echo "FAILED"
    nfails=`expr $nfails + 1`
else
    echo "PASSED"
fi

report=`./isnumber.sh {1,2, 3}`
result=$?
ntests=`expr $ntests + 1`
if [[ $result == "1" ]]; then
    echo "FAILED"
    nfails=`expr $nfails + 1`
else
    echo "PASSED"
fi

report=`./isnumber.sh 12i`
result=$?
ntests=`expr $ntests + 1`
if [[ $result == "1" ]]; then
    echo "FAILED"
    nfails=`expr $nfails + 1`
else
    echo "PASSED"
fi


report=`./isnumber.sh 12.i`
result=$?
ntests=`expr $ntests + 1`
if [[ $result == "1" ]]; then
    echo "FAILED"
    nfails=`expr $nfails + 1`
else
    echo "PASSED"
fi

report=`./isnumber.sh .12i`
result=$?
ntests=`expr $ntests + 1`
if [[ $result == "1" ]]; then
    echo "FAILED"
    nfails=`expr $nfails + 1`
else
    echo "PASSED"
fi


report=`./isnumber.sh 1.2i`
result=$?
ntests=`expr $ntests + 1`
if [[ $result == "1" ]]; then
    echo "FAILED"
    nfails=`expr $nfails + 1`
else
    echo "PASSED"
fi

echo " "
echo "SUMMARY"
echo "---------------------------------"
echo "FAILED $nfails OF $ntests TESTS";
if [[ $nfails == 0 ]]; then
    echo "PASSED ALL TESTS!!!!"
fi

# the end
