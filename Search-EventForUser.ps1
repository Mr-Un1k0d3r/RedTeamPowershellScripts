function Search-EventForUser {
	# Mr.Un1k0d3r - RingZer0 Team 2016
	# Search for a user through the events
	# Todo :
	# 		Add an option to fetch all the DCs
	#		Search for multiple users at the same time
	#		Parse the output and make it more readable
	
	param(
	[Parameter(Mandatory=$True, ValueFromPipeline=$true)]
	[string]$User,
	[Parameter(Mandatory=$False)]
	[string]$ComputerName = (Get-Item env:COMPUTERNAME).Value,
	[Parameter(Mandatory=$False)]
	[switch]$FindDC = $False
	)
	
	BEGIN {
		Write-Output "[+] Parsing Event Log on $($ComputerName)"
	}
	
	PROCESS {
		$dcs = @{};
		if($FindDC) {
			Write-Output "[+] Enumrating all the DCs"
			ForEach($dc in [DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain().DomainControllers) {
				Write-Output "[+] DC found: $($dc.Name)"
				$dcs.Add($dc.Name)
			}
		}
	
		
		ForEach($item in $User) {
			Write-Output "[+] Parsing Log looking for $($item)"
			$xmlFilter = "<QueryList><Query Id=""0"" Path=""Security""><Select Path=""Security"">*[System[(EventID=4624)] and EventData[Data[@Name=""TargetUserName""]=""$($item)""]]</Select></Query></QueryList>";
			$data = Get-WinEvent -FilterXml $xmlFilter -ComputerName $ComputerName -ErrorAction SilentlyContinue | Select Message;
			if($data) {
				ForEach($entry in $data) {
					Write-Output "[+] Event found" 
					Write-Output $entry.Message
				}
			} else {
				Write-Output "[-] No event found..."
			}
		}
	}
	
	END {
		Write-Output "[+] Process completed..."
	}
}
