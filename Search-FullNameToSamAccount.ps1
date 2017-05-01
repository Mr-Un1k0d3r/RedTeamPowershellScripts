function Search-FullNameToSamAccount {
	# Mr.Un1k0d3r - RingZer0 Team 2017
	# Get SamAccountName using Full name search
	# dependencies ActiveDirectory module
	
	param(
		[Parameter(Mandatory=$True, ValueFromPipeline=$true)]
		[string]$Filter
	)
  
	BEGIN {
		$module = Get-Module -List ActiveDirectory
		if($module) {
			Import-Module ActiveDirectory
		} else {
			throw "[-] ERROR: ActiveDirectory cannot be imported. Aborting..."
		}
		Write-Host "[*] Searching for $($Filter)"
	}
	
	PROCESS {
        	$Users = Get-ADUser -Filter{displayName -like $Filter -and Enabled -eq $True} -Properties SamAccountName, displayName
		ForEach($user in $Users) {
			Write-Host "[+] Found: $($user.displayName) -> $($user.SamAccountName)"
		}
	}
	
	END {
		Write-Host "[*] Process completed..."
	}
}
