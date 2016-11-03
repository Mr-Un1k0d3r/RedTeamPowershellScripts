# Powershell Script
```
Search-EventForUser.ps1: Powershell script that search through the Windows event logs for specific user
Remote-WmiExecute.ps1: Execute command remotely using WMI
```

# Search-EventForUser Usage
```
module-import .\Search-EventForUser.ps1; Search-EventForUser -User MrUn1k0d3r

module-import .\Search-EventForUser.ps1; Search-EventForUser -User MrUn1k0d3r -ComputerName DC01

module-import .\Search-EventForUser.ps1; $ips = @('DC01', 'DC02'); foreach($ip in $ips) {
  Search-EventForUser -User MrUn1k0d3r -ComputerName $ip 
}
```

# Remote-WmiExecute.ps1 Usage
```
module-import .\Remote-WmiExecute.ps1.ps1; Remote-WmiExecute.ps1 -ComputerName victim01 -Payload "cmd.exe /c whoami"
```

# Todo

1. Search-EventForUser.ps1:
⋅⋅*Add an option to fetch all the DCs
⋅⋅*Search for multiple users at the same time
⋅⋅*Parse the output and make it more readable
2. Remote-WmiExecute.ps1:
⋅⋅*Improve error handling (Access Denied etc...)

# Credit
Charles F. Hamilton Aka Mr.Un1k0d3r RingZer0 Team
