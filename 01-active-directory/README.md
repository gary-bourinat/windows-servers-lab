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

```text
Domaine
│
├── OU Utilisateurs
│   ├── Direction
│   ├── Administration
│   └── Technique
│
├── OU Groupes
│
├── OU Ordinateurs
│
└── OU Serveurs
```

Cette organisation facilite ensuite :

- l'application de stratégies de groupe ;
- la délégation de certaines tâches administratives ;
- la gestion des droits ;
- l'organisation des postes et utilisateurs.

## Création d'utilisateurs et de groupes

La gestion des identités est réalisée depuis la console :

```text
Active Directory Users and Computers
```

Les principales opérations comprennent :

1. création d'un utilisateur ;
2. définition de son identifiant ;
3. attribution d'un mot de passe initial ;
4. ajout éventuel à un ou plusieurs groupes ;
5. placement dans l'OU appropriée.

Les groupes permettent ensuite de gérer plus simplement les droits et les accès aux ressources.

## Intégration d'un poste au domaine

Pour qu'un poste client puisse rejoindre le domaine :

1. le poste doit pouvoir communiquer avec le contrôleur de domaine ;
2. son serveur DNS doit pointer vers le DNS du domaine ;
3. le nom du domaine doit pouvoir être résolu ;
4. le poste est joint au domaine avec un compte autorisé ;
5. la machine est redémarrée ;
6. un utilisateur du domaine peut ensuite ouvrir une session.

Schéma simplifié :

```text
Poste client
    │
    │ DNS + réseau
    ▼
Contrôleur de domaine
    │
    ├── Active Directory
    └── DNS
```

## Vérifications et diagnostic

### Configuration réseau

```powershell
ipconfig /all
```

Permet notamment de vérifier :

- l'adresse IP ;
- la passerelle ;
- le serveur DNS utilisé ;
- le suffixe DNS.

### Résolution DNS

```powershell
nslookup nom-du-serveur
```

Permet de vérifier que le nom du serveur est correctement résolu.

### Connectivité

```powershell
ping nom-du-serveur
```

Permet de vérifier la connectivité réseau ainsi que la résolution du nom.

### Identité de l'utilisateur

```powershell
whoami
```

Permet d'identifier le compte actuellement utilisé.

Exemple :

```text
MONDOMAINE\utilisateur
```

### Informations sur le domaine

```powershell
systeminfo
```

Cette commande permet notamment de vérifier si la machine appartient à un domaine.

## Points de contrôle en cas de problème

En cas d'échec lors de l'intégration d'un poste au domaine, il est nécessaire de vérifier :

- la configuration IP ;
- le serveur DNS configuré sur le client ;
- la résolution du nom de domaine ;
- la connectivité avec le contrôleur de domaine ;
- l'heure du poste et du serveur ;
- les identifiants utilisés ;
- l'état des services Active Directory et DNS.

## Compétences mises en pratique

- installation d'Active Directory Domain Services ;
- administration d'un domaine ;
- gestion des utilisateurs et groupes ;
- organisation d'un annuaire avec des OU ;
- intégration de machines clientes au domaine ;
- compréhension de la relation entre Active Directory et DNS ;
- utilisation d'outils de diagnostic Windows ;
- résolution de problèmes d'authentification et de connectivité.

## Documentation à venir

Ce dossier sera progressivement complété avec :

- captures d'écran de l'environnement ;
- schéma complet de l'architecture ;
- exemples d'OU ;
- exemples de groupes ;
- procédures d'administration ;
- scénarios de dépannage.
