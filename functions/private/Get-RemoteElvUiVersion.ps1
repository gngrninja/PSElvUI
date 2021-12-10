function Get-RemoteElvUiVersion {
    [cmdletbinding()]
    param(
        [Parameter(

        )]
        [ValidateSet('Retail','Classic','TBC')]
        $WowEdition = 'Retail'
    )
        
    try {        

        switch ($WowEdition) {

            'Classic' {      

                [double]$version = [double]$version = (Invoke-WebRequest 'https://raw.githubusercontent.com/tukui-org/ElvUI/development/ElvUI/ElvUI_Classic.toc' | Select-Object -ExpandProperty Content).Split('##')[3].Split(' ')[2].Trim()               
                $remoteElvInfo   = [PSCustomObject]@{
            
                    FileName     = "elv_classic.zip"
                    Version      = $version
                    DownloadLink = "https://www.tukui.org/classic-addons.php?download=2"
            
                }
            }

            'TBC' {
                                                            
                [double]$version = [double]$version = (Invoke-WebRequest 'https://raw.githubusercontent.com/tukui-org/ElvUI/development/ElvUI/ElvUI_TBC.toc' | Select-Object -ExpandProperty Content).Split('##')[3].Split(' ')[2].Trim()            
                $remoteElvInfo   = [PSCustomObject]@{
            
                    FileName     = "elv_tbc.zip"
                    Version      = $version
                    DownloadLink = "https://www.tukui.org/classic-tbc-addons.php?download=2"
            
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