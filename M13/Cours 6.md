# Introduction à GNU/Linux

## Est-ce que Linux est un système d'exploitation?

Non, il s'agit en réalité que d'un noyau.

## Qu'est-ce qu'un noyau?

C'est la partie du système d'exploitation qui est nécessaire pour communiquer avec le matériel. Elle permet d'utiliser se matériel comme ressource faisant partie du système.

## Qui a créé le noyau Linux?

Le créateur du noyau Linux est Linus Torvalds qui a entamé le développement de Linux il y a plus que 20 ans (fin août 1991). Linus s'occupe toujours de la direction du développement pour le noyau Linux.

## Où est utilisé majoritairement Linux de nos jours?

Au niveau des serveurs, Linux et Unix détiennent approximativement 66% du marché. 

## Où puis-je trouver le dernier noyau?

https://www.kernel.org

## Puis-je l'installer sans distribution?

Non, un noyau fait partie des premières étapes du chargement d'un système d'exploitation, mais il a besoin d'être compilé et installé dans l'EFI afin d'être bootable. Par la suite, il doit être chargé en mémoire centrale afin de détecter le matériel et communiquer avec le différent matériel. Finalement, il cède la main à init qui est le premier processus à être créé. Cependant, sans distribution, il n'y a pas de programme init, donc ça plante!

## Alors pourquoi utiliser le terme GNU/Linux dans tout ça?

### GNU
Afin de rendre ce noyau fonctionnel, les développeurs ont ajouté divers outils système, compilateurs et librairies à ce dernier. On y greffa alors l'univers GNU, ce qui le transforma alors en système GNU/Linux:

* gcc (compilateur C) : afin de pouvoir compiler le code source C en langage machine
* glibc (librairie C) : afin de ne pas être obligé de tout programmer, offrir des * librairies de programmation aux développeurs de solutions logicielles
* binutils (linker): afin de lier des programmes à des librairies existantes
* gnome (interface graphique): afin de ne pas tout faire en ligne de commande
*screen ( multiplexeur de ligne de commande)
* tar (archiveur)
* gimp (dessin de graphique)

Aujourd'hui, GNU/Linux est un système d'exploitation complet, permettant à quiconque d'utiliser son ordinateur comme sur le S.E. Windows. Mis à part certains logiciels propriétaires tel que la suite Adobe et la suite Office de Microsoft, la plupart des logiciels sont disponibles sur le système GNU/Linux.

Étant un système d'exploitation plus léger, l'utilisation d'un GNU/Linux sur un ordinateur périmé permettra d'étendre sa durée de vie tout en permettant d'être sécuritaire, car par exemple Windows 7 n'est plus supporté par Microsoft et les failles de sécurité ne sont plus corrigées. Windows 8 a été supporté jusqu'en janvier 2023 pour la correction des failles de sécurité.

Il est désormais possible de jouer à une grande quantité de jeu de Steam grâce à l'émulateur Proton (qui est un fork, une fourche de développement de wine).

## LFS

Si vous avez envie de voir la création d'un Linux à partir de rien, vous pouvez installer LFS de chez vous, ils expliquent en détail toutes les étapes de création d'un Linux à partir de rien. Vous apprendrez alors les étapes:

