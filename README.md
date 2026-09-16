# Windows Server Lab

Lab personnel autour de **Windows Server 2022** et des principaux services d'infrastructure Microsoft.

## Objectif du lab

Documenter les services Windows Server, leur administration et leur diagnostic dans un parcours d'apprentissage **Systèmes & Réseaux**.

Ce dépôt présente un lab pédagogique Windows Server 2022, et non une infrastructure de production.

## Sommaire

| # | Domaine | Documentation |
|---|---|---|
| 01 | Active Directory Domain Services | [Voir le lab](./01-active-directory/) |
| 02 | DNS & DHCP | [Voir le lab](./02-dns-dhcp/) |
| 03 | Group Policy Objects (GPO) | [Voir le lab](./03-gpo/) |
| 04 | Windows Deployment Services (WDS) | [Voir le lab](./04-wds/) |
| 05 | Utilisateurs, groupes & intégration au domaine | [Voir le lab](./05-users-groups-domain-join/) |

## État du lab

Le dépôt contient des explications, des procédures générales et des exemples de commandes. Les procédures sont documentées ; les validations et preuves d'exécution seront ajoutées progressivement.

Le statut **Documenté** décrit le contenu disponible, sans confirmer sa validation dans le lab. Les prochaines validations restent à réaliser ou à fournir.

| Domaine | Ce qui est documenté | État | Prochaine validation |
|---|---|---|---|
| Active Directory | Rôle AD DS, étapes de promotion et organisation des OU | Documenté | Vérifier le domaine et relever les OU réellement créées |
| DNS | Résolution de noms, cache et commandes de diagnostic | Documenté | Consigner une résolution depuis un client avec le DNS du domaine |
| DHCP | Création d'une étendue, exemple fictif et processus DORA | Documenté | Vérifier un bail et les paramètres reçus par un client |
| Utilisateurs et groupes | Création de comptes, groupes et principes d'attribution des droits | Documenté | Vérifier une appartenance à un groupe et un accès associé |
| Jonction au domaine | Prérequis, étapes de jonction et vérifications de session | Documenté | Confirmer la jonction d'un client et une session de domaine |
| GPO | Création, liaison à une OU et commandes de vérification | Documenté | Tester un paramètre précis et relever son application sur un client |
| WDS | Installation du rôle, images et déroulement PXE | Documenté | Identifier les images utilisées et consigner le résultat d'un déploiement |
| PowerShell | Script `Test-LabConnectivity.ps1` présent ; smoke tests locaux réalisés | À valider dans le lab | Exécuter le script dans le lab Windows Server et consigner les résultats |

## Parcours conseillé

Pour progresser dans le lab, il est conseillé de suivre cet ordre :

1. Active Directory : mettre en place le domaine ;
2. DNS et DHCP : configurer la résolution de noms et l'attribution des paramètres réseau ;
3. Utilisateurs, groupes et jonction au domaine : organiser les comptes et intégrer les postes clients ;
4. GPO : appliquer et vérifier les stratégies sur les utilisateurs et les postes du domaine ;
5. WDS : expérimenter le déploiement de Windows par le réseau.

## Architecture générale

```text
                    Windows Server 2022
                           │
          ┌────────────────┼────────────────┐
          │                │                │
          ▼                ▼                ▼
   Active Directory       DNS             DHCP
          │                │                │
          └────────────────┼────────────────┘
                           │
                           ▼
                     Postes clients
                           │
               ┌───────────┴───────────┐
               │                       │
               ▼                       ▼
              GPO                     WDS
                                       │
                                       ▼
                              Déploiement Windows
```

## Technologies utilisées

- Windows Server 2022
- Active Directory Domain Services
- DNS
- DHCP
- Group Policy Management
- Windows Deployment Services
- Windows clients
- PowerShell
- VirtualBox
- TCP/IP

## Compétences abordées

- installation et configuration de Windows Server ;
- création et administration d'un domaine Active Directory ;
- gestion des utilisateurs, groupes et unités d'organisation ;
- intégration de postes Windows au domaine ;
- configuration et diagnostic DNS ;
- configuration et administration DHCP ;
- création et déploiement de GPO ;
- configuration de Windows Deployment Services ;
- compréhension du démarrage PXE ;
- diagnostic réseau et système ;
- utilisation des outils d'administration Windows.

## Outils de diagnostic

Plusieurs commandes sont présentées dans les différents labs :

```powershell
ipconfig /all
```

```powershell
nslookup
```

```powershell
ping
```

```powershell
whoami
```

```powershell
gpupdate /force
```

```powershell
gpresult /r
```

Ces outils permettent notamment de diagnostiquer les problèmes liés au réseau, au DNS, au domaine et aux stratégies de groupe.

## Scripts PowerShell

Le script [Test-LabConnectivity.ps1](./scripts/Test-LabConnectivity.ps1) fournit un diagnostic en lecture seule : inventaire des interfaces IPv4 actives, passerelle et serveurs DNS, test ICMP, résolution DNS facultative et contrôle de services Windows locaux. Il affiche un résumé `OK / WARNING / ERROR`.

Les paramètres et exemples d'utilisation sont décrits dans la [documentation des scripts](./scripts/README.md).

La syntaxe a été vérifiée sous **Windows PowerShell 5.1** et **PowerShell 7.6.6**. Deux smoke tests locaux ont été réalisés sous PowerShell 7.6.6. La validation fonctionnelle dans le lab Windows Server reste à réaliser.

## Organisation du dépôt

```text
windows-servers-lab/
│
├── 01-active-directory/
│   └── README.md
│
├── 02-dns-dhcp/
│   └── README.md
│
├── 03-gpo/
│   └── README.md
│
├── 04-wds/
│   └── README.md
│
├── 05-users-groups-domain-join/
│   └── README.md
│
└── README.md
```

## Évolution du lab

La documentation sera progressivement enrichie avec :

- captures d'écran ;
- schémas réseau ;
- procédures détaillées ;
- exemples de configuration ;
- scénarios de panne ;
- procédures de dépannage ;
- commandes PowerShell d'administration.

## Objectif professionnel

Ce dépôt fait partie de mon portfolio technique en **Systèmes & Réseaux**. Il présente mon parcours d'apprentissage, avec une attention portée à la documentation et au diagnostic.

---

**Gary Bourinat**  
Systèmes & Réseaux | Cybersécurité  
La Rochelle, France
