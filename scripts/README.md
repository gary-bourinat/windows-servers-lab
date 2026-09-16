# Scripts PowerShell du lab

## Test-LabConnectivity.ps1

Ce script fournit un diagnostic de base d'une machine Windows du lab. Il affiche :

- le nom de la machine locale et la version de PowerShell ;
- les interfaces actives avec une adresse IPv4, leur passerelle IPv4 et leurs serveurs DNS ;
- le résultat d'un test ICMP vers la cible fournie ;
- une résolution DNS facultative ;
- l'état des services locaux demandés ;
- un résumé des observations `[OK]`, `[WARNING]` et `[ERROR]`.

Le script fonctionne en lecture seule : aucune installation, modification de configuration ou création de fichier. Les tests ICMP et DNS peuvent émettre des requêtes réseau.

## Prérequis et compatibilité

- Windows avec Windows PowerShell 5.1 ou PowerShell 7.
- Cmdlets `Get-NetIPConfiguration`, `Test-Connection`, `Resolve-DnsName` et `Get-Service` disponibles pour les contrôles concernés.
- Les tests de base sont conçus pour une session sans privilèges administrateur. Une restriction d'accès est signalée sans tentative d'élévation.

La compatibilité fonctionnelle reste à vérifier dans le lab sur les deux versions. Une commande indisponible ou une erreur de lecture est signalée ; les contrôles suivants continuent. Le script ne change pas la stratégie d'exécution PowerShell.

## Paramètres

| Paramètre | Obligatoire | Rôle |
|---|---|---|
| `TargetHost` | Oui | Nom ou adresse de la cible du test ICMP |
| `DnsName` | Non | Nom à résoudre avec `Resolve-DnsName -DnsOnly` et la configuration DNS locale |
| `ServiceName` | Non | Zéro, un ou plusieurs noms exacts de services locaux, et non leurs noms d'affichage |

`ServiceName` contrôle la machine qui exécute le script, pas `TargetHost`. Aucun service n'est démarré, arrêté ou redémarré. Sans `DnsName`, la résolution explicite est ignorée ; une cible ICMP fournie sous forme de nom peut toutefois nécessiter une résolution.

## Exemples

Depuis la racine du dépôt, remplacer chaque placeholder entre chevrons par une valeur réelle du lab avant exécution. Ces exemples ne décrivent aucune configuration existante.

Configuration locale et connectivité vers une cible :

```powershell
.\scripts\Test-LabConnectivity.ps1 -TargetHost '<CIBLE_DU_LAB>'
```

Ajouter une résolution DNS :

```powershell
.\scripts\Test-LabConnectivity.ps1 -TargetHost '<CIBLE_DU_LAB>' -DnsName '<NOM_DNS_A_RESOUDRE>'
```

Ajouter le contrôle de deux services locaux :

```powershell
.\scripts\Test-LabConnectivity.ps1 -TargetHost '<CIBLE_DU_LAB>' -DnsName '<NOM_DNS_A_RESOUDRE>' -ServiceName '<SERVICE_LOCAL_1>', '<SERVICE_LOCAL_2>'
```

L'aide intégrée est accessible avec `Get-Help .\scripts\Test-LabConnectivity.ps1 -Full`.

## Lecture des résultats et limites

- `[OK]` : information lue ou contrôle réussi, sans validation globale du lab.
- `[WARNING]` : observation à interpréter, par exemple absence de réponse ICMP, de passerelle ou service non démarré.
- `[ERROR]` : contrôle en échec ou impossible, par exemple résolution DNS en erreur, service absent ou accès refusé.

Le résumé compte les observations affichées : une interface peut produire plusieurs résultats. Les contrôles facultatifs ignorés et les informations d'identification ne sont pas comptés. Le script affiche un rapport destiné à la lecture humaine et ne définit pas de code de sortie pour une automatisation.

Une réponse ICMP ne valide pas les services de la cible. Une interface active ne garantit pas son accès au réseau. Une résolution réussie ne valide pas toute l'infrastructure DNS ni Active Directory. Un service arrêté peut correspondre à la configuration attendue.

Aucun résultat réel du lab n'est fourni ici. Les exécutions et leurs preuves restent à réaliser et à documenter.
