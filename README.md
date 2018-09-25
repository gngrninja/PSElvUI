PowerShell -> ElvUI Updater
======
This module provides an easy way to update/install ElvUI.
Currently only working on Windows / PowerShell 3.0+

## Getting Started
### If you've never installed/used a module/script before you must do the following:

1. Run PowerShell as Administrator
2. Set Execution Policy to RemoteSigned. This will allow local script execution

```powershell
Set-ExecutionPolicy RemoteSigned
```

More information on execution policies can be found [here](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-6).

Module Install: 
------

#### (Best method) Via the PowerShell Gallery:

```powershell
Install-Module PSElvUI
```

#### (OR) Downloading this repository locally and extracting it:

```powershell
Import-Module .\path\to\PSElvUI.psd1
```
-or-

```powershell
Import-Module .\path\to\FolderModuleFilesAreIn
```

Help / Examples
------

Check for update/update if available:
```powershell
Invoke-ElvUICheck -Verbose
```

Check for update only, don't do anything else
```powershell
Invoke-ElvUICheck -OnlyCheck -Verbose
```

Check for update/update if available, or install if not found:
```powershell
Invoke-ElvUICheck -InstallIfDoesntExist -Verbose
```

In PowerShell help:

```powershell
Get-Help Invoke-ElvUICheck -Detailed 
```

*Leave an issue here if you have some feedback, issues, or questions.*