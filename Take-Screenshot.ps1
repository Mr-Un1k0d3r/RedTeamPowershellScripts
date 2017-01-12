function Take-Screenshot {
	# Mr.Un1k0d3r - RingZer0 Team 2016
	# Screen capture using powershell
	# Output file is a png
	
	param(
	[Parameter(Mandatory=$True)]
	[string]$Path
	)
	
	BEGIN {

	}
	
	PROCESS {
		[Reflection.Assembly]::LoadWithPartialName("System.Drawing") | Out-Null
		[Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
		
		if(-Not [Environment]::UserInteractive) {
			Write-Host "[-] WARNING process is not interactive your screen capture will likely fail"
		}

		$bounds = [System.Windows.Forms.Screen]::AllScreens.Bounds
		Write-Host "[+] Screen resolution is $($bounds.Width) x $($bounds.Height)"
		$bounds = [Drawing.Rectangle]::FromLTRB(0, 0,  $bounds.Width, $bounds.Height)
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
