function Invoke-ElvUiCheck {
      <#
    .SYNOPSIS

    Invoke-ElvUiCheck
    Updates / Installs / Checks for latest ElvUI version

    .DESCRIPTION

    This function will check for / install the latest ElvUI version

    .PARAMETER InstallIfDoesntExist

    If specified, will install ElvUI if it is not found

    .PARAMETER OnlyCheck

    If specified, will only check to see if a newer version is available, but do nothing else

    .PARAMETER WowEdition

    You can specify Classic to install/update ElvUI for WoW classic. Defaults to Retail.

    .EXAMPLE

    (check for latest version/update if found)
    Invoke-ElvUICheck

    .EXAMPLE

    (check for latest version/do nothing if found)
    Invoke-ElvUICheck -OnlyCheck

    .EXAMPLE

    (check for latest version/install if not installed)

    Invoke-ElvUICheck -InstallIfDoesntExist

    .EXAMPLE

    (check for latest version/install if not installed for Classic WoW)

    Invoke-ElvUICheck -WowEdition Classic -InstallIfDoesntExist -Verbose

    .EXAMPLE

    (check for latest version/install if not installed for TBC)

    Invoke-ElvUICheck -WowEdition TBC -InstallIfDoesntExist -Verbose    

    #>
    [cmdletbinding()]
    param(
        [Parameter(
        )]
        [switch]
        $InstallIfDoesntExist,

        [Parameter(
        )]
        [switch]
        $OnlyCheck,

        [Parameter(
            
        )]
        [ValidateSet('Retail','Classic','TBC')]
        $WowEdition = 'Retail'
    )

    begin {
        #Variable setup
        if ($IsLinux) {

            if (!(Test-Path -Path $defaultPSElvUIDir -ErrorAction SilentlyContinue)) {

                Write-Verbose "Creating directory [$($defaultPSElvUIDir)]..."
                New-Item -ItemType Directory -Path $defaultPSElvUIDir
                New-Item -ItemType File -Path $defaultPSElvUIDir -Name 'config.json'

            }

            $script:config = Get-Content -Path "$($defaultPSElvUIDir)$($separator)config.json" | ConvertFrom-Json
            $dlfolder = $defaultPSElvUIDir
            
        } else {

            $dlfolder = $env:TEMP

        }

        $wowInfo = Get-WowInstallPath -WowEdition $WowEdition
        $remoteElvUiInfo = Get-RemoteElvUiVersion -WowEdition $WowEdition
        $localDlPath = "$dlfolder$($separator)$($remoteElvUiInfo.FileName)"

    }

    process {

        try {
            switch ($WowEdition) {

                'Classic' {

                    $localVersion = Get-LocalElvUiVersion -AddonsFolder $wowInfo.AddonsFolder -WowEdition $WowEdition -ErrorAction Stop

                }   
                'Retail' {

                    $localVersion = Get-LocalElvUiVersion -AddonsFolder $wowInfo.AddonsFolder -WowEdition $WowEdition -ErrorAction Stop
        
                }

                'TBC' {

                    $localVersion = Get-LocalElvUiVersion -AddonsFolder $wowInfo.AddonsFolder -WowEdition $WowEdition -ErrorAction Stop

                }

            }                
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
    
            if (!$OnlyCheck) {
                
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
    
                Write-Host "Run without -OnlyCheck to update!"
    
            }                
    
        } else {
    
            Write-Host "ElvUI is already up to date (local [$localVersion]) (remote[$($remoteElvUiInfo.Version)])"
    
        }
    }

    end {

    }             
}
