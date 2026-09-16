<#
.SYNOPSIS
Affiche un diagnostic reseau et des services locaux, en lecture seule.
.DESCRIPTION
Controle la configuration IPv4 locale, la reponse ICMP d'une cible,
la resolution DNS facultative et les services locaux demandes.
Aucune configuration n'est modifiee et aucun fichier n'est cree.
Un succes ne valide pas a lui seul Active Directory, DNS ou tout le lab.
Concu pour Windows PowerShell 5.1 et PowerShell 7 sous Windows.
.PARAMETER TargetHost
Nom ou adresse de la machine a tester par ICMP. Obligatoire.
.PARAMETER DnsName
Nom a resoudre avec les serveurs DNS configures sur la machine locale.
Sans ce parametre, le test DNS est ignore.
.PARAMETER ServiceName
Zero, un ou plusieurs noms exacts de services de la machine locale.
Ces services ne sont pas interroges sur TargetHost.
.EXAMPLE
.\Test-LabConnectivity.ps1 -TargetHost '<CIBLE_DU_LAB>'
Remplacer le placeholder par une cible reelle du lab.
.EXAMPLE
.\Test-LabConnectivity.ps1 -TargetHost '<CIBLE_DU_LAB>' -DnsName '<NOM_DNS_A_RESOUDRE>' -ServiceName '<NOM_SERVICE_LOCAL>'
Remplacer tous les placeholders avant execution.
#>

#requires -Version 5.1

[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [ValidatePattern('\S')]
    [string]$TargetHost,

    [ValidateNotNullOrEmpty()]
    [ValidatePattern('\S')]
    [string]$DnsName,

    [string[]]$ServiceName = @()
)

$counts = @{ OK = 0; WARNING = 0; ERROR = 0 }

function Write-Result {
    param (
        [ValidateSet('OK', 'WARNING', 'ERROR')]
        [string]$Status,
        [string]$Message
    )
    $counts[$Status]++
    Write-Host ('[{0}] {1}' -f $Status, $Message)
}

function Write-Summary {
    Write-Host ('Resume : {0} OK | {1} WARNING | {2} ERROR' -f
        $counts.OK, $counts.WARNING, $counts.ERROR)
    Write-Host 'Les controles facultatifs ignores ne sont pas comptes.'
    Write-Host 'Ces observations ne valident pas a elles seules AD, DNS ou le lab.'
}

Write-Host ('Machine locale : {0}' -f [Environment]::MachineName)
Write-Host ('PowerShell : {0}' -f $PSVersionTable.PSVersion)

if ([Environment]::OSVersion.Platform -ne [PlatformID]::Win32NT) {
    Write-Result ERROR 'Ce script necessite Windows.'
    Write-Summary
    return
}

try {
    # -All inclut les interfaces virtuelles ; seules celles actives avec IPv4 sont retenues.
    $interfaces = @(Get-NetIPConfiguration -All -ErrorAction Stop |
        Where-Object { $_.NetAdapter.Status -eq 'Up' -and $_.IPv4Address })

    if ($interfaces.Count -eq 0) {
        Write-Result WARNING 'Aucune interface active avec une adresse IPv4 trouvee.'
    }
    foreach ($interface in $interfaces) {
        $addresses = @($interface.IPv4Address | ForEach-Object {
            '{0}/{1}' -f $_.IPAddress, $_.PrefixLength
        })
        Write-Result OK ('Interface {0} : IPv4 {1}' -f
            $interface.InterfaceAlias, ($addresses -join ', '))

        $gateways = @($interface.IPv4DefaultGateway | ForEach-Object {
            $_.NextHop
        } | Where-Object { $_ })
        if ($gateways.Count -gt 0) {
            Write-Result OK ('Passerelle IPv4 : {0}' -f ($gateways -join ', '))
        }
        else {
            Write-Result WARNING 'Pas de passerelle IPv4 ; cela peut etre normal sur un reseau isole.'
        }

        $dnsServers = @($interface.DNSServer | ForEach-Object {
            $_.ServerAddresses
        } | Where-Object { $_ } | Select-Object -Unique)
        if ($dnsServers.Count -gt 0) {
            Write-Result OK ('Serveurs DNS configures : {0}' -f ($dnsServers -join ', '))
        }
        else {
            Write-Result WARNING 'Aucun serveur DNS configure sur cette interface.'
        }
    }
}
catch {
    Write-Result ERROR ('Lecture des interfaces impossible : {0}' -f $_.Exception.Message)
}

try {
    # L'argument positionnel evite la difference ComputerName/TargetName entre versions.
    $reachable = Test-Connection $TargetHost -Count 2 -Quiet -ErrorAction Stop
    if ($reachable) {
        Write-Result OK ('Reponse ICMP recue de {0}.' -f $TargetHost)
    }
    else {
        Write-Result WARNING ('Aucune reponse ICMP de {0}. ICMP peut etre filtre ; cela ne prouve pas une panne.' -f $TargetHost)
    }
}
catch {
    Write-Result ERROR ('Test ICMP impossible pour {0} : {1}' -f $TargetHost, $_.Exception.Message)
}

if ($PSBoundParameters.ContainsKey('DnsName')) {
    try {
        $records = @(Resolve-DnsName -Name $DnsName -DnsOnly -ErrorAction Stop)
        if ($records.Count -gt 0) {
            Write-Result OK ('Resolution de {0} : {1} enregistrement(s).' -f $DnsName, $records.Count)
            $records | Format-Table Name, Type, IPAddress, NameHost -AutoSize | Out-Host
        }
        else {
            Write-Result WARNING ('Aucun enregistrement retourne pour {0}.' -f $DnsName)
        }
    }
    catch {
        Write-Result ERROR ('Resolution DNS impossible pour {0} : {1}' -f $DnsName, $_.Exception.Message)
    }
}
else {
    Write-Host 'Resolution DNS ignoree : DnsName non fourni.'
}

if (@($ServiceName).Count -eq 0) {
    Write-Host 'Controle des services ignore : aucun ServiceName fourni.'
}
foreach ($name in $ServiceName) {
    if ([string]::IsNullOrWhiteSpace($name)) {
        Write-Result ERROR 'Nom de service vide : fournir un nom exact de service local.'
        continue
    }
    try {
        # Get-Service accepte les jokers ; les echapper conserve un nom exact.
        $service = Get-Service -Name ([WildcardPattern]::Escape($name)) -ErrorAction Stop
        if ($service.Status -eq 'Running') {
            Write-Result OK ('Service local {0} : {1}' -f $name, $service.Status)
        }
        else {
            Write-Result WARNING ('Service local {0} : {1}. Verifier si cet etat est attendu.' -f $name, $service.Status)
        }
    }
    catch {
        Write-Result ERROR ('Lecture du service local {0} impossible : {1}' -f $name, $_.Exception.Message)
    }
}

Write-Summary
