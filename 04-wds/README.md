# Windows Deployment Services (WDS)

## Objectif

Mettre en place Windows Deployment Services sous Windows Server 2022 afin de permettre le déploiement de systèmes Windows sur des postes clients directement depuis le réseau.

## Environnement

- Windows Server 2022
- Active Directory Domain Services
- DNS
- DHCP
- Windows Deployment Services
- Postes clients Windows
- VirtualBox
- Réseau local virtualisé

## Principe

Windows Deployment Services permet d'installer Windows sur des postes clients sans utiliser individuellement une clé USB ou un support d'installation.

Le poste client démarre via le réseau grâce au protocole PXE, contacte l'infrastructure de déploiement puis charge l'environnement d'installation Windows.

Schéma simplifié :

```text
Poste client
    │
    │ Démarrage réseau PXE
    ▼
Serveur DHCP
    │
    │ Configuration réseau
    ▼
Serveur WDS
    │
    │ Image de démarrage
    ▼
Windows PE
    │
    │ Sélection de l'image
    ▼
Installation de Windows
```

## Prérequis

Le fonctionnement de WDS nécessite notamment :

- un serveur Windows Server correctement configuré ;
- une connectivité réseau fonctionnelle ;
- un service DNS opérationnel ;
- un service DHCP fonctionnel ;
- Windows Deployment Services installé ;
- des images Windows compatibles ;
- des clients capables de démarrer en PXE.

## Installation du rôle WDS

Les principales étapes sont :

1. ouvrir `Server Manager` ;
2. sélectionner `Add Roles and Features` ;
3. ajouter le rôle `Windows Deployment Services` ;
4. installer les composants nécessaires ;
5. ouvrir la console `Windows Deployment Services` ;
6. procéder à la configuration du serveur.

## Configuration du serveur WDS

Après l'installation du rôle, le serveur doit être initialisé.

Les opérations principales comprennent :

1. sélection du mode de fonctionnement ;
2. définition du dossier de stockage des fichiers de déploiement ;
3. configuration du comportement PXE ;
4. ajout d'une image de démarrage ;
5. ajout d'une image d'installation ;
6. démarrage et vérification du service WDS.

## Images utilisées

WDS utilise principalement deux catégories d'images.

### Boot Image

L'image de démarrage permet au poste client de lancer l'environnement d'installation Windows depuis le réseau.

Exemple :

```text
boot.wim
```

Elle contient généralement Windows PE, utilisé pour lancer l'installation.

### Install Image

L'image d'installation contient le système Windows qui sera installé sur la machine cliente.

Exemple :

```text
install.wim
```

Ces fichiers peuvent être récupérés depuis un média d'installation Windows.

## Fonctionnement du démarrage PXE

Lorsqu'un poste client démarre via le réseau :

```text
1. Le client démarre en PXE
        │
        ▼
2. Le client recherche une configuration réseau
        │
        ▼
3. Le serveur DHCP fournit une adresse IP
        │
        ▼
4. Le client localise le service de déploiement
        │
        ▼
5. Le serveur WDS fournit l'environnement de démarrage
        │
        ▼
6. Windows PE est chargé
        │
        ▼
7. L'utilisateur sélectionne l'image Windows
        │
        ▼
8. L'installation démarre
```

## Configuration du poste client

Pour permettre un démarrage PXE, le poste client doit notamment être configuré pour :

- autoriser le démarrage réseau ;
- utiliser une carte réseau compatible PXE ;
- placer le démarrage réseau dans l'ordre de boot si nécessaire ;
- être connecté au même environnement réseau que les services DHCP et WDS.

Dans VirtualBox, il faut également vérifier la configuration de la carte réseau de la machine virtuelle.

## Test du déploiement

Lors du test, le comportement attendu est le suivant :

```text
Démarrage du poste
      │
      ▼
Initialisation PXE
      │
      ▼
Obtention d'une adresse IP
      │
      ▼
Contact du serveur WDS
      │
      ▼
Chargement de Windows PE
      │
      ▼
Sélection d'une image
      │
      ▼
Installation de Windows
```

## Vérifications réseau

Avant de diagnostiquer WDS lui-même, la configuration réseau doit être contrôlée.

Sur le serveur ou le client :

```powershell
ipconfig /all
```

Permet notamment de vérifier :

- l'adresse IP ;
- le masque ;
- la passerelle ;
- le serveur DHCP ;
- le serveur DNS.

Un test de connectivité peut également être réalisé avec :

```powershell
ping adresse-ip-du-serveur
```

ou :

```powershell
ping nom-du-serveur
```

## Vérification des services

Sous Windows Server, les services liés à WDS peuvent être contrôlés depuis :

```text
services.msc
```

Il est également possible d'utiliser PowerShell :

```powershell
Get-Service WDSServer
```

Pour afficher l'état du service Windows Deployment Services.

## Diagnostic PXE

Si le poste client ne démarre pas via PXE, plusieurs points doivent être vérifiés :

- le client obtient-il une adresse IP ?
- le serveur DHCP fonctionne-t-il ?
- le service WDS est-il démarré ?
- les images de démarrage sont-elles présentes ?
- les images d'installation sont-elles présentes ?
- le poste est-il configuré pour démarrer sur le réseau ?
- la carte réseau virtuelle est-elle correctement configurée ?
- le client et le serveur communiquent-ils sur le même réseau ?

## Diagnostic des images

Si le démarrage PXE fonctionne mais que l'installation ne démarre pas, vérifier notamment :

- la présence de `boot.wim` ;
- la présence de `install.wim` ;
- la compatibilité de l'image ;
- les droits d'accès ;
- l'espace disque disponible sur le serveur ;
- l'intégrité du média Windows utilisé.

## Relation entre les services

WDS s'intègre dans une infrastructure comprenant plusieurs services :

```text
Active Directory
      │
      ├──────── DNS
      │
      ├──────── DHCP
      │
      └──────── WDS
                 │
                 ▼
           Postes clients
```

Le bon fonctionnement du déploiement dépend donc également de la configuration réseau et des services associés.

## Compétences mises en pratique

- installation du rôle Windows Deployment Services ;
- configuration d'un serveur WDS ;
- compréhension du démarrage PXE ;
- gestion des images `boot.wim` et `install.wim` ;
- déploiement d'un système Windows via le réseau ;
- compréhension des interactions entre WDS, DHCP et DNS ;
- configuration d'un client pour le démarrage réseau ;
- diagnostic d'un échec PXE ;
- utilisation d'outils Windows d'administration et de diagnostic.

## Documentation à venir

Ce dossier sera progressivement complété avec :

- captures de la console WDS ;
- ajout des images de démarrage ;
- ajout des images d'installation ;
- captures d'un démarrage PXE ;
- captures du déploiement d'un poste client ;
- schéma complet de l'infrastructure ;
- scénarios de panne et dépannage.
