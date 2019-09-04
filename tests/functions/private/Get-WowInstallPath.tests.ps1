InModuleScope PSElvUi {

    describe 'Get-WowInstallPath (retail)' {

        $wowInfo = Get-WowInstallPath -WowEdition 'Retail'

        it 'Returns WoW Install Path' {

            $wowInfo.WoWInstallPath | Should Exist

        }

        it 'Finds addons folder in path' {

            $wowInfo.AddonsFolder | Should Exist

        }
    }

    describe 'Get-WowInstallPath (classic)' {

        $wowInfo = Get-WowInstallPath -WowEdition 'Classic'
        
        it 'Returns WoW Install Path' {

            $wowInfo.WoWInstallPath | Should Exist

        }

        it 'Finds addons folder in path' {

            $wowInfo.AddonsFolder | Should Exist

        }        
    }
}
