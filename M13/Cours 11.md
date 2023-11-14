# Mémoire centrale et virtuelle

La mémoire physique est constituée d'un ensemble de blocs de mémoire contigus désignés chacun par une adresse physique. Un bloc de mémoire est constitué d'un ou plusieurs octets (16 bits, 32 bits, 64 bits ou 128 bits). Le processeur accède aux mots de la mémoire centrale par le biais de deux registres, le registre adresse MAR et le registre donnée MBR ou MDR:

* MAR (memory address register) contient l'adresse du mot (à lire ou écrire)
* MBR ou MDR (memory data register)  contient la donnée (à lire ou écrire)

## Cache processeur

Ce sont les emplacements L1, L2, L3. Même si les trois sont de la mémoire SRAM, L1 est le plus rapide et L3 le plus lent.

Deux principes de localité sont utilisés en informatique afin de permettre de planifier un meilleur accès aux données:

* la localité temporelle: si vous avez besoin d'une information à un instant t, la probabilité que vous en ayez au moment t+1 et t+2 est grande.
* la localité spatiale: si vous avez besoin d'une information i de mémoire à un instant t, la probabilité que vous ayez du bloc mémoire i+1 au moment t+1 ou t+2 est grande.

De plus, la gestion de l'écriture peut suivre un de ces deux fonctionnements:

* write-through, le mot est immédiatement écrit en mémoire à chaque fois qu'il est modifié par le processeur.
* write-back, le mot est écrit en mémoire centrale seulement lorsque l'entrée du cache contenant le mot est réquisitionné pour y placer un nouveau mot.

## Espace d'adressage

L'espace d'adressage d'un processus est constitué de l'ensemble des adresses auxquelles le processus a accès au cours de son exécution. 

Cet espace d'adressage est constitué de trois parties:

* Le code: les lignes de code en assembleur permettant le traitement du flot d'information.
* Les données: les données du processus
* Sa pile: le pointeur qui permet de se positionner dans le programme et de faire des appels, revenir, l'exécution au sens strict quoi.

Cet ensemble d'adresse est appelé espace d'adresses logiques cependant, pour pouvoir être exécuté, celui-ci doit être chargé en mémoire physique. Ce qui implique de mapper l'espace d'adressage logique du processus sur l'espace physique de la mémoire centrale. 

Il faut donc pouvoir convertir les adresses logiques générées par le processus en adresses physiques pour avoir accès aux données réelles en mémoire. Une conversion est donc faite systématiquement du monde des adresses logiques vers le monde des adresses physiques. Cette conversion est faite par un composant informatique appelé MMU (memory-mapping unit). Il est typiquement intégré au sein du processeur, bien que d'anciens systèmes avaient des MMU à part.

## Mémoire physique

Deux définitions importantes:

* L'espace d'adressage virtuel des processus est découpé en morceaux linéaires de même taille, appelés pages.
* L'espace de la mémoire physique est découpé en morceaux linéaires de même tailles appelés cases ou cadres. La taille des cases en mémoire physique varie entre 512 octets ou 8192 octets.

Dans ce contexte, charger un programme en mémoire centrale consiste à placer les pages dans n'importe quelle case libre de la mémoire physique. Afin de pouvoir déterminer les emplacements libres ou non, le système d'exploitation maintient une table des cases pour laquelle il indique pour chaque case de la mémoire physique:

* si elle est libre
* sinon, la page et le processus auquelle elle appartient.

Chaque processus a sa propre table des pages. Il s'agit d'une structure de données qui est utilisée par la mémoire virtuelle afin de pouvoir référencer la ou les pages et l'emplacement sur la case, en gros c'est un mappage de la mémoire logique vers la mémoire physique. En plus, elle agit comme une isolation , car chaque processus ne peut voir que ses propres pages, pas celles des autres processus. 

L'opération de commutation de contexte (changement de processus) se traduit également par un changement de table des pages de manière à ce que la table active corresponde à celle du processus élu. La gestion des différentes pages et de l'accès à ceux-ci sont gérées par le noyau, bien entendu. 

Accéder à un emplacement mémoire à partir d'une adresse paginée <page, deplacement> requiert deux actions:

