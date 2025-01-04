# Interactive script to install Active Directory Domain Services (AD DS)

# Check if the script is running with administrator privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "This script must be run with administrator privileges." -ForegroundColor Red
    exit
}

# Function to read user input
function Read-Input($prompt, $default = "") {
    if ($default -ne "") {
        $prompt += " [$default]: "
    } else {
        $prompt += ": "
    }
    $input = Read-Host $prompt
    return if ($input -eq "" -and $default -ne "") { $default } else { $input }
}

# Install the AD DS role
Write-Host "Installing the Active Directory Domain Services role..." -ForegroundColor Green
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools -Verbose

Write-Host "The role was successfully installed." -ForegroundColor Green

# Prompt for new forest and domain creation details
$domainName = Read-Input "Enter the domain name (e.g., example.com)"
$netbiosName = Read-Input "Enter the NetBIOS name (leave blank for default)" ""
$password = Read-Input "Enter the password for Directory Services Restore Mode (DSRM)"

# Confirm the domain functional level
$domainLevel = "WinThreshold"
Write-Host "The domain functional level will be set to Windows Server 2016 (default)." -ForegroundColor Yellow

# Configure the new forest and domain
Write-Host "Configuring the new forest and domain..." -ForegroundColor Green
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force

# Define installation parameters
$installArgs = @{
    DomainName         = $domainName
    DomainNetBIOSName  = if ($netbiosName -eq "") { $domainName.Split('.')[0].ToUpper() } else { $netbiosName.ToUpper() }
    DatabasePath       = "C:\Windows\NTDS"       # Default path for the AD database
    LogPath            = "C:\Windows\NTDS"       # Default path for AD logs
    SysvolPath         = "C:\Windows\SYSVOL"     # Default path for SYSVOL
    SafeModeAdministratorPassword = $securePassword
    Force              = $true
    NoRebootOnCompletion = $true
    InstallDNS         = $true                   # Install the DNS server
    CreateDNSDelegation = $false                 # Disable DNS delegation
}

# Run the AD DS installation
Install-ADDSForest @installArgs

Write-Host "Configuration completed. Restart the system to finalize the installation." -ForegroundColor Green
