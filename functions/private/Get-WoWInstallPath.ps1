function Get-WoWInstallPath {
    [cmdletbinding()]
    param(
        [Parameter(
            
        )]
        [ValidateSet('Retail','Classic','TBC')]
        $WowEdition = 'Retail'
    )
        
    begin {

        Write-Verbose "Attempting to find WoW install path [$($WowEdition)]..."

        [string]$regPath = 'hklm:\SOFTWARE\WOW6432Node\Blizzard Entertainment\World of Warcraft'       

    }

    process {

        try {
            
            if (!$IsLinux)  {

                $wowInstallPath = (Get-Item $regPath).GetValue('InstallPath')
                $base = Split-Path -Path $wowInstallPath                
                
            } else {

                if (!$config.InstallPath) {

                    do {

                        $base = Read-Host "Wow install path?"

                    } until (Test-Path -Path $base)

                    $configExport = [PSCustomObject]@{

                        InstallPath = $base

                    }

                    $configExport | ConvertTo-Json -Depth 2 | Out-File -FilePath "$($defaultPSElvUIDir)$($separator)config.json"

                } else {

                    $base = $config.InstallPath

                }
            }    

            switch ($WowEdition) {
    
                'Retail' {

                    $wowInstallPath = "$($base)$($separator)_retail_$($separator)"

                }

                'Classic' {

                    $wowInstallPath = "$($base)$($separator)_classic_era_$($separator)"

                }

                'TBC' {

                    $wowInstallPath = "$($base)$($separator)_classic_$($separator)"

                }
            }

            $addonsFolder   = "$($wowInstallPath)Interface$($separator)AddOns"

            $wowInstallInfo = [PSCustomObject]@{
    
                AddonsFolder   = $addonsFolder
                WowInstallPath = $wowInstallPath
    
            }                            
        }
    
        catch {
    
            $errorMessage = $_.Exception.Message 
            throw "Error determining WoW Install Path/ElvUi Version -> [$errorMessage]!"            
    
        }
    }
    
    end {

        return $wowInstallInfo

    }   
}