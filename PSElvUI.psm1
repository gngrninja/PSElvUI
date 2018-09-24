#Import functions
$Public  = @( Get-ChildItem -Path "$PSScriptRoot\functions\public\*.ps1" )
$Private = @( Get-ChildItem -Path "$PSScriptRoot\functions\private\*.ps1" )

@($Public + $Private) | ForEach-Object {

    Try {

        . $_.FullName

    } Catch {

        Write-Error -Message "Failed to import function $($_.FullName): $_"
        
    }

}