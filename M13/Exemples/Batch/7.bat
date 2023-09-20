@echo off 
SET /A a = 5 
SET /A b = 10 
SET /A c = %a% + %b%
if %c%==15 echo "La valeur de c est 15"  
if %c%==10 echo "La valeur de C est 10"