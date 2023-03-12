#!/bin/bash

student_name="John"

echo student_name = $student_name
echo student_name = ${student_name}

DATE=2022-01-21
echo Good Morning, Today date is $DATE

## Command Substitution
DATE=$(date +%F)
echo Good Morning, Today date is $DATE

## Arthmetic Substitution
EXPR1=$((2+3-4*5/7*8))
echo EXPR1 OUTPUT = $EXPR1

## Trying to access a variable from shell command line
COURSE_NAME=DevOps
echo Course Name = $COURSE_NAME
