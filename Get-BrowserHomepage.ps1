function Get-BrowserHomepage {
	# Mr.Un1k0d3r - RingZer0 Team 2016
	# Get Browser Homepage

  	BEGIN {

	}
	
	PROCESS {
    		Get-ItemProperty -Path "HKCU:\Software\Microsoft\Internet Explorer\Main\" -Name "start page" | Select "Start Page"
	}
	
	END {
		Write-Host "[+] Process completed..."
	}
}
