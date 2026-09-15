# Utilisateurs, groupes et intégration au domaine

## Objectif

Administrer les utilisateurs, les groupes et les postes clients dans un environnement Active Directory sous Windows Server 2022.

L'objectif est de centraliser l'authentification, organiser les comptes et permettre aux postes Windows de rejoindre le domaine.

## Environnement

- Windows Server 2022
- Active Directory Domain Services
- DNS
- Postes clients Windows
- VirtualBox
- Domaine Active Directory

## Principe

Active Directory permet de centraliser la gestion des identités et des ordinateurs du réseau.

Schéma simplifié :

```text
Active Directory
      │
      ├── Utilisateurs
      │
      ├── Groupes
      │
      ├── Ordinateurs
      │
      └── Unités d'organisation (OU)
```

Cette organisation facilite :

- l'administration des comptes ;
- l'attribution des droits ;
- l'application des GPO ;
- la gestion des postes ;
- la centralisation de l'authentification.

# Gestion des utilisateurs

## Création d'un utilisateur

Les comptes utilisateurs peuvent être créés depuis :

```text
Active Directory Users and Computers
```

Les principales étapes sont :

1. ouvrir l'OU dans laquelle le compte doit être créé ;
2. sélectionner `New` puis `User` ;
3. renseigner le prénom et le nom ;
4. définir l'identifiant de connexion ;
5. définir un mot de passe initial ;
6. configurer les options liées au mot de passe ;
7. valider la création.

Exemple :

```text
Prénom     : Jean
Nom        : Dupont
Identifiant: j.dupont
```

Dans un environnement de production, les conventions de nommage doivent être définies et appliquées de manière cohérente.

## Organisation avec les OU

Les unités d'organisation permettent de classer les comptes selon différents critères.

Exemple :

```text
Domaine
│
├── OU Utilisateurs
│   ├── Direction
│   ├── Administration
│   └── Technique
│
└── OU Ordinateurs
    ├── Postes
    └── Serveurs
```

Cette structure permet ensuite d'appliquer des stratégies ou des règles adaptées à chaque catégorie.

# Gestion des groupes

## Principe

Les groupes permettent de gérer collectivement les droits attribués aux utilisateurs.

Il est préférable d'attribuer des permissions à un groupe plutôt qu'individuellement à chaque utilisateur.

Exemple :

```text
Utilisateur
    │
    ▼
Groupe
    │
    ▼
Ressource
```

Par exemple :

```text
Jean Dupont
     │
     ▼
GRP-Techniciens
     │
     ▼
Accès au dossier Technique
```

## Création d'un groupe

Depuis `Active Directory Users and Computers` :

1. ouvrir l'OU appropriée ;
2. sélectionner `New` puis `Group` ;
3. définir le nom du groupe ;
4. choisir son étendue ;
5. choisir son type ;
6. valider la création.

## Ajout d'un utilisateur à un groupe

Un utilisateur peut appartenir à plusieurs groupes.

Exemple :

```text
Utilisateur : j.dupont

Groupes :
├── GRP-Techniciens
├── GRP-VPN
└── GRP-Support
```

L'utilisation de groupes simplifie fortement la gestion des droits.

# Intégration d'un poste au domaine

## Prérequis

Avant d'intégrer un poste Windows au domaine, plusieurs éléments doivent fonctionner :

- le poste dispose d'une configuration IP correcte ;
- le poste peut communiquer avec le contrôleur de domaine ;
- le serveur DNS du poste pointe vers le DNS du domaine ;
- le domaine peut être résolu ;
- le contrôleur de domaine est accessible ;
- un compte autorisé à joindre la machine au domaine est disponible.

## Vérification réseau

Sur le poste client :

```powershell
ipconfig /all
```

Cette commande permet notamment de vérifier :

- l'adresse IP ;
- le masque ;
- la passerelle ;
- le serveur DNS ;
- le suffixe DNS.

## Test du contrôleur de domaine

Par adresse IP :

```powershell
ping adresse-ip-du-controleur
```

Par nom :

```powershell
ping nom-du-controleur
```

Le deuxième test permet également de vérifier que la résolution DNS fonctionne correctement.

## Vérification DNS

```powershell
nslookup nom-du-controleur
```

Exemple :

