function Search-FullNameToSamAccount {
	# Mr.Un1k0d3r - RingZer0 Team 2017
	# Get SamAccountName using displayname property search
	
	param(
		[Parameter(Mandatory=$True, ValueFromPipeline=$True)]
		[string]$Filter,
		[Parameter(Mandatory=$False)]
		[string]$Domain = "",
		[Parameter(Mandatory=$False)]
		[switch]$SamOnly = $False
	)

	BEGIN {
		$Users = @()
	}

	PROCESS {
		ForEach($User in $Filter) {
			Write-Output "[*] Searching for $($User)"
			$Query = "(&(objectCategory=User)(displayName=*$($User)*))"
			if($Domain -eq "") {
				$Domain = New-Object System.DirectoryServices.DirectoryEntry
			}
			$DirSearch = New-Object System.DirectoryServices.DirectorySearcher
			$DirSearch.SearchRoot = $Domain
			$DirSearch.PageSize = 100
			$DirSearch.Filter = $Query
			$DirSearch.SearchScope = "Subtree"

			ForEach($Item in $DirSearch.FindAll()) {
				$Data = $Item.Properties
				If($SamOnly) {
					$Output = New-Object -TypeName PSObject -Property @{
						Name = $Data.givenname[0]
						SamAccount = $Data.samaccountname[0]
					}	
				} Else {
					$Output = New-Object -TypeName PSObject -Property @{
						Name = $Data.givenname[0]
						SamAccount = $Data.samaccountname[0]
						Department = $Data.department[0]
						Description = $Data.description[0]
					}				
				}

				$Users += $Output
			}
			$Users | Format-Table -Wrap -AutoSize
			$Users = @()
		}
		
	}

	END {
		Write-Output "[*] Process completed..."
	}
}
