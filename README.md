# Automated-OU-Organizer
This PowerShell script allows the interactive creation and organization of Active Directory Organizational Units (OUs), making it easy to manage complex domain structures. Perfect for IT admins looking to automate and standardize OU management.

# Automated-OU-Organizer

A comprehensive PowerShell automation solution for deploying and organizing Active Directory Domain Services (AD DS). This repository contains scripts that streamline the process of setting up AD DS and creating a well-structured organizational unit hierarchy.

## 🌟 Features

- **Interactive AD DS Installation**: Guided setup process for installing and configuring Active Directory Domain Services
- **Automated OU Organization**: Create and manage organizational units with predefined or custom structures
- **Safe Mode Recovery**: Built-in Directory Services Restore Mode (DSRM) password configuration
- **DNS Integration**: Automatic DNS server installation and configuration
- **Flexible Configuration**: Customizable domain names, NetBIOS names, and directory paths

## 🚀 Benefits

- **Time Savings**: Reduce deployment time from hours to minutes
- **Error Prevention**: Interactive prompts and validation prevent common configuration mistakes
- **Standardization**: Ensure consistent AD deployment across multiple environments
- **Best Practices**: Implements Microsoft-recommended configurations by default
- **Flexibility**: Easy customization for different organizational needs
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
git clone https://github.com/YourUsername/Automated-OU-Organizer.git
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
.\Install-ADDS.ps1
```

2. Follow the interactive prompts to configure:
   - Domain name
   - NetBIOS name (optional)
   - DSRM password
   - Directory paths (optional)

3. Wait for the installation to complete and restart when prompted

### OU Organization Script

[Add specific instructions for your OU organization script here]

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

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📧 Contact

Your Name - [Your Email]
Project Link: [https://github.com/YourUsername/Automated-OU-Organizer](https://github.com/YourUsername/Automated-OU-Organizer)

## 🙏 Acknowledgments

- Microsoft Active Directory documentation
- PowerShell community
- All contributors who help improve this project
