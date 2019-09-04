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
        [ValidateSet('Retail','Classic')]
        $WowEdition = 'Retail'
    )

    begin {

        #Variable setup
        $dlfolder        = $env:TEMP
        $wowInfo         = Get-WowInstallPath -WowEdition $WowEdition
        $remoteElvUiInfo = Get-RemoteElvUiVersion -WowEdition $WowEdition
        $localDlPath     = "$dlfolder\$($remoteElvUiInfo.FileName)"

    }

    process {

        try {
            switch ($WowEdition) {
                'Classic' {

                    $localVersion = 0.0 

                }   
                'Retail' {

                    $localVersion = Get-LocalElvUiVersion -AddonsFolder $wowInfo.AddonsFolder -ErrorAction Stop

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
