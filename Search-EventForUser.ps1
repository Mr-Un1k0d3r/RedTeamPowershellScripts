function Search-EventForUser {
	# Charles F. Hamilton - Mandiant 2016
	# Search for a user through the events
	# Todo :
	# 		Add an option to fetch all the DCs
	#		Search for multiple users at the same time
	#		Parse the output and make it more readable
	
	param(
	[Parameter(Mandatory=$True)]
	[string]$User,
	[Parameter(Mandatory=$False)]
	[string]$ComputerName = (Get-Item env:COMPUTERNAME).Value,
	[Parameter(Mandatory=$False)]
	[switch]$FindDC = $False
	)
	
	BEGIN {
		Write-Host "[+] Parsing Event Log on $($ComputerName) looking for ""$($User)"""
	}
	
	PROCESS {
		if($FindDC) {
			Write-Host "[+] Enumrating all the DCs"
			# Todo
		}
	
		$xmlFilter = "<QueryList><Query Id=""0"" Path=""Security""><Select Path=""Security"">*[System[(EventID=4624)] and EventData[Data[@Name=""TargetUserName""]=""$($user)""]]</Select></Query></QueryList>";
		$data = Get-WinEvent -FilterXml $xmlFilter -ComputerName $ComputerName -ErrorAction SilentlyContinue | Select Message;
		if($data) {
			ForEach($entry in $data) {
				Write-Host "[+] Event found" 
				Write-Host $entry.Message
			}
		} else {
			Write-Host "[-] No event found..."
		}
	}
	
	END {
		Write-Host "[+] Process completed..."
	}
}
