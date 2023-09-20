@echo off

echo Voici la liste des fichiers batchs et de leur contenu:

for %%f in (*.*) do (
echo .
echo .
echo %%f :
echo .
type %%f
)
