# Installation of Active Directory

# Function verify Admin permissions
function Test-Administrator {
    $currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

# Verify Administrative privilege
if (-not (Test-Administrator)) {
    Write-Error "Admin privilege to execute the script!"
    Exit 1
}

# Function domain_name
function Test-DomainName {
    param([string]$DomainName)
    return $DomainName -match "^[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9](\.[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9])*$"
}

# Request parameters
do {
    $domainName = Read-Host "Insert your domain name (es. contoso.local)"
} while (-not (Test-DomainName $domainName))

do {
    $netbiosName = Read-Host "Insert your NetBios name (max 15 caracthers)"
} while ($netbiosName.Length -gt 15 -or $netbiosName.Length -eq 0)

$safeModePassword = Read-Host "Insert your passowrd for DSRM" -AsSecureString
$confirmPassword = Read-Host "Confirm password for DSRM" -AsSecureString

$pwdString = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($safeModePassword))
$confirmString = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($confirmPassword))

if ($pwdString -ne $confirmString) {
    Write-Error "Password doesn't match!"
    Exit 1
}

# Installation AD DS
try {
    Write-Host "Installation Active Directory Domain Services..."
    Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

    # Verify of that
    $addsFeature = Get-WindowsFeature -Name AD-Domain-Services
    if (-not $addsFeature.Installed) {
        throw "Failure AD  DS installation!"
    }

    Write-Host "Configuring new domain..."
    Import-Module ADDSDeployment

    # Configuration new domain
    $params = @{
        CreateDnsDelegation = $false
        DatabasePath = "C:\Windows\NTDS"
        DomainMode = "WinThreshold"
        DomainName = $domainName
        DomainNetbiosName = $netbiosName
        ForestMode = "WinThreshold"
        InstallDns = $true
        LogPath = "C:\Windows\NTDS"
        NoRebootOnCompletion = $false
        SafeModeAdministratorPassword = $safeModePassword
        SysvolPath = "C:\Windows\SYSVOL"
        Force = $true
    }

    Install-ADDSForest @params

    Write-Host "Installation complete! The server is gonna be rebooting automatically."
}
catch {
    Write-Error "Error: $_"
    Exit 1
}
