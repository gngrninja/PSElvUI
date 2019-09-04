PowerShell -> ElvUI Updater
======
This module provides an easy way to update/install ElvUI.
Currently only working on Windows / PowerShell 3.0+

You can now specify the edition of WoW, and update retail and classic!

## Getting Started
### If you've never installed/used a module/script before you must do the following:

1. Run PowerShell as Administrator
2. Set Execution Policy to RemoteSigned, as this will allow local script execution

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

#### (OR) Downloading/cloning this repository locally and extracting it:

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

Check for update only, don't do anything else:
```powershell
Invoke-ElvUICheck -OnlyCheck -Verbose
```

Check for update/update if available, or install if not found:
```powershell
Invoke-ElvUICheck -InstallIfDoesntExist -Verbose
```

You can also specify the WoW edition, and use it for classic!
```powershell
Invoke-ElvUiCheck -WowEdition Classic -InstallIfDoesntExist -Verbose
```

```
VERBOSE: Attempting to find WoW install path [Classic]...                                                               
VERBOSE: Attempting to retrieve ElvUI information from [https://www.tukui.org/download.php?ui=elvui]...                 
VERBOSE: GET https://www.tukui.org/download.php?ui=elvui with 0-byte payload                                            
VERBOSE: received -byte response of content type text/html                                                                                                            Installing ElvUI...                                                                                                                                                   VERBOSE: GET https://www.tukui.org/downloads/elvui-11.21.zip with 0-byte payload                                        
VERBOSE: received 3742269-byte response of content type application/zip                                                 
VERBOSE: Extracting new version to [C:\World of Warcraft\_classic_\Interface\AddOns]...                                 
```

In PowerShell help:

```powershell
Get-Help Invoke-ElvUICheck -Detailed 
```

*Leave an issue here if you have some feedback, issues, or questions.*