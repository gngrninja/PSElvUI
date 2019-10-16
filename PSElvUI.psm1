#Setup default paths for module in user home dir

$script:separator = [IO.Path]::DirectorySeparatorChar

switch ($PSVersionTable.PSEdition) {

    'Desktop' {

        $userDir = $env:USERPROFILE

    }

    'Core' {

        switch ($PSVersionTable.Platform) {

            'Win32NT' {
        
                $userDir = $env:USERPROFILE
        
            }
        
            'Unix' {
        
                $userDir = $env:HOME
        
            }
        }
    }
}

$script:defaultPSElvUIDir = (Join-Path -Path $userDir -ChildPath '.pselvui')
$script:configDir         = "$($defaultPsDsDir)$($separator)configs"

#Import functions
$Public  = @( Get-ChildItem -Path "$PSScriptRoot$($separator)functions$($separator)public$($separator)*.ps1" )
$Private = @( Get-ChildItem -Path "$PSScriptRoot$($separator)functions$($separator)private$($separator)*.ps1" )

@($Public + $Private) | ForEach-Object {

    Try {

        . $_.FullName

    } Catch {

        Write-Error -Message "Failed to import function $($_.FullName): $_"
        
    }

}