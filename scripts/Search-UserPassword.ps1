
function Ldap-GetProperty {
	param(
	[Parameter(Mandatory=$True, ValueFromPipeline=$True)]
	[string]$Filter,
	[Parameter(Mandatory=$True)]
	[string]$Property
	)
	
	BEGIN {
		$Output = @()
	}
	
	PROCESS {
		$Domain = New-Object System.DirectoryServices.DirectoryEntry

		$DirSearch = New-Object System.DirectoryServices.DirectorySearcher
		$DirSearch.SearchRoot = $Domain
		$DirSearch.PageSize = 100
		$DirSearch.Filter = $Filter
		$DirSearch.SearchScope = "Subtree"	
		
		ForEach($Item in $DirSearch.FindAll()) {
			$Data = $Item.Properties
			Try {
			$Element = New-Object -TypeName PSObject -Property @{
				$Property = $Data.$Property[0]
			}

			$Output += $Element		
			} Catch {
				Write-Output "[-] Property not found"
			}
		}
		return $Output
	}
	
}

function Search-UserPassword {
	
	param(
	[Parameter(Mandatory=$True, ValueFromPipeline=$True)]
	[string]$UserName
	)
	
	BEGIN {
	
	}
	
	PROCESS {
		ForEach($User in $UserName) {
			Write-Output "[*] $($User)"
			Ldap-GetProperty -Filter "(&(objectCategory=User)(samaccountname=*$($User)*))" -Property "userpassword" | Format-Table -Wrap -AutoSize
		}
	}
	
	END {
		Write-Output "[+] Process completed..."
	}
}

function Search-AllUsersPassword {
	
	param(
	[Parameter(Mandatory=$True, ValueFromPipeline=$True)]
	[string]$UserName
	)
	
	BEGIN {
		Write-Output "[*] Searching all users for userPassword property"
	}
	
	PROCESS {
		Ldap-GetProperty -Filter "(&(objectCategory=User))" -Property "userpassword" | Format-Table -Wrap -AutoSize
	}
	
	END {
		Write-Output "[+] Process completed..."
	}
}
