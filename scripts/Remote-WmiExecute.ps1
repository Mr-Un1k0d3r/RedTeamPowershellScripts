function Remote-WmiExecute {
	# Mr.Un1k0d3r - RingZer0 Team 2016
	# Execute command through WMI on a remote computer
	
	param(
	[Parameter(Mandatory=$True)]
	[string]$Payload,
	[Parameter(Mandatory=$True)]
	[string]$ComputerName,
	[Parameter(Mandatory=$False)]
	[string]$Username,
	[Parameter(Mandatory=$False)]
	[string]$Password	
	)
	
	BEGIN {
		Write-Host "[+] Executing payload on $($ComputerName)"
		if($Username -ne "") {
			$SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force
			$Creds = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $Username, $SecurePassword
		}
	}
	
	PROCESS {
		if($Creds) {
			Write-Output "[*] Remotely authenticated as $($Username)"
			$process = Invoke-WmiMethod -ComputerName $ComputerName -Class Win32_Process -Name Create -ArgumentList $Payload -Impersonation 3 -EnableAllPrivileges -Credential $Creds
			Try {
				Register-WmiEvent -ComputerName $ComputerName -Query "Select * from Win32_ProcessStopTrace Where ProcessID=$($process.ProcessId)" -Credential $Creds -Action {
					$state = $event.SourceEventArgs.NewEvent;
					Write-Host "`n[+] Remote process status:`nPID: $($state.ProcessId)`nState: $($state.State)`nStatus: $($state.Status)" 
				}
			} Catch {
				Write-Host "`n[-] PID Couldn't be retrieved"
			}
		} else {
			$process = Invoke-WmiMethod -ComputerName $ComputerName -Class Win32_Process -Name Create -ArgumentList $Payload
			Try {
				Register-WmiEvent -ComputerName $ComputerName -Query "Select * from Win32_ProcessStopTrace Where ProcessID=$($process.ProcessId)" -Action {
					$state = $event.SourceEventArgs.NewEvent;
					Write-Host "`n[+] Remote process status:`nPID: $($state.ProcessId)`nState: $($state.State)`nStatus: $($state.Status)" 
				}
			} Catch {
				Write-Host "`n[-] PID Couldn't be retrieved"
			}
		}
	}
	
	END {
		Write-Host "[+] Process completed..."
	}
}
