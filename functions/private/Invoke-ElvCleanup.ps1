function Invoke-ElvCleanUp {
    [cmdletbinding()]
    param(
        [string]
        $CleanupPath
    )

    begin {

    }

    process {

        if ((Test-Path -Path $CleanupPath)) {            

            Write-Verbose "Removing [$CleanupPath]..."
            
            Remove-Item -Path $CleanupPath -Force
    
        } else {
    
            Write-Error "File -> [$CleanupPath] not found!"
    
        }
    }

    end {

    }
}