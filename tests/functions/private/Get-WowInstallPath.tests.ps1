InModuleScope PSElvUi {

    describe 'Get-WowInstallPath' {

        $wowInfo = Get-WowInstallPath

        it 'Returns WoW Install Path' {

            $wowInfo.WoWInstallPath | Should Exist

        }

        it 'Finds addons folder in path' {

            $wowInfo.AddonsFolder | Should Exist

        }
    }
}
