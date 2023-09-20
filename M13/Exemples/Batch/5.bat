@echo off 
set file=1.bat
if exist %file% echo "Le fichier %file% existe" 
set file=11.bat
if exist %file% (echo "Le fichier %file% existe") else (echo "Le fichier 11.bat n'existe pas")