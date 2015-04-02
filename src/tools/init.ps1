param($installPath, $toolsPath, $package)

Import-Module (Join-Path $toolsPath "BobConfig")

$projectPath = Get-ScProjectPath
if($projectPath) {
    $bobConfigUser = "$projectPath\App_Config\Bob.config.user"
    if(-not (Test-Path $bobConfigUser)) {
        cp "$installPath\content\App_Config\Bob.config.user" $bobConfigUser
    }
}
else {
    Write-Warning "No project path could be found."
}
