function Search-EventForUser {
	# Mr.Un1k0d3r - RingZer0 Team 2016
	# Search for a user through the events
	# Parse the output and make it more readable
	
	param(
	[Parameter(Mandatory=$True, ValueFromPipeline=$true)]
	[string]$UserName,
	[Parameter(Mandatory=$False)]
	[string]$ComputerName = (Get-Item env:COMPUTERNAME).Value,
	[Parameter(Mandatory=$False)]
	[switch]$FindDC = $False
	)
	
	BEGIN {
	
	}
	
	PROCESS {
		[System.Collections.ArrayList]$dcs = @() 
		if($FindDC) {
			Write-Output "[+] Enumrating all the DCs"
			ForEach($dc in [DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain().DomainControllers) {
				Write-Output "[+] DC found: $($dc.Name)"
				$dcs.Add($dc.Name) | Out-Null
			}
		} else {
			$dcs.Add($ComputerName) | Out-Null
		}
		
		ForEach($dc in $dcs) {
			ForEach($item in $UserName) {
				Write-Output "[+] Parsing $($dc) Logs looking for $($item)"
				
				$xmlFilter = "<QueryList><Query Id=""0"" Path=""Security""><Select Path=""Security"">*[System[(EventID=4624)] and EventData[Data[@Name=""TargetUserName""]=""$($item)""]]</Select></Query></QueryList>";
				$data = Get-WinEvent -FilterXml $xmlFilter -ComputerName $dc -ErrorAction SilentlyContinue | Select Message;
				if($data) {
					ForEach($entry in $data) {
						Write-Output "[+] Event found" 
						Write-Output $entry.Message
					}
				} else {
					Write-Output "[-] No event found on $($dc)..."
				}
			}
		}
	}
	
	END {
		Write-Output "[+] Process completed..."
	}
}
