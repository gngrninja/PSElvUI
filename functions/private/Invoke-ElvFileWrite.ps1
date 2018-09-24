function Invoke-ElvFileWrite {
    [cmdletbinding()]
    param(
        [Parameter()]
        $Path,

        [Parameter()]
        $FileContent
    )

    [io.file]::WriteAllBytes($Path, $FileContent)

}