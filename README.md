PowerShell -> ElvUI Updater
======
This module provides an easy way to update/install ElvUI.

Currently only working on Windows / PowerShell 5.1+

You can now specify the edition of WoW, and update both retail and classic!

I highly recommend installing PowerShell Core, from here: https://github.com/PowerShell/PowerShell

## Getting Started
### Windows PowerShell/Desktop Edition Preconfiguration (Core users can skip this, and start at Module Install below)
#### If you've never installed/used a module/script before you must do the following:

1. Run PowerShell as Administrator
2. Set Execution Policy to RemoteSigned, as this will allow local script execution

```powershell
Set-ExecutionPolicy RemoteSigned
```

More information on execution policies can be found [here](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-6).

#### If you are using the built-in version (Desktop), make sure you've launched old-school Internet Explorer (Start/Windows Key -> iexplore.exe), and have accepted the default prompt. Otherwise you may receive an error.

Module Install: 
------

#### (Best method) Via the PowerShell Gallery:

```powershell
Install-Module PSElvUI
```

If you want more information about the PowerShell Gallery, visit this link:
https://docs.microsoft.com/en-us/powershell/scripting/gallery/getting-started?view=powershell-7#:~:text=To%20install%20a%20package%20from,This%20requires%20an%20administrator%20account.

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

![examples](https://github.com/gngrninja/PSElvUI/blob/master/media/examples.PNG?raw=true)

Check for update only, don't do anything else:
```powershell
Invoke-ElvUICheck -OnlyCheck -Verbose
```

Check for update/update if available:
```powershell
Invoke-ElvUICheck -Verbose
```

Check for update/update if available, or install if not found:
```powershell
Invoke-ElvUICheck -InstallIfDoesntExist -Verbose
```

You can also specify the WoW edition, and use it for classic!
```powershell
Invoke-ElvUiCheck -WowEdition Classic -InstallIfDoesntExist -Verbose
```

In PowerShell help:

```powershell
Get-Help Invoke-ElvUICheck -Detailed 
```

*Leave an issue here if you have some feedback, issues, or questions.*