function Invoke-ElvUiInstall {
    [cmdletbinding()]
    param(

    )

    #Download file
    $file = Invoke-WebRequest -Uri $remoteElvUiInfo.DownloadLink    
        
    Invoke-ElvFileWrite -Path $localDlPath -FileContent $file.Content

    Write-Host `n"Extracting new version to [$($wowInfo.AddonsFolder)]..."`n

    Expand-Archive -Path $localDlPath -DestinationPath $wowInfo.AddonsFolder -Force
    
}