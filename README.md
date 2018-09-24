# PowerShell -> ElvUI Updater
This module provides an easy way to update/install ElvUI.
Currently only working on Windows!

Article for this repository:
...coming soon

## Getting Started
You can import the module by using: 

```powershell
Import-Module .\path\to\PSElvUI.psd1
```
-or-
```powershell
Import-Module .\path\to\FolderModuleFilesAreIn
```
-or-

Via the PowerShell Gallery:

```powershell
Install-Module PSElvUI
```

Once it is imported, use...

```powershell
Get-Help Invoke-ElvUICheck -Detailed 
```
...to get all the help goodness.

## Help / Examples
Check for update/update if available:
```powershell
Invoke-ElvUICheck 
```

Check for update only, don't do anything else
```powershell
Invoke-ElvUICheck -OnlyCheck
```

Check for update/update if available, or install of not found:
```powershell
Invoke-ElvUICheck -InstallIfDoesntExist
```

*Leave an issue here if you have some feedback, issues, or questions.*