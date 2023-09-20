# Les fichiers batchs
Un fichier de commande est un fichier texte qui contient des commandes en mode invite de commande. On le surnomme fichier batch ou batch file, il possède l'extension **.bat**. À l'époque du DOS jusqu'au première version de Windows, c'est le fichier autoexec.bat qui s'exécutait à la fin du démarrage du DOS et lançait l'exécution de Windows. 

Les fichiers Batch sont interprété par l'interpréteur de commande, c'est à dire qu'ils s'exécutent de la première à la dernière ligne une à la suite de l'autre. Cet interpréteur est le programme COMMAND.COM que l'on connait depuis les débuts du DOS, il est devenu CMD.EXE depuis Windows NT.

La majorité des commandes se situent soit dans des commandes DOS traditionnelles ou au travers de conditions et des boucles: IF, FOR et GOTO.

On utilise les fichiers de commande pour créer des procédures automatiques pouvant être lancées par des personnes qui en ignorent les détails ou pour automatiser des séquences fréquemment utilisées: comme par exemple, suite à votre login: mounter un disque réseau, copier des polices dans le répertoire police de l'utilisateur afin d'uniformiser les polices de l'entreprise, ...

## ECHO
La commande Echo peut vous rendre deux fonctionnalités:
Afficher des messages à l'écran

```
ECHO %VARIABLE% : Affiche la valeur de la variable 
ECHO "Ami" : Affiche "Ami" 
ECHO . : Affiche un saut de ligne (enter)
ECHO OFF : Aucun écho sur la sortie standard (l'écran) 
ECHO ON : L'écho est à nouveau autorisé 
```

MS-DOS affiche généralement chaque ligne du fichier de commande au moment où il les interprète, juste avant de les exécuter. Cette affichage des commandes peut être désactivé par la commande ECHO OFF ou réactivé par la commande ECHO ON. Le fichier de commande débute souvent par @ECHO OFF. Le @ masque l'affichage de cette ligne de commande. La suite de l'instruction, la commande ECHO OFF empêche les échos des commandes suivantes.

## @
Le @ placé en début de ligne dans un fichier de commande empêche l'affichage de celle-ci sans pourtant en interdire l'exécution.

## REM
La commande Rem, placée en début de ligne, a pour fonction d'introduire un commentaire dans le code du fichier de commande. Elle est aussi très pratique pour désactiver une ligne de commande.

## PAUSE

La commande Pause interrompt l'exécution du fichier de commande en affichant :
Appuyer sur une touche pour continuer...

Si ce message ne vous convient pas, annulez le en le redirigeant vers la sortie fictive NUL:
pause < nul

## SET
Les variables d'environnement sont des données auxquelles le système d'exploitation réserve une partie de la mémoire vive. Elles sont accessibles à n'importe quel programme. Parmi la liste des variables d'environnement, une bien connue est la variable PATH afin de connaître la liste des emplacements des fichiers exécutables en ligne de commande.

```
SET            # Affiche toutes les variables d'environnement
SET A          # Affiche toutes les variables dont le nom commence par A
SET A=chaîne   # Assigne la valeur chaîne à A 
SET variable   # Supprime la variable
```

Elles se modifient comme ceci:
PATH=%PATH%;c:\Util

#### Attention

Les espaces autour du signe égal comptent dans l'affectation et l'assignation:
```
SET A = abc 
```
Le nom de la variable comporte deux caractères : 
* A 
* un espace

La valeur de la variable en compte 4 : 
* un espace 
* a
* b
* c

L'option "Assignation" permet d'évaluer une expression arithmétique ou logique et d'en attribuer la valeur à une variable. Nous plaçons les expressions entre guillemets. Un nom de variable dans une expression représente sa valeur. Il n'est donc plus nécessaire de placer les noms entre % .

Les valeurs numériques sont décimales (base 10) par défaut. On les fait précéder du préfixe 0x pour les valeurs hexadécimales (base 16) ou par 0 si elles sont saisies en octal (base 8)
```
SET /A variable="expression"
SET /A varA "2+3" donne 5 (car 2+3= 5)
SET /A varB "0xB+6" donne 17 (car 0xB = 11 +6=17)
SET /A varC "14 & 3" donne 2 (car 1110 AND 0011 = 0010)
```

