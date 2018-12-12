function Get-WoWInstallPath {
    [cmdletbinding()]
    param(

    )

    Write-Verbose "Attempting to find WoW install path..."

    try {

        $wowInstallPath = (Get-Item 'hklm:\SOFTWARE\WOW6432Node\Blizzard Entertainment\World of Warcraft').GetValue('InstallPath')
        $addonsFolder   = "$($wowInstallPath)Interface\AddOns" 

        $wowInstallInfo = [PSCustomObject]@{

            AddonsFolder   = $addonsFolder
            WowInstallPath = $wowInstallPath

        }

        return $wowInstallInfo
        
    }

    catch {

        $errorMessage = $_.Exception.Message 
        throw "Error determining WoW Install Path/ElvUi Version -> [$errorMessage]!"
        break

    }
}