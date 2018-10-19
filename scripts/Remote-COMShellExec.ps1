function Remote-COMShellExec {
	# Mr.Un1k0d3r - RingZer0 Team 2018
	
	param(
	[Parameter(Mandatory=$True)]
	[string]$ComputerName,
	[Parameter(Mandatory=$True)]
	[string]$Command,
	[Parameter(Mandatory=$True)]
	[string]$Argument
	)
	
	BEGIN {
		Write-Output "[+] Executing $($Command) $($Argument) on $($ComputerName)"
	}
	
	PROCESS {
		$Com = [activator]::CreateInstance([type]::GetTypeFromCLSID("13709620-C279-11CE-A49E-444553540000", $ComputerName)) 
		$Com.ShellExecute($Command, $Argument, "", "", 0)
	}
	
	END {
		Write-Output "[+] Process completed..."
	}
}
