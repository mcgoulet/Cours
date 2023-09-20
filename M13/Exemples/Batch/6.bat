@echo off 
SET str1 = String1 
SET str2 = String2 
if defined str1 echo "Variable str1 n'est pas définie"

if defined str3 (echo "Variable str3 est définie") else (echo "Variable str3 n'existe pas")