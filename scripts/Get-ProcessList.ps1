function Get-ProcessList {
	PROCESS {
		$ProcessList = @()

		Get-CimInstance Win32_process | ForEach-Object {
			$Process = $_
			$Owner = Invoke-CimMethod -InputObject $Process -MethodName GetOwner | Select Domain, User
			
			$OwnerString = ""
			if ([String]::IsNullOrEmpty($Owner.Domain)) {
				$OwnerString = $Owner.User
			} else {
				$OwnerString = "$($Owner.Domain)\$($Owner.User)"
			}
			
			$Output = New-Object -TypeName PSObject -Property @{
				PID = $Process.ProcessId
				Name = $Process.ProcessName
				Owner = $OwnerString
				CommandLine = $Process.CommandLine
			}
			$ProcessList += $Output
			
		}

		$ProcessList | Format-Table -Wrap -AutoSize
	}
}
