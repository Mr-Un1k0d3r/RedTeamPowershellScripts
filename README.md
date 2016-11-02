# Powershell-Search-EventForUser

Powershell script that search through the Windows event logs for specific user

# Usage
```
module-import .\Search-EventForUser.ps1; Search-EventForUser -User MrUn1k0d3r

module-import .\Search-EventForUser.ps1; Search-EventForUser -User MrUn1k0d3r -ComputerName DC01

module-import .\Search-EventForUser.ps1; $ips = @('DC01', 'DC02'); foreach($ip in $ips) { Search-EventForUser -User MrUn1k0d3r -ComputerName $ip }
```

# Todo
Add an option to fetch all the DCs
Search for multiple users at the same time
Parse the output and make it more readable

# Credit
Charles F. Hamilton Aka Mr.Un1k0d3r RingZer0 Team
