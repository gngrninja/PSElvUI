function Get-WoWInstallPath {
    [cmdletbinding()]
    param(
        [Parameter(
            
        )]
        [ValidateSet('Retail','Classic')]
        $WowEdition = 'Retail'
    )
    
    

    begin {

        Write-Verbose "Attempting to find WoW install path [$($WowEdition)]..."

        [string]$regPath = 'hklm:\SOFTWARE\WOW6432Node\Blizzard Entertainment\World of Warcraft'       

    }

    process {

        try {

            $wowInstallPath = (Get-Item $regPath).GetValue('InstallPath')

            $base = Split-Path -Path $wowInstallPath

            switch ($WowEdition) {

                'Retail' {

                    $wowInstallPath = "$($base)\_retail_\"

                }

                'Classic' {

                    $wowInstallPath = "$($base)\_classic_\"

                }
            }

            $addonsFolder   = "$($wowInstallPath)Interface\AddOns" 
    
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