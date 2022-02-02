function Add-UserLogonScript {
	param(
	[Parameter(Mandatory=$True)]
	[string]$Target,
	[Parameter(Mandatory=$True)]
	[string]$TargetUser,
	[Parameter(Mandatory=$True)]
	[string]$ScriptPath
	)
	
	BEGIN {
		Write-Output "Adding $($ScriptPath) to user $($TargetUser)"
	}
	
	PROCESS {
		$ADSI = [ADSI]"WinNT://$Target"
		$user = $ADSI.PSBase.Children.Find($TargetUser)
		$user.LoginScript = $ScriptPath
		$user.SetInfo()
	}
	
	END {
		Write-Output "[+] Process completed..."
	}
}
