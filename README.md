# Red Team Powershell Scripts

```
Search-EventForUser.ps1: Powershell script that search through the Windows event logs for specific user(s)
Remote-WmiExecute.ps1: Execute command remotely using WMI
Take-Screenshot.ps1: Take a screenshot (PNG)
Get-BrowserHomepage.ps1: Get browser homepage
Search-FullNameToSamAccount.ps1: Full name to SamAccountName
```

# Search-EventForUser.ps1 Usage
```
module-import .\Search-EventForUser.ps1; Search-EventForUser -User "MrUn1k0d3r"

module-import .\Search-EventForUser.ps1; "MrUn1k0d3r" | Search-EventForUser

module-import .\Search-EventForUser.ps1; Search-EventForUser -User MrUn1k0d3r -ComputerName DC01

module-import .\Search-EventForUser.ps1; $ips = @('DC01', 'DC02'); foreach($ip in $ips) {
  Search-EventForUser -User MrUn1k0d3r -ComputerName $ip 
}
```
The -User parameter support single user list of users from pipeline

# Remote-WmiExecute.ps1 Usage
```
module-import .\Remote-WmiExecute.ps1; Remote-WmiExecute -ComputerName victim01 -Payload "cmd.exe /c whoami"
```

# Take-Screenshot.ps1 Usage
```
module-import .\Take-Screenshot.ps1; Take-Screenshot -Path C:\test.png
```

# Get-BrowserHomepage.ps1 Usage
```
module-import .\Get-BrowserHomepage.ps1; Get-BrowserHomepage
```
# Search-FullNameToSamAccount.ps1 Usage
```
module-import .\Search-FullNameToSamAccount.ps1; FullNameToSamAccount -Filter *god*
```

# Todo

1. Search-EventForUser.ps1:
  * Add an option to fetch all the DCs
  * Search for multiple users at the same time
  * Parse the output and make it more readable
2. Remote-WmiExecute.ps1:
  * Improve errors handling (Access Denied etc...)
3. Take-Screenshot.ps1:
  * Handle multiple screens

# Credit
Charles F. Hamilton Aka Mr.Un1k0d3r RingZer0 Team