* Création de la partition Linux
* Compilation des librairies C, (première compilation) du compilateur gcc, des librairies C++ et des utilitaires binaires
* Compilation du noyau
* Compilation des outils complémentaires (bash, coreutils, file, findutils, gawk, grep, gzip, make, patch, sed, tar, xz, (seconde compilation) utilitaires binaires et (seconde compilation) du compilateur gcc
* ...
 
Dans ce cours, nous ne ferons pas cet exercice mais, ça reste que si vous aimez vraiment ce système d'exploitation, je vous suggère de lire beaucoup sur ce site.

En suivant ce guide, vous aurez une version de Linux fonctionnelle et vous serez comblé, cependant un problème se glisse à l'horizon...

Il n'y a aucune façon automatisée pour garder à jour notre système, les logiciels devront être gardés à jour et malheureusement vous n'aurez aucun outil pour le faire. C'est l'inconvénient du système LFS et la raison pour laquelle que c'est un excellent outil pédagogique, mais pas un système en production.

Un système GNU/Linux contenant une liste de programme initial fonctionnel, mais qui n'est pas tenu à jour serait cribblé de failles de sécurité et deviendrait rapidement passé date. Avec le temps, des failles de sécurité seront découvertes et corrigées autant au niveau des logiciels qu'à celui du noyau, des librairies. De nouvelles fonctionnalités auront été ajoutées aux programmes que vous utilisez, mais vous n'y aurez pas accès car aucun moyen de garder à jour son système sans une nouvelle compilation.

Imaginez alors que vous souhaitez faire une mise à jour sur une librairie de développement:

* Quels logiciels seront impactés et lesquels nécessitent une nouvelle compilation?
* Combien de temps de compilation sera nécessaire pour compiler l'ensemble des logiciels affectés?
* Est-ce que cette mise à jour pourra être exécutée sur un serveur en production et combien de temps cela prend-il? 
* Est-ce que les applications seront toujours fonctionnelles après la mise à jour?

C'est dans cette optique qu'existent les distributions.

# Distribution

Une distribution est:

* un nom de distribution,
* un noyau,
* numéro de version / ou nom (certaine fois un nom comme dans le cas de Debian ou d'Ubuntu)
* un ensemble de logiciels de base,
* un outil de gestion des paquetages (installation / désinstallation) et de mise à jour

Un grand nombre de distributions existe, un simple tour sur http://www.distrowatch.org.

## Paquetages

Un paquetage est un conteneur qui est composé de deux parties:

* données de contrôle (# de version, dépendances, ...) 
* fichiers à installer (et emplacements)

Il y a plus que 51 000 paquetages disponibles sur Debian. Ces paquetages peuvent être des logiciels, des fichiers de configuration, des librairies, des sons, des images, ... L'idée principale est de se rappeler que la grande totalité des fichiers installés par le système d'exploitation est géré par le gestionnaire de paquetages.

Le gestionnaire a les informations de version et la description du programme, mais aussi ses différentes types de dépendances, ses recommandations et ses suggestions. Par exemple, lorsque j'installe le logiciel evince, je dois également installer les librairies A, B, C.

Un paquet est relié à une distribution par l'entremise de son gestionnaire de paquet:

* apt, dpkg pour Debian,
* pacman pour ArchLinux,
* emerge ou portage pour Gentoo,
* dnf pour Fedora,
* chaque distribution possède son système de paquetage (ou presque)

Il faut comprendre ici que pour un logiciel, deux paquets provenant de deux sources (par exemple Ubuntu et Fedora) seront totalement différents car le gestionnaire de paquet n'est pas le même pour les deux systèmes et donc non compatibles. Chaque gestionnaire de paquets a sa propre façon de gérer les dépendances, les paquets et les différentes versions de ces deux derniers éléments.

Ubuntu et Debian utilisent tous les deux dpkg comme gestionnaire de paquet. Même si les deux sont compatibles, ce n'est pas recommandé de prendre des paquets de l'autre distribution. 

### Version des distributions sous Debian

Debian offrent des arbres de distribution (chacun avec ses logiciels en version):

* Stable
* Testing
* Développement (nommé sid)

Des versions plus stables avec moins de fonctionnalités, alors que les dernières fonctionnalités seront intégrées dans des versions de tests ou de développement. En temps et lieux, la distribution de test deviendra la stable et la développement, la version de test.

Du côté de ArchLinux, c'est un arbre avec seulement les versions les plus récentes des distributions.

## Binaire vs Source

Deux types principaux de distributions de paquets.

* Binaires: Debian, Ubuntu, Fedora, OpenSuse, ArchLinux
* Sources: Gentoo, Archlinux (AUR), FreeBSD (ce n'est pas Linux)

Une distribution binaire (comme Debian et ArchLinux) partage des paquets compilés sur le serveur. Alors qu'une distribution source offre des paquets sources sont en réalité des fichiers textes indiquant la marche à suivre pour télécharger / configurer / compiler / installer le logiciel.

La différence principale est le temps nécessaire pour l'installation de la mise à jour. Vous aurez compris que les distributions sources vont être beaucoup plus lentes à compiler, mais vous pouvez les optimiser plus facilement pour votre système et elles sont moins "lourdes" sur les serveurs du propriétaire de la distribution.

# License GPL

Comment Linux a réussi à exister et à rester en vie dans un monde capitaliste?
Il fallait être capable de protéger ses intérêts tout en s'assurant que tout le monde était régi par des règles simples permettant de s'assurer que les logiciels restent disponibles dans le futur.

Il serait dur de vous parler de l'univers du libre sans glisser un mot sur les licences. Une des plus connues est la licence GPL qui est une licence qui s'assure que les logiciels demeurent libres. Richard Stallman est le fondateur de cette licence et du mouvement GNU (vous vous rappelez, GNU/Linux).

Les objectifs de la GPL:

1. la liberté d'exécuter le programme, pour tous les usages,
2. la liberté d'étudier le fonctionnement du programme et de l'adapter à ses besoins: nécessite l'accès au code source.
3. la liberté de redistribuer des copies du programme (ce qui implique la possibilité aussi bien de donner que de vendre des copies). Vous pourriez vendre vos logiciels issus d'un développement GPL, cependant puisque vous donnez vos sources, c'est généralement plus le support que vous allez offrir que le logiciel en tant que tel.
4. la liberté d'améliorer le programme et de distribuer ces améliorations au public, pour en faire profiter toute la communauté. Il est généralement bien perçu de partager ses améliorations.

Finalement toute modification faîtes à un document GPL fait que ce dernier reste GPL. Vous n'avez pas légalement le droit d'enlever le GPL d'un programme. Si vous copiez du code GPL sur Internet et que vous l'insérez dans votre programme, votre code devient **automatiquement** GPL.

# Hiérarchie des répertoires

Vu que Linux est un système d'exploitation, il n'a pas la même structure que Windows. Voici une liste des répertoires du système, **contrairement à Windows où il y a plusieurs racines, sur Linux, il y en a juste une**. 

| Emplacement | Définition                                                                                       |
| ----------- | ------------------------------------------------------------------------------------------------ |
| /           | Racine du système                                                                                |
| /bin        | Fichier disponible pour tous les utilisateurs                                                    |
| /boot       | Fichiers de démarrage (noyau, initrd, grub)                                                      |
| /dev        | Liste des du matériel détecter par le noyau                                                      |
| /etc        | Fichier de configuration                                                                         |
| /home       | Répertoire utilisateur                                                                           |
| /lib        | Librairie système, tel les modules du noyau                                                      |
| /media      | Répertoire de montage pour les médias amovibles                                                  |
| /mnt        | Répertoire de montage temporaire.                                                                |
| /opt        | Localisation optionnelle de certains programmes (Chrome)                                         |
| /proc       | Information au niveau des processus et du noyau. (uptime, réseau, ...)                           |
| /root       | Répertoire home de l'utilisateur root                                                            |
| /sbin       | Programme utilisable que par le root                                                             |
| /tmp        | Répertoire temporaire, fichiers supprimés après chaque redémarrage.                              |
| /usr/bin    | Programmes utilisateurs                                                                          |
| /usr/lib    | Librairies des programmes utilisateurs                                                           |
| /usr/share  | Données utilisées partagées par les différents programmes (son, images, ...)                     |
| /var        | Données des programmes en exécution, ils peuvent être variables.file de courrier ou d'impression |
| /var/log    | Log des programmes systèmes                                                                      |

Ceci n'est qu'une recommandation et non une formalité et comme personne n'est tenu à respecter ça, la hiérarchie pourrait être différente dans certaines distributions.

Un contenu particulier à connaître lors de votre parcours Linux est le répertoire personnel, chaque utilisateur d'un système d'exploitation Linux se fait assigné lors de la création du compte, un répertoire nommé personnel qui va contenir tous ses fichiers, ses configurations, son cache, ...

# Les informations de fichier
Voyons comment les fichiers sont enregistrés sur le système, ça diffère de sur Windows.

Voici un exemple de droit d'accès pour un fichier, il fut obtenu en exécutant (vous pouvez le tester dans votre machine virtuelle):

```
ls -l /bin/cat
-rwxr-xr-x 1 root root 47784 12 oct 08:47 /bin/cat 
```

* En suivant la hiérarchie précédente, ce fichier est situé sous la racine (/), dans le répertoire bin (/bin) et a le nom cat (/bin/cat).

* En regardant la troisième et la quatrième colonne, il appartient à l'**utilisateur** root et au **groupe** root. Chaque utilisateur fait partie d'un certain nombre de groupes.

* 47 784 est la taille du fichier
* 12 oct 08:47 est la date de dernière modification
* -rwxr-xr-x sont les permissions d'accès

Avant de parler des bits d'accès, nous devons expliquer les permissions possibles,

### Fichier 

| Propriété | Définition                                                                                                                                     |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| r         | lecture, permet de lire le contenu d'un fichier                                                                                                |
| w         | écriture permet d'écrire dans le fichier ou de remplacer le contenu d'un fichier                                                               |
| x         | exécution permet du fichier dans le cas que c'est un fichier exécutable ou un fichier de script (permettant l'exécution de commande succésive) |

### Répertoire

| Propriété | Définition                                                                                                                                                    |
| --------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| r         | lecture, permet de lire le contenu d'un répertoire                                                                                                            |
| w         | écriture, permet d'écrire d'ajouter ou supprimer des fichiers dans le répertoire                                                                              |
| x         | exécution, permet de traver le répertoire dans le sens que si vous voulez exécuter la commande /bin/cat, vous devez avoir l'exécution pour le répertoire bin. |

## Pourquoi les bits d'accès se répète (-rwxr-xr-x) ?

Explication, divisons nos bits d'accès -rwxr-xr-x, séparons les en 4 parties:

### -

Cela signifie que ce dont on parle n'est ni un répertoire (d), ni un lien (l). En réalité, le - stipule que c'est un fichier.

### rwx

Ici ça stipule que les droits d'accès sont lecture (r), écriture (w) et exécution (x) pour le propriétaire du fichier. Donc son propriétaire pourrait réécrire le fichier dans le cas d'une mise à jour par exemple. Comme on l'a vu précédemment, son propriétaire est root, donc il s'agit en réalité d'un fichier système (ce n'est pas une certitude, mais puisqu'il est dans le répertoire /bin, c'est le cas) puisque possédé par root.

### r-x

Ici ça stipule que les droits d'accès sont lecture (r) et exécution (x) pour le groupe du fichier. Le groupe qu'on a vu précédemment (avec le ls) est le groupe root. Il est à noter ici que chacun des fichiers du système de fichier ont ce genre de droit d'accès, dans le sens qu'ils sont possédés par un utilisateur et font partie d'un groupe. Donc le groupe root est un groupe où les majorités des programmes et des utilitaires du systèmes d'exploitation font partie. Généralement le seul utilisateur faisant partie du groupe root est le root.

### r-x

Ici ça stipule que les droits d'accès sont lecture (r) et exécution(x) pour le reste des gens. Et oui, une dernière catégorie est les autres, ceux ne faisant pas propriétaire, ni faisant partie du groupe. Nous voyons donc que le programme (oui car il est situé dans /bin) est un utilitaire système que tout le monde peut utilisé car tout le monde a la permission lecture et écriture.

# Changer les permissions

Deux façons sont possibles avec la commande **chmod**

1. Façon symbolique

Nous avons vu qu'il y a 3 parties:

| Élément | Définition   |
| ------- | ------------ |
| u       | user / owner |
| g       | group        |
| o       | others       |
| a       | tous         |

a = u + g + o

Il est possible d'utiliser les opérateurs suivants:
```
+ : ajout d'une permission
- : efface une permission
= : assigne la permission
```

### Exemple
Si nous voulons retirer des groupes la possibilité d'écrire dans un fichier texte nommé "fichier" tout en conservant les propriétés pour l'utilisateur et les autres (groupe ne sera pas modifié pour ses propriétés de lecture et d'exécution:

```
chmod g-w fichier.txt
```

Si nous voulons assigner lecture et exécution à tous au fichier:
```
chmod a+rx fichier.txt
```

Si nous voulons assigner lecture et exécution à tous au fichier et leur enlever l'écriture:
```
chmod a=rx fichier.txt
```

## Façon absolue

Les permissions sont au nombre de 8, supposons 0 pour inactive et 1 pour active (r: lecture, w: écriture, x: exécution)

| r   | w   | x   | Décimal |
| --- | --- | --- | ------: |
| 0   | 0   | 0   |    0 () |
| 0   | 0   | 1   |   1 (x) |
| 0   | 1   | 0   |   2 (w) |
| 0   | 1   | 1   |  3 (wx) |
| 1   | 0   | 0   |   4 (r) |
| 1   | 0   | 1   |  5 (rx) |
| 1   | 1   | 0   |  6 (rw) |
| 1   | 1   | 1   | 7 (rwx) |

Par contre, ce n'est pas suffisant pour affecter nos fichiers, puisque les permissions sont un regroupement de 3 permissions (users, groupes, autres).

Donc il nous faut 3 valeurs de 8 choix collées, ou sinon un nombre entre 000 et 777 en base 8 (aucune colonne ne peut dépasser 7).

Si nous souhaitons assigner lecture et écriture pour l'utilisateur et toutes les permissions pour le groupe et le propriétaire pour le fichier fichier:
```
chmod 776 fichier
```

Si nous souhaitons assigner lecture et écriture pour le propriétaire et aucun accès pour le groupe et les autres
```
chmod 600 fichier
```

## Commande à apprendre pour aujourd'hui

| Nom | Définition |
| --- | ---------- |
man | aide pour une commande
cd | changement de répertoire
mkdir| création de répertoire
cp| copie de fichier ou répertoire
mv| déplacement de fichier ou répertoire
rm| effacement de fichier
rm -r| effacement récursif (répertoire)
touch| création d'un fichier vide
ln| création de lien (soit symbolique: raccourci), soit dure pointe aux données à partir d'un nouvel emplacement)
ls| liste de fichier (dir)
cat, less, more | voir le contenu d'un fichier texte

Supposons que nous sommes dans le répertoire où se trouve "fichier,txt" et que nous voulons copier celui-ci dans un nouveau sous-répertoire "test".
```
mdir test/
cp fichier.txt ./test
```
