Function Set-WSLFoward ($Ports) {
  If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {   
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Break
  }
  
  $remoteport = bash.exe -c "ifconfig eth0 | grep 'inet '"
  $found = $remoteport -match '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}';
  
  if ( $found ) {
    $remoteport = $matches[0];
  }
  else {
    Write-Output "The Script Exited, the ip address of WSL 2 cannot be found";
    exit;
  }
  
  Invoke-Expression "netsh interface portproxy reset";
  
  for ( $i = 0; $i -lt $Ports.length; $i++ ) {
    $Ports = $Ports[$i];
    Invoke-Expression "netsh interface portproxy add v4tov4 listenport=$Ports connectport=$port connectaddress=$remoteport";
  }
  
  Invoke-Expression "netsh interface portproxy show v4tov4";
}
