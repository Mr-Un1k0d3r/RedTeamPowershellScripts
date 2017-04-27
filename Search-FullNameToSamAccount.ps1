Import-Module ActiveDirectory

function Search-FullNameToSamAccount {
	# Mr.Un1k0d3r - RingZer0 Team 2016
	# Get SamAccountName using Full name search
	# Need ActiveDirectory module
	
	param(
		[Parameter(Mandatory=$True, ValueFromPipeline=$true)]
		[string]$Filter
	)
  
	BEGIN {
		Write-Host "Searching for $($Filter)"
	}
	
	PROCESS {
        $Users = Get-ADUser -Filter{displayName -like $Filter -and Enabled -eq $True} -Properties SamAccountName
    		ForEach($user in $Users) {
			Write-Host $user.SamAccountName
        	}
	}
	
	END {
		Write-Host "[+] Process completed..."
	}
}
