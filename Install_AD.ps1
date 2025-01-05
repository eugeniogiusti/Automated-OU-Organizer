# Function to read non-empty input (requires domain name)
function Read-NonEmptyInput {
    param (
        [string]$prompt,
        [string]$default
    )

    $input = Read-Host "$prompt (default: $default)"
    if ([string]::IsNullOrWhiteSpace($input)) {
        $input = $default
    }
    return $input
}

# Function to obtain secure password
function Get-SecurePassword {
    param (
        [string]$prompt
    )
    Write-Host $prompt -ForegroundColor Yellow
    $password = Read-Host -AsSecureString
    return $password
}

# Ask domain
$domainName = Read-NonEmptyInput "Enter the domain name" "mycompany.local"

# Ask netbios
$netbiosName = Read-NonEmptyInput "Enter the NetBIOS name (leave blank for default)" ""

# Ask password for Directory Services Restore Mode (DSRM)
$dsrmPassword = Get-SecurePassword "Enter the password for Directory Services Restore Mode (DSRM)"

# Level of functionality
$domainFunctionalLevel = "Win2016" # Impostazione predefinita a Windows Server 2016

# Configure path of database, log and SYSVOL (default C:\Windows)
$databasePath = "C:\Windows\NTDS"
$logPath = "C:\Windows\NTDS"
$sysvolPath = "C:\Windows\SYSVOL"

# Argoments installation AD
$installArgs = @{
    DomainName                   = $domainName
    DomainNetBIOSName            = if ($netbiosName -eq "") { $domainName.Split('.')[0].ToUpper() } else { $netbiosName.ToUpper() }
    DatabasePath                 = $databasePath
    LogPath                      = $logPath
    SysvolPath                   = $sysvolPath
    SafeModeAdministratorPassword = $dsrmPassword
    Force                        = $true
    NoRebootOnCompletion         = $true
    InstallDNS                   = $true                   # Install DNS
    CreateDNSDelegation          = $false                  # Disable delegation DNS
    DomainMode                   = $domainFunctionalLevel # Domain functionality
}

# Install Active Directory Domain Services
try {
    Write-Host "Starting the Active Directory Domain Services installation..." -ForegroundColor Green
    Install-ADDSForest @installArgs
    Write-Host "Installation completed successfully." -ForegroundColor Green
}
catch {
    Write-Host "Error during installation: $_" -ForegroundColor Red
}

# Note: Please reboot the system
Write-Host "Reboot the system to apply changes." -ForegroundColor Cyan