## setx

La commande précédente créait une variable d'environnement seulement pour l'exécution de la fenêtre DOS. **setx** permet d'en créer qui seront affectées pour toujours.

Les variables d'environnements du systèmes sont affectées par le système d'exploitation qui permet d'accéder à diverses informations précises, tel que nom d'utilisateur et emplacement du répertoire temporaire.

Variables d'environnement | Description
---|---
%USERNAME% | nom d'utilisateur de la personne connectée
%USERPROFILE% | l'emplacement du profil de l'utilisateur
%PROGDATA% et %PROGFILES% | deux emplacements pour les données et les fichiers des programmes installés
%TEMP% | le répertoire temporaire, c'est à dire que les fichiers devraient être supprimés lorsque vous redémarrez votre ordinateur.
%WINDIR% | une variable d'environnement qui pointe au répertoire de Windows.
%PATH% | la liste des répertoires dont les fichiers seront exécutables peu importe où l'on est situé.

Vous pouvez créer vos propres variables d'environnement et elles seront disponibles à partir de votre ligne de commande. Lorsque vous en créez de nouvelles, vous devrez relancer vos propres scripts afin de mettre à jour vos variables d'environnement.

## LABEL
Les fichiers de commandes ne sont pas toujours de simples séquences d'instructions. Il arrive dans certaines conditions que des instructions doivent être ignorées ou au contraire être répétées un certain nombre de fois. Cela est possible en combinant les instructions de tests et les instructions de sauts.

:label

* Le label est un nom quelconque précédé de deux points.
* Il doit être seul, il ne peut pas être suivi par une commande sur la même ligne.
* Il marque un endroit donné du code pour servir de destination à la commande GOTO ou CALL.

## GOTO
La commande GOTO suivie d'un label provoque un saut dans le programme à l'endroit où est défini le label.

GOTO nomLabel

La commande GOTO :EOF permet de sortir d'un fichier batch (si on met le label à la fin du fichier). On se sert de cette forme de la commande GOTO pour faire l'équivalent d'un "Return" en fin d'une sous-routine.

## CALL
La commande CALL a été prévue initialement pour appeler un fichier de commande à partir d'une autre. Une fois que les commandes du fichier appelés sont achevées on revient à l'instruction qui suit le call.

```
CALL CmdFile2 Arg1 Arg2
ECHO "J'aime le chocolat"
```

Ceci appelle le fichier de commande CmdFile2 en lui passant les arguments Arg1 et Arg2. Les commandes du fichier appelé étant achevées on revient à l'instruction qui suit le CALL.

Le retour à l'instruction suivante n'aurait pas eu lieu si on avait appelé CmdFile2 en inscrivant son nom comme une commande sans utiliser la commande CALL. La commande CALL accepte les étiquettes comme cible.

## IF

Soumet l'exécution de la commande à une condition. Suivant que la condition est vraie ou fausse, ce sera la commande1 ou la commande2 qui s'exécutera:

```
IF condition commande1 ELSE commande2
```

En principe, les instructions IF et ELSE doivent être écrites sur une même ligne. Ce n'est pas toujours possible car certaines commandes du DOS doivent s'achever par un retour à la ligne. On parvient à concilier ces deux exigences en plaçant les commandes entre parenthèses.

```
IF Condition (
  Commande1
) ELSE Commande2
IF condition (
  commande1
) ELSE (
  command2
)
```

Commande1 et commande2 peuvent être remplacées par des blocs de plusieurs lignes de commandes. Cette disposition fait penser à celle du langages C ou du Java.

### Attention

Malgré l'artifice des parenthèses, la commande IF reste à considérer comme une commande en une seule ligne. Cela a une conséquence étrange, qu'il faut savoir prévoir. La ligne est lue complètement en échangeant les variables mises entre \% avec leur valeur avant l'exécution. Ce remplacement est appelé l'expansion des variables. Il est fait à la lecture et non pas lors de l'exécution de la ligne de commande.

