# DNS & DHCP

## Objectif

Mettre en place les services DNS et DHCP sous Windows Server 2022 afin d'assurer la résolution de noms et l'attribution automatique des paramètres réseau aux postes clients du domaine.

## Environnement

- Windows Server 2022
- Active Directory
- Service DNS
- Service DHCP
- Postes clients Windows
- VirtualBox
- Réseau local virtualisé

## DNS

Le service DNS est essentiel au fonctionnement d'un domaine Active Directory.

Il permet notamment :

- de résoudre les noms de machines en adresses IP ;
- de localiser les services du domaine ;
- de permettre aux postes clients de trouver le contrôleur de domaine ;
- de faciliter l'administration du réseau.

### Vérifications

-powershell:

ipconfig /all

-(Permet notamment de vérifier le serveur DNS configuré sur la machine.)

nslookup nom-du-serveur

-(Permet de tester la résolution d'un nom DNS.)

ping nom-du-serveur

-(Permet de vérifier la résolution du nom et la connectivité réseau.)

ipconfig /flushdns

-(Vide le cache DNS local d'un poste Windows.)

DHCP

Le service DHCP permet d'attribuer automatiquement les paramètres réseau aux machines clientes.

Les principaux paramètres distribués sont :

adresse IP ;
masque de sous-réseau ;
passerelle par défaut ;
serveur DNS ;
durée du bail DHCP.
Étapes principales

La mise en place du service DHCP comprend notamment :

installation du rôle DHCP ;
autorisation du serveur DHCP dans Active Directory ;
création d'une étendue IPv4 ;
définition de la plage d'adresses distribuées ;
configuration des exclusions si nécessaire ;
définition de la passerelle par défaut ;
configuration du serveur DNS ;
activation de l'étendue ;
test depuis un poste client.
Vérification côté client

Pour demander une nouvelle configuration réseau :

ipconfig /release
ipconfig /renew

Puis :

ipconfig /all

-(permet de vérifier les paramètres reçus depuis le serveur DHCP.)

Diagnostic

En cas de problème, plusieurs éléments doivent être contrôlés :

connectivité entre le client et le serveur ;
configuration de l'étendue DHCP ;
disponibilité des adresses IP ;
serveur DNS distribué aux clients ;
passerelle par défaut ;
état des services DNS et DHCP ;
configuration réseau du poste client.
Compétences mises en pratique
configuration d'un serveur DNS ;
compréhension du rôle du DNS dans Active Directory ;
installation et configuration du rôle DHCP ;
création et gestion d'une étendue DHCP ;
attribution automatique des paramètres réseau ;
diagnostic de problèmes DNS et DHCP ;
utilisation d'outils Windows de diagnostic réseau.
Documentation à venir

Ce dossier sera progressivement complété avec :

captures d'écran de la console DNS ;
captures d'écran de la console DHCP ;
exemple d'étendue IPv4 ;
schéma du réseau ;
scénarios de panne et dépannage.
