# Automated-OU-Organizer
This PowerShell script allows the interactive creation and organization of Active Directory Organizational Units (OUs), making it easy to manage complex domain structures. Perfect for IT admins looking to automate and standardize OU management.

## 🌟 Features

### AD DS Installation
- **Interactive Setup**: Guided process for installing and configuring Active Directory Domain Services
- **Safe Mode Recovery**: Built-in Directory Services Restore Mode (DSRM) password configuration
- **DNS Integration**: Automatic DNS server installation and configuration
- **Flexible Configuration**: Customizable domain names, NetBIOS names, and directory paths

### OU Organization
- **Hierarchical Structure**: Create multi-level organizational unit hierarchies
- **Location-Based Organization**: Support for multiple geographical locations
- **Department Management**: Easy creation of department-specific OUs
- **Server Environment Organization**: Separate OU structure for different server environments
- **Duplicate Prevention**: Built-in checks to prevent OU naming conflicts
- **Interactive Creation**: User-friendly prompts for OU naming and structure

## 🚀 Benefits

### Efficiency
- **Time Savings**: Reduce deployment time from hours to minutes
- **Automated Structure**: Create complex OU hierarchies in minutes
- **Batch Creation**: Create multiple OUs across locations simultaneously

### Quality & Consistency
- **Error Prevention**: Interactive prompts and validation prevent common configuration mistakes
- **Standardization**: Ensure consistent AD structure across locations
- **Best Practices**: Implements Microsoft-recommended configurations by default

### Flexibility & Maintenance
- **Adaptable Structure**: Easy customization for different organizational needs
- **Scalable Design**: Add new locations and departments as needed
- **Clear Organization**: Logical separation of clients and servers
- **Documentation**: Well-documented code for easy maintenance and modifications

## 📋 Prerequisites

- Windows Server 2016 or later
- PowerShell 5.1 or later
- Administrator privileges
- Minimum system requirements for AD DS:
  - 2GB RAM (4GB recommended)
  - 32GB available disk space
  - x64 processor

## 🛠️ Installation

1. Clone the repository:
```powershell
git clone https://github.com/eugeniogiusti/Automated-OU-Organizer.git
Or download directly the zip file on your server
```

2. Navigate to the script directory:
```powershell
cd Automated-OU-Organizer
```

3. Ensure you have the necessary permissions:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

## 📖 Usage

### AD DS Installation Script

1. Run the AD DS installation script as administrator:
```powershell
.\Install_AD.ps1
```

2. Follow the interactive prompts to configure:
   - Domain name
   - NetBIOS name (optional)
   - DSRM password
   - Directory paths (optional)

3. Wait for the installation to complete and restart when prompted

### OU Organization Script

1. Run the OU organization script as administrator:
```powershell
.\OUAutoBuilder.ps1
```

2. The script will guide you through creating a hierarchical OU structure:
   - First, enter location names (e.g., "NewYork", "London", "Tokyo")
   - For each location, the script creates two main OUs:
     - **Clients**: For organizing department-specific OUs
     - **Servers**: For organizing server environment OUs
   
3. For each location, you can:
   - Add multiple departments under the Clients OU
   - Add multiple server environments under the Servers OU
   - Press Enter without input to move to the next section

Example structure created:
```
Domain
├── Location1
│   ├── OU_Clients
│   │   ├── HR
│   │   ├── Finance
│   │   └── IT
│   └── OU_Servers
│       ├── Production
│       ├── Development
│       └── Testing
└── Location2
    ├── OU_Clients
    │   └── ...
    └── OU_Servers
        └── ...
```

The script includes built-in checks to:
- Prevent duplicate OU creation
- Validate OU names
- Provide feedback on creation status
- Handle existing OUs gracefully

## 🏗️ Default Configuration

The scripts use the following default paths:
- AD Database: `C:\Windows\NTDS`
- AD Logs: `C:\Windows\NTDS`
- SYSVOL: `C:\Windows\SYSVOL`

Domain functional level: Windows Server 2016 (WinThreshold)

## ⚠️ Important Notes

- Always backup existing AD configuration before making changes
- Test in a non-production environment first
- Review and modify default paths if needed
- Ensure proper network connectivity
- Plan your OU structure before deployment

## 🔒 Security Considerations

- Use strong passwords for DSRM
- Follow the principle of least privilege
- Regular backup of AD database
- Monitor event logs after installation
- Implement proper Group Policy Objects (GPOs)

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.