* Obtenir l'entrée de la case c en mémoire centrale de la page **page** de la table des pages
* Obtenir la donnée qui se trouve à la position **deplacement** dans la case c.

## Partage des pages

Des bits de protection sont également ajoutés à chaque page de la table des pages d'un processus, permettant entre autres de partager les données. C'est notamment le cas des librairies, dont il est souhaitable qu'elles soient utilisables par plusieurs processus.

Par exemple, l'utilisation du même programme par deux utilisateurs différents.

Il faut alors que dans la table des pages processus, les deux pages du programmes pointent vers la même case et que celle-ci aille des droits de lecture pour tous. Côté système, la table des cases peut également indiquer qu'une case peut être partagée entre deux processus.

# Mémoire Swap

Soit une situation où deux processus (A et B) s'accaparent la totalité de l'espace mémoire disponible laissant un troisième processus (C) dans l'impossibilité d'accéder à la mémoire centrale. On constate que le processus A n'accède qu'à une petite partie de son espace d'adressage par exemple: i-e le code couramment utilisé par le processus et les données correspondantes (localité spatiale). Les autres pages de l'espace d'adressage ne sont pas accédées et donc inutiles en mémoire centrale. Une solution serait donc de pouvoir charger qu'une partie des pages (les plus utilisées) et laisser les autres "ailleurs". 

Il est aussi possible qu'un processus prend plus que la totalité de la mémoire physique disponible dans l'ordinateur. Ce cas étant moint présent de nos jours, mais il est toujours possible dans le cas de manipulation de large quantitées de données en mémoire centrale. Le principe de la mémoire virtuelle consiste donc à charger à un instant donné en mémoire centrale que la partie couramment utilisée de l'espace d'adressage du processus  permettant donc l'exécution d'un programme dont la taille serait plus grande que l'espace physique en mémoire centrale.

Puisque les pages ne sont pas toutes chargées en mémoire centrale, le processeur doit détecter leur absence éventuelle au moment où s'effectue la conversion de l'adresse logique vers l'adresse physique. Chaque entrée de la table des pages aurait alors un champ supplémentaire, le bit de validation, qui serait à 1 si et seulement si la page est en mémoire centrale. 

### Que se passe-t-il lorsqu'un processus tente d'accéder à une page de son espace d'adressage qui n'est pas en mémoire centrale? 

Une trappe (interruption du processeur ou interrupt en anglais) appelée défaut de page (page fault) va être levée qui va suspendre l'exécution du processus puis initier une opération d'entrées sorties afin de charger la page manquante en mémoire centrale dans une case libre. Si aucune est libre, le noyau choisira un processus ancien et déplacera la données d'une case mémoire vers la mémoire virtuelle ou swap.

Les pages constituant l'espace d'adressage du processus sont stockées dans une zone particulière du disque communément appelée zone de swap.

## Espace noyau (kernel space) vs Espace utilisateur (user space)

Les systèmes d'exploitation conventionnels établissent une séparation de la mémoire virtuelle entre l'espace noyau et l'espace utilisateur:

* L'espace noyau est strictement réservé pour exécuter le noyau, ses extensions (modules) et certains pilotes de périphériques.

* L'espace utilisateur est une région de la mémoire virtuelle où les applications des utilisateurs s'exécutent. Chaque processus en mode utilisateur tourne dans son propre espace de mémoire virtuel, et à moins de dispositions contraires, ne peut accéder à l'espace mémoire des autres processus. C'est la base de la protection mémoire.

La répartition entre espace utilisateur et espace noyau diffère naturellement entre les OS. Trop diminuer l'espace noyau cause des problèmes, par exemple limiter le nombre d'utilisateurs qui peuvent se connecter au système en même temps. À l'inverse, un espace utilisateur trop petit signifie que le programmeur a moins de mémoire pour travailler.

## Fonctionnement de la mémoire centrale sous Linux

Le logiciel free sous linux permet de savoir l'utilisation des mémoires suivantes:

* **total**: La quantité de mémoire totale

* **libre** (free): La mémoire disponible pour les nouveaux processus

* **partagée** (shared): La mémoire partagée entre plusieurs processus

