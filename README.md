# Windows Server Lab

Lab personnel autour de **Windows Server 2022** et des principaux services d'infrastructure Microsoft.

L'objectif de ce dépôt est de documenter une infrastructure Windows Server, son administration et les procédures de diagnostic associées.

## Sommaire

| # | Domaine | Documentation |
|---|---|---|
| 01 | Active Directory Domain Services | [Voir le lab](./01-active-directory/) |
| 02 | DNS & DHCP | [Voir le lab](./02-dns-dhcp/) |
| 03 | Group Policy Objects (GPO) | [Voir le lab](./03-gpo/) |
| 04 | Windows Deployment Services (WDS) | [Voir le lab](./04-wds/) |
| 05 | Utilisateurs, groupes & intégration au domaine | [Voir le lab](./05-users-groups-domain-join/) |

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

## Compétences mises en pratique

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

Plusieurs commandes sont utilisées dans les différents labs :

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

Ce dépôt fait partie de mon portfolio technique et présente des compétences pratiques en administration **Systèmes & Réseaux**, avec une attention particulière portée à la compréhension de l'infrastructure, à la documentation et au diagnostic.

---

**Gary Bourinat**  
Systèmes & Réseaux | Cybersécurité  
La Rochelle, France
