function Resolve-DCtoIP {

	PROCESS {
		Write-Output "[+] Enumerating all the DCs"
		ForEach($dc in [DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain().DomainControllers) {
			Write-Output "[+] DC found: $($dc.Name):$($dc.IPAddress)"
		}
	}
}
