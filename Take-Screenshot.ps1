function Take-Screenshot {
	# Charles F. Hamilton - Mandiant 2016
	# Screen capture using powershell
	
	param(
	[Parameter(Mandatory=$True)]
	[string]$Path
	)
	
	BEGIN {
		Write-Host "[+] Capturing screenshot"
	}
	
	PROCESS {
		[Reflection.Assembly]::LoadWithPartialName("System.Drawing") | Out-Null
		$size = Get-WmiObject -Class Win32_DesktopMonitor | Select-Object ScreenWidth,ScreenHeight
		
		Write-Host "[+] Screen resolution is $($size.ScreenWidth) x $($size.ScreenHeight)"
		$bounds = [Drawing.Rectangle]::FromLTRB(0, 0,  ([int]($size.ScreenWidth[1])),  ([int]($size.ScreenHeight[1])))
		$bmp = New-Object Drawing.Bitmap $bounds.width, $bounds.height
		$graphics = [Drawing.Graphics]::FromImage($bmp)

		$graphics.CopyFromScreen($bounds.Location, [Drawing.Point]::Empty, $bounds.size)

		$bmp.Save($Path)

		$graphics.Dispose()
		$bmp.Dispose()
	}
	
	END {
		Write-Host "[+] Screenshot saved $($Path)"
		Write-Host "[+] Process completed..."
	}
}