* **tampons** (buffers): Le buffer est une mémoire temporaire d'une application particulière similère à l'envoi de données. Supposons que vous avez un grand nombre de données à envoyer par le réseau et que votre carte réseau ne peut qu'envoyer une certaine quantitée à la fois, elle va conserver les données dans un buffer le temps que le réseau soit moins utilisé.

* **cache** (cached): Le cache est une mémoire temporaire de contenu d'un fichier lu régulièrement afin d'éviter de le recharger à chaque fois, en gros une donnée lue sera enregistrée dans le cache tant que la donnée ne sera pas sauvegardée.
Les deux derniers sont des emplacements temporaires qui vont s'ajuster selon les besoins des applications en cours.

## Création de mémoire virtuelle sous Linux

Sous Linux, l'administrateur est responsable de créer soit une partition ou un fichier afin de permettre le swap entre la mémoire virtuelle et le disque dur: 

### Créer une partition:

* Créer la partition du disque avec fdisk ou gdisk
* Formatter la partition avec la commande mkswap /dev/partition
* Monter la partition avec swapon /dev/partition

### Créer un fichier d'échange:

* Créer le fichier avec fallocate et le mettre à un emplacement et un utilisateur que tout le monde n'aura pas accès, car il est possible qu'un utilisateur mauvais analyse le contenu de la swap pour y découvrir des informations.
* Formatter le fichier avec la commande mkswap.
* Monter la partition avec swapon fichier

## Fonctionnement de la mémoire centrale sous Windows

Quelques notions sont ajoutées afin de nous permettre de comprendre la façon de fonctionner:

### Gestionnaire de tâches

La quantité de mémoire utilisée par un processus est : **WorkingSet** 

Le WorkingSet a deux portions: **privées** et **partagées** (quantitée de mémoire disponible à d'autres processus):

Par exemple, quand vous ouvrez un document word, le programme word.exe est dans la mémoire partagée, alors que le document word est dans la mémoire privée. Tout comme les drivers et les DLLs ne sont que des données partagées.

La **mémoire virtuelle** sous Windows nommée PageFile permet comme sur Linux au processus d'obtenir plus de mémoire au besoin. Elle est configurable par l'entremise de l'onglet performance de l'interface système du menu Paramètres.

La **mémoire committée** est l'addition des WorkingSet et de la taille de la mémoire virtuelle (PageFile). Il s'agit en réalité de la mémoire virtuelle réservée pour un processus donné. Ce n'est qu'une approximation, car elle n'est pas concrètement allouée et ne le sera que si seulement on en a besoin.

**Taille de mémoire virtuelle** = Mémoire Physique + Page File Size (paramétrée par l'utilisateur)

**Taille de mémoire commitée (en cours d'utilisateur)** = Taille de mémoire virtuelle - Taille de mémoire virtuelle disponible (msinfo).

Le **mémoire paginée** est la quantitée de mémoire utilisée par le noyau avec des données qui peuvent être paginée lorsqu'elles ne sont plus utilisées. Inversement, la **mémoire non-paginée** ne peut être inscrite sur le disque et doit être conservée en mémoire en permanence.

### Moniteurs de ressources

Le moniteur de ressources amène pour sa part quelques nouveaux termes:

* **Matériel réservé**: espace mémoire réservé pour le matériel de l'ordinateur (driver) qui doivent toujours être présents en RAM. La mémoire est généralement barrée et n'est pas disponible pour le gestionnaire de mémoire du système d'exploitation.

* **En cours d'utilisation**: espace mémoire utilisé par l'addition de tous les WorkingSets de tous les processus gérés par le système d'exploitation.

* **Modifiée**: espace mémoire qui ne fait plus partie d'un WorkingSet car il était trop au ralenti depuis une trop grande période de temps. Cela peut aussi être des données devant être écrites au disque avant que la mémoire ne puisse être disponible à d'autres processus.

* **En attente**: espace mémoire qui permet de garder un cache des anciennes exécutions des logiciels / fichiers, permettant de les réutiliser plus rapidement au besoin.

* **Libre**: espace mémoire disponible pour l'exécution de nouveau processus, toute nouvelle demande puise à l'intérieur.

* **Installée**: Quantitée de mémoire totale de l'ordinateur (en cours d'utilisation + modifiée + en attente + libre + matériel)