```powershell
nslookup srv-ad01
```

Le serveur DNS doit être capable de retourner l'adresse IP correspondant au contrôleur de domaine.

## Ajout du poste au domaine

Depuis Windows :

```text
Paramètres système
      │
      ▼
Nom de l'ordinateur
      │
      ▼
Domaine
      │
      ▼
Saisie du nom du domaine
      │
      ▼
Authentification
      │
      ▼
Redémarrage
```

Après validation, un message doit confirmer que le poste a correctement rejoint le domaine.

Le redémarrage de la machine est ensuite nécessaire.

# Ouverture d'une session avec un compte du domaine

Après intégration du poste au domaine, un utilisateur du domaine peut ouvrir une session.

Exemple :

```text
MONDOMAINE\j.dupont
```

ou :

```text
j.dupont@mondomaine.local
```

Selon la configuration de l'environnement.

## Vérification du compte utilisé

Une fois connecté :

```powershell
whoami
```

Exemple de résultat :

```text
mondomaine\j.dupont
```

Cela permet de confirmer que l'utilisateur est bien authentifié avec un compte Active Directory.

## Vérification du domaine

```powershell
systeminfo
```

La sortie permet notamment d'identifier :

```text
Domain: mondomaine.local
```

et de confirmer l'appartenance du poste au domaine.

# Vérification Active Directory

Une fois le poste intégré, l'objet ordinateur doit apparaître dans Active Directory.

Exemple :

```text
Active Directory
│
└── OU Ordinateurs
    │
    ├── PC-DIRECTION-01
    ├── PC-ADMIN-01
    └── PC-TECH-01
```

Les objets ordinateurs peuvent ensuite être déplacés dans différentes OU afin de leur appliquer les GPO correspondantes.

# Diagnostic

## Le domaine est introuvable

Vérifier :

- l'adresse du serveur DNS configuré sur le client ;
- la résolution DNS ;
- la connectivité avec le contrôleur de domaine ;
- le nom du domaine saisi ;
- l'état des services Active Directory et DNS.

Commandes utiles :

```powershell
ipconfig /all
```

```powershell
nslookup mondomaine.local
```

```powershell
ping nom-du-controleur
```

## Le poste ne peut pas rejoindre le domaine

Vérifier notamment :

- les identifiants utilisés ;
- les droits du compte ;
- la connectivité réseau ;
- la configuration DNS ;
- l'heure système du client ;
- l'heure du contrôleur de domaine.

Une différence importante entre l'heure du poste et celle du contrôleur de domaine peut provoquer des problèmes d'authentification.

## L'utilisateur ne peut pas ouvrir de session

Vérifier :

- que le compte existe ;
- que le compte est actif ;
- que le mot de passe est correct ;
- que le poste est toujours membre du domaine ;
- que le contrôleur de domaine est accessible ;
- que DNS fonctionne correctement.

# Bonnes pratiques

Dans un environnement professionnel, il est recommandé de :

- utiliser des conventions de nommage cohérentes ;
- organiser les utilisateurs et postes dans des OU ;
- attribuer les droits via des groupes ;
- éviter d'accorder directement des permissions utilisateur par utilisateur ;
- désactiver les comptes devenus inutiles ;
- appliquer une politique de mot de passe adaptée ;
- documenter les groupes et leurs fonctions ;
- appliquer le principe du moindre privilège.

# Compétences mises en pratique

- création et gestion de comptes Active Directory ;
- création et gestion de groupes ;
- organisation des objets avec des OU ;
- compréhension de la gestion centralisée des identités ;
- intégration d'un poste Windows à un domaine ;
- configuration DNS nécessaire à Active Directory ;
- authentification avec un compte de domaine ;
- gestion des objets ordinateurs ;
- utilisation de `whoami`, `ipconfig`, `ping`, `nslookup` et `systeminfo` ;
- diagnostic de problèmes d'intégration et d'authentification.

## Documentation à venir

Ce dossier sera progressivement complété avec :

- captures de création d'utilisateurs ;
- captures de création de groupes ;
- organisation réelle des OU du lab ;
- intégration complète d'un poste Windows ;
- ouverture de session avec un compte de domaine ;
- exemples de groupes et permissions ;
- scénarios de dépannage.
