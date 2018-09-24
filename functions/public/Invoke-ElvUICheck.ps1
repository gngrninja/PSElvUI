function Invoke-ElvUiCheck {
    [cmdletbinding()]
    param(
        [Parameter(
        )]
        [switch]
        $InstallIfDoesntExist,

        [Parameter(
        )]
        [switch]
        $OnlyCheck
    )

    #Variable setup
    $dlfolder = $env:TEMP

    #Find local WoW install path / local ElvUI Version
    $wowInfo = Get-WowInstallPath

    #Get remote ElvUI information
    $remoteElvUiInfo = Get-RemoteElvUiVersion
    $localDlPath     = "$dlfolder\$($remoteElvUiInfo.FileName)"

    try {

        $localVersion = Get-LocalElvUiVersion -AddonsFolder $wowInfo.AddonsFolder -ErrorAction Stop

    }
    catch {

        if ($InstallIfDoesntExist -and $_.Exception.Message -eq 'ElvUI addon not found!') {

            Write-Host `n"Installing ElvUI..."`n

            Invoke-ElvUiInstall

            break

        } else {

            $errorMessage = $_.Exception.Message 
            throw "Error determining local version of ElvUI -> [$errorMessage]!"

        }

    }
        
    if ($remoteElvUiInfo.Version -gt $localVersion) {
        
        Write-Host `n"New version of ElvUI found! (you have [$localVersion], latest is [$($remoteElvUiInfo.Version)])"`n
        Write-Host `n"Downloading file from [$($remoteElvUiInfo.DownloadLink)]... to [$localDlPath]"`n        

        Invoke-ElvUiInstall

        Write-Host `n"Verifying local version has been updated..."`n
                
        $localVersion = $null
        $localVersion = Get-LocalElvUiVersion -AddonsFolder $wowInfo.AddonsFolder

        if ($localVersion -eq $remoteElvUiInfo.Version) {

            Write-Host `n"Local version is now the latest [$localVersion]"`n

        }

        Write-Host `n"Cleaning up..."`n

        Invoke-ElvCleanUp -CleanupPath $localDlPath
        

    } else {

        Write-Host "ElvUI is already up to date (local [$localVersion]) (remote[$($remoteElvUiInfo.Version)])"

    }
}
