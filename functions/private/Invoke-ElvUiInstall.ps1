function Invoke-ElvUiInstall {
    [cmdletbinding()]
    param(

    )

    #Download file
    $file = Invoke-WebRequest -Uri $remoteElvUiInfo.DownloadLink    
       
    #Write contents
    Invoke-ElvFileWrite -Path $localDlPath -FileContent $file.Content

    Write-Verbose "Extracting new version to [$($wowInfo.AddonsFolder)]..."

    #Expand zip file (using force to overwrite if needed)
    Expand-Archive -Path $localDlPath -DestinationPath $wowInfo.AddonsFolder -Force

}