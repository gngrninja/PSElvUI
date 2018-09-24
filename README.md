# PowerShell -> ElvUI Updater
This module provides an easy way to update/install ElvUI.
Currently only working on Windows!

Article for this repository:
...coming soon

## Getting Started
Module Install: 

Via the PowerShell Gallery:

```powershell
Install-Module PSElvUI
```

-or-

```powershell
Import-Module .\path\to\PSElvUI.psd1
```
-or-

```powershell
Import-Module .\path\to\FolderModuleFilesAreIn
```

## Help / Examples
Check for update/update if available:
```powershell
Invoke-ElvUICheck 
```

Check for update only, don't do anything else
```powershell
Invoke-ElvUICheck -OnlyCheck
```

Check for update/update if available, or install if not found:
```powershell
Invoke-ElvUICheck -InstallIfDoesntExist
```

In PowerShell help:

```powershell
Get-Help Invoke-ElvUICheck -Detailed 
```

*Leave an issue here if you have some feedback, issues, or questions.*