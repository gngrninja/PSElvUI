function Get-RemoteElvUiVersion {
    [cmdletbinding()]
    param(
        [Parameter(

        )]
        [ValidateSet('Retail','Classic')]
        $WowEdition = 'Retail'
    )
    
    try {        
        switch ($WowEdition) {
            'Classic' {            
                $remoteElvInfo = [PSCustomObject]@{
            
                    FileName     = "elv_classic.zip"
                    Version      = 1.0
                    DownloadLink = "https://www.tukui.org/classic-addons.php?download=2"
            
                }
            }
            'Retail' {
                $baseUrl      = 'https://www.tukui.org'
                $downloadPage = "$baseUrl/download.php?ui=elvui"
                $dlString     = '.+Download ElvUI.+'
        
                Write-Verbose "Attempting to retrieve ElvUI information from [$downloadPage]..."
                $downloadLink = "$baseUrl$(Invoke-WebRequest -Uri $downloadPage | 
                                            Select-Object -ExpandProperty Links | 
                                            Where-Object {
                                                $_.Outerhtml -match $dlString
                                            }                                   | 
                                            Select-Object -ExpandProperty href)" 
            
                $fileName             = $($downloadLink.Split('/')[4])
                [double]$elvUiVersion = $fileName.Split('-')[1].Replace('.zip','')
            
                $remoteElvInfo = [PSCustomObject]@{
            
                    FileName     = $fileName
                    Version      = $elvUiVersion
                    DownloadLink = $downloadLink
            
                }
            }

        }

    
        return $remoteElvInfo 

    }
    catch {
        $errorMessage = $_.Exception.Message
        throw "Error getting remote ElvUI Information -> [$errorMessage]"
    }
}