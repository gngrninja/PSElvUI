InModuleScope PSElvUi {

    describe 'Invoke-ElvCleanup' {

        it 'Cleans up download if it exists' {

            $fileToCleanup = New-Item "$PSScriptRoot\..\..\artifacts\test.zip" -ItemType File -Force

            Invoke-ElvCleanup -CleanupPath $fileToCleanup

            $fileToCleanup | Should Not Exist
            
        }
    }
}