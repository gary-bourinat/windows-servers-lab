# DNS & DHCP

## Objectif

Mettre en place les services DNS et DHCP sous Windows Server 2022 afin d'assurer la résolution de noms et l'attribution automatique des paramètres réseau aux postes clients du domaine.

## Environnement

- Windows Server 2022
- Active Directory Domain Services
- DNS
- DHCP
- Postes clients Windows
- VirtualBox
- Réseau local virtualisé

# DNS

## Principe

Le DNS permet d'associer un nom à une adresse IP.

Dans un environnement Active Directory, il joue un rôle essentiel car les postes clients l'utilisent notamment pour localiser le contrôleur de domaine et les différents services associés.

Schéma simplifié :

```text
Poste client
    │
    │ Requête DNS
    ▼
Serveur DNS
    │
    │ Réponse
    ▼
Adresse IP du serveur recherché
```

## Fonctions principales

Le service DNS permet notamment :

- de résoudre les noms de machines en adresses IP ;
- de localiser les services du domaine ;
- de permettre aux postes clients de trouver le contrôleur de domaine ;
- de simplifier l'administration des machines du réseau.

## Vérification de la configuration DNS

```powershell
ipconfig /all
```

Cette commande permet notamment de vérifier :

- l'adresse IP du poste ;
- le serveur DNS utilisé ;
- la passerelle ;
- le suffixe DNS.

## Test de résolution

```powershell
nslookup nom-du-serveur
```

Exemple :

```powershell
nslookup srv-ad01
```

La commande permet de vérifier si le serveur DNS retourne correctement une adresse IP.

## Test de connectivité

```powershell
ping nom-du-serveur
```

Cette commande peut permettre de vérifier à la fois :

- la résolution DNS ;
- la connectivité réseau.

## Gestion du cache DNS

Pour vider le cache DNS local :

```powershell
ipconfig /flushdns
```

Pour afficher le cache DNS :

```powershell
ipconfig /displaydns
```

# DHCP

## Principe

Le DHCP permet d'attribuer automatiquement les paramètres réseau aux machines clientes.

Sans DHCP, chaque machine devrait être configurée manuellement.

Schéma simplifié :

```text
Poste client
    │
    │ Demande DHCP
    ▼
Serveur DHCP
    │
    │ Attribution des paramètres
    ▼
Adresse IP
Masque
Passerelle
DNS
```

## Paramètres distribués

Le serveur DHCP peut notamment fournir :

- une adresse IP ;
- un masque de sous-réseau ;
- une passerelle par défaut ;
- un ou plusieurs serveurs DNS ;
- une durée de bail.

## Mise en place du service DHCP

Les principales étapes comprennent :

1. installation du rôle DHCP ;
2. autorisation du serveur DHCP dans Active Directory ;
3. création d'une étendue IPv4 ;
4. définition de la plage d'adresses distribuées ;
5. définition éventuelle d'exclusions ;
6. configuration de la passerelle ;
7. configuration du serveur DNS ;
8. activation de l'étendue ;
9. test depuis un poste client.

## Exemple d'étendue

Exemple fictif utilisé pour illustrer le fonctionnement :

```text
Réseau        : 192.168.10.0/24
Plage DHCP    : 192.168.10.100 - 192.168.10.200
Passerelle    : 192.168.10.1
Serveur DNS   : 192.168.10.10
```

Ces valeurs sont uniquement utilisées à titre d'exemple pour le lab.

## Vérification côté client

Pour libérer l'adresse IP actuelle :

```powershell
ipconfig /release
```

Pour demander une nouvelle configuration au serveur DHCP :

```powershell
ipconfig /renew
```

Puis :

```powershell
ipconfig /all
```

permet de vérifier les paramètres reçus.

## Processus simplifié DHCP

Lorsqu'un poste client demande une configuration réseau, le processus suit généralement cette logique :

```text
Client
  │
  ├── DHCP Discover
  │
  ▼
Serveur DHCP
  │
  ├── DHCP Offer
  │
  ▼
Client
  │
  ├── DHCP Request
  │
  ▼
Serveur DHCP
  │
  └── DHCP ACK
```

Ce mécanisme est souvent résumé par :

```text
DORA
Discover
Offer
Request
Acknowledgement
```

## Diagnostic DNS

En cas de problème DNS, vérifier notamment :

- le serveur DNS configuré sur le poste ;
- la connectivité avec le serveur ;
- la zone DNS ;
- les enregistrements DNS ;
- la résolution avec `nslookup` ;
- le cache DNS local.

## Diagnostic DHCP

En cas de problème DHCP, vérifier notamment :

- que le service DHCP est démarré ;
- que le serveur est autorisé dans Active Directory ;
- que l'étendue est active ;
- qu'il reste des adresses disponibles ;
- que le client est sur le bon réseau ;
- que la configuration réseau de la machine virtuelle est correcte.

Une adresse automatique du type :

```text
169.254.x.x
```

peut indiquer qu'aucun serveur DHCP n'a répondu au client.

## Compétences mises en pratique

- configuration d'un serveur DNS ;
- compréhension du rôle du DNS dans Active Directory ;
- test de la résolution de noms ;
- installation et configuration du rôle DHCP ;
- création et gestion d'une étendue DHCP ;
- attribution automatique des paramètres réseau ;
- compréhension du processus DORA ;
- diagnostic de problèmes DNS et DHCP ;
- utilisation des commandes réseau Windows.

## Documentation à venir

Ce dossier sera progressivement complété avec :

- captures de la console DNS ;
- captures de la console DHCP ;
- exemple d'étendue IPv4 ;
- zones et enregistrements DNS ;
- schéma complet du réseau ;
- scénarios de panne et dépannage.
