# Group Policy Objects (GPO)

## Objectif

Mettre en place et administrer des stratégies de groupe dans un environnement Active Directory afin d'appliquer automatiquement des paramètres aux utilisateurs et aux postes du domaine.

## Environnement

- Windows Server 2022
- Active Directory Domain Services
- Group Policy Management
- Postes clients Windows
- VirtualBox
- Domaine Active Directory

## Principe

Les Group Policy Objects permettent de centraliser la configuration des postes et des utilisateurs d'un domaine.

Une GPO peut notamment servir à :

- appliquer des paramètres de sécurité ;
- configurer l'environnement utilisateur ;
- déployer certains paramètres Windows ;
- contrôler l'accès à certaines fonctionnalités ;
- appliquer des règles différentes selon les unités d'organisation (OU).

## Organisation

Les GPO peuvent être liées à différents niveaux de l'annuaire Active Directory :

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

Cette organisation permet d'appliquer des stratégies différentes selon les utilisateurs ou les machines concernés.

## Création d'une GPO

Les principales étapes sont :

1. ouvrir la console `Group Policy Management` ;
2. créer une nouvelle GPO ;
3. lui attribuer un nom explicite ;
4. modifier les paramètres souhaités ;
5. lier la GPO à l'OU concernée ;
6. vérifier son application sur un poste client.

## Exemple de stratégie

Exemple de stratégie pouvant être utilisée dans un environnement de test :

```text
Nom : GPO-Postes-Utilisateurs
Cible : OU Postes
Objectif : appliquer automatiquement certains paramètres aux ordinateurs membres du domaine
```

Les paramètres exacts peuvent varier selon les besoins du réseau.

## Mise à jour des stratégies

Sur un poste client, il est possible de forcer l'actualisation des stratégies avec :

```powershell
gpupdate /force
```

Cette commande demande au système de réappliquer les stratégies utilisateur et ordinateur.

## Vérification

Pour vérifier les stratégies appliquées :

```powershell
gpresult /r
```

Cette commande permet notamment d'afficher :

- le domaine de l'utilisateur ;
- les GPO appliquées ;
- les groupes de sécurité ;
- les stratégies appliquées à l'ordinateur et à l'utilisateur.

Pour obtenir un rapport plus détaillé :

```powershell
gpresult /h rapport-gpo.html
```

Un fichier HTML est alors généré avec les informations concernant les stratégies appliquées.

## Diagnostic

En cas de problème d'application d'une GPO, plusieurs points peuvent être vérifiés :

- appartenance du poste au domaine ;
- emplacement du compte ou du poste dans la bonne OU ;
- liaison de la GPO avec la bonne OU ;
- filtrage de sécurité ;
- connectivité avec le contrôleur de domaine ;
- résolution DNS ;
- résultat de `gpupdate /force` ;
- résultat de `gpresult`.

## Compétences mises en pratique

- utilisation de Group Policy Management ;
- création et modification de GPO ;
- liaison de stratégies à des OU ;
- compréhension de l'héritage des stratégies ;
- application centralisée de paramètres ;
- utilisation de `gpupdate` ;
- utilisation de `gpresult` ;
- diagnostic de problèmes d'application des stratégies.

## Documentation à venir

Ce dossier sera progressivement complété avec :

- captures de la console Group Policy Management ;
- exemples de stratégies ;
- organisation des OU ;
- résultats de `gpresult` ;
- scénarios de dépannage.
