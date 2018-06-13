#!/bin/bash

# Safety measures
set -o errexit   # Leave immediately if a command returns an error
set -o nounset   # Leave immediately if an un-itialized value is used

WHERE=$1

TABLES=$(echo $2 | tr "," "\n")

TEMP=/tmp/temp_list_of_files.txt

echo -n "Number of tables: "
echo $TABLES | wc -w

aws s3 ls --recursive $WHERE > /tmp/temp_list_of_files.txt

for T in $TABLES; do
    echo "test R2"
    R1=$(cat /tmp/temp_list_of_files.txt | grep "/$T/" | wc -l)
    R2=$(cat /tmp/temp_list_of_files.txt | grep -E "/${T}$" | wc -l)

    if [ $R1 \> 0 ]; then
         echo "file $T is present :"
         echo "$R1 times"
    elif [ $R2 \> 0 ]; then
         echo "file $T is present :"
         echo "$R2 times"
    else
        echo "file $T not found"
    fi
    lower_case_table=$(echo $T | tr '[:upper:]' '[:lower:]')

    r1=$(cat /tmp/temp_list_of_files.txt | grep "/$lower_case_table/" | wc -l)
    r2=$(cat /tmp/temp_list_of_files.txt | grep -E "/${lower_case_table}$" | wc -l)

    if [ $r1 \> 0 ]; then
         echo "file $lower_case_table is present :"
         echo "$r1 times"
    elif [ $r2 \> 0 ]; then
         echo "file $lower_case_table is present :"
         echo "$r2 times"
    else
        echo "file $lower_case_table not found"
    fi
done
