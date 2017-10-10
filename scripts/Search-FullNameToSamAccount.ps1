function Search-FullNameToSamAccount {
	# Mr.Un1k0d3r - RingZer0 Team 2017
	# Get SamAccountName using displayname property search
	param(
		[Parameter(Mandatory=$True, ValueFromPipeline=$true)]
		[string]$Filter
	)

	BEGIN {
		$Users = @()
		Write-Output "[*] Searching for $($Filter)"
	}

	PROCESS {
		$Query = "(&(objectCategory=User)(displayName=*$($Filter)*))"
		$Domain = New-Object System.DirectoryServices.DirectoryEntry

		$DirSearch = New-Object System.DirectoryServices.DirectorySearcher
		$DirSearch.SearchRoot = $Domain
		$DirSearch.PageSize = 100
		$DirSearch.Filter = $Query
		$DirSearch.SearchScope = "Subtree"

		ForEach($Item in $DirSearch.FindAll()) {
			$User = $Item.Properties
			$Output = New-Object -TypeName PSObject -Property @{
				Name = $User.givenname[0]
				SamAccount = $User.samaccountname[0]
				Department = $User.department[0]
				Description = $User.description[0]
			}

			$Users += $Output
		}

		$Users | Format-Table -Wrap -AutoSize
	}

	END {
		Write-Output "[*] Process completed..."
	}
}
