function Get-RemoteElvUiVersion {
    [cmdletbinding()]
    param(
    )
        
    begin {
        $apiUrl = 'https://api.tukui.org/v1/addon/elvui'
    }

    process {
        try {                                       
            $elvInfo              = Invoke-RestMethod -Uri $apiUrl            
            [double]$elvUiVersion = $elvInfo.version
            $fileName             = "elvui-$($elvUiVersion).zip"

            $remoteElvInfo = [PSCustomObject]@{    
                FileName     = $fileName
                Version      = $elvUiVersion
                DownloadLink = $elvInfo.url    
            }
         
            return $remoteElvInfo     
        }
        catch {
    
            $errorMessage = $_.Exception.Message
            throw "Error getting remote ElvUI Information -> [$errorMessage]"
    
        }
    }

    end {

    }
}