# Active Directory Domain Services

## Objectif

Mettre en place et administrer un domaine Active Directory sous Windows Server 2022 afin de centraliser la gestion des utilisateurs, des groupes, des postes clients et des ressources du réseau.

## Environnement

- Windows Server 2022
- Active Directory Domain Services (AD DS)
- DNS
- Postes clients Windows
- VirtualBox
- Réseau local virtualisé

## Mise en œuvre

Les principales opérations réalisées dans cet environnement comprennent :

- installation du rôle Active Directory Domain Services ;
- promotion du serveur en contrôleur de domaine ;
- création et organisation des unités d'organisation (OU) ;
- création de comptes utilisateurs ;
- création et gestion de groupes ;
- intégration de postes Windows au domaine ;
- gestion centralisée des comptes depuis Active Directory Users and Computers ;
- vérification de la résolution DNS nécessaire au fonctionnement du domaine.

## Organisation logique

L'annuaire Active Directory permet d'organiser les ressources du réseau de manière hiérarchique.

Exemple de structure utilisée dans le lab :

Domaine
│
├── Utilisateurs
│   ├── Direction
│   ├── Administration
│   └── Technique
│
├── Groupes
│
├── Ordinateurs
│
└── Serveurs

Cette organisation facilite ensuite l'application de stratégies de groupe et la gestion des droits.

Intégration d'un poste au domaine

Pour qu'un poste client puisse rejoindre le domaine :

le client doit pouvoir communiquer avec le contrôleur de domaine ;
son serveur DNS doit pointer vers le DNS du domaine ;
le nom du domaine doit pouvoir être résolu ;
le poste est ensuite joint au domaine avec un compte autorisé ;
après redémarrage, un utilisateur du domaine peut ouvrir une session sur le poste.
Vérifications et diagnostic

Quelques outils et commandes permettent de vérifier le bon fonctionnement de l'environnement :

PowerShell:
ipconfig /all
-(Affiche notamment la configuration IP et les serveurs DNS utilisés.)
nslookup
-(Permet de vérifier la résolution DNS.)
ping 'nom-du-serveur'
-(Permet de vérifier la connectivité réseau et la résolution du nom.)
whoami
-(Permet d'identifier le compte actuellement utilisé et de vérifier l'ouverture d'une session avec un compte du domaine.)

Compétences mises en pratique
administration d'Active Directory ;
gestion des utilisateurs et groupes ;
organisation d'un annuaire avec des OU ;
intégration de machines clientes à un domaine ;
compréhension de la dépendance entre Active Directory et DNS ;
diagnostic de problèmes d'authentification et de connectivité.
Documentation à venir

Ce dossier sera progressivement complété avec :

captures d'écran de l'environnement ;
schéma de l'architecture ;
exemples d'OU et de groupes ;
procédures d'administration ;
scénarios de dépannage.
