InModuleScope PSElvUi {

    describe 'Get-LocalElvUiVersion' {

        it 'Errors if addons folder is accessible, but ElvUI is not installed' {

            $addonsFolder = $PSScriptRoot

            {Get-LocalElvUiVersion -AddonsFolder $addonsFolder} | Should Throw 'ElvUI addon not found!'

        }

        it 'Errors if addons folder is inaccessible' {
            
            $addonsFolder = Get-Random -Minimum 1 -Maximum 100

            {Get-LocalElvUiVersion -AddonsFolder $addonsFolder} | Should Throw "Unable to access WoW addon folder [$addonsFolder]!"

        }

        it 'Errors if unable to determine version' {

            $addonsFolder           = "$PSScriptRoot\..\..\artifacts\ElvUIWrong"
            
            {Get-LocalElvUiVersion -AddonsFolder $addonsFolder} | Should Throw 'Error determining ElvUI version -> [No luck finding version in file]!'

        }

        it 'Determines version of ElvUI' {
            
            [double]$correctVersion = 10.82
            $addonsFolder           = "$PSScriptRoot\..\..\artifacts\"
            
            Get-LocalElvUiVersion -AddonsFolder $addonsFolder | Should Be $correctVersion

        }
    }
}