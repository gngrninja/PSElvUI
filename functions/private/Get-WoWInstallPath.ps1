function Get-WoWInstallPath {
    [cmdletbinding()]
    param(
        [Parameter(
            
        )]
        [ValidateSet('Retail','Classic','Wrath')]
        $WowEdition = 'Retail'
    )
        
    begin {

        Write-Verbose "Attempting to find WoW install path [$($WowEdition)]..."

        [string]$regPath = 'hklm:\SOFTWARE\WOW6432Node\Blizzard Entertainment\World of Warcraft'       

    }

    process {

        try {
            
            if ($IsLinux) {

                if (!$config.InstallPath) {

                    do {

                        $base = Read-Host "Wow install path?"

                    } until (Test-Path -Path $base)

                    $configExport = [PSCustomObject]@{

                        InstallPath = $base

                    }

                    $configExport | 
                        ConvertTo-Json -Depth 2 | 
                            Out-File -FilePath "$($defaultPSElvUIDir)$($separator)config.json"

                } else {

                    $base = $config.InstallPath

                }

            } elseif ($IsMacOS) {
                
                $base = '/Applications/World of Warcraft'

            } else {

                $wowInstallPath = (Get-Item $regPath).GetValue('InstallPath')
                $base = Split-Path -Path $wowInstallPath   
                      
            }  

            switch ($WowEdition) {
    
                'Retail' {

                    $wowInstallPath = "$($base)$($separator)_retail_$($separator)"

                }

                'Classic' {

                    $wowInstallPath = "$($base)$($separator)_classic_era_$($separator)"

                }

                'Wrath' {

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