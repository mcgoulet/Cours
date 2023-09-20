@echo off

rem Problème

set VAR="avant"
if %VAR%=="avant" (
   set VAR="apres"
   echo %VAR%
)
echo %VAR%
