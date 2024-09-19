function Get-LocalElvUiVersion {
    [cmdletbinding()]
    param(
        [string]
        $addonsFolder,

        [ValidateSet('Retail','Classic','Wrath')]
        $WowEdition
    )

    [double]$localVersion = 0.0
    $toc = [string]::Empty

    if ((Test-Path $addonsFolder)) {

        try {

            switch ($WowEdition) {

                'Retail' {

                    $toc = Get-Content -Path "$addonsFolder$($separator)ElvUI$($separator)ElvUI_Mainline.toc" -ErrorAction Stop

                }

                'Classic' {

                    $toc = Get-Content -Path "$addonsFolder$($separator)ElvUI$($separator)ElvUI_Vanilla.toc" -ErrorAction Stop

                }

                'Wrath' {

                    $toc = Get-Content -Path "$addonsFolder$($separator)ElvUI$($separator)ElvUI_Wrath.toc" -ErrorAction Stop

                }
            }
            

            $toc | ForEach-Object {

                if ($_ -match "## Version:") {        
                    $parsedVersion = $_.Split(':')[1].trim()
                    if ($parsedVersion -match '^v.+') {
                        $localVersion = $parsedVersion.TrimStart('v').Trim()
                    } else {
                        $localVersion = $parsedVersion.Trim()
                    }
                }
                
            }

            if ($localVersion -ne 0.0) {

                return $localVersion

            } else {

                throw 'No luck finding version in file'

            }
            

        }
        catch [System.Management.Automation.ItemNotFoundException] {

            throw "ElvUI addon not found!"

        }
        catch {            

            $errorMessage = $_.Exception.Message
            throw "Error determining ElvUI version -> [$errorMessage]!"

        }
        
    } else {

        throw "Unable to access WoW addon folder [$addonsFolder]!"

    }                
}