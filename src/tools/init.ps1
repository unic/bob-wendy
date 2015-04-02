param($installPath, $toolsPath, $package)

Import-Module (Join-Path $toolsPath "BobConfig")

$projectPath = Get-ScProjectPath

$bobConfigUser = "$projectPath\App_Config\Bob.config.user"
if(-not (Test-Path $bobConfigUser)) {
    cp "$toolsPath\..\content\App_Config\Bob.config.user" $bobConfigUser
}
