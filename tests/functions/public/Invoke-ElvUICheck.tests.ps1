InModuleScope PSElvUi {

    describe 'Invoke-ElvUICheck' {

        mock Expand-Archive {

        }
        mock Invoke-WebRequest {
    
        }
        mock Get-WowInstallPath {
            $wowInfo = [PSCustomObject]@{

                InstallPath = "C:\WoW"
                AddonsFolder = "C:\WoW\Addons"

            }
            return $wowInfo
        }    
    
        mock Invoke-ElvFileWrite {
    
        }

        mock Invoke-ElvCleanup {

        }

        mock Invoke-ElvUiInstall {

        }
    
        it 'Properly handles a version upgrade' {        
        
            mock Get-RemoteElvUiVersion {
                $remote = [PSCustomObject]@{
                    Version = 1.2
                    DownloadLink = 'https://www.site.com/link.zip'
                    FileName     = 'link.zip'
                }
                return  $remote
            }

            mock Get-LocalElvUiVersion {
                return 1.1
            }

            Invoke-ElvUICheck

            Assert-MockCalled -CommandName 'Get-LocalElvUiVersion'
            Assert-MockCalled -CommandName 'Get-RemoteElvUiVersion'
            Assert-MockCalled -CommandName 'Invoke-ElvUiInstall' -Times 1 -Scope It
            #Assert-MockCalled -CommandName 'Invoke-ElvFileWrite'
            Assert-MockCalled -CommandName 'Invoke-ElvCleanup'            

        }

        it 'Properly handles a version match' {        
        
            mock Get-RemoteElvUiVersion {
                $remote = [PSCustomObject]@{
                    Version = 1.1
                    DownloadLink = 'https://www.site.com/link.zip'
                    FileName     = 'link.zip'
                }
                return  $remote
            }

            mock Get-LocalElvUiVersion {
                return 1.5
            }

            Invoke-ElvUICheck

            Assert-MockCalled -CommandName 'Get-LocalElvUiVersion'
            Assert-MockCalled -CommandName 'Get-RemoteElvUiVersion'
            Assert-MockCalled -CommandName 'Invoke-ElvUiInstall' -Times 0 -Scope It     


        }

        it 'Does nothing but check for version is -OnlyCheck is specified' {

            Invoke-ElvUICheck -OnlyCheck

            Assert-MockCalled -CommandName 'Invoke-ElvFileWrite' -Times 0 -Scope It
            Assert-MockCalled -CommandName 'Invoke-ElvUiInstall' -Times 0 -Scope It  
                        
        }
    }
}