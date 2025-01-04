# Import the Active Directory module
Import-Module ActiveDirectory

function Check-OUExistence {
    param (
        [string]$OUName,
        [string]$ParentDN
    )
    $FullDN = "OU=$OUName,$ParentDN"
    return (Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$FullDN'" -ErrorAction SilentlyContinue) -ne $null
}

function Create-OU {
    param (
        [string]$OUName,
        [string]$ParentDN
    )
    if (Check-OUExistence -OUName $OUName -ParentDN $ParentDN) {
        Write-Host "The OU '$OUName' already exists under '$ParentDN'." -ForegroundColor Yellow
    } else {
        $FullDN = "OU=$OUName,$ParentDN"
        New-ADOrganizationalUnit -Name $OUName -Path $ParentDN
        Write-Host "OU '$OUName' successfully created under '$ParentDN'." -ForegroundColor Green
    }
}

function Process-OU {
    param (
        [string]$ParentDN
    )

    # Create OU_Clients
    $ClientsOU = "Clients"
    Create-OU -OUName $ClientsOU -ParentDN $ParentDN
    $ClientsDN = "OU=$ClientsOU,$ParentDN"

    while ($true) {
        $DeptName = Read-Host "Enter the name of the department to create under 'Clients' (leave blank to finish)"
        if ([string]::IsNullOrWhiteSpace($DeptName)) { break }
        Create-OU -OUName $DeptName -ParentDN $ClientsDN
    }

    # Create OU_Servers
    $ServersOU = "Servers"
    Create-OU -OUName $ServersOU -ParentDN $ParentDN
    $ServersDN = "OU=$ServersOU,$ParentDN"

    while ($true) {
        $ServerName = Read-Host "Enter the name of the server environment to create under 'Servers' (leave blank to finish)"
        if ([string]::IsNullOrWhiteSpace($ServerName)) { break }
        Create-OU -OUName $ServerName -ParentDN $ServersDN
    }
}

# Start script
$DomainDN = (Get-ADDomain).DistinguishedName

while ($true) {
    $LocationName = Read-Host "Enter the name of the location (leave blank to finish)"
    if ([string]::IsNullOrWhiteSpace($LocationName)) { break }

    # Create the location OU
    Create-OU -OUName $LocationName -ParentDN $DomainDN
    $LocationDN = "OU=$LocationName,$DomainDN"

    # Process OUs for Clients and Servers
    Process-OU -ParentDN $LocationDN
}

Write-Host "Script completed. All OUs have been created." -ForegroundColor Cyan