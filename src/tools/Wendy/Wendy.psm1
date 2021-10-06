$PSScriptRoot = Split-Path  $script:MyInvocation.MyCommand.Path
$ErrorActionPreference = "Stop"

Get-ChildItem -Path $PSScriptRoot\*.ps1 -Exclude *.tests.ps1 | Foreach-Object{ . ([scriptblock]::Create([io.file]::ReadAllText($_.FullName))) }
Export-ModuleMember -Function * -Alias *
