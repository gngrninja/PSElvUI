InModuleScope PSElvUi {

    describe 'Get-RemoteElvUiVersion' {

        $remoteElvUiInfo = Get-RemoteElvUiVersion

        it 'Returns an object' {

            $remoteElvUiInfo | Should Not Be Null

        }

        it 'Returns a version number' {

            $remoteElvUiInfo.Version | Should BeOfType Double 
            $remoteElvUiInfo.Version | Should BeGreaterThan 0.0
            
        }

        it 'Returns a download link' {

            $remoteElvUiInfo.DownloadLink | Should Match '^https.+\.zip$'

        }

        it 'Returns a filename' {

            $remoteElvUiInfo.FileName | Should Match '^elv.+\.zip$'

        }
    }
}