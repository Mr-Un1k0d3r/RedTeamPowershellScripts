function Get-IEBookmarks {
	# Mr.Un1k0d3r - RingZer0 Team 2016
	# Get IE bookmarks URL

  	BEGIN {
		$path = [Environment]::GetFolderPath('Favorites')
		Write-Output "[+] Bookmark are located in $($path)"
	}
	
	PROCESS {
    		Get-ChildItem -Recurse $path -File | ForEach {
				$data = Get-Content $_.fullname | Select-String -Pattern URL
				Write-Output $data
			}
	}
	
	END {
		Write-Output "[+] Process completed..."
	}
}
