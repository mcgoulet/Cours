@echo off

:question_age
SET /p age=Quel est votre age?

echo %age%

if %age% gtr 0 if  %age% lss 120 goto question_sexe

cls
echo Votre age doit etre entre 0 et 120

goto question_age

:question_sexe
SET /P sexe=Quel est votre sexe? (H/F)

if /I "%sexe%" == "H" goto fin
if /I "%sexe%" == "F" goto fin

cls
echo Choisissez H ou F
goto question_sexe

:fin
set output=Vous etes un
if /I %sexe% == H set output2= homme
if /I %sexe% == F set output2=e femme

goto fin_output

:fin_output
set output3= de %age% ans.

set final_output=%output%%output2%%output3%
echo %final_output%
