# Script per l'installazione automatizzata di Active Directory Domain Services
# Richiede privilegi di amministratore per essere eseguito

# Funzione per verificare se lo script è eseguito come amministratore
function Test-Administrator {
    $currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

# Verifica privilegi amministrativi
if (-not (Test-Administrator)) {
    Write-Error "Lo script deve essere eseguito come amministratore!"
    Exit 1
}

# Funzione per validare il nome del dominio
function Test-DomainName {
    param([string]$DomainName)
    return $DomainName -match "^[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9](\.[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9])*$"
}

# Richiesta parametri all'utente
do {
    $domainName = Read-Host "Inserisci il nome del dominio (es. contoso.local)"
} while (-not (Test-DomainName $domainName))

do {
    $netbiosName = Read-Host "Inserisci il nome NetBIOS del dominio (max 15 caratteri)"
} while ($netbiosName.Length -gt 15 -or $netbiosName.Length -eq 0)

$safeModePassword = Read-Host "Inserisci la password per la modalità provvisoria (DSRM)" -AsSecureString
$confirmPassword = Read-Host "Conferma la password per la modalità provvisoria (DSRM)" -AsSecureString

$pwdString = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($safeModePassword))
$confirmString = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($confirmPassword))

if ($pwdString -ne $confirmString) {
    Write-Error "Le password non corrispondono!"
    Exit 1
}

# Installazione del ruolo AD DS
try {
    Write-Host "Installazione del ruolo Active Directory Domain Services..."
    Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

    # Verifica che l'installazione sia andata a buon fine
    $addsFeature = Get-WindowsFeature -Name AD-Domain-Services
    if (-not $addsFeature.Installed) {
        throw "Installazione del ruolo AD DS fallita!"
    }

    Write-Host "Configurazione del nuovo dominio..."
    Import-Module ADDSDeployment

    # Configurazione del nuovo dominio
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

    Write-Host "Installazione completata con successo! Il server verrà riavviato automaticamente."
}
catch {
    Write-Error "Si è verificato un errore durante l'installazione: $_"
    Exit 1
}
