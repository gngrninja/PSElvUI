function Invoke-ElvFileWrite {
    [cmdletbinding()]
    param(
        [Parameter()]
        $Path,

        [Parameter()]
        $FileContent
    )

    begin {

    }

    process {

        [io.file]::WriteAllBytes($Path, $FileContent)

    }

    end {

    } 
}