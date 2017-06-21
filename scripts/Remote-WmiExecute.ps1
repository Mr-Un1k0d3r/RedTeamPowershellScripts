function Remote-WmiExecute {
	# Mr.Un1k0d3r - RingZer0 Team 2016
	# Execute command through WMI on a remote computer
	
	param(
	[Parameter(Mandatory=$True)]
	[string]$Payload,
	[Parameter(Mandatory=$True)]
	[string]$ComputerName
	)
	
	BEGIN {
		Write-Host "[+] Executing payload on $($ComputerName)"
	}
	
	PROCESS {
		$process = Invoke-WmiMethod -ComputerName $ComputerName -Class Win32_Process -Name Create -ArgumentList $Payload
		Register-WmiEvent -ComputerName $ComputerName -Query "Select * from Win32_ProcessStopTrace Where ProcessID=$($process.ProcessId)" -Action {
			$state = $event.SourceEventArgs.NewEvent;
			Write-Host "`n[+] Remote process status:`nPID: $($state.ProcessId)`nState: $($state.State)`nStatus: $($state.Status)" 
		}
	}
	
	END {
		Write-Host "[+] Process completed..."
	}
}