```
set VAR=avant
if "%VAR%"=="avant" (
   set VAR=après
   echo %VAR%
) 
echo %VAR%
```

On s’attendrait à voir deux après, mais ce n’est pas le cas. Car le premier s’effectue en parallèle du set... alors le set n’est pas terminé qu’on a affiché le contenu de %VAR% et donc de "avant" (voir l'exemple 9.bat).

```
IF Condition (Commande1) ELSE Commande2
```

### Exemples d’expressions conditionnelles

Code | Explication
---|---
IF [NOT] ERRORLEVEL nombre | Si le code rendu par le programme précédent est supérieur ou égal au nombre indiqué
IF [NOT] DEFINED variable  | Si la variable est définie 
IF [NOT] EXIST fichier | Si le fichier existe 

Comparaison chaîne | Explication
---|---
chaîne1 == chaîne 2 | Si chaine1 est identique à chaîne2 (seulement pour des chaînes) 
chaîne1 EQU chaîne 2  | Si chaine1 est identique à chaîne2
chaîne1 NEQ chaîne 2  | 	Si chaine1 est différente de chaîne2
chaîne1 LSS chaîne 2  | 	Si chaine1 est plus petite que chaîne2
chaîne1 LEQ chaîne 2 |	Si chaine1 est inférieur ou égale à chaîne2
chaîne1 GTR chaîne 2  |	Si chaine1 est supérieur à chaîne2
chaîne1 GEQ chaîne 2 | Si chaine1 est supérieur ou égale à chaîne2 

L'option /I demande d'ignorer la casse lors de ces comparaisons. Si les deux chaînes ne contiennent que des chiffres, alors la comparaison est numérique au lieu d'être alphabétique.

### for

for {variable} in {collection} do {commande}

Le mot variable doit être bien choisie, de plus x et X ne sont pas la même variable \footnote{La casse a de l'importance et il semble mieux d’avoir qu’un seul caractère pour les variables}.

### /d - directory 

Indique que la collection d'items sont des répertoires

```
for /d %X in (C:\*) do echo %X
```

### /r - récursif

Indique que la collection est récursive 

```
for /R C:\pictures %X in (*.jpg) do 
  (echo %X >> listjpg.txt)
```

### /L - loop

Indique que la collection d'item a un début, un pas et une fin.

Loop un certain nombre de fois (start, step, end) (voir Exemple 8.bat)

```
for /L %X in (1,1,99) 
  do (echo %X >> numbers.txt)
```

### /F - File Output

Ne sera pas utilisé ni demandé, ça semble être utilisé pour parser les sorties d'une commande.

## Redirection

Par défaut, la sortie des programmes se retrouvent où l'exécution a été lancée, ainsi si vous lancez la commande dir, l'affichage des fichiers et répertoires se fera immédiatement après.

Cependant, il existe 2 emplacements de sortie d'affichage à l’exécution:


* Sortie standard 1> ou > 
* Sortie erreur 2>

**Echo envoie sa sortie vers la sortie standard par défaut**

Si vous faîtes ceci:

```
echo TEST > test.txt
```

Ceci permet de rediriger le **echo TEST** vers le fichier test.txt. Donc le fichier test.txt sera créé avec le contenu: TEST.

Si une commande vous retourne un message d'erreur, celui-ci pourra être redirigé également:
```
dir test 2> patate.txt 
```
Si le fichier test n'existe pas dans le dossier en cours, à l'intérieur de patate.txt sera inscrit fichier introuvable.
Les commandes peuvent également ajouter à un fichier plutôt que remplacé un fichier. Ceci va ajouter la chaîne bonjour à la fin du fichier test.txt:

```
echo “bonjour” >> test.txt
```

Il est possible de prendre le contenu d’un fichier et de l’envoyer vers une commande (voir exemple num.bat):

```
command < file
```

Et de rediriger la sortie d’une commande vers l’entrée d’une deuxième commande:

```
commande1 | commande2
```