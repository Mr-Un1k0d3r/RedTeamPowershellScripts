function Run-As {
	param(
		[Parameter(Mandatory=$True)]
		[string]$Username,
		[Parameter(Mandatory=$True)]
		[string]$Password,
		[Parameter(Mandatory=$True)]
		[string]$Process
	)
	
	PROCESS {
		$Secure = ConvertTo-SecureString $Password -AsPlainText -Force
		$Cred = New-Object System.Management.Automation.PSCredential($Username, $Secure) 
		Start-Process -FilePath $Process -Credential $Cred
	}
}
